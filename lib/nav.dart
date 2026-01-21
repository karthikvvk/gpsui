import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gpstracking/pages/auth/sign_in_page.dart';
import 'package:gpstracking/pages/auth/sign_up_page.dart';
import 'package:gpstracking/pages/dashboard/dashboard_page.dart';
import 'package:gpstracking/pages/profile/profile_page.dart';
import 'package:gpstracking/pages/shell/app_shell.dart';
import 'package:gpstracking/pages/trips/trip_details_page.dart';
import 'package:gpstracking/pages/trips/trips_page.dart';
import 'package:gpstracking/pages/welcome_page.dart';
import 'package:gpstracking/state/app_session.dart';
import 'package:gpstracking/ui/app_motion.dart';

class AppRouter {
  static final AppSession session = AppSession();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.welcome,
    refreshListenable: session,
    redirect: (context, state) {
      final signedIn = session.signedIn;
      final loc = state.matchedLocation;

      final inAuth = loc == AppRoutes.welcome || loc == AppRoutes.signIn || loc == AppRoutes.signUp;
      final inApp = loc.startsWith(AppRoutes.app);

      if (!signedIn && inApp) return AppRoutes.welcome;
      if (signedIn && inAuth) return AppRoutes.dashboard;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        name: 'welcome',
        pageBuilder: (context, state) => _page(child: const WelcomePage(), state: state),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        name: 'signIn',
        pageBuilder: (context, state) => _page(child: const SignInPage(), state: state),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: 'signUp',
        pageBuilder: (context, state) => _page(child: const SignUpPage(), state: state),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            name: 'dashboard',
            pageBuilder: (context, state) => NoTransitionPage(child: const DashboardPage()),
          ),
          GoRoute(
            path: AppRoutes.trips,
            name: 'trips',
            pageBuilder: (context, state) => NoTransitionPage(child: const TripsPage()),
            routes: [
              GoRoute(
                path: 'details/:tripId',
                name: 'tripDetails',
                pageBuilder: (context, state) {
                  final tripId = state.pathParameters['tripId'] ?? 'unknown';
                  return _page(child: TripDetailsPage(tripId: tripId), state: state);
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            pageBuilder: (context, state) => NoTransitionPage(child: const ProfilePage()),
          ),
        ],
      ),
    ],
  );

  static CustomTransitionPage<void> _page({required Widget child, required GoRouterState state}) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: AppMotion.page,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => AppMotion.fadeSlide(child, animation),
    );
  }
}

class AppRoutes {
  static const String welcome = '/welcome';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';

  static const String app = '/app';
  static const String dashboard = '/app/dashboard';
  static const String trips = '/app/trips';
  static const String profile = '/app/profile';

  static String tripDetails(String tripId) => '${AppRoutes.trips}/details/$tripId';
}
