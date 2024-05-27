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
      onPressed: () => Files.cat(),
      child: const Text("cat"),
    );

    final decryptButton = ElevatedButton(
      onPressed: () => decryptToSave(ref),
      child: const Text("decrypt"),
    );

    final selectJsonButton = ElevatedButton(
      onPressed: () => Files.selectKeyJson(ref),
      child: const Text("select key.json"),
    );

    final fileNameText = Text("filename : ${ref.watch(fileNameProvider)}");
    final keyText = Text("key : ${ref.watch(keyProvider)}");
    final ivText = Text("iv : ${ref.watch(ivProvider)}");

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
