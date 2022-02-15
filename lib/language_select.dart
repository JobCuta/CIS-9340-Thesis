import 'package:flutter/material.dart';

void main() => runApp(const LanguageSelect());

class LanguageSelect extends StatelessWidget {
  const LanguageSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: LanguagesWidget(),
          ),
        )
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
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Image.asset('assets/images/language-select.png',),
        ),
        const Text("Select language",
          style: TextStyle(fontWeight: FontWeight.w800,
              fontSize: 30,
              fontFamily: 'Header 5'),
        ),
        const SizedBox(height: 15.0,),
        const Text("Which language would you like to access the app in",
          style: TextStyle(fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: 1,
              fontFamily: 'Body 2',
              color: Color.fromRGBO(37, 47, 72, 1.0)),
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
                          onChanged: (Language? value) {
                            setState(() {
                              _language = value;
                            });
                          })
                  )
                ],
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
                        onChanged: (Language? value) {
                          setState(() {
                            _language = value;
                          });
                        }),
                  )
                ],
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
                        onChanged: (Language? value) {
                          setState(() {
                            _language = value;
                          });
                        }),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
