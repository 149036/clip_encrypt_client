import 'dart:html';
import 'dart:typed_data';

import 'package:clip_encrypt_client/crypt/decrypt.dart';
import 'package:clip_encrypt_client/files.dart';
import 'package:clip_encrypt_client/provider/providers.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void decryptWeb(WidgetRef ref, Function cont) {
  Files.select((FileReader reader) {
    Key key = Key.fromBase64(ref.watch(keyProvider)!);
    IV iv = IV.fromBase64(ref.watch(ivProvider)!);
    Uint8List content = reader.result as Uint8List;
    cont(myDecrypt(key, iv, content));
  });
}
