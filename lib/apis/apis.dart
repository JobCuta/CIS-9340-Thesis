import 'package:flutter_application_1/apis/userSecureStorage.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class UserProvider extends GetConnect {
  final storage = const FlutterSecureStorage();
  static const domain = "https://kasiyanna-efd6n.ondigitalocean.app/";

  final Map paths = {
    "login": "api/v1/auth/login/",
    "logout": "api/v1/auth/logout/",
    "register": "api/v1/auth/registration/",
    "forgot": "api/v1/auth/forgot/",
    "getUser": "api/v1/auth/user/",
  };

  //POST
  Future login(LoginForm loginData) async {
    final response = await post(domain + paths["login"], loginData.form());
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
      if (map.containsKey("details")) {
        status = true;
        message = map["details"];
      } else {
        message =
            "Unknown error occured verifying user details during registration";
      }
    }
    return {"message": message, "status": status};
  }

  Future<bool> forgotPassword(String email) async {
    final response = await post(domain + paths["forgot"], email);
    if (response.hasError) {
      return false;
    }
    return true;
  }

  //GET
  Future<Response> logout() async => await get(domain + paths["logout"]);

  //PUT
  Future<bool> updateUser(UserForm userData) async {
    String? authKey = await UserSecureStorage.getLoginKey();
    final response = await put(domain + paths["getUser"], userData.form(),
        headers: {"Authorization": "Token " + authKey!});
    if (response.hasError) {
      return false;
    }
      return true;
  }
}
