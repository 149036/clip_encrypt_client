import 'package:clip_encrypt_client/crypt/decrypt_to_save.dart';
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

    final selectEncryptedFileButton = ElevatedButton(
      onPressed: () => Files.selectEncryptedFile(ref),
      child: const Text("slect encrypted file"),
    );

    final fileNameText =
        Text("filename : ${ref.watch(aesKeyProvider)!.fileName}");
    final keyText = Text("key : ${ref.watch(aesKeyProvider)!.key}");
    final ivText = Text("iv : ${ref.watch(aesKeyProvider)!.iv}");

    final infoKeyJson = Column(
      children: [
        const Text("info key.json"),
        fileNameText,
        keyText,
        ivText,
        selectJsonButton
      ],
    );

    return Scaffold(
      body: Center(
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  catFileButton,
                  const SizedBox(width: 50),
                  Column(
                    children: [
                      infoKeyJson,
                      const SizedBox(height: 50),
                      selectEncryptedFileButton,
                      const SizedBox(height: 50),
                      decryptButton,
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
