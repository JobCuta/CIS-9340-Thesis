import 'package:flutter/material.dart';
import 'IntroductionScreen.dart';

void main() => runApp(const LanguageSelect());

class LanguageSelect extends StatelessWidget {
  const LanguageSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: LanguagesWidget(),
    );
  }
}

enum Language { english, ilocano, tagalog }

class LanguagesWidget extends StatefulWidget {
  const LanguagesWidget({Key? key}) : super(key: key);

  @override
  State<LanguagesWidget> createState() => _LanguagesState();
}

class _LanguagesState extends State<LanguagesWidget> {
  Language? _language = Language.english;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            const Center(
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Image(image: AssetImage('assets/images/language-select.png')),
                )),
            const Center(
              child: Text("Select language",
                style: TextStyle(fontWeight: FontWeight.w800,
                    fontSize: 30,
                    fontFamily: 'Header 5'),
              ),
            ),
            const SizedBox(height: 15.0,),
            const Center(
              child: Text("Which language would you like to access the app in",
                style: TextStyle(fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 1,
                  fontFamily: 'Body 2',
                  color: Color.fromRGBO(37, 47, 72, 1.0)),
              ),
            ),
            const SizedBox(height: 25.0,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Row(
                    children: const <Widget>[
                      Text("Language",
                        style: TextStyle(fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Body 2',
                            color: Color.fromRGBO(172, 178, 180, 1)),
                      ),
                    ]
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _language = Language.english;
                            });
                          },
                          child: const Text('English',
                            style: TextStyle(fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Body 2'
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Radio(
                              value: Language.english,
                              groupValue: _language,
                              activeColor: Colors.green,
                              onChanged: (Language? value) {
                                setState(() {
                                  _language = value;
                                });
                              })
                      )
                      ],
                    ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromRGBO(240, 241, 241, 1),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: GestureDetector(
                          onTap: () {
                          setState(() {
                            _language = Language.ilocano;
                          });
                        },
                        child: const Text('Ilocano',
                            style: TextStyle(fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Body 2'
                            )),
                        ),
                      ),
                      Expanded(
                      flex: 1,
                      child: Radio(
                          value: Language.ilocano,
                          groupValue: _language,
                          activeColor: Colors.green,
                          onChanged: (Language? value) {
                            setState(() {
                              _language = value;
                            });
                          }),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromRGBO(240, 241, 241, 1),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _language = Language.tagalog;
                            });
                          },
                        child: const Text('Tagalog',
                            style: TextStyle(fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Body 2'
                            )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Radio(
                          value: Language.tagalog,
                          groupValue: _language,
                            activeColor: Colors.green,
                          onChanged: (Language? value) {
                            setState(() {
                              _language = value;
                            });
                          }),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromRGBO(240, 241, 241, 1),
                  ),
                  const SizedBox(height: 75,)
                ],
              ),
            ),
          ],
        ),
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
          child: const Text('Continue',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Proxima Nova',
                  fontSize: 16,
                  color: Colors.white)),
          onPressed: () {
            //navigate to next page
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Intro()
            ));
          },
        ),
      ),
    );
  }
}
