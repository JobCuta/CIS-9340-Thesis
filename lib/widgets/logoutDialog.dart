import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

showLogoutConfirmation(context) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          insetPadding: const EdgeInsets.all(50.0),
          title: Text(
            'Come back soon!',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                color: Theme.of(context).colorScheme.neutralBlack02,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Wrap(
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/logout.svg'),
                  Text('Are you sure you want to logout?',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.neutralBlack02)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: Text(
                            'Logout',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .accentRed02,
                                    fontWeight: FontWeight.w600),
                          ),
                          onPressed: () async {
                            var response = await UserProvider().logout();
                            print('logout $response');
                            Get.offAllNamed('/accountScreen');
                          },
                        ),
                        TextButton(
                            child: Text(
                              'Cancel',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralBlack02,
                                      fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              Get.back();
                            }),
                      ])
                ]),
          )));
}
