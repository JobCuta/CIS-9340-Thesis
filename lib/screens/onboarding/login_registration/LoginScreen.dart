import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';

import 'ForgotPasswordScreen.dart';

void main() => runApp(const LoginScreen());

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: LoginWidgets(),
    );
  }
}

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({Key? key}) : super(key: key);

  @override
  State<LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  String email = '';
  String password = '';
  final bool _isObscure = true;
  late bool _validate = false;
  bool isButtonActive = false;
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  String error = '';

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      var emailFilled = emailController.text.isNotEmpty;
      passwordController.addListener(() {
        var passwordFilled = passwordController.text.isNotEmpty;
        if (emailFilled && passwordFilled == true) {
          const isButtonActive = true;
          setState(() => this.isButtonActive = isButtonActive);
        } else {
          const isButtonActive = false;
          setState(() => this.isButtonActive = isButtonActive);
        }
      });
    });
    passwordController.addListener(() {
      var passwordFilled = passwordController.text.isNotEmpty;
      emailController.addListener(() {
        var emailFilled = emailController.text.isNotEmpty;
        if (emailFilled && passwordFilled == true) {
          const isButtonActive = true;
          setState(() => this.isButtonActive = isButtonActive);
        } else {
          const isButtonActive = false;
          setState(() => this.isButtonActive = isButtonActive);
        }
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  handleLogin() async {
    var response = await UserProvider()
        .login(LoginForm(emailController.text, passwordController.text));
    if (response["status"]) {
      return true;
    } else {
      error = response["message"];
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(
                  child: Text(
                'Log in',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w600,
                ),
              )),
            ),
            const Center(
              child: Text(
                'Please enter your credentials to continue',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Image(image: AssetImage('assets/images/sunflower.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Form(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: const [
                        Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(94, 102, 104, 1)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                      controller: emailController,
                      decoration: textFieldStyle(),
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      onTap: () {
                        setState(() {
                          emailController.text.isEmpty
                              ? _validate = false
                              : _validate = false;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: const [
                        Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(94, 102, 104, 1)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: _isObscure,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                      decoration: textFieldStyle(),
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      onTap: () {
                        setState(() {
                          emailController.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordScreen()));
                              //Go to Forgot Your Password Screen
                            },
                            child: const Text(
                              'Forgot your password?',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(94, 102, 104, 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onSurface: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Proxima Nova',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: isButtonActive
                          ? () async {
                              //Navigation and account validation
                              bool result = await handleLogin() ;
                              if (result) {
                                Get.snackbar(
                                  "Logged In",
                                  "It Worked!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                );
                              } else {
                                Get.snackbar(
                                  "Log in failed",
                                  error,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                );
                              }
                            }
                          : null,
                    ),
                  ),
                ],  
              ),
            ),
          ),
        ],
      );
  }

  InputDecoration textFieldStyle() {
    return InputDecoration(
      errorText: _validate ? 'This field is required' : null,
      border: const OutlineInputBorder(),
      hintText: 'Enter your email',
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.grey[700],
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
    );
  }
}
