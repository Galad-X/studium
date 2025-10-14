import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _onboardingSeenKey = 'has_seen_onboarding';

/// A provider that checks if the user has seen the onboarding screen.
final onboardingProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_onboardingSeenKey) ?? false;
});

/// A function to mark the onboarding as seen.
/// This should be called when the user finishes the onboarding flow.
Future<void> markOnboardingAsSeen() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_onboardingSeenKey, true);
}
