import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gutsyx/core/theme.dart';
import 'package:gutsyx/features/auth/providers/auth_provider.dart';
import 'package:gutsyx/features/auth/screens/login_screen.dart';
import 'package:gutsyx/features/dashboard/screens/dashboard_screen.dart';
import 'package:gutsyx/features/history/screens/history_screen.dart';
import 'package:gutsyx/features/scanner/screens/scanner_screen.dart';
import 'package:gutsyx/features/paywall/screens/paywall_screen.dart';
import 'package:gutsyx/features/profile/screens/profile_screen.dart';
import 'package:gutsyx/features/profile/screens/settings_screen.dart';
import 'package:gutsyx/core/widgets/main_scaffold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gutsyx/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const ProviderScope(child: GutsyXApp()));
}

final _routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: authState.isAuthenticated ? '/dashboard' : '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/paywall',
        builder: (context, state) => const PaywallScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/history',
            builder: (context, state) => const HistoryScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/scan',
        builder: (context, state) => const ScannerScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    redirect: (context, state) {
      final loggingIn = state.matchedLocation == '/login';
      if (!authState.isAuthenticated) {
        return loggingIn ? null : '/login';
      }
      if (loggingIn) {
        return '/dashboard';
      }
      return null;
    },
  );
});

class GutsyXApp extends ConsumerWidget {
  const GutsyXApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(_routerProvider);
    return MaterialApp.router(
      title: 'GutsyX AI',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
