import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';

import 'env.dart';

class AuthService {
  Future<GoogleSignInAuthentication?> signInWithGoogle() async {
    //dot env
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
