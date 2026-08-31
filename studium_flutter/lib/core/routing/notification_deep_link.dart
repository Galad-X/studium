/// Converts server notification metadata into a safe in-app destination.
/// Unknown notification types deliberately remain in the notification center.
String? notificationDeepLink(String type, int? relatedId) {
  if (relatedId == null) return null;
  return switch (type) {
    'room_post' ||
    'room_chat' ||
    'study_session' =>
      '/collaboration/rooms/$relatedId',
    'challenge' || 'challenge_team' => '/collaboration/challenges/$relatedId',
    'institution_membership' ||
    'moderation_report' =>
      '/collaboration/institutions',
    'moderation_appeal' => '/moderation/appeals',
    _ => null,
  };
}
