import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _loginKey = 'loginkey';
  static const _email = 'emailKey';
  static const _usern = 'usernKey';

  static Future setKeyLogin(String key) async =>
      await _storage.write(key: _loginKey, value: key);

  static Future<String?> getLoginKey() async =>
      await _storage.read(key: _loginKey);

  static removeLoginKey() async => await _storage.delete(key: _loginKey);

  static Future setLoginDetails(String email, String usern) async {
    await _storage.write(key: _email, value: email);
    await _storage.write(key: _usern, value: usern);
  }

  static Future<String?> getEmail() async => await _storage.read(key: _email);
  static Future<String?> getUsern() async => await _storage.read(key: _usern);
}
