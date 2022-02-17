import 'package:flutter/material.dart';

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
  bool isPasswordVisible = false;
  String password = '';
  String confirmPassword = '';
  String email = '';

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
                    //errorText: 'This Field is Required',
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
                  obscureText: isPasswordVisible,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your password',
                    //errorText: 'This Field is Required',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                    suffixIcon: IconButton(
                      icon: Icon(
                          isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => password = val);
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
                  obscureText: isPasswordVisible,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Confirm your password',
                    //errorText: 'This Field is Required',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                    suffixIcon: IconButton(
                      icon: Icon(
                          isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => confirmPassword = val);
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
                          Switch(
                            value: isSwitched,
                              onChanged: (value){
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
                    onPressed: (){},
                    //navigate to next page
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
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
