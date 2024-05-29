import 'dart:typed_data';

import 'package:clip_encrypt_client/crypt/my_crypt.dart';
import 'package:clip_encrypt_client/files.dart';
import 'package:clip_encrypt_client/provider/providers.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void decryptToSave(WidgetRef ref) {
  String fileName = ref.watch(aesKeyProvider)!.fileName.replaceAll(".enc", "");
  Key key = Key.fromBase64(ref.watch(aesKeyProvider)!.key);
  IV iv = IV.fromBase64(ref.watch(aesKeyProvider)!.iv);
  Uint8List content = ref.watch(encryptedFileProvider)!;
  Files.save(fileName, "video/mp4", MyCrypt().decrypt(key, iv, content));
}
