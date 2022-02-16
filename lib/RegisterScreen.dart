import 'package:flutter/foundation.dart';
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

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text('Register',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w800,
                fontSize: 30,
                fontFamily: 'Header 5'),
          ),
        const SizedBox(height: 15.0,),
        const Text('Please enter your credentials to continue',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: 1,
              fontFamily: 'Body 2',
              color: Color.fromRGBO(37, 47, 72, 1.0)),
        ),
        const SizedBox(height: 20.0,),
        const SizedBox(
          width: 320,
          height: 61,
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Email',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 20.0,),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                            ]
                        ),
                      ),
                    ),
                    Switch(
                      value: isSwitched,
                        onChanged: (value){
                          setState(() {
                            isSwitched = value;
                            if (kDebugMode) {
                              print(isSwitched);
                            }
                          });
                        },
                    )
                  ],
                ),
              ],
            ),
        ),
        const SizedBox(height: 100.0,),
        SizedBox(
          width: 328,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(12),
              primary: Colors.green,
            ),
            onPressed: () {},
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
