import 'package:flutter/material.dart';

void main() {
  runApp(const AboutSelfScreen());
}

class AboutSelfScreen extends StatelessWidget {
  const AboutSelfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: AboutSelfWidget(),
        ),
      ),
    );
  }
}

class AboutSelfWidget extends StatefulWidget {
  const AboutSelfWidget({Key? key}) : super(key: key);

  @override
  State<AboutSelfWidget> createState() => _AboutSelfState();
}

class _AboutSelfState extends State<AboutSelfWidget>{

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('Tell us about yourself',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w800,
                fontSize: 30,
                fontFamily: 'Header 5'),
          ),
          const Text('Please enter your credentials to continue',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w800,
                fontSize: 15,
                fontFamily: 'Header 1'),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: const <Widget>[
                Text('First Name', textAlign: TextAlign.left, style: TextStyle(height: 1.2, fontSize: 15),),
                TextField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Enter your First Name',
                    border: OutlineInputBorder(),
                    //errorText: 'This Field is Required',
                  ),
                ),
                SizedBox(height: 15.0,),
                Text('Last Name', textAlign: TextAlign.left, style: TextStyle(height: 1.2, fontSize: 15),),
                TextField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Enter your Last Name',
                    border: OutlineInputBorder(),
                    //errorText: 'This Field is Required',
                  ),
                ),
                SizedBox(height: 15.0,),
                Text('Nickname (Optional)', textAlign: TextAlign.left, style: TextStyle(height: 1.2, fontSize: 15),),
                TextField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Enter your Nickname',
                    border: OutlineInputBorder(),
                    //errorText: 'This Field is Required',
                  ),
                ),
                SizedBox(height: 15.0,),
                Text('Gender', textAlign: TextAlign.left, style: TextStyle(height: 1.2, fontSize: 15),),
                TextField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Choose your Gender',
                    border: OutlineInputBorder(),
                    //errorText: 'This Field is Required',
                  ),
                ),
                SizedBox(height: 15.0,),
                Text('Birthday', textAlign: TextAlign.left, style: TextStyle(height: 1.2, fontSize: 15),),
                TextField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Enter your Birthday',
                    border: OutlineInputBorder(),
                    //errorText: 'This Field is Required',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}