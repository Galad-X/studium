// lib/routing/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_client/module.dart';
import 'package:studium_client/studium_client.dart';

// Providers
import '../core/providers/auth_provider.dart';
import '../core/providers/onboarding_provider.dart';

// Screens
import '../features/admin/screens/user_analytics_screen.dart';
import '../features/auth/screens/auth_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/collaboration/screens/collaboration_screen.dart';
import '../features/collaboration/screens/room_detail_screen.dart';
import '../features/collaboration/screens/challenge_detail_screen.dart';
import '../features/collaboration/screens/institution_hub_screen.dart';
import '../features/collaboration/screens/moderation_appeals_screen.dart';
import '../features/collaboration/screens/moderation_feedback_screen.dart';
import '../features/collaboration/screens/conversations_screen.dart';
import '../features/opportunities/screens/opportunities_screen.dart';
import '../features/history/screens/my_summaries_screen.dart';
import '../features/history/screens/my_writings_screen.dart';
import '../features/history/screens/summary_detail_screen.dart';
import '../features/materials/screens/materials_screen.dart';
import '../features/onboarding/screens/landing_page.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/writing/screens/start_writing_screen.dart';
import '../features/study_material/screens/material_detail_screen.dart';
import '../features/study_material/screens/upload_material_screen.dart';
import '../features/quiz/screens/start_quiz_screen.dart';
import '../features/quiz/screens/quiz_screen.dart';
import '../features/quiz/screens/quiz_results_screen.dart';
import '../features/ai_tools/screens/summary_screen.dart';
import '../features/ai_tools/screens/research_comparison_screen.dart';
import '../features/writing/screens/writing_result_screen.dart';
import '../features/notifications/screens/notifications_screen.dart';
import '../features/subscription/screens/subscription_screen.dart';
import '../features/subscription/screens/subscription_management_screen.dart';
import 'app_layout.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    refreshListenable: router,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/landing',
        name: 'landing',
        builder: (context, state) => LandingPage(
          onGetStarted: () => context.goNamed('login'),
          onSignIn: () => context.goNamed('login'),
        ),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => OnboardingScreen(),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => AppLayout(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/materials',
            name: 'materials',
            builder: (context, state) => const MaterialsScreen(),
          ),
          GoRoute(
            path: '/collaboration',
            name: 'collaboration',
            builder: (context, state) => const CollaborationScreen(),
          ),
          GoRoute(
            path: '/collaboration/rooms/:roomId',
            name: 'roomDiscussion',
            builder: (context, state) => RoomDetailScreen(
              roomId: int.parse(state.pathParameters['roomId']!),
            ),
          ),
          GoRoute(
            path: '/collaboration/challenges/:challengeId',
            name: 'challengeDetail',
            builder: (context, state) => ChallengeDetailScreen(
              challengeId: int.parse(state.pathParameters['challengeId']!),
              challenge:
                  state.extra is Challenge ? state.extra as Challenge : null,
            ),
          ),
          GoRoute(
            path: '/collaboration/institutions',
            name: 'institutionHub',
            builder: (context, state) => const InstitutionHubScreen(),
          ),
          GoRoute(
            path: '/collaboration/conversations',
            name: 'conversations',
            builder: (context, state) => const ConversationsScreen(),
          ),
          GoRoute(
            path: '/opportunities',
            name: 'opportunities',
            builder: (context, state) => const OpportunitiesScreen(),
          ),
          GoRoute(
            path: '/writer',
            name: 'writer',
            builder: (context, state) => const StartAcademicWritingScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/moderation/appeals',
        name: 'moderationAppeals',
        builder: (context, state) => const ModerationAppealsScreen(),
      ),
      GoRoute(
        path: '/moderation/feedback',
        name: 'moderationFeedback',
        builder: (context, state) => const ModerationFeedbackScreen(),
      ),
      // Full-screen routes that are pushed on top of the shell
      GoRoute(
        path: '/materials/upload',
        name: 'uploadMaterial',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const UploadMaterialScreen(),
      ),
      GoRoute(
        path: '/profile/writings',
        name: 'myWritings',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const MyWritingsScreen(),
      ),
      GoRoute(
        path: '/profile/summaries',
        name: 'mySummaries',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const MySummariesScreen(),
      ),
      GoRoute(
        path: '/profile/analytics',
        name: 'userAnalytics',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const UserAnalyticsScreen(),
      ),

      GoRoute(
        path: '/materials/:id',
        name: 'materialDetails',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final material = state.extra as StudyMaterial;
          return MaterialDetailScreen(material: material);
        },
      ),
      GoRoute(
        path: '/materials/:id/quiz',
        name: 'startQuiz',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final material = state.extra as StudyMaterial;
          return StartQuizScreen(material: material);
        },
      ),
      GoRoute(
        path: '/quiz-active',
        name: 'quizActive',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const QuizScreen(),
      ),
      GoRoute(
        path: '/quiz-results',
        name: 'quizResults',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const QuizResultsScreen(),
      ),
      GoRoute(
        path: '/materials/:id/summary',
        name: 'summary',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final materialId = int.parse(state.pathParameters['id']!);
          final materialTitle = (state.extra as StudyMaterial).title;
          return SummaryScreen(
              materialId: materialId, materialTitle: materialTitle);
        },
      ),

      GoRoute(
        path: '/summary/:id',
        name: 'summaryDetails',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final summary = state.extra as Summary;
          return SummaryDetailScreen(summary: summary);
        },
      ),
      GoRoute(
        path: '/materials/:id/compare',
        name: 'compare',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final materialId = int.parse(state.pathParameters['id']!);
          return ResearchComparisonScreen(studyMaterialId: materialId);
        },
      ),
      GoRoute(
        path: '/writer/result',
        name: 'writingResult',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final writing = state.extra as AcademicWriting;
          return WritingResultScreen(writing: writing);
        },
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/subscription',
        name: 'subscription',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SubscriptionScreen(),
      ),
      GoRoute(
        path: '/subscription/manage',
        name: 'subscriptionManage',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final sub = state.extra as Subscription;
          return SubscriptionManagementScreen(subscription: sub);
        },
      ),
    ],
    redirect: (context, state) => router.redirect(state),
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.error}'),
      ),
    ),
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  bool _isDisposed = false;

  RouterNotifier(this._ref) {
    _ref.listen<AsyncValue<UserInfo?>>(
        authStateProvider, (_, __) => notifyListeners());
    _ref.listen<AsyncValue<bool>>(
        onboardingProvider, (_, __) => notifyListeners());
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) super.notifyListeners();
  }

  String? redirect(GoRouterState state) {
    final auth = _ref.read(authStateProvider);
    final onboarding = _ref.read(onboardingProvider);
    final location = state.matchedLocation;

    if (auth.isLoading || onboarding.isLoading) {
      return null; // Wait for providers
    }

    final isLoggedIn = auth.valueOrNull != null;
    final hasSeenOnboarding = onboarding.valueOrNull ?? false;
    final isGoingToLogin = location == '/login';
    final isGoingToLanding = location == '/landing';
    final isGoingToOnboarding = location == '/onboarding';

    // Rule 1: If not logged in, go to the login page.
    if (!isLoggedIn) {
      // If the user is trying to go to the landing or login page, let them.
      if (isGoingToLanding || isGoingToLogin) {
        return null;
      }
      // For any other route, redirect them to the landing page.
      return '/landing';
    }

    // Rule 2: Handle authenticated users.
    if (isLoggedIn) {
      // If they are on a page for unauthenticated users, redirect them.
      if (isGoingToLanding || isGoingToLogin) {
        // If they haven't seen onboarding, send them there first.
        if (!hasSeenOnboarding) return '/onboarding';
        // Otherwise, send them to the dashboard.
        return '/';
      }

      // If they haven't seen onboarding yet, force them to the onboarding screen.
      if (!hasSeenOnboarding && !isGoingToOnboarding) {
        return '/onboarding';
      }

      // If they have seen onboarding but are on that page, redirect to dashboard.
      if (hasSeenOnboarding && isGoingToOnboarding) {
        return '/';
      }
    }

    // If no rules match, no redirect is needed.
    return null;
  }
}
