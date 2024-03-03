import "package:envied/envied.dart";

part "env.g.dart";

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: "CLIENT_ID", obfuscate: true)
  static final String clientId = _Env.clientId;
}
