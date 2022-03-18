import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

Future errorDialog(String message) {
  return Get.defaultDialog(
      title: "An error occured",
      barrierDismissible: true,
      titleStyle: const TextStyle(
          fontSize: 30,
          fontFamily: 'Proxima Nova',
          fontWeight: FontWeight.w600),
      titlePadding: const EdgeInsets.only(top: 20, bottom: 20),
      content: Column(children: [
        SvgPicture.asset('assets/images/exclamation.svg'),
        Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              message,
              textAlign: TextAlign.center,
            ))
      ]),
      radius: 8,
      confirm: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            primary: const Color(0xff3FCD67),
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            Navigator.of(Get.context!).pop();
          },
          child: const Text(
            'Okay',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white,
              fontFamily: 'Proxima Nova',
            ),
          ),
        ),
      ));
}
