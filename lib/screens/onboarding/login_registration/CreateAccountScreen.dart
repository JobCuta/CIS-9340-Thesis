import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';

void main() {
  runApp(const CreateAccountScreen());
}

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(242, 255, 245, 1.0),
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

class _CreateAccountScreenState extends State<CreateAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
          child: Text(
            'Before we continue...',
            softWrap: true,
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/images/create.png'),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          'Create an account!',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 30,
              fontFamily: 'Header 5'),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'All interactions and data are fully encrypted and secure. Your data is safe with us!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: 1,
                fontFamily: 'Body 2',
                color: Color.fromRGBO(37, 47, 72, 1.0)),
          ),
        ),
        const SizedBox(
          height: 50.0,
        ),
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
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)
                    ),
                  ),
                  useRootNavigator: true,
                  isScrollControlled: true,
                  builder: (context) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: const RegisterWidget()
                    );
                  });
            },
            child: const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Already have an account?',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 15),
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
            onPressed: () {
              showModalBottomSheet(
                context: context, 
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4)
                  ),
                ),
                useRootNavigator: true,
                isScrollControlled: true,
                builder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: const LoginWidgets()
                  );
                }
              );
            },
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
