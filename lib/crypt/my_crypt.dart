import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

class MyCrypt {
  List<int> decrypt(Key key, IV iv, Uint8List content) {
    return Encrypter(AES(key, mode: AESMode.cbc))
        .decryptBytes(Encrypted(content), iv: iv);
  }
}
