import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TableSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _lastUpdatePHQ = 'phqKey';
  static const _lastUpdateSIDAS = 'sidasKey';
  static const _lastUpdateEmotion = 'emotionKey';

  static Future setLatestPHQ(String date) async =>
      await _storage.write(key: _lastUpdatePHQ, value: date);

  static Future<String?> getLatestPHQ() async =>
      await _storage.read(key: _lastUpdatePHQ);

  static Future setLatestSIDAS(String date) async =>
      await _storage.write(key: _lastUpdateSIDAS, value: date);

  static Future<String?> getLatestSIDAS() async =>
      await _storage.read(key: _lastUpdateSIDAS);
  
  static Future setLatestEmotion(String date) async =>
      await _storage.write(key: _lastUpdateEmotion, value: date);

  static Future<String?> getLatestEmotion() async =>
      await _storage.read(key: _lastUpdateEmotion);
}
