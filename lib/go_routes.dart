import 'package:app/UI/screens/home_screen.dart';
import 'package:app/UI/screens/login_screen.dart';
import 'package:app/providers/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/login',

    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    ],

    redirect: (context, state) {
      final isLoading = authState.isLoading;
      final user = authState.value;

      final isOnLogin = state.matchedLocation == '/login';
      if (isLoading) return null;
      if (user == null && !isOnLogin) {
        return '/login';
      }
      if (user != null && isOnLogin) {
        return '/home';
      }

      return null;
    },
  );
});
