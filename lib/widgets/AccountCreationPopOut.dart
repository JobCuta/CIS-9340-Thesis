import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Future registeredDialog(BuildContext context) {
  return Get.defaultDialog(
    title: 'Account successfully registered!',
    barrierDismissible: false,
    contentPadding: const EdgeInsets.all(20),
    titleStyle: Theme.of(context)
        .textTheme
        .headline5
        ?.copyWith(fontWeight: FontWeight.w600),
    content: Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Divider(
            color: Theme.of(context).colorScheme.neutralWhite03,
            height: 25,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset('assets/images/yellow_icon.svg'),
          ),
          Text('Check your email to confirm your account in order to log in',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.neutralBlack02,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    ),
    confirm: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: Theme.of(context).colorScheme.intGreenMain,
        fixedSize: const Size(245, 50),
      ),
      onPressed: () {
        Get.offAllNamed('/assessPHQScreen');
      },
      child: Text(
        'Okay!',
        style: Theme.of(context).textTheme.subtitle2?.copyWith(
            color: Theme.of(context).colorScheme.neutralWhite01,
            fontWeight: FontWeight.w600),
      ),
    ),
  );
}
