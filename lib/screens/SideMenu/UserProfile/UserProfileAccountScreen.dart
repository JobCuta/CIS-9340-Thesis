import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/userProfileController.dart';

class UserProfileAccountScreen extends StatefulWidget {
  const UserProfileAccountScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileAccountScreen> createState() =>
      _UserProfileAccountScreenState();
}

final UserProfileController _profileController =
    Get.put(UserProfileController());

class _UserProfileAccountScreenState extends State<UserProfileAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
        appBar: AppBar(
            elevation: 1,
            leading: BackButton(
                color: Theme.of(context).colorScheme.accentBlue02,
                onPressed: () {
                  Get.back();
                }),
            backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
            title: Text('Account',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.neutralBlack02))),
        primary: true,
        body: SafeArea(
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralBlack02)),
                          RichText(
                            text: TextSpan(children: <InlineSpan>[
                              TextSpan(
                                  text: _profileController.email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralGray01,
                                          fontWeight: FontWeight.w600)),
                            ]),
                          )
                        ]),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.neutralWhite03,
                    height: 25,
                    thickness: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/userDeactivateAccountScreen');
                    },
                    splashColor: Theme.of(context).colorScheme.neutralGray02,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Deactivate Account',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralBlack02)),
                            RichText(
                              text: TextSpan(children: <InlineSpan>[
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Icon(
                                        Icons.keyboard_arrow_right_sharp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray01))
                              ]),
                            )
                          ]),
                    ),
                  ),
                ],
              )),
        ));
  }
}
