import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../view/views.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeView();
          },
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginView();
          },
        ),
        GoRoute(
          path: 'editor',
          builder: (BuildContext context, GoRouterState state) {
            return const EditorView();
          },
        ),
      ],
    ),
  ],
);
