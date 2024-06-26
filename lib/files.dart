import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:clip_encrypt_client/crypt/aes_key.dart';
import 'package:clip_encrypt_client/provider/providers.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Files {
  static void save(
    String fileName,
    String mimeType,
    dynamic content,
  ) async {
    final FileSaveLocation? result =
        await getSaveLocation(suggestedName: fileName);
    if (result == null) {
      return;
    }
    XFile textFile;
    if (content is List<int>) {
      textFile = XFile.fromData(Uint8List.fromList(content),
          mimeType: mimeType, name: fileName);
    } else {
      textFile = XFile.fromData(content, mimeType: mimeType, name: fileName);
    }
    await textFile.saveTo(result.path);
  }

  static void cat() {
    select((reader) {
      final content = reader.result as Uint8List;
      _saveVideoBlob(content, "a.txt");
    });
  }

  static void selectKeyJson(WidgetRef ref) {
    select((reader) {
      final content = reader.result as Uint8List;
      final utf8content = utf8.decode(content);

      debugPrint(utf8content);
      Map jsonData = jsonDecode(utf8content);
      jsonData.forEach((key, value) {
        ref.read(aesKeyProvider.notifier).state =
            AesKey(key, value["key"], value["iv"]);
      });
    });
  }

  static void selectEncryptedFile(WidgetRef ref) {
    select((reader) {
      ref.read(encryptedFileProvider.notifier).state =
          reader.result as Uint8List;
    });
  }

  static void _saveVideoBlob(Uint8List data, String fileName) {
    final blob = html.Blob([data]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("downlaod", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  static void select(Function cont) {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files?.length == 1) {
        final file = files![0];
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((event) {
          cont(reader);
        });
      }
    });
  }
}
