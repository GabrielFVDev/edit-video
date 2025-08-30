import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../view/views.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return SplashView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return HomeView();
          },
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return LoginView();
          },
        ),
        GoRoute(
          path: 'editor',
          builder: (BuildContext context, GoRouterState state) {
            return EditorView();
          },
        ),
        GoRoute(
          path: 'config',
          builder: (BuildContext context, GoRouterState state) {
            return ConfigView();
          },
        ),
        GoRoute(
          path: 'cadastro',
          builder: (BuildContext context, GoRouterState state) {
            return CadastroView();
          },
        ),
      ],
    ),
  ],
);
