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

showTalkingPerson({required context, required dialog}) async {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Material(
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    'assets/images/talking_person.svg',
                  )),
              Container(
                margin: const EdgeInsets.only(left: 40, top: 40),
                constraints:
                    const BoxConstraints(maxHeight: 120, maxWidth: 230),
                child: Text(dialog,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.neutralWhite01)),
              ),
            ],
          )));
}
