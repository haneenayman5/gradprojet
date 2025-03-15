import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<void> saveUsername(String username) async {
    await storage.write(key: "username", value: username);
  }

  Future<String?> getUsername() async {
    return await storage.read(key: "username");
  }

}