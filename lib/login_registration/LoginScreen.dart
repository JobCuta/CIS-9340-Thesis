import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_registration/ForgotPasswordScreen.dart';

void main() => runApp(const LoginScreen());

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  bool _isObscure = true;
  final _text = TextEditingController();
  late bool _validate = false;
  bool isButtonActive = false;
  late TextEditingController emailController;


  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    emailController.addListener(() {
      final isButtonActive = emailController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget> [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(
                  child: Text('Log in',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                    ),
                  )
              ),
            ),
            const Center(
              child: Text('Please enter your credentials to continue',
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
            Padding(padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Form(
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
                        errorText: _validate ? 'This field is required' : null,
                        border: const OutlineInputBorder(),
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
                      obscureText: _isObscure,
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
                              _isObscure ? Icons.visibility : Icons.visibility_off),
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
                          _text.text.isEmpty ? _validate = true : _validate = false;
                        });
                      },
                    ),
                    const SizedBox(height: 5.0,),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordScreen()
                              ));
                              //Go to Forgot Your Password Screen
                            },
                            child: const Text('Forgot your password?',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(94, 102, 104, 1)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100.0,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onSurface: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          child: const Text('Continue',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Proxima Nova',
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          onPressed: isButtonActive ? () {
            //Navigation and account validation
          }
              :null,
        ),
      ),
    );
  }
}
