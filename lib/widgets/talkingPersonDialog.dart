import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/forms.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

showTalkingPerson({required context, required dialog}) {
  return showDialog<String>(
      barrierColor: const Color(0xff101010).withOpacity(0.60),
      context: context,
      builder: (BuildContext context) => Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            // closes the dialog when any element in the dialog is tapped.
            onTap: () {
              Get.back();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 80),
              child: Column(
                children: [
                  const Expanded(child: const Text('')),
                  Stack(
                    children: [
                      Material(
                          color: Colors.transparent,
                          child: SvgPicture.asset(
                            'assets/images/talking_person.svg',
                          )),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 40, top: 40),
                        constraints:
                            const BoxConstraints(maxHeight: 120, maxWidth: 230),
                        child: Text(dialog,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralWhite01)),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Tap to continue',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).colorScheme.neutralWhite01)),
                  )
                ],
              ),
            ),
          )));
}
