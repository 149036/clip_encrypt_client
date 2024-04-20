import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:clip_encrypt_client/files.dart';
import 'package:clip_encrypt_client/provider/providers.dart';
import 'package:encrypt/encrypt.dart';

class MyDecrypt {
  // final key = Key.fromBase64("ytw6+SwqBHiYZ5jYTVFy4SRv2uSGghGzIAMbN7J0C7E=");
  // final iv = IV.fromBase64("qC3RK8Xg0rbYE3WHNTO81w==");

  static void _decrypt(
      String encryptedFileName, Key key, IV iv, Uint8List content) {
    final utf8DecodedContent = utf8.decode(content);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final cleanedString = utf8DecodedContent.replaceAll('\n', '');
    final e = Encrypted.fromBase64(cleanedString);

    final decrypted = encrypter.decryptBytes(e, iv: iv);
    Uint8List videodata = Uint8List.fromList(decrypted);
    String fileName = encryptedFileName.replaceAll("encrypted-", "");
    Files.save(videodata, fileName, 'video/mp4');
  }

  static void decryptFile(ref) {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files?.length == 1) {
        final file = files![0];
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((event) {
          final fileName = ref.watch(fileNameProvider);
          final key = Key.fromBase64(ref.watch(keyProvider));
          final iv = IV.fromBase64(ref.watch(ivProvider));
          final content = reader.result as Uint8List;
          _decrypt(fileName, key, iv, content);
        });
      }
    });
  }
}
