import 'package:flutter/material.dart';

import 'AboutSelfScreen.dart';
import 'LoginScreen.dart';

void main() {
  runApp(const AnonymousScreen());
}

class AnonymousScreen extends StatelessWidget{
  const AnonymousScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: AnonymousWidget(),
        ),
      ),
    );
  }
}

class AnonymousWidget extends StatefulWidget {
  const AnonymousWidget({Key? key}) : super(key: key);

  @override
  State<AnonymousWidget> createState() => _AnonymousState();
}

class _AnonymousState extends State<AnonymousWidget>{
  String nickName = '';

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Account successfully Registered!', textAlign: TextAlign.center,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  <Widget>[
          Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset('assets/images/yellow_icon.png'),
          ),
          const Text('Check your email to confirm your account in order to log in', textAlign: TextAlign.center,),
        ],
      ),
      actions: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(10),
              primary: Colors.green,
              fixedSize: const Size(245, 50),
            ),
            onPressed: (){
              //navigate to next page
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const LoginScreen()
              ));
            },
            child: const Text(
              'Okay!',
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
        children: <Widget> [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(
                child: Text('Staying Anonymous',
                  style: TextStyle(fontWeight: FontWeight.w800,
                      fontSize: 30,
                      fontFamily: 'Header 5'),
                )
            ),
          ),
          const Center(
            child: Text('What do you want us to call you?',
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
                children: <Widget>[
                  Row(
                    children: const [
                      Text('Nickname',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(94, 102, 104, 1)
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0,),
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter your name',
                      //errorText: 'This Field is Required',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
                    ),
                    onChanged: (val) {
                      setState(() => nickName = val);
                    },
                  ),
                  const SizedBox(height: 400.0,),
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
                      onPressed: (){
                        //navigate to next page
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => _buildPopupDialog(context),
                        ));
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  SizedBox(
                    width: 328,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.all(10),
                        primary: Colors.white,
                      ),
                      onPressed: (){
                        //navigate to next page
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const AboutSelfScreen()
                        ));
                      },
                      child: const Text(
                        'I changed my mind...',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
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