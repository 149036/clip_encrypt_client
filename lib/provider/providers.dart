import 'package:flutter_riverpod/flutter_riverpod.dart';

final accessTokenProvider = StateProvider<String?>((ref) => null);
final responseProvider = StateProvider<String?>((ref) => null);

final fileNameProvider = StateProvider<String>((ref) => "none");
final keyProvider = StateProvider<String>((ref) => "none");
final ivProvider = StateProvider<String>((ref) => "none");

final indexProvider = StateProvider((ref) => 0);
