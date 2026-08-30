/// Pure route-access rules kept separate from GoRouter so they can be tested
/// without booting the application or a Serverpod client.
class RouteAccessPolicy {
  const RouteAccessPolicy._();

  static bool canEnterRoom({
    required bool authenticated,
    required bool institutionVerified,
    required bool privateRoom,
    required bool roomMember,
  }) {
    if (!authenticated) return false;
    if (!privateRoom) return true;
    return institutionVerified && roomMember;
  }
}
