import 'dart:developer';

import 'package:flutter_application_1/apis/EmotionEntryDetail.dart';
import 'package:flutter_application_1/apis/Level.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/apis/phqHive.dart';
import 'package:flutter_application_1/apis/settingsHive.dart';
import 'package:flutter_application_1/apis/sidasHive.dart';
import 'package:flutter_application_1/apis/userSecureStorage.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserProvider extends GetConnect {
  static const domain = "https://kasiyanna-efd6n.ondigitalocean.app/";

  @override
  void onInit() {
    httpClient.baseUrl = domain;
    httpClient.timeout = const Duration(seconds: 10);
  }

  final Map paths = {
    "login": "api/v1/auth/login/",
    "logout": "api/v1/auth/logout/",
    "register": "api/v1/auth/registration/",
    "forgot": "api/v1/auth/password/reset/",
    "getUser": "api/v1/auth/user/",
    "PHQ": "api/v1/PHQ9/",
    "PHQL": "api/v1/PHQ9-LIST/",
    "SIDAS": "api/v1/SIDAS/",
    "emotion": "api/v1/EmotionEntry/",
    "bulkPHQ": "api/v1/PHQ9-UPDATE/",
    'bulkSIDAS': "api/v1/SIDAS-UPDATE/",
    'bulkEmotion': "api/v1/EMOTIONS-UPDATE/",
    'feedback': "api/v1/CustomerSupport/",
    'notifs': "api/v1/NotificationSettings/"
  };

  //POST
  Future login(LoginForm loginData) async {
    final response = await post(domain + paths["login"], loginData.form());
    var map = Map<String, dynamic>.from(response.body);
    String message = "";
    bool status = false, firstTimeLogin = false;
    if (response.hasError && map.containsKey("non_field_errors")) {
      log('look ehre');
      message = map["non_field_errors"][0];
    } else {
      if (map.containsKey("key")) {
        log('login key ${map['key']}');
        status = true;
        message = "Successfully logged in.";
        await UserSecureStorage.setKeyLogin(map["key"]);
        var user = Map<String, dynamic>.from(map["user"]);
        await UserSecureStorage.setLoginDetails(
          user["email"],
          user["nickname"] == "" ? user["first_name"] : user["nickname"],
          user["first_name"],
          user["last_name"],
          user["date_of_birth"],
          user["gender"],
          user["anon"].toString(),
        );
        firstTimeLogin = user["first_time_login"];
      } else if (map.containsKey("email")) {
        message = map["email"][0];
      } else {
        message = "Unknown error occurred during Login";
      }
    }
    return {"message": message, "status": status, "firstTimeLogin": firstTimeLogin};
  }

  Future register(RegisterForm userData) async {
    var form = userData.anon
        ? userData.anonForm()
        : userData.nickn.isEmpty
            ? userData.userFormN()
            : userData.userForm();
    final response = await post(domain + paths["register"], form);
    log('register response ${response.body}');
    var map = Map<String, dynamic>.from(response.body);
    String message = "";
    bool status = false;
    if (response.hasError) {
      if (map.containsKey("email")) {
        message = map["email"][0];
      } else if (map.containsKey("password1")) {
        message = map["password1"][0];
      } else if (map.containsKey("non_field_errors")) {
        message = map["non_field_errors"].join(",");
      }
    } else {
      if (map.containsKey("detail")) {
        status = true;
        message = map["detail"];
      } else {
        message = "Unknown error occured verifying user details during registration";
      }
    }
    return {"message": message, "status": status};
  }

  Future forgotPassword(String email) async {
    final response = await post(domain + paths["forgot"], {"email": email});
    // print('forgot response ${response.statusText} ${response.body}');
    var map = Map<String, dynamic>.from(response.body);
    if (response.hasError) {
      if (map.containsKey("detail")) {
        return {"status": false, "detail": map["detail"]};
      } else if (map.containsKey("email")) {
        return {"status": false, "email": map["email"][0]};
      } else {
        return {"status": false, "detail": "Uncaught Server Error"};
      }
    }
    return {"status": true, "detail": map["detail"]};
  }

  Future<Map<String, dynamic>> createPHQ(phqHive entry) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await post(domain + paths["PHQ"], {
      "date_created": entry.date.toUtc().toString(),
      "score": entry.score,
    }, headers: {
      "Authorization": "Token " + key
    });
    if (response.hasError) {
      log('create PHQ9 entry error ${response.statusText} ${response.body}');
      return {"status": false};
    }
    return {"status": true, "body": response.body};
  }

  Future<Map<String, dynamic>> createSIDAS(sidasHive entry) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await post(domain + paths["SIDAS"], {
      "date_created": entry.date.toUtc().toString(),
      "sum": entry.score,
    }, headers: {
      "Authorization": "Token " + key
    });
    if (response.hasError) {
      log('create SIDAS entry error ${response.statusText} ${response.body}');
      return {"status": false};
    }
    return {"status": true, "body": response.body};
  }

  Future<Map<String, dynamic>> createEmotion(EmotionEntryDetail entry, DateTime date) async {
    List pList = entry.positiveEmotions.map((e) => e.name).toList();
    List nList = entry.negativeEmotions.map((e) => e.name).toList();
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await post(domain + paths["emotion"], {
      "date": '${date.year}-${date.month}-${date.day}',
      "date_time_answered": DateTime.now().toUtc().toString(),
      "time_of_day": entry.timeOfDay,
      "current_mood": entry.mood,
      "note": entry.note,
      "positive_emotions": pList,
      "negative_emotions": nList,
    }, headers: {
      "Authorization": "Token " + key
    });
    if (response.hasError) {
      log('create Emotion entry error ${response.statusText} ${response.body}');
      return {"status": false};
    }
    return {"status": true, "body": response.body};
  }

  Future<bool> bulkPhqUpdate(List entries) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await post(domain + paths["bulkPHQ"], entries, headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('bulk phq update error ${response.statusText} ${response.body}');
      return false;
    }
    return true;
  }

  Future<bool> bulkSidasUpdate(List entries) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await post(domain + paths["bulkSIDAS"], entries, headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('bulk sidas update error ${response.statusText} ${response.body}');
      return false;
    }
    return true;
  }

  Future<bool> bulkEmotionUpdate(List entries) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await post(domain + paths['bulkEmotion'], entries, headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('bulk emotion update error ${response.statusText} ${response.body}');
      return false;
    }
    return true;
  }

  Future<bool> sendCustomerFeedback(String text) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await post(domain + paths['feedback'], {"date_created": '', "text": text},
        headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('feedback error ${response.statusText} ${response.body}');
      return false;
    }
    return true;
  }

  Future<Map> createNotifs(SettingsHive settings) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    formatTime(List<String> list) => '${list[0]}:${list[1]}';
    final response = await post(domain + paths['notifs'], {
      "morning": formatTime(settings.notificationsMorningTime),
      "afternoon": formatTime(settings.notificationsAfternoonTime),
      "evening": formatTime(settings.notificationsEveningTime),
      "notifs_enabled": settings.notificationsEnabled,
      "phqNotif": settings.phqNotificationsEnabled,
      "sidasNotif": settings.sidasNotificationsEnabled,
    }, headers: {
      "Authorization": "Token " + key
    });
    if (response.hasError) {
      log('create notifs error ${response.statusText} ${response.body}');
      if (response.statusText == 'Bad Request') return {"id": -1};
      return {};
    }
    return response.body;
  }

  //GET
  Future<bool> logout() async {
    var response = await get(domain + paths["logout"]);
    UserSecureStorage.removeLoginKey();
    if (response.hasError) {
      log('logout error ${response.statusText}');
      return false;
    }
    log('logging out.. ${response.body}');
    return true;
  }

  Future<bool> user() async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await get(domain + paths["getUser"], headers: {"Authorization": "Token " + key});
    log('get user response ${response.body}');
    var map = Map<String, dynamic>.from(response.body);
    if (!response.hasError) {
      log('da map $map');
      await UserSecureStorage.setLoginDetails(
        map["email"],
        map["nickname"] == "" ? map["first_name"] : map["nickname"],
        map["first_name"],
        map["last_name"],
        map["date_of_birth"],
        map["gender"],
        map["anon"].toString(),
      );
      return true;
    } else {
      return false;
    }
  }

  Future<Map> getUser() async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await get(domain + paths["getUser"], headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('get user error ${response.statusText} ${response.body}');
      return {};
    }
    return response.body;
  }

  Future phqScores() async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await get(domain + paths["PHQ"], headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('phq scores error ${response.statusText}');
      return response.statusText;
    }
    List<dynamic> body = response.body;
    log('scores body $body');
    return body;
  }

  Future sidasScores() async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await get(domain + paths["SIDAS"], headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('sidas scores error ${response.statusText}');
      return response.statusText;
    }
    List<dynamic> body = response.body;
    log('scores body $body');
    return body;
  }

  Future<List> emotionScores() async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await get(domain + paths["emotion"], headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('emotion scores error ${response.statusText}');
      return [];
    }
    // log('scores body $body');
    return response.body;
  }

  Future<Map> savedNotifs() async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await get(domain + paths["notifs"], headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('notif settings error ${response.statusText}');
      return {};
    }
    log('notifs body ${response.body}');
    return response.body[0];
  }

  //PUT
  Future<bool> firstLogin() async {
    String key = "", email = '';
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    await UserSecureStorage.getEmail().then((value) => email = value.toString());
    log('first time ${domain + paths["getUser"]} | $key, $email');
    final response = await put(domain + paths["getUser"], {"email": email, "first_time_login": false},
        headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('first time error ${response.statusText}');
      return false;
    }
    log('first time login ${response.body}');
    return true;
  }

  Future<bool> updatePHQ(int score, String index) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response =
        await put(domain + paths["PHQ"] + '$index/', {"score": score}, headers: {"Authorization": "Token" + key});
    if (response.hasError) {
      log('error ${response.statusText} ${response.body}');
      return false;
    }
    return true;
  }

  Future<bool> updateSIDAS(int score, String index) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response =
        await put(domain + paths["SIDAS"] + '$index/', {"score": score}, headers: {"Authorization": "Token" + key});
    if (response.hasError) {
      log('error ${response.statusText} ${response.body}');
      return false;
    }
    return true;
  }

  Future<Map<String, String>> updateEmotion(EmotionEntryDetail entry, DateTime date) async {
    List pList = entry.positiveEmotions.map((e) => e.name).toList();
    List nList = entry.negativeEmotions.map((e) => e.name).toList();
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await put(domain + paths['emotion'] + '${entry.id}/', {
      "date": '${date.year}-${date.month}-${date.day}',
      "date_time_answered": DateTime.now().toUtc().toString(),
      "time_of_day": entry.timeOfDay,
      "current_mood": entry.mood,
      "positive_emotions": pList,
      "negative_emotions": nList,
    }, headers: {
      "Authorization": "Token " + key
    });
    if (response.hasError) {
      log('update emotion entry error ${response.statusText}');
      if (response.statusText == "Not Found") {
        return {"status": "Not Found"};
      }
      return {"status": "Error"};
    }
    return {"status": "Updated"};
  }

  Future<Map> updateNotifs(SettingsHive settings, String id) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    formatTime(List<String> list) => '${list[0]}:${list[1]}';
    final response = await put(domain + paths['notifs'] + '$id/', {
      "morning": formatTime(settings.notificationsMorningTime),
      "afternoon": formatTime(settings.notificationsAfternoonTime),
      "evening": formatTime(settings.notificationsEveningTime),
      "notifs_enabled": settings.notificationsEnabled,
      "phqNotif": settings.phqNotificationsEnabled,
      "sidasNotif": settings.sidasNotificationsEnabled,
    }, headers: {
      "Authorization": "Token " + key
    });
    if (response.hasError) {
      log('update notifs error ${response.statusText} ${response.body}');
      return {};
    }
    return response.body;
  }

  Future updateEXP(Level level) async {
    String key = "", email = '';
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    await UserSecureStorage.getEmail().then((value) => email = value.toString());
    final response = await put(
        domain + paths['user'], {"email": email, "exp": (level.currentLevel * level.xpForNextLevel) + level.currentXp},
        headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('update exp error ${response.statusText} ${response.body}');
      return false;
    }
    return true;
  }

  Future updateFrame(String path) async {
    String key = "", email = '';
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    await UserSecureStorage.getEmail().then((value) => email = value.toString());
    final response = await put(domain + paths['getUser'], {"email": email, "frame": path},
        headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('update frame error ${response.statusText} ${response.body}');
      return false;
    }
    return true;
  }
}
