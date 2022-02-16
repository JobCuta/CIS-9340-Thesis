import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';

class UserProvider extends GetConnect {

  static const domain = "https://kasiyanna-efd6n.ondigitalocean.app/";

  final Map paths = {
    "login": "api/v1/auth/registration/",
    "logout":"api/v1/auth/logout/",
    "register": "api/v1/auth/login/",
    "forgot": "",
    "getUser": "api/v1/auth/user/",
  };

  //POST
  Future<Response> login(LoginForm loginData) => post( domain + paths["login"], loginData);

  Future<Response> register(Map userData) => post( domain + paths["register"], userData);

  Future<Response> forgotPassword(String email) => post(domain + paths["forgot"], email);

  //GET
  Future<Response> logout() => get(domain + paths["logout"]);
  
  //PUT
  Future<Response> updateUser(UserForm userData) => put(domain + paths["getUser"], userData);

}
