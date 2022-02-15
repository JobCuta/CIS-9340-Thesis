import 'package:flutter/material.dart';

void main() {
  runApp(const LoginScreen());
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Widget titleSection = const Padding(
    padding: EdgeInsets.all(32),
    child: Text(
      'Before we continue...',
      softWrap: true,
    ),
  );

  Widget bodySection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*1*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Create an account!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            /*2*/
            Text(
              'All interactions and data are fully encrypted and secure. Your data is safe with us!',
              style: TextStyle(
                color: Colors.green[500],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget buttonSection(){
    return SizedBox(
      width: 328,
      height: 142,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
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
          const SizedBox(height: 10),
          const Text(
            'Already have an account?',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(12),
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
            children: [
              titleSection,
              bodySection,
              buttonSection(),
            ]
        ),
      ),
    );
  }



}