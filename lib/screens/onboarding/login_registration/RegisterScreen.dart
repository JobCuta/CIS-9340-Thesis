import 'package:flutter/material.dart';

import 'AboutSelfScreen.dart';

void main() {
  runApp(const RegisterScreen());
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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

class _RegisterState extends State<RegisterWidget>{
  bool isSwitched = false;
  bool isPasswordVisible = true;
  bool isPasswordVisible2 = true;
  bool isButtonActive = false;
  bool allFieldsFilled = false;
  late bool _validate = false;
  late bool _validateEmail = false;
  String email = '';
  String password = '';
  String confirmPassword = '';
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      var emailFilled = emailController.text.isNotEmpty;
      passwordController.addListener(() {
        var passwordFilled = passwordController.text.isNotEmpty;
        confirmPasswordController.addListener(() {
          var confirmPasswordFilled = confirmPasswordController.text.isNotEmpty;
          if (emailFilled && passwordFilled && confirmPasswordFilled && isSwitched == true){
            if (passwordController.text == confirmPasswordController.text) {
              const isButtonActive = true;
              setState(() => this.isButtonActive = isButtonActive);
            }
          } else {
            const isButtonActive = false;
            setState(() => this.isButtonActive = isButtonActive);
          }
        });
      });
    });
    emailController.addListener(() {
      var emailFilled = emailController.text.isNotEmpty;
      confirmPasswordController.addListener(() {
        var confirmPasswordFilled = confirmPasswordController.text.isNotEmpty;
        passwordController.addListener(() {
          var passwordFilled = passwordController.text.isNotEmpty;
          if (emailFilled && passwordFilled && confirmPasswordFilled && isSwitched == true){
            if (passwordController.text == confirmPasswordController.text) {
              const isButtonActive = true;
              setState(() => this.isButtonActive = isButtonActive);
            }
          } else {
            const isButtonActive = false;
            setState(() => this.isButtonActive = isButtonActive);
          }
        });
      });
    });
    passwordController.addListener(() {
      var passwordFilled = passwordController.text.isNotEmpty;
      confirmPasswordController.addListener(() {
        var confirmPasswordFilled = confirmPasswordController.text.isNotEmpty;
        emailController.addListener(() {
          var emailFilled = emailController.text.isNotEmpty;
          if (emailFilled && passwordFilled && confirmPasswordFilled && isSwitched == true){
            if (passwordController.text == confirmPasswordController.text) {
              const isButtonActive = true;
              setState(() => this.isButtonActive = isButtonActive);
            }
          } else {
            const isButtonActive = false;
            setState(() => this.isButtonActive = isButtonActive);
          }
        });
      });
    });
    passwordController.addListener(() {
      var passwordFilled = passwordController.text.isNotEmpty;
      emailController.addListener(() {
        var emailFilled = emailController.text.isNotEmpty;
        confirmPasswordController.addListener(() {
          var confirmPasswordFilled = confirmPasswordController.text.isNotEmpty;
          if (emailFilled && passwordFilled && confirmPasswordFilled && isSwitched == true){
            if (passwordController.text == confirmPasswordController.text) {
              const isButtonActive = true;
              setState(() => this.isButtonActive = isButtonActive);
            }
          } else {
            const isButtonActive = false;
            setState(() => this.isButtonActive = isButtonActive);
          }
        });
      });
    });
    confirmPasswordController.addListener(() {
      var confirmPasswordFilled = confirmPasswordController.text.isNotEmpty;
      emailController.addListener(() {
        var emailFilled = emailController.text.isNotEmpty;
        passwordController.addListener(() {
          var passwordFilled = passwordController.text.isNotEmpty;
          if (emailFilled && passwordFilled && confirmPasswordFilled && isSwitched == true){
            if (passwordController.text == confirmPasswordController.text) {
              const isButtonActive = true;
              setState(() => this.isButtonActive = isButtonActive);
            }
          } else {
            const isButtonActive = false;
            setState(() => this.isButtonActive = isButtonActive);
          }
        });
      });
    });
    confirmPasswordController.addListener(() {
      var confirmPasswordFilled = confirmPasswordController.text.isNotEmpty;
      passwordController.addListener(() {
        var passwordFilled = passwordController.text.isNotEmpty;
        emailController.addListener(() {
          var emailFilled = emailController.text.isNotEmpty;
          if (emailFilled && passwordFilled && confirmPasswordFilled && isSwitched == true){
            if (passwordController.text == confirmPasswordController.text) {
              const isButtonActive = true;
              setState(() => this.isButtonActive = isButtonActive);
            }
          } else {
            const isButtonActive = false;
            setState(() => this.isButtonActive = isButtonActive);
          }
        });
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool validateIfPasswordsMatch(String newPass, String confirmPass) {
    if (newPass != confirmPass) {
      setState(() {
        _validate = true;
      });
      return false;
    } else if (newPass.isEmpty || confirmPass.isEmpty) {
      setState(() {
        _validate = true;
      });
    }
    setState(() {
      _validate = false;
    });
    return true;
  }

  @override
  Widget build(BuildContext context){
    return ListView(
      children: <Widget> [
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: Center(
              child: Text('Register',
                style: TextStyle(fontWeight: FontWeight.w800,
                    fontSize: 30,
                    fontFamily: 'Header 5'),
              )
          ),
        ),
        const Center(
          child: Text('Please enter your credentials to continue',
            style: TextStyle(fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: 1,
              fontFamily: 'Body 2',
            ),
          ),
        ),
        const SizedBox(height: 20.0,),
        Padding(padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Form(
            key: _form,
            child: Column(
              children: <Widget> [
                Row(
                  children: const [
                    Text('Email',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(94, 102, 104, 1)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
                TextField(
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  controller: emailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    errorText: _validateEmail ? 'This field is required' : null,
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                  ),
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  onTap: (){
                    setState(() {
                      emailController.text.isEmpty
                          ? _validateEmail = false
                          : _validateEmail = false;
                    });
                  },
                ),
                const SizedBox(height: 20.0,),
                Row(
                  children: const [
                    Text('Password',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(94, 102, 104, 1)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
                TextField(
                  controller: passwordController,
                  obscureText: isPasswordVisible,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                    suffixIcon: IconButton(
                      icon: Icon(
                          isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  onChanged: (val) {
                    validateIfPasswordsMatch(passwordController.text, confirmPasswordController.text);
                  },
                  onTap: () {
                    setState(() {
                      emailController.text.isEmpty
                          ? _validateEmail = true
                          : _validateEmail = false;
                    });
                  },
                ),
                const SizedBox(height: 20.0,),
                Row(
                  children: const [
                    Text('Confirm Password',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(94, 102, 104, 1)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: isPasswordVisible2,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Confirm your password',
                    errorText: _validate ? 'Please make sure your passwords match.' : null,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                    suffixIcon: IconButton(
                      icon: Icon(
                          isPasswordVisible2 ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible2 = !isPasswordVisible2;
                        });
                      },
                    ),
                  ),
                  onChanged: (val) {
                    validateIfPasswordsMatch(passwordController.text, confirmPasswordController.text);
                  },
                  onTap: () {
                    setState(() {
                      emailController.text.isEmpty
                          ? _validateEmail = true
                          : _validateEmail = false;
                    });
                  },
                ),
                const SizedBox(height: 15.0,),
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
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(text: 'terms of use', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                                  TextSpan(text: ' and '),
                                  TextSpan(text: 'privacy policy', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                                ],
                              ),
                            ),
                          ),
                          Switch.adaptive(
                            value: isSwitched,
                            onChanged: (value) {
                              isSwitched = value;
                              if (value == true) {
                                const isButtonActive = true;
                                setState(() => this.isButtonActive = isButtonActive);
                              } else {
                                const isButtonActive = false;
                                setState(() => this.isButtonActive = isButtonActive);
                              }
                            },
                            activeColor: Colors.white,
                            activeTrackColor: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50.0,),
                SizedBox(
                  width: 328,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(10),
                      primary: Colors.green,
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: isButtonActive ? (){
                      //navigate to next page
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const AboutSelfScreen()
                      ));
                    }
                    :null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
