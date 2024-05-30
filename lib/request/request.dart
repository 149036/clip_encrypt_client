import 'dart:convert';
import 'dart:typed_data';

import 'package:clip_encrypt_client/crypt/algo.dart';
import 'package:clip_encrypt_client/files.dart';
import 'package:clip_encrypt_client/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class Request {
  Request();
  Uri uri = Uri.parse('http://127.0.0.1:7999/drive');
  Map<String, dynamic> requestBody = Map();

  void post(
    TextEditingController driveFolderIdController,
    TextEditingController videoUrlController,
    WidgetRef ref,
  ) async {
    Uri url = Uri.parse('http://127.0.0.1:7999/drive');
    // Uri url = Uri.parse('https://clip-encrypt.com/drive');
    Map<String, dynamic> requestBody;
    requestBody = {
      "drive_folder_id": "${driveFolderIdController.text}",
      "video_url": "${videoUrlController.text}",
      "access_token": "${ref.watch(accessTokenProvider)}",
      "encryption": true,
      "crypt_algo": "${ref.watch(cryptAlgoProvider).name}",
    };
    try {
      final response = await http.post(
        url,
        headers: {"content-type": "application/json"},
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        final body = response.body;
        setResponse(ref, body);
        debugPrint(body);
        if (body == '{"message":"error"}') {
          return;
        }
        final content = Uint8List.fromList(utf8.encode(body));
        Files.save("key.json", "application/json", content);
      }
    } catch (e) {
      debugPrint("${e}");
    }
  }

  setResponse(WidgetRef ref, content) {
    final notifier = ref.read(responseProvider.notifier);
    notifier.state = content;
  }
}
