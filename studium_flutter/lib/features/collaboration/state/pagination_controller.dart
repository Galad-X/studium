import 'package:flutter_riverpod/flutter_riverpod.dart';

class PagedState<T> {
  const PagedState({
    this.items = const [],
    this.page = -1,
    this.hasMore = true,
    this.loading = false,
    this.error,
  });

  final List<T> items;
  final int page;
  final bool hasMore;
  final bool loading;
  final Object? error;

  PagedState<T> copyWith({
    List<T>? items,
    int? page,
    bool? hasMore,
    bool? loading,
    Object? error = _keepError,
  }) =>
      PagedState<T>(
        items: items ?? this.items,
        page: page ?? this.page,
        hasMore: hasMore ?? this.hasMore,
        loading: loading ?? this.loading,
        error: identical(error, _keepError) ? this.error : error,
      );
}

const _keepError = Object();

class PagedController<T> extends StateNotifier<PagedState<T>> {
  PagedController({required this.fetchPage, this.pageSize = 30})
      : super(PagedState<T>());

  final Future<List<T>> Function(int page, int limit) fetchPage;
  final int pageSize;

  Future<void> refresh() async {
    state = PagedState<T>();
    await loadMore();
  }

  Future<void> loadMore() async {
    if (state.loading || !state.hasMore) return;
    state = state.copyWith(loading: true, error: null);
    final nextPage = state.page + 1;
    try {
      final next = await fetchPage(nextPage, pageSize);
      state = state.copyWith(
        items: [...state.items, ...next],
        page: nextPage,
        hasMore: next.length >= pageSize,
        loading: false,
      );
    } catch (error) {
      state = state.copyWith(loading: false, error: error);
    }
  }
}
