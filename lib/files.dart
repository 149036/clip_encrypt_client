import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:clip_encrypt_client/page/decrypt_page.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Files {
  static void save(
    Uint8List fileData,
    String fileName,
    String mimeType,
  ) async {
    final FileSaveLocation? result =
        await getSaveLocation(suggestedName: fileName);
    if (result == null) {
      return;
    }

    final XFile textFile =
        XFile.fromData(fileData, mimeType: mimeType, name: fileName);
    await textFile.saveTo(result.path);
  }

  static void select() {}

  static void cat() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files?.length == 1) {
        final file = files![0];
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((event) {
          final content = reader.result as Uint8List;
          saveVideoBlob(content, "a.txt");
        });
      }
    });
  }

  static void selectKeyJson(WidgetRef ref) {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files?.length == 1) {
        final file = files![0];
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((event) {
          final content = reader.result as Uint8List;
          final utf8content = utf8.decode(content);

          debugPrint(utf8content);
          Map jsonData = jsonDecode(utf8content);
          jsonData.forEach((key, value) {
            debugPrint("file name : ${key}");
            debugPrint("key       : ${value["key"]}");
            debugPrint("iv        : ${value["iv"]}");
            ref.read(FileNameProvider.notifier).state = key;
            ref.read(keyProvider.notifier).state = value["key"];
            ref.read(ivProvider.notifier).state = value["iv"];
          });
        });
      }
    });
  }

  static void saveVideoBlob(Uint8List data, String fileName) {
    final blob = html.Blob([data]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("downlaod", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
