import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';

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
  late bool _isObscure = true;
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/background_images/sunflower_background.png'),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Center(
                      child: Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Proxima Nova',
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Center(
                  child: Text(
                    'Please enter your credentials to continue',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Proxima Nova',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25, left: 20.0, right: 20),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [Text('Email', style: captionTextStyle())],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        SizedBox(
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                            controller: emailController,
                            decoration: InputDecoration(
                              errorText:
                                  _validate ? 'This field is required' : null,
                              border: const OutlineInputBorder(),
                              hintText: 'Enter your email',
                              hintStyle: hintTextStyle(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              )),
                            ),
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
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          children: [
                            Text('Password', style: captionTextStyle()),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        SizedBox(
                          child: TextField(
                            controller: passwordController,
                            obscureText: _isObscure,
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Enter your password',
                              hintStyle: hintTextStyle(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              )),
                              suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                            ),
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
                                  Get.toNamed('/forgotScreen');
                                  //Go to Forgot Your Password Screen
                                },
                                child: Text(
                                  'Forgot your password?',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[500]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100.0),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green[400],
                              onSurface: Colors.grey[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
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
                                    bool result = await handleLogin();
                                    if (result) {
                                      Get.snackbar(
                                        "Logged In",
                                        "It Worked!",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.green,
                                      );
                                      Get.toNamed('/homepage');
                                      //Navigate to main page
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
                        const SizedBox(height: 50)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle captionTextStyle() {
    return const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(94, 102, 104, 1),
        fontFamily: 'Proxima Nova');
  }

  TextStyle hintTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.grey[500],
        fontFamily: 'Proxima Nova');
  }
}
