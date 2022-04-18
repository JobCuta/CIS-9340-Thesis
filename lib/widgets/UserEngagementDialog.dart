import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';

showUserEngagementDialog(context) {
  Get.defaultDialog(
      barrierDismissible: false,
      title: "We're curious with how the app left an impression with you!",
      titleStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
          height: 1.5,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.accentBlue02),
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      content: Container(
        alignment: Alignment.center,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              thickness: 1,
              color: Theme.of(context).colorScheme.neutralWhite03,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'The following items will let us know how you feel when using the app so we can further cater the needs of our users.',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralBlack02),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).colorScheme.accentBlue02,
                ),
                child: Text(
                  "Let's get started",
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.neutralWhite01),
                ),
                onPressed: () {
                  Get.toNamed('/engagementScaleScreen');
                }),
          ),
        ]),
      ));
}
