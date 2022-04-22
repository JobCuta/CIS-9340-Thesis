import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _loginKey = 'loginkey';
  static const _email = 'emailKey';
  static const _usern = 'usernKey';
  static const _firstn = 'firstnKey';
  static const _lastn = 'lastnKey';
  static const _birthday = 'birthdayKey';
  static const _gender = 'genderKey';
  static const _anon = 'anonKey';

  static Future setKeyLogin(String key) async =>
      await _storage.write(key: _loginKey, value: key);

  static Future<String?> getLoginKey() async =>
      await _storage.read(key: _loginKey);

  static removeLoginKey() async => await _storage.delete(key: _loginKey);

  static Future setLoginDetails(String email, String usern, String firstName,
      String lastName, String birthday, String gender, String anon) async {
    await _storage.write(key: _email, value: email);
    await _storage.write(key: _usern, value: usern);
    await _storage.write(key: _firstn, value: firstName);
    await _storage.write(key: _lastn, value: lastName);
    await _storage.write(key: _birthday, value: birthday);
    await _storage.write(key: _gender, value: gender);
    await _storage.write(key: _anon, value: anon);
  }

  static Future<String?> getEmail() async => await _storage.read(key: _email);
  static Future<String?> getUsern() async => await _storage.read(key: _usern);
  static Future<String?> getFirstn() async => await _storage.read(key: _firstn);
  static Future<String?> getLastn() async => await _storage.read(key: _lastn);
  static Future<String?> getBirthday() async =>
      await _storage.read(key: _birthday);
  static Future<String?> getGender() async => await _storage.read(key: _gender);
  static Future<String?> getAnon() async => await _storage.read(key: _anon);
}
