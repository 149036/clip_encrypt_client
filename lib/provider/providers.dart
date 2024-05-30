import 'dart:typed_data';

import 'package:clip_encrypt_client/crypt/aes_key.dart';
import 'package:clip_encrypt_client/crypt/algo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexProvider = StateProvider((ref) => 1);
final accessTokenProvider = StateProvider<String?>((ref) => null);
final responseProvider = StateProvider<String>((ref) => "");
final cryptAlgoProvider =
    StateProvider<CryptAlgo>((ref) => CryptAlgo.values[1]);
final aesKeyProvider =
    StateProvider<AesKey?>((ref) => AesKey("none", "none", "none"));
final encryptedFileProvider = StateProvider<Uint8List?>((ref) => null);
final decryptedFileProvider = StateProvider<List<int>?>((ref) => null);
