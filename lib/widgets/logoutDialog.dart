import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/emotionEntryHive.dart';
import 'package:flutter_application_1/apis/tableSecureStorage.dart';
import 'package:flutter_application_1/apis/userSecureStorage.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

showLogoutConfirmation(context) {
  return Get.defaultDialog(
      title: 'Come back soon!',
      titleStyle: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.w600),
      titlePadding: const EdgeInsets.symmetric(vertical: 20),
      contentPadding: const EdgeInsets.only(left: 20, right: 20),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        SvgPicture.asset('assets/images/logout.svg'),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text('Are you sure you want to logout?',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.neutralBlack02)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TextButton(
              child: Text(
                'Logout',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Theme.of(context).colorScheme.accentRed02, fontWeight: FontWeight.w600),
              ),
              onPressed: () async {
                var response = await UserProvider().logout();
                if (response) {
                  Box phq = Hive.box('phq');
                  Box sidas = Hive.box('sidas');
                  Box emotion = Hive.box<EmotionEntryHive>('emotion');

                  await phq.clear();
                  await sidas.clear();
                  await emotion.clear();

                  TableSecureStorage.setLatestPHQ('null');
                  TableSecureStorage.setLatestSIDAS('null');
                  TableSecureStorage.setLatestEmotion('null');

                  UserSecureStorage.setLoginDetails('', '', '', '', '', '', '');
                  UserSecureStorage.setNotifID('');

                  Get.offAllNamed('/accountScreen');
                  log('log out succesfful. Databases deleted. ${phq.keys} ${sidas.keys} ${emotion.keys}');
                } else {
                  log('logging out failed..');
                }
              },
            ),
            TextButton(
                child: Text(
                  'Nevermind',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Theme.of(context).colorScheme.neutralBlack02, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Get.back();
                }),
          ]),
        )
      ]));
}
