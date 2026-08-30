import 'package:flutter/foundation.dart' hide Summary;
import 'package:studium_client/studium_client.dart';

/// A service class responsible for all summary-related API calls.
///
/// This class centralizes the logic for fetching, deleting, or otherwise
/// managing Summary objects from the Serverpod backend.
class SummaryService {
  /// A private instance of the Serverpod client.
  /// It is provided through the constructor (dependency injection).
  final Client _client;

  /// The constructor requires a [Client] instance to communicate with the backend.
  SummaryService(this._client);

  /// Fetches a list of all summaries for the currently authenticated user.
  ///
  /// Returns a `Future<List<Summary>>` upon success.
  /// Throws an [Exception] if the API call fails, with a user-friendly message.
  Future<List<Summary>> getSummaries() async {
    try {
      // Calls the `getSummaries` method on the `summary` endpoint of the client.
      return await _client.summary.getSummaries();
    } catch (e) {
      // In case of an error (e.g., network issue, server error),
      // we throw a new exception with a clearer message for the UI to display.
      debugPrint('Error fetching summaries: $e');
      throw Exception(
          'Failed to load your summaries. Please check your connection and try again.');
    }
  }

  /// Deletes a specific summary by its ID.
  ///
  /// The [summaryId] is the unique identifier of the summary to be deleted.
  /// Throws an [Exception] if the deletion fails.
  Future<void> deleteSummary(int summaryId) async {
    try {
      await _client.summary.deleteSummary(summaryId);
    } catch (e) {
      debugPrint('Error deleting summary $summaryId: $e');
      throw Exception('Failed to delete the summary. Please try again.');
    }
  }
}
