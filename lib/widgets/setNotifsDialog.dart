import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';

setNotificationsAlert(context) {
  AlertDialog(
      insetPadding: const EdgeInsets.all(20.0),
      title: Text(
        'One last thing...',
        style: Theme.of(context).textTheme.headline5?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.sunflowerYellow01),
        textAlign: TextAlign.center,
      ),
      content: Wrap(
          // runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            Text(
              'These questions will be asked to you 3 times a day. Would you like to be reminded when to answer them?',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralBlack02),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Divider(
                height: 1.0,
                thickness: 1.0,
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
          ]));
}
