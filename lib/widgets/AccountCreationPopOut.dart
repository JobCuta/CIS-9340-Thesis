import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Future registeredDialog(BuildContext context) {
  return Get.defaultDialog(
    title: 'Account successfully registered!',
    titleStyle: Theme.of(context)
        .textTheme
        .headline5
        ?.copyWith(fontWeight: FontWeight.w600),
    titlePadding: const EdgeInsets.only(top: 20),
    barrierDismissible: false,
    onWillPop: () => Future.value(false),
    contentPadding: const EdgeInsets.all(20),
    content: Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Divider(
            color: Theme.of(context).colorScheme.neutralWhite04,
            height: 10,
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
    confirm: SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: Theme.of(context).colorScheme.intGreenMain,
        ),
        onPressed: () {
          Get.offAllNamed('/accountScreen');
        },
        child: Text(
          'Back to Login',
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: Theme.of(context).colorScheme.neutralWhite01,
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
