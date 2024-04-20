import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';

import 'env.dart';



class AuthService {
  Future<GoogleSignInAuthentication?> signInWithGoogle() async {
    // TODO: dotenv
    final clientId = Env.clientId;

    final scopes = [
      // "email",
      DriveApi.driveScope, //google drive フルアクセス
    ];
    final request = GoogleSignIn(
      clientId: clientId,
      scopes: scopes,
    );
    final response = await request.signIn();
    final googleAuth = await response?.authentication;
    return googleAuth;
  }
}
