import 'package:flutter/material.dart';
import 'language_select.dart';

void main() => runApp(const logoPage());


class logoPage extends StatelessWidget {
  const logoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //appBar: AppBar(title: Text("Kasiyana")),
        body: Center(
          child: FlatButton(
            padding: EdgeInsets.all(0.0),
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => LanguageSelect()
            ));
          },
            child: Image.asset('assets/images/splash.png'),
          )
        )
      ),
    );
  }
}


