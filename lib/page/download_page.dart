import 'package:clip_encrypt_client/crypt/algo.dart';
import 'package:clip_encrypt_client/provider/providers.dart';
import 'package:clip_encrypt_client/request/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageScreen();
  }
}

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

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
        Request().post(driveFolderIdController, videoUrlController, ref);
      },
      child: const Text("post"),
    );
    final response = Text("response : ${ref.watch(responseProvider)}");

    const cryptAlgoText = Text("暗号アルゴリズム");
    final cryptAlgoDropdownButton = DropdownButton(
      value: ref.watch(cryptAlgoProvider),
      items: [
        for (int i = 0; i < CryptAlgo.values.length; i++) ...{
          DropdownMenuItem(
            value: CryptAlgo.values[i],
            child: Text("${CryptAlgo.values[i].name}"),
          )
        },
      ],
      onChanged: (newCryptAlgo) {
        final notifier = ref.read(cryptAlgoProvider.notifier);
        // notifier.state = newCryptAlgo!;
        notifier.state = newCryptAlgo!;
        debugPrint("cryptAlgo : ${ref.watch(cryptAlgoProvider).name}");
      },
    );

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  cryptAlgoText,
                  const SizedBox(width: 8),
                  cryptAlgoDropdownButton
                ],
              ),
              const SizedBox(height: 8),
              postButton,
              const SizedBox(height: 8),
              response,
            ],
          ),
        ),
      ),
    );
  }
}
