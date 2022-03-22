import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:hive/hive.dart';

import '../../../apis/EmotionEntryDetail.dart';
import '../../../apis/dailyHive.dart';
import '../../../apis/emotionEntryHive.dart';
import '../../../apis/userSecureStorage.dart';

class UserProfileDeactivateSuccessfulScreen extends StatefulWidget {
  const UserProfileDeactivateSuccessfulScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileDeactivateSuccessfulScreen> createState() =>
      _UserProfileDeactivateSuccessfulScreenState();
}

class _UserProfileDeactivateSuccessfulScreenState
    extends State<UserProfileDeactivateSuccessfulScreen> {
  Timer? timer;

  clearBoxes() async {
    var phqBox = await Hive.openBox('phq');
    var sidasBox = await Hive.openBox('sidas');
    var dailyBox = await Hive.openBox<DailyHive>('daily');
    var emotionBox = await Hive.openBox<EmotionEntryHive>('emotion');
    var emotionEntryBox =
        await Hive.openBox<EmotionEntryDetail>('emotionEntry');
    var emotionObjBox = await Hive.openBox('emotionObj');
    var settingsBox = await Hive.openBox('settings');

    // Gets the no. of entries in the HIVE boxes
    print('START');
    print(phqBox.length);
    print(sidasBox.length);
    print(dailyBox.length);
    print(emotionBox.length);
    print(emotionEntryBox.length);
    print(emotionObjBox.length);
    print(settingsBox.length);

    await phqBox.clear();
    await sidasBox.clear();
    await dailyBox.clear();
    await emotionBox.clear();
    await emotionEntryBox.clear();
    await emotionObjBox.clear();
    await settingsBox.clear();

    // Verifies that all entries have been removed from the HIVE boxes
    print('CLEARED');
    print(phqBox.length);
    print(sidasBox.length);
    print(dailyBox.length);
    print(emotionBox.length);
    print(emotionEntryBox.length);
    print(emotionObjBox.length);
    print(settingsBox.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
        appBar: AppBar(
            elevation: 1,
            backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
            title: Text('Deactivated Sucessfully',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.neutralBlack02))),
        primary: true,
        body: Stack(
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                child: Wrap(
                    runSpacing: 25,
                    alignment: WrapAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: SvgPicture.asset(
                          'assets/images/deactivateWave.svg',
                          height: 200,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 25),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.neutralWhite04,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Text(
                            'You have successfully deactivated your Kasiyanna account. Please note that it may take 7 days to complete the deactivation process.\nThank you for using our app.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralGray04)),
                      ),
                    ])),
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
                          primary: Theme.of(context).colorScheme.accentBlue02),
                      onPressed: () async {
                        //API CALL TO DELETE ACCOUNT FROM BACKEND
                        //CLEAR HIVE DATA
                        await clearBoxes();
                        //DELETE LOGIN Key
                        UserSecureStorage.removeLoginKey();
                        //ROUTE TO LOG-IN PAGE
                        Timer(const Duration(seconds: 3), () {
                          Get.offAllNamed('/accountScreen');
                        });
                      },
                      child: Text('Confirm',
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
