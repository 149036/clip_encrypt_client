import 'dart:convert';
import 'dart:typed_data';

import 'package:clip_encrypt_client/crypt/my_crypt.dart';
import 'package:encrypt/encrypt.dart';
import 'package:test/test.dart';

void main() {
  test("myDecrypt_test", () {
    Key key = Key.fromBase64("ytw6+SwqBHiYZ5jYTVFy4SRv2uSGghGzIAMbN7J0C7E=");
    IV iv = IV.fromBase64("qC3RK8Xg0rbYE3WHNTO81w==");

    String target = "0yW6DiREMDQE58kIxgjxzw=="; // Hello Encrypt!
    Uint8List content = Uint8List.fromList(base64Decode(target));

    String str = utf8.decode(MyCrypt().decrypt(key, iv, content));

    expect("Hello Encrypt!", str);
  });
}
