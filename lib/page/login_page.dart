import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../service.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleSignInButton = SignInButton(
      Buttons.google,
      onPressed: () async {
        final googleAuth = await AuthService().signInWithGoogle();
        final accessToken = googleAuth?.accessToken;
        if (accessToken != null) {
          ref.read(accessTokenProvider.notifier).state = accessToken;
          context.go("/home_page");
        }
      },
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            googleSignInButton,
          ],
        ),
      ),
    );
  }
}
