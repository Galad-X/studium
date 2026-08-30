import 'package:flutter_test/flutter_test.dart';
import 'package:studium_flutter/routing/route_access_policy.dart';

void main() {
  test('anonymous users cannot enter rooms', () {
    expect(
      RouteAccessPolicy.canEnterRoom(
        authenticated: false,
        institutionVerified: false,
        privateRoom: false,
        roomMember: false,
      ),
      isFalse,
    );
  });

  test('public rooms remain available without verified institution identity',
      () {
    expect(
      RouteAccessPolicy.canEnterRoom(
        authenticated: true,
        institutionVerified: false,
        privateRoom: false,
        roomMember: false,
      ),
      isTrue,
    );
  });

  test('private rooms require active membership', () {
    expect(
      RouteAccessPolicy.canEnterRoom(
        authenticated: true,
        institutionVerified: true,
        privateRoom: true,
        roomMember: false,
      ),
      isFalse,
    );
    expect(
      RouteAccessPolicy.canEnterRoom(
        authenticated: true,
        institutionVerified: true,
        privateRoom: true,
        roomMember: true,
      ),
      isTrue,
    );
  });
}
