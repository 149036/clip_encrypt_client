import 'dart:convert';
import 'dart:typed_data';

import 'package:clip_encrypt_client/files.dart';
import 'package:clip_encrypt_client/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageScreen();
  }
}

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  _setResponse(WidgetRef ref, content) {
    final notifier = ref.read(responseProvider.notifier);
    notifier.state = content;
  }

  _post(driveFolderIdController, videoUrlController, ref) async {
    Uri url = Uri.parse('http://127.0.0.1:7999/drive/');
    // Uri url = Uri.parse('https://clip-encrypt.com/drive');
    Map<String, dynamic> requestBody;
    requestBody = {
      "drive_folder_id": "${driveFolderIdController.text}",
      "video_url": "${videoUrlController.text}",
      "access_token": "${ref.watch(accessTokenProvider)}",
      "encryption": true,
    };
    try {
      final response = await http.post(
        url,
        headers: {"content-type": "application/json"},
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        final body = response.body;
        _setResponse(ref, body);
        final fileData = Uint8List.fromList(utf8.encode(body));
        Files.save(fileData, "key.json", "application/json");
      }
    } catch (e) {
      debugPrint("${e}");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoUrlController = TextEditingController();
    final driveFolderIdController = TextEditingController();

    final videoUrl = TextField(
      controller: videoUrlController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "video url",
      ),
    );
    final driveFolderId = TextField(
      controller: driveFolderIdController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "drive folder id",
      ),
    );

    final postButton = ElevatedButton(
      onPressed: () async {
        _post(driveFolderIdController, videoUrlController, ref);
      },
      child: const Text("post"),
    );

    final debugPrintAccessToken = ElevatedButton(
      onPressed: () {
        debugPrint("${ref.watch(accessTokenProvider)}");
      },
      child: Text("print access token"),
    );
    final accessToken = ref.watch(accessTokenProvider) != null
        ? Text("${ref.watch(accessTokenProvider)}")
        : Text("");

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              videoUrl,
              const SizedBox(height: 8),
              driveFolderId,
              const SizedBox(height: 8),
              postButton,
              const SizedBox(height: 8),
              ref.watch(responseProvider) != null
                  ? Text("${ref.watch(responseProvider)}")
                  : const Text(""),
              debugPrintAccessToken,
              accessToken,
            ],
          ),
        ),
      ),
    );
  }
}
