import 'package:flutter_test/flutter_test.dart';
import 'package:studium_flutter/features/collaboration/screens/privacy_controls_screen.dart';
import 'package:studium_flutter/features/collaboration/state/pagination_controller.dart';

void main() {
  test('paged controller refreshes and appends pages', () async {
    final requests = <int>[];
    final controller = PagedController<int>(
      pageSize: 2,
      fetchPage: (page, limit) async {
        requests.add(page);
        if (page == 0) return [1, 2];
        return [3];
      },
    );

    await controller.loadMore();
    expect(controller.state.items, [1, 2]);
    expect(controller.state.hasMore, isTrue);
    await controller.loadMore();
    expect(controller.state.items, [1, 2, 3]);
    expect(controller.state.hasMore, isFalse);
    await controller.refresh();
    expect(requests, [0, 1, 0]);
    expect(controller.state.items, [1, 2]);
    controller.dispose();
  });

  test('paged controller exposes fetch failures and can retry', () async {
    var shouldFail = true;
    final controller = PagedController<int>(
      fetchPage: (page, limit) async {
        if (shouldFail) throw StateError('offline');
        return [42];
      },
    );

    await controller.loadMore();
    expect(controller.state.error, isA<StateError>());
    shouldFail = false;
    await controller.loadMore();
    expect(controller.state.items, [42]);
    expect(controller.state.error, isNull);
    controller.dispose();
  });

  test('minor mode always disables unknown direct-message senders', () {
    final controller = DirectMessagePrivacyController();
    controller.setUnknownSenders(true);
    expect(controller.state.allowUnknownSenders, isTrue);
    controller.setMinor(true);
    expect(controller.state.isMinor, isTrue);
    expect(controller.state.allowUnknownSenders, isFalse);
    controller.setMinor(false);
    expect(controller.state.allowUnknownSenders, isFalse);
    controller.dispose();
  });
}
