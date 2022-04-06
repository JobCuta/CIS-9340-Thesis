import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/apis/ContactDetails.dart';
import 'package:flutter_application_1/apis/EmotionEntryDetail.dart';
import 'package:flutter_application_1/apis/Level.dart';
import 'package:flutter_application_1/apis/SudokuSettings.dart';
import 'package:flutter_application_1/apis/dailyHive.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/apis/hopeBoxHive.dart';
import 'package:flutter_application_1/apis/hopeBoxObject.dart';
import 'package:flutter_application_1/apis/settingsHive.dart';
import 'package:flutter_application_1/apis/userSecureStorage.dart';
import 'package:hive/hive.dart';

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
  bool isLoading = false;

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
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
                      onPressed: () async {
                        if (selectedIndexes.length == 4) {
                          setState(() => isLoading = true);
                          // API CALL TO DELETE ACCOUNT FROM BACKEND
                          // CLEAR HIVE DATA
                          await clearBoxes();
                          // DELETE LOGIN Key
                          UserSecureStorage.removeLoginKey();
                          Timer(const Duration(seconds: 2), () {
                            Get.offAllNamed('/userDeactivateSuccessScreen');
                          });
                        }
                      },
                      child: isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Theme.of(context)
                                    .colorScheme
                                    .neutralWhite01,
                                strokeWidth: 2,
                              ),
                            )
                          : Text('Agree',
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

  clearBoxes() async {
    var phqBox = await Hive.openBox('phq');
    var sidasBox = await Hive.openBox('sidas');
    var dailyBox = await Hive.openBox<DailyHive>('daily');
    var emotionBox = await Hive.openBox<EmotionEntryHive>('emotion');
    var emotionEntryBox =
        await Hive.openBox<EmotionEntryDetail>('emotionEntry');
    var emotionObjBox = await Hive.openBox('emotionObj');
    var settingsBox = await Hive.openBox<SettingsHive>('settings');
    var levelsBox = await Hive.openBox<Level>('level');
    var hopeBox = await Hive.openBox<HopeBox>('hopeBox');
    var hopeBoxObj = await Hive.openBox<HopeBoxObject>('hopeBoxObj');
    var contactBox = await Hive.openBox<ContactDetails>('contactPerson');
    var sudokuBox = await Hive.openBox<SudokuSettings>('sudokuBox');

    // Gets the no. of entries in the HIVE boxes
    print('START');
    print(phqBox.length);
    print(sidasBox.length);
    print(dailyBox.length);
    print(emotionBox.length);
    print(emotionEntryBox.length);
    print(emotionObjBox.length);
    print(settingsBox.length);
    print(levelsBox.length);
    print(hopeBox.length);
    print(hopeBoxObj.length);
    print(contactBox.length);
    print(sudokuBox.length);

    await phqBox.clear();
    await sidasBox.clear();
    await dailyBox.clear();
    await emotionBox.clear();
    await emotionEntryBox.clear();
    await emotionObjBox.clear();
    await settingsBox.clear();
    await levelsBox.clear();
    await hopeBox.clear();
    await hopeBoxObj.clear();
    await contactBox.clear();
    await sudokuBox.clear();

    // Verifies that all entries have been removed from the HIVE boxes
    print('CLEARED');
    print(phqBox.length);
    print(sidasBox.length);
    print(dailyBox.length);
    print(emotionBox.length);
    print(emotionEntryBox.length);
    print(emotionObjBox.length);
    print(settingsBox.length);
    print(levelsBox.length);
    print(hopeBox.length);
    print(hopeBoxObj.length);
    print(contactBox.length);
    print(sudokuBox.length);
  }
}
