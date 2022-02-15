import 'package:get/get.dart';

class UserProvider extends GetConnect {
  static const domain = '';

  final Map paths = {
    "login": "",
    "register": "",
    "emailCode": "",
    "forgot": ""
  };

  Future<Response> login(Map loginData) => post(
        domain + paths["login"],
        loginData,
      );

  Future<Response> register(Map userData) =>
      post(domain + paths["register"], userData);

  Future<Response> emailCode() => get(domain + paths["emailCode"]);

  Future<Response> forgotPassword(String email) =>
      get(domain + paths["forgot"]);
}
