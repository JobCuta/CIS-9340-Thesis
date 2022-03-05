import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future errorDialog(String message) {
    return Get.defaultDialog(
        title: "An error occured",
        barrierDismissible: true,
        titleStyle: const TextStyle(
            fontSize: 30,
            fontFamily: 'Proxima Nova',
            fontWeight: FontWeight.w600),
        titlePadding: const EdgeInsets.only(top: 20),
        content: Column(children: [
          Image.asset('assets/images/exclamation.png'),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              primary: Colors.green[400],
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              Navigator.of(Get.context!).pop();
            },
            child: const Text(
              'Okay',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Proxima Nova',
              ),
            ),
          ),
        ));
  }