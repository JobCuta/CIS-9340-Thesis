import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';

void main() => runApp(const LoginModal());

class LoginModal extends StatelessWidget {
  const LoginModal({Key? key}) : super(key: key);

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
    print("response loging ${emailController.text} ${passwordController.text}");
    var response = await UserProvider()
        .login(LoginForm(emailController.text, passwordController.text));
    if (response["status"]) {
      await UserProvider().user(true);
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
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Center(
                      child: Text('Log in',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(fontWeight: FontWeight.w600))),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Text(
                    'Please enter your credentials to continue',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25, left: 20.0, right: 20),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Text('Email',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        fontSize: 12,
                                        color: const Color.fromRGBO(
                                            94, 102, 104, 1)))
                          ],
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
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      fontSize: 12, color: Colors.grey[500]),
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
                            Text('Password',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        fontSize: 12,
                                        color: const Color.fromRGBO(
                                            94, 102, 104, 1))),
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
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      fontSize: 12, color: Colors.grey[500]),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          fontSize: 12,
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
                            child: Text(
                              'Continue',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: Colors.white),
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
                                      Timer(const Duration(seconds: 5), (){
                                        buildShowDialog(context);
                                        Get.offAndToNamed('/homepage');
                                      });
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
}

buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(backgroundColor: Colors.green),
        );
      });
}
