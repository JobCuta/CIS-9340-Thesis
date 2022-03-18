import 'package:flutter_application_1/apis/userSecureStorage.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class UserProvider extends GetConnect {
  final storage = const FlutterSecureStorage();
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
    "forgot": "api/v1/auth/reset/",
    "getUser": "api/v1/auth/user/",
  };

  //POST
  Future login(LoginForm loginData) async {
    final response = await post(domain + paths["login"], loginData.form());
    print('response ${response}');
    var map = Map<String, dynamic>.from(response.body);
    String message = "";
    bool status = false;
    if (response.hasError && map.containsKey("non_field_errors")) {
      message = map["non_field_errors"][0];
    } else {
      if (map.containsKey("key")) {
        status = true;
        message = "Successfully logged in.";
        await UserSecureStorage.setKeyLogin(map["key"]);
      } else {
        message =
            "Unknown error occurred checking if response contains login key";
      }
    }
    return {"message": message, "status": status};
  }

  Future register(RegisterForm userData) async {
    final response = await post(domain + paths["register"], userData.form());
    print('register response ${response.body}');
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
        message =
            "Unknown error occured verifying user details during registration";
      }
    }
    return {"message": message, "status": status};
  }

  Future forgotPassword(String email) async {
    final response = await post(domain + paths["forgot"], {"email": email});
    print('forgot response ${response.statusText} ${response.body}');
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

  //GET
  Future<Response> logout() async {
    var response = await get(domain + paths["logout"]);
    UserSecureStorage.removeLoginKey();
    return response;
  }

  Future<Object> user(bool initial) async {
    String key = "";
    await UserSecureStorage.getLoginKey()
        .then((value) => key = value.toString());
    final response = await get(domain + paths["getUser"],
        headers: {"Authorization": "Token " + key});
    var map = Map<String, dynamic>.from(response.body);
    print("it be like that");
    if (!response.hasError) {
      print("it be like that2 $map");
      if (initial) {
        print("hello ${map["email"]}");

        await UserSecureStorage.setLoginDetails(
            map["email"],
            map["nickname"] == "" ? map["first_name"] : map["nickname"],
            map["first_name"],
            map["last_name"],
            map["date_of_birth"],
            map["gender"]);
        return true;
      } else {
        return response;
      }
    } else {
      return false;
    }
  }
}
