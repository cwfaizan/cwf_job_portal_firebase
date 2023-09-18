import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/sign_in_page.dart';
import '../pages/sign_up_page.dart';
import '../providers/firebase_provider.dart';
import 'go_router_refresh_stream.dart';

enum AppRoute {
  signInPage,
  signUpPage,
  homePage,
  profilePage,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
    initialLocation: '/sign-in',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = firebaseAuth.currentUser != null;
      if (isLoggedIn) {
        if (state.uri.path == '/sign-in') {
          return '/home';
        }
      } else {
        if (state.uri.path.startsWith('/home')) {
          return '/sign-in';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
    routes: [
      GoRoute(
        path: '/sign-in',
        name: AppRoute.signInPage.name,
        builder: (context, state) => SignInPage(),
      ),
      GoRoute(
        path: '/sign-up',
        name: AppRoute.signUpPage.name,
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.homePage.name,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'profile',
            name: AppRoute.profilePage.name,
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
});
