import 'package:clip_encrypt_client/page/decrypt_page.dart';
import 'package:clip_encrypt_client/page/download_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexProvider = StateProvider((ref) {
  return 0;
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexProvider);

    const items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.download),
        label: "download",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.lock_open),
        label: "decrypt",
      ),
    ];

    final bar = BottomNavigationBar(
      items: items,
      currentIndex: index,
      onTap: (index) {
        ref.read(indexProvider.notifier).state = index;
      },
    );
    const pages = [
      DownloadPage(),
      DecryptPage(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: bar,
    );
  }
}
