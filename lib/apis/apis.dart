import 'dart:developer';

import 'package:flutter_application_1/apis/phqHiveObject.dart';
import 'package:flutter_application_1/apis/sidasHive.dart';
import 'package:flutter_application_1/apis/userSecureStorage.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';

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
  };

  //POST
  Future login(LoginForm loginData) async {
    final response = await post(domain + paths["login"], loginData.form());
    var map = Map<String, dynamic>.from(response.body);
    String message = "";
    bool status = false, firstTimeLogin = false;
    if (response.hasError && map.containsKey("non_field_errors")) {
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
            user["anon"].toString());
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

  Future<Map<String, dynamic>> createPHQ(phqHiveObj entry) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await post(domain + paths["PHQ"], {
      "date_created": entry.date.toString(),
      "score": entry.score,
    }, headers: {
      "Authorization": "Token " + key
    });
    if (response.hasError) {
      log('create PHQ9 entry error ${response.statusText}');
      return {"status": false};
    }
    return {"status": true, "body": response.body};
  }

  Future<Map<String, dynamic>> createSIDAS(sidasHive entry) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await post(domain + paths["SIDAS"], {
      "date_created": entry.date.toString(),
      "sum": entry.score,
    }, headers: {
      "Authorization": "Token " + key
    });
    if (response.hasError) {
      log('create SIDAS entry error ${response.statusText}');
      return {"status": false};
    }
    return {"status": true, "body": response.body};
  }

  //GET
  Future<Response> logout() async {
    var response = await get(domain + paths["logout"]);
    UserSecureStorage.removeLoginKey();
    return response;
  }

  Future<Object> user() async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await get(domain + paths["getUser"], headers: {"Authorization": "Token " + key});
    log('get user response ${response.body}');
    var map = Map<String, dynamic>.from(response.body);
    if (!response.hasError) {
      log('da map $map');
      await UserSecureStorage.setLoginDetails(map["email"], map["nickname"] == "" ? map["first_name"] : map["nickname"],
          map["first_name"], map["last_name"], map["date_of_birth"], map["gender"], map["anon"].toString());
      return true;
    } else {
      return false;
    }
  }

  Future phqScores() async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await get(domain + paths["PHQ"], headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('error ${response.statusText}');
      return response.statusText;
    }
    List<dynamic> body = response.body;
    log('scores body $body');
    return response.body;
  }

  Future sidasScores() async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response = await get(domain + paths["SIDAS"], headers: {"Authorization": "Token " + key});
    List<dynamic> body = response.body;
    log('scores body $body');
    return response.body;
  }

  //PUT
  Future firstLogin() async {
    String key = "", email = '';
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    await UserSecureStorage.getEmail().then((value) => email = value.toString());
    final response = await put(domain + paths["getUser"], {"email": email, "first_time_login": false},
        headers: {"Authorization": "Token " + key});
    if (response.hasError) {
      log('error ${response.statusText}');
      return false;
    }
    return true;
  }

  Future updatePHQ(int score, String index) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response =
        await put(domain + paths["PHQ"] + '$index/', {"score": score}, headers: {"Authorization": "Token" + key});
    if (response.hasError) {
      log('error ${response.statusText}');
      return false;
    }
    return true;
  }

  Future updateSIDAS(int score, String index) async {
    String key = "";
    await UserSecureStorage.getLoginKey().then((value) => key = value.toString());
    final response =
        await put(domain + paths["SIDAS"] + '$index/', {"score": score}, headers: {"Authorization": "Token" + key});
    if (response.hasError) {
      log('error ${response.statusText}');
      return false;
    }
    return true;
  }
}
