import 'package:flutter/material.dart';
import 'package:flutter_application_1/intro/ShakeScreen.dart';

void main() {
  runApp(const Intro());
}

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Background.png"),
                  fit: BoxFit.cover)),
          child: const CreateAccountWidget(),
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
          padding: EdgeInsets.fromLTRB(20.0, 70.0 , 20.0, 30.0),
          child: Text(
            'Welcome to Kasiyanna!',
            style: TextStyle(fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Header 5'),
          ),
        ),const SizedBox(height: 10.0,),
        const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w400,
          fontSize: 15,
          letterSpacing: 4,
          fontFamily: 'Body 2',
              color: Colors.white
          ),
        ),
        const SizedBox(height: 15.0,),
        Padding(
          padding: const EdgeInsets.all(25),
          child: Image.asset('assets/images/meditate.png',),
        ),
        const SizedBox(height: 10.0,),
        SizedBox(
          width: 340,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(12),
              primary: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ShakeScreen()
              ));
            },
            child: const Text(
              'Start your journey',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Your privacy matters to us. You can learn how we can handle your information when you use our Services by reading our Privacy Policy',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey
          ),
        ),
      ],
    );
  }
}





