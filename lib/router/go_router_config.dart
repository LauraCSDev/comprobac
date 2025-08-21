import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/pages/home_page.dart';
import '../ui/pages/login_page.dart';
import '../ui/pages/onboarding_page.dart';
import '../ui/pages/validation/form_page.dart';
import '../ui/pages/validation/result_page.dart';

///Necessary to get the context anywhere and show the snackbar
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class GoRouterConfig {
  static GoRouter getRouterConfig() {
    return GoRouter(
      routes: [
        GoRoute(
          name: 'Login',
          pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
          path: '/',
        ),
        GoRoute(
          name: 'Onboarding',
          pageBuilder: (context, state) => const MaterialPage(child: Onboarding()),
          path: '/onboarding',
        ),
        GoRoute(
          name: 'Home',
          pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
          path: '/home',
        ),
        GoRoute(
          name: 'Validate',
          pageBuilder: (context, state) => const MaterialPage(child: FormPage()),
          path: '/validate',
        ),
        GoRoute(
          name: 'ValidationResult',
          path: '/validation',
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: ResultPage(),
            );
          },
        ),
      ],
    );
  }
}
