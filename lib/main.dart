import 'package:clip_encrypt_client/go_router_conf.dart';
import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

void main() async {
  final app = GoRouterConf();

  final scope = ProviderScope(child: app);

  runApp(scope);
}
