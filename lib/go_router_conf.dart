import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'page/home_page.dart';
import 'page/login_page.dart';

class GoRouterConf extends StatelessWidget {
  GoRouterConf({super.key});

  final router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: "/login_page",
        builder: (context, state) => LoginPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
