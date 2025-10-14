import 'package:flutter/foundation.dart';
import 'package:studium_client/studium_client.dart';

class UserService {
  final Client _client;
  UserService(this._client);

  Future<UserProfileBundle> getProfileBundle() async {
    try {
      return await _client.user.getProfileBundle();
    } catch (e) {
      throw Exception('Failed to load user profile. $e');
    }
  }

  Future<DashboardBundle> getDashboardBundle() async {
    try {
      return await _client.user.getDashboardBundle();
    } catch (e, stackTrace) {
      debugPrint('Failed to load dashboard data: $e');
      debugPrint('Stack trace: $stackTrace');

      // Provide more specific error messages based on the error type
      if (e.toString().contains('ServerpodClientException')) {
        throw Exception(
            'Server error while loading dashboard. Please try again.');
      } else if (e.toString().contains('connection')) {
        throw Exception(
            'Connection error. Please check your internet connection.');
      } else {
        throw Exception(
            'Could not load your dashboard data. Please try again.');
      }
    }
  }
}
