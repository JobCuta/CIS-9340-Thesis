import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Future registeredDialog(BuildContext context) {
    return Get.defaultDialog(
      title: 'Account successfully registered!',
      barrierDismissible: false,
      titleStyle: Theme.of(context)
          .textTheme
          .headline5
          ?.copyWith(fontWeight: FontWeight.w600),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Divider(height: 1.0, thickness: 1.0, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset('assets/images/yellow_icon.svg'),
          ),
          const Text(
            'Check your email to confirm your account in order to log in',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(10),
          primary: Colors.green[400],
          fixedSize: const Size(245, 50),
        ),
        onPressed: () {
          Get.offAllNamed('/accountScreen');
        },
        child: Text(
          'Okay!',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }