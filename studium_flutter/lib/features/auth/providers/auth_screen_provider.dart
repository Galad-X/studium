import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:studium_client/studium_client.dart';
import '../../../api/serverpod_client.dart';

// NEW: Add a verification step to the enum
enum AuthMode { signIn, signUp, verifyEmail }

class AuthScreenState {
  final AuthMode authMode;
  final bool isLoading;
  final String? errorMessage;
  final String emailForVerification;

  final String? serverErrorDetails;

  AuthScreenState({
    this.authMode = AuthMode.signIn,
    this.isLoading = false,
    this.errorMessage,
    this.emailForVerification = '',
    this.serverErrorDetails,
  });

  AuthScreenState copyWith({
    AuthMode? authMode,
    bool? isLoading,
    String? errorMessage,
    String? emailForVerification,
    String? serverErrorDetails,
    bool clearError = false,
  }) {
    return AuthScreenState(
      authMode: authMode ?? this.authMode,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      emailForVerification: emailForVerification ?? this.emailForVerification,
      serverErrorDetails: serverErrorDetails ?? this.serverErrorDetails,
    );
  }
}

class AuthScreenNotifier extends StateNotifier<AuthScreenState> {
  final Ref ref;
  late final EmailAuthController _emailAuthController;

  AuthScreenNotifier(this.ref) : super(AuthScreenState()) {
    // Initialize the controller from the Serverpod auth module
    _emailAuthController = EmailAuthController(client.modules.auth);
    // Check server connectivity on initialization
  }

  void setMode(AuthMode mode) {
    state = state.copyWith(authMode: mode, clearError: true);
  }

  // NEW: Method to get detailed error information
  String _getDetailedErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException')) {
      return 'Cannot connect to server. Please check your internet connection.';
    } else if (error.toString().contains('TimeoutException')) {
      return 'Server request timed out. Please try again.';
    } else if (error.toString().contains('409')) {
      return 'Email or username already exists. Please try a different one.';
    } else if (error.toString().contains('400')) {
      return 'Invalid request. Please check your input.';
    } else if (error.toString().contains('500')) {
      return 'Server error. Please try again later.';
    } else if (error.toString().contains('Serverpod')) {
      return 'Authentication service error: ${error.toString()}';
    }
    return error.toString();
  }

  Future<void> handleSignIn(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);

    // Check server connectivity first

    try {
      final userInfo = await _emailAuthController.signIn(email, password);
      if (userInfo == null) {
        throw Exception('Invalid credentials or email not verified.');
      }
      // On success, the main AppLayout will handle navigation.
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getDetailedErrorMessage(e),
      );
    }
  }

  Future<void> handleSignUpRequest(
      String username, String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);

    if (username.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Username cannot be empty.',
      );
      return;
    }

    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Please enter a valid email address.',
      );
      return;
    }
    if (password.isEmpty || password.length < 8) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Password must be at least 6 characters long.',
      );
      return;
    }
    debugPrint(
        'Sign-up request for username: $username, email: $email, password: $password');
    try {
      // This will trigger our onUserWillBeCreated hook on the server
      bool result = await _emailAuthController.createAccountRequest(
          username, email, password);

      debugPrint('createAccountRequest success: $result');

      if (result) {
        // Move to the verification step
        state = state.copyWith(
          isLoading: false,
          authMode: AuthMode.verifyEmail,
          emailForVerification: email,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to create account. Please try again.',
        );
      }
    } on ServerpodClientException catch (e) {
      debugPrint('ServerpodClientException during sign-up: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getDetailedErrorMessage(e),
      );
    } on Exception catch (e) {
      debugPrint('Exception during sign-up: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getDetailedErrorMessage(e),
      );
    } catch (e) {
      debugPrint('Sign-up error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getDetailedErrorMessage(e),
      );
    }
  }

  Future<void> handleVerification(
      String verificationCode, String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      debugPrint(
          'Attempting to verify email: $email with code: $verificationCode');

      // Step 1: Validate the code. This creates the user in the DB.
      final userInfo =
          await _emailAuthController.validateAccount(email, verificationCode);
      if (userInfo == null) {
        throw Exception('Invalid verification code.');
      }

      debugPrint('Email verification successful, attempting auto sign-in...');

      // Step 2: Automatically sign the user in after successful verification.
      final signedInUser = await _emailAuthController.signIn(email, password);
      if (signedInUser == null) {
        throw Exception(
            'Verification successful, but auto sign-in failed. Please try signing in manually.');
      }

      debugPrint('Auto sign-in successful');
      // On success, the main AppLayout will handle navigation.
      state = state.copyWith(isLoading: false);
    } catch (e) {
      debugPrint('Verification error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getDetailedErrorMessage(e),
      );
    }
  }
}

// The provider remains the same
final authScreenProvider =
    StateNotifierProvider.autoDispose<AuthScreenNotifier, AuthScreenState>(
        (ref) {
  return AuthScreenNotifier(ref);
});
