import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';

Future verificationDialog(BuildContext context) {
  return Get.defaultDialog(
    title: 'Enter the verification code we sent',
    titleStyle: Theme.of(context)
        .textTheme
        .headline5
        ?.copyWith(fontWeight: FontWeight.w600),
    titlePadding: const EdgeInsets.only(top: 20),
    barrierDismissible: false,
    onWillPop: () => Future.value(false),
    contentPadding: const EdgeInsets.only(top: 20, left: 20.0, right: 20),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 10,
          thickness: 1.0,
          color: Theme.of(context).colorScheme.neutralWhite04,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          'Check your email and open the link given to reset your password',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.neutralBlack02),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24))),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Theme.of(context).colorScheme.intGreenMain,
              ),
              child: Text(
                'Return to login',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.neutralWhite01),
              ),
              onPressed: () {
                //Navigation and account validation
                Get.offAllNamed('/accountScreen');
              }),
        )
      ],
    ),
  );
}
