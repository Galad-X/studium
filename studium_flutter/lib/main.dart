import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'api/serverpod_client.dart';

import 'core/providers/theme_provider.dart';
import 'routing/app_router.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const stripePublishableKey = String.fromEnvironment('STRIPE_PUBLISHABLE_KEY');
  if (stripePublishableKey.isNotEmpty) {
    Stripe.publishableKey = stripePublishableKey;
  }

  runApp(const ProviderScope(child: AppInitializer()));
}

class AppInitializer extends ConsumerStatefulWidget {
  const AppInitializer({super.key});

  @override
  ConsumerState<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends ConsumerState<AppInitializer> {
  Future<void>? _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _initializeApp();
  }

  Future<void> _initializeApp() async {
    await initializeServerpodClient();
  }

  void _retryInitialization() {
    setState(() {
      _initialization = _initializeApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Now, we return a MaterialApp in all cases.
        // The content of the MaterialApp changes based on the state.
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // Return a MaterialApp with the error screen as its home.
            return buildMaterialApp(
              home: _buildErrorScreen(context, snapshot.error.toString()),
            );
          }
          // On success, return the main app with its router.
          return const StudiumApp();
        }
        // While loading, return a MaterialApp with the loading screen as its home.
        return buildMaterialApp(
          home: _buildLoadingScreen(context),
        );
      },
    );
  }

  // This helper builds a basic MaterialApp for the loading/error states.
  Widget buildMaterialApp({required Widget home}) {
    return MaterialApp(
      home: home,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // You can also connect this to the theme provider if you want,
      // but it's often fine to use the default for initial loading.
    );
  }

  Widget _buildLoadingScreen(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primaryContainer.withAlpha(77),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withAlpha(204),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withAlpha(77),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_stories_rounded,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
              ),
              const SizedBox(height: 24),
              Text(
                'Loading Studium AI...',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorScreen(BuildContext context, String error) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                'Failed to initialize app',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _retryInitialization,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudiumApp extends ConsumerWidget {
  const StudiumApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Studium AI',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      color: Colors.limeAccent,
      debugShowCheckedModeBanner: false,
    );
  }
}
