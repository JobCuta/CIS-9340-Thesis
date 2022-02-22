import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _loginKey = 'loginkey';

  static Future setKeyLogin(String key) async =>
      await _storage.write(key: _loginKey, value: key);

  static Future<String?> getLoginKey() async =>
      await _storage.read(key: _loginKey);
}
