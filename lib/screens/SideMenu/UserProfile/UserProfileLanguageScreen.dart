import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';

class UserProfileLanguageScreen extends StatefulWidget {
  const UserProfileLanguageScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileLanguageScreen> createState() =>
      _UserProfileLanguageScreenState();
}

String _locale = "English";

class _UserProfileLanguageScreenState extends State<UserProfileLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
      appBar: AppBar(
          elevation: 1,
          leading: BackButton(
              color: Theme.of(context).colorScheme.accentBlue02,
              onPressed: () {
                Get.back();
              }),
          backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
          title: Text('Language',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralBlack02))),
      primary: true,
      body: Stack(
        children: [
          ListView(
              shrinkWrap: true, //just set this property
              padding: const EdgeInsets.all(8.0),
              children: [
                RadioListTile(
                  title: Text('English',
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.neutralBlack02)),
                  value: 'English',
                  activeColor: Theme.of(context).colorScheme.accentBlue02,
                  controlAffinity: ListTileControlAffinity.trailing,
                  groupValue: _locale,
                  onChanged: (String? value) {
                    setState(() {
                      _locale = value.toString();
                    });
                    print(_locale);
                  },
                ),
                // Remove after localization is integrated
                AbsorbPointer(
                  absorbing: true,
                  child: RadioListTile(
                    tileColor: Theme.of(context).colorScheme.neutralWhite04,
                    title: Text('Ilocano',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).colorScheme.neutralGray01)),
                    value: 'Ilocano',
                    activeColor: Theme.of(context).colorScheme.accentBlue02,
                    controlAffinity: ListTileControlAffinity.trailing,
                    groupValue: _locale,
                    onChanged: (String? value) {
                      null;
                      // setState(() {
                      //   _locale = value.toString();
                      //   // print(_locale);
                      // });
                      print(_locale);
                    },
                  ),
                ),
                // Remove after localization is integrated
                AbsorbPointer(
                  absorbing: true,
                  child: RadioListTile(
                    tileColor: Theme.of(context).colorScheme.neutralWhite04,
                    title: Text('Tagalog',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).colorScheme.neutralGray01)),
                    value: 'Tagalog',
                    activeColor: Theme.of(context).colorScheme.accentBlue02,
                    groupValue: _locale,
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (String? value) {
                      null;
                      // setState(() {
                      //   _locale = value.toString();
                      // });
                      print(_locale);
                    },
                  ),
                )
              ]),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).colorScheme.accentBlue02),
                    onPressed: () {},
                    child: Text('Save',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).colorScheme.neutralWhite01,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
