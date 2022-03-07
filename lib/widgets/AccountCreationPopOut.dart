import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Widget buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: Text(
      'Account successfully registered!',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 24),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Divider(
          height: 1.0,
          thickness: 1.0,
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: SvgPicture.asset('assets/images/yellow_icon.svg'),
        ),
        const SizedBox(height: 10.0),
        Text(
          'Check your email to confirm your account in order to log in',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    ),
    actions: <Widget>[
      Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(10),
            primary: Colors.green[400],
            fixedSize: const Size(245, 50),
          ),
          onPressed: () {
            Get.offAndToNamed('/accountScreen');
          },
          child: Text(
            'Okay!',
            style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white),
          ),
        ),
      ),
      const SizedBox(
        height: 20.0,
      )
    ],
  );
}