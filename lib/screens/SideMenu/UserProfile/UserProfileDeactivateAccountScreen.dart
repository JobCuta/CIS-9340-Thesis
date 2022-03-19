import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/userProfileController.dart';

class UserProfileDeactivateAccountScreen extends StatefulWidget {
  const UserProfileDeactivateAccountScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileDeactivateAccountScreen> createState() =>
      _UserProfileDeactivateAccountScreenState();
}

class _UserProfileDeactivateAccountScreenState
    extends State<UserProfileDeactivateAccountScreen> {
  var mainText = [
    'Your personal data and usage information will be ',
    'All your achievements and game progress will be ',
    'All mood entries will be deleted and ',
    'You will '
  ];
  var emphasizedText = [
    'deleted.',
    'lost.',
    'cannot be recovered.',
    'not be able to recover your account information.'
  ];
  var selectedIndexes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 1,
            leading: BackButton(
                color: Theme.of(context).colorScheme.accentBlue02,
                onPressed: () {
                  Get.back();
                }),
            backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
            title: Text('Deactivate Account',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.neutralBlack02))),
        primary: true,
        body: Stack(
          children: [
            Column(
              children: [
                ListView.builder(
                    shrinkWrap: true, //just set this property
                    padding: const EdgeInsets.all(8.0),
                    itemCount: mainText.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 0),
                        child: CheckboxListTile(
                          title: RichText(
                            text: TextSpan(children: <InlineSpan>[
                              TextSpan(
                                  text: mainText[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralBlack02,
                                          fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: emphasizedText[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .accentRed02,
                                          fontWeight: FontWeight.w600)),
                            ]),
                          ),
                          autofocus: false,
                          activeColor:
                              Theme.of(context).colorScheme.accentBlue02,
                          value: selectedIndexes.contains(index),
                          onChanged: (bool? value) {
                            if (selectedIndexes.contains(index)) {
                              setState(() {
                                selectedIndexes.remove(index);
                              });
                            } else {
                              setState(() {
                                selectedIndexes.add(index);
                              });
                            }
                          },
                        ),
                      );
                    }),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 25.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.neutralWhite04,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Text(
                      'I have agreed to the terms above and I understand the consequences of deactivating my account.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.neutralGray04)),
                ),
              ],
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: selectedIndexes.length == 4
                              ? Theme.of(context).colorScheme.accentBlue02
                              : Theme.of(context).colorScheme.neutralWhite04),
                      onPressed: () {
                        selectedIndexes.length == 4
                            ? Get.offAllNamed('/userDeactivateSuccessScreen')
                            : null;
                      },
                      child: Text('Agree',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01,
                                  fontWeight: FontWeight.w600)),
                    ),
                  ),
                )),
          ],
        ));
  }
}
