import 'dart:developer';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';

class UserProvider extends GetConnect {
  static const domain = "https://kasiyanna-efd6n.ondigitalocean.app/";

  final Map paths = {
    "login": "api/v1/auth/login/",
    "logout": "api/v1/auth/logout/",
    "register": "api/v1/auth/registration/",
    "forgot": "",
    "getUser": "api/v1/auth/user/",
  };

  //POST
  Future login(LoginForm loginData) async {
    final response = await post(domain + paths["login"], loginData.form());
    var map = Map<String, dynamic>.from(response.body);
    String message;
    bool status;
    if (response.hasError) {
      status = false;
      message = map["non_field_errors"];
    } else {
      status = true;
      message = map["key"];
    }
    return {"message": message, "status": status};
  }

  Future register(Map userData) async {
    final response = await post(domain + paths["register"], userData);
    var map = Map<String, dynamic>.from(response.body);
    return map;
  }

  Future<Response> forgotPassword(String email) async =>
      await post(domain + paths["forgot"], email);

  //GET
  Future<Response> logout() async => await get(domain + paths["logout"]);

  //PUT
  Future<Response> updateUser(UserForm userData) async =>
      await put(domain + paths["getUser"], userData);
}
