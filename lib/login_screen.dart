import 'package:flutter/material.dart';

void main() => runApp(const LoginScreen());

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const SafeArea(
            child: LoginWidgets()
        ),
        bottomSheet: Container(
          width: double.infinity,
          height: 50,
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: TextButton(
            child: const Text('Login',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Proxima Nova',
                    fontSize: 20,
                    color: Colors.white)),
            onPressed: () {
              //navigate to next page
            },
          ),
        ),
      ),
    );
  }
}

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({Key? key}) : super(key: key);

  @override
  State<LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                  ),
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
                    )
                  ),
                const SizedBox(height: 5.0,),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //Go to Forgot Your Password Screen
                        },
                        child: const Text('Forgot your password?',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(94, 102, 104, 1)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}
