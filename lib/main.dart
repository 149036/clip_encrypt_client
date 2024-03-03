import 'package:clip_encrypt_client/page/home_page.dart';
import 'package:clip_encrypt_client/page/login_page.dart';
import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:go_router/go_router.dart';

void main() async {
  final app = App();

  // riverpod アプリ全体をscopeで囲う
  final scope = ProviderScope(child: app);

  runApp(scope);
}

class App extends StatelessWidget {
  App({super.key});

  final router = GoRouter(
    initialLocation: "/login_page",
    routes: [
      GoRoute(
        path: "/login_page",
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: "/home_page",
        builder: (context, state) => HomePage(),
      )
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
