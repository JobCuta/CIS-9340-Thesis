import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';

setNotificationsAlert(context) {
  Get.defaultDialog(
      title: 'One last thing...',
      barrierDismissible: false,
      onWillPop: () => Future.value(false),
      titleStyle: Theme.of(context).textTheme.headline5?.copyWith(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.sunflowerYellow01),
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.only(left: 30, right: 30.0),
      content: Container(
        alignment: Alignment.center,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'These questions will be asked to you 3 times a day. Would you like to be reminded when to answer them?',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralBlack02),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              height: 10,
              thickness: 1,
              color: Theme.of(context).colorScheme.neutralWhite03,
            ),
          ),
          SvgPicture.asset('assets/images/notification_bell.svg'),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).colorScheme.sunflowerYellow01,
                ),
                child: Text(
                  'Yes',
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.neutralWhite01),
                ),
                onPressed: () {
                  Get.offAndToNamed('/notifScreen');
                }),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.neutralWhite04,
                    width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(24))),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).colorScheme.neutralWhite01,
                ),
                child: Text(
                  "I'll do this later...",
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.sunflowerYellow01),
                ),
                onPressed: () {
                  Get.back();
                  Get.toNamed('/loadingScreen');
                }),
          )
        ]),
      ));
}
