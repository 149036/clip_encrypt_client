import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

Uint8List myDecrypt(Key key, IV iv, Uint8List content) {
  Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  Uint8List decrypted =
      Uint8List.fromList(encrypter.decryptBytes(Encrypted(content), iv: iv));
  return decrypted;
}
