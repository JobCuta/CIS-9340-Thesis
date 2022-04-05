import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

Future errorDialog(context, String message) {
  return Get.defaultDialog(
      title: "An error occured",
      barrierDismissible: true,
      titleStyle: Theme.of(context).textTheme.headline5?.copyWith(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.neutralBlack02),
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.all(20),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
        child: Column(children: [
          SvgPicture.asset('assets/images/exclamation.svg'),
          Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.neutralBlack02)))
        ]),
      ),
      confirm: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: Theme.of(context).colorScheme.intGreenMain,
          ),
          onPressed: () {
            Navigator.of(Get.context!).pop();
          },
          child: Text(
            'Okay',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.neutralWhite01),
          ),
        ),
      ));
}
