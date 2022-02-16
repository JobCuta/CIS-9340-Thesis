import 'package:flutter/material.dart';

void main() {
  runApp(const CreateAccountScreen());
}

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: CreateAccountWidget(),
        ),
      ),
    );
  }
}
class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({Key? key}) : super(key: key);

  @override
  State<CreateAccountWidget> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountWidget>{

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            'Before we continue...',
            softWrap: true,
          ),
        ),
        const SizedBox(height: 15.0,),
        Padding(
          padding: const EdgeInsets.all(25),
          child: Image.asset('assets/images/language-select.png',),
        ),
        const SizedBox(height: 20.0,),
        const Text('Create an account!',
          style: TextStyle(fontWeight: FontWeight.w800,
              fontSize: 30,
              fontFamily: 'Header 5'),
        ),
        const SizedBox(height: 10.0,),
        const Text('All interactions and data are fully encrypted and secure. Your data is safe with us!',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: 1,
              fontFamily: 'Body 2',
              color: Color.fromRGBO(37, 47, 72, 1.0)),
        ),
        const SizedBox(height: 15.0,),
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
              'Sign up',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Already have an account?',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 328,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(15),
              primary: Colors.white,
            ),
            onPressed: () {},
            child: const Text(
              'Log in',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }
}





