import 'package:clip_encrypt_client/crypt/decrypt_web.dart';
import 'package:clip_encrypt_client/files.dart';
import 'package:clip_encrypt_client/provider/providers.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DecryptPage extends ConsumerWidget {
  const DecryptPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catFileButton = ElevatedButton(
      onPressed: () {
        Files.cat();
      },
      child: const Text("cat"),
    );

    final decryptButton = ElevatedButton(
      onPressed: () {
        String? fileName = ref.watch(fileNameProvider)!.replaceAll(".enc", "");
        decryptWeb(
            ref, (content) => Files.save(fileName, "video/mp4", content));
      },
      child: const Text("decrypt"),
    );

    final selectJsonButton = ElevatedButton(
      onPressed: () {
        Files.selectKeyJson(ref);
      },
      child: const Text("select key.json"),
    );

    final fileNameText = ref.watch(fileNameProvider) != null
        ? Text("filename : ${ref.watch(fileNameProvider)!}")
        : const Text("filename : none");

    final keyText = ref.watch(keyProvider) != null
        ? Text("key : ${ref.watch(keyProvider)!}")
        : const Text("key : none");

    final ivText = ref.watch(ivProvider) != null
        ? Text("iv : ${ref.watch(ivProvider)!}")
        : const Text("iv : none");

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                catFileButton,
                selectJsonButton,
                fileNameText,
                keyText,
                ivText,
                decryptButton,
              ],
            )
          ],
        ),
      ),
    );
  }
}
