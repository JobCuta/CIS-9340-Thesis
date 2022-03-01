import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:get/get.dart';
import 'AboutSelfScreen.dart';

void main() {
  runApp(const RegisterScreen());
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: RegisterWidget(),
        ),
      ),
    );
  }
}

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterWidget> {
  bool isSwitched = false;
  bool isPasswordVisible = true;
  bool isPasswordVisible2 = true;
  late bool _validateEmail = false;
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  handleRegistration() async {
    var response = await UserProvider()
        .register(RegisterForm(email, password, confirmPassword));
    log('response $response');
    return (response["status"]);
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
          )
      ),
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
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            fontFamily: 'Proxima Nova'),
                      )),
                ),
                const SizedBox(height: 15.0),
                const Center(
                  child: Text(
                    'Please enter your credentials to continue',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Body 2',
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                                'Email',
                                style: captionTextStyle()),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          child: TextFormField(
                            style: const TextStyle(fontSize: 14.0),
                            decoration: InputDecoration(
                              isDense: true,
                              border: const OutlineInputBorder(),
                              hintText: 'Enter your email',
                              hintStyle: hintTextStyle(),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 15.0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  )
                              ),
                            ),
                            validator: (input) {
                              if (input == null || input.isEmpty) {
                                return 'This field is required.';
                              } else {
                                _validateEmail = EmailValidator.validate(input);
                                if (_validateEmail != true) {
                                  return 'Please enter a valid email.';
                                }
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          children: [
                            Text(
                                'Password',
                                style: captionTextStyle()),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            ],
                            obscureText: isPasswordVisible,
                            style: const TextStyle(fontSize: 14.0),
                            decoration: InputDecoration(
                              isDense: true,
                              border: const OutlineInputBorder(),
                              hintText: 'Enter your password',
                              hintStyle: hintTextStyle(),
                              contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  )
                              ),
                              suffixIcon: IconButton(
                                iconSize: 25,
                                icon: Icon(isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (input) {
                              if (input == null || input.isEmpty) {
                                return 'This field is required.';
                              }
                              if (input.trim().length < 8) {
                                return 'Password must be at least 8 characters in length';
                              }
                              return null;
                            },
                            onChanged: (val) => password = val,
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          children: [
                            Text(
                                'Confirm Password',
                                style: captionTextStyle())
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            ],
                            obscureText: isPasswordVisible2,
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
                              hintText: 'Enter your password',
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: hintTextStyle(),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  )
                              ),
                              suffixIcon: IconButton(
                                iconSize: 25,
                                icon: Icon(isPasswordVisible2
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible2 = !isPasswordVisible2;
                                  });
                                },
                              ),
                            ),
                            validator: (input) {
                              if (input == null || input.isEmpty) {
                                return 'This field is required';
                              }
                              if (input != password) {
                                return 'Passwords do not match. Please try again.';
                              }
                              return null;
                            },
                            onChanged: (val) => confirmPassword = val,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'I have read and understood the ',
                                        style: const TextStyle(
                                          fontFamily: 'Proxima Nova',
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'terms of use',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue[300])),
                                          const TextSpan(text: ' and '),
                                          TextSpan(
                                              text: 'privacy policy',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue[300])),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Switch.adaptive(
                                    value: isSwitched,
                                    onChanged: (value) {
                                      setState(() {
                                        isSwitched = value;
                                      });
                                    },
                                    activeColor: Colors.white,
                                    activeTrackColor: Colors.green,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.all(10),
                              primary: Colors.green[400],
                              onSurface: Colors.grey[700],
                            ),
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: isSwitched
                                ? () async {
                              if (_form.currentState!.validate()) {
                                bool result = await handleRegistration();
                                if (result) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const AboutSelfScreen()));
                                } else {
                                  Get.snackbar(
                                    "Log in failed",
                                    error,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                  );
                                }
                              }
                              //navigate to next page
                            }
                                : null,
                          ),
                        ),
                        const SizedBox(height: 25,)
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
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(94, 102, 104, 1),
        fontFamily: 'Proxima Nova'
    );
  }

  TextStyle hintTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.grey[500],
        fontFamily: 'Proxima Nova'
    );
  }
}
