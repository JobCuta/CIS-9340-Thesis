import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TableSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _lastUpdatePHQ = '';
  static const _lastUpdateSIDAS = '';

  static Future setLatestPHQ(String date) async =>
      await _storage.write(key: _lastUpdatePHQ, value: date);

  static Future<String?> getLatestPHQ() async =>
      await _storage.read(key: _lastUpdatePHQ);

    static Future setLatestSIDAS(String date) async =>
      await _storage.write(key: _lastUpdateSIDAS, value: date);

  static Future<String?> getLatestSIDAS() async =>
      await _storage.read(key: _lastUpdateSIDAS);
}
