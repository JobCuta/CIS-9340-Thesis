import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/controllers/userProfileController.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  _buildLevelComponent(String value, String title) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      spacing: 5,
      children: [
        Text(value,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w400))
      ],
    );
  }

  _buildFieldComponent(
      String fieldName, String fieldValue, bool isEditable, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(fieldName,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w400)),
        RichText(
          text: TextSpan(children: <InlineSpan>[
            TextSpan(
                text: fieldValue,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: const Color(0xffC7CBCC),
                    fontWeight: FontWeight.w600)),
            isEditable
                ? const WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(Icons.keyboard_arrow_right_sharp,
                        color: Color(0xffC7CBCC)))
                : const TextSpan(text: '')
          ]),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    showLogoutConfirmation() {
      return showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
              insetPadding: const EdgeInsets.all(50.0),
              title: Text(
                'Come back soon!',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: const Color(0xff161818),
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              content: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Wrap(
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/logout.svg'),
                      Text('Are you sure you want to logout?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff161818))),
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
                                        color: const Color(0xffFC4C51),
                                        fontWeight: FontWeight.w600),
                              ),
                              onPressed: () async {
                                var response = await UserProvider().logout();
                                print('logout $response');
                                Get.offAndToNamed('/accountScreen');
                              },
                            ),
                            TextButton(
                                child: Text(
                                  'Cancel',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          color: const Color(0xff161818),
                                          fontWeight: FontWeight.w600),
                                ),
                                onPressed: () {
                                  Get.back();
                                }),
                          ])
                    ]),
              )));
    }

    final UserProfileController _userProfileController =
        Get.put(UserProfileController());

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("Settings and User Profile",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.white)),
          primary: true,
          elevation: 0,
          backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
        ),
        body: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
              color: Color(0xff7c94b6),
              image: DecorationImage(
                image: AssetImage(
                  'assets/background_images/blue_user_profile_background.png',
                ),
                fit: BoxFit.cover,
              ),
            )),
            GetBuilder<UserProfileController>(
              builder: (value) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 60),
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      alignment: Alignment.center,
                      child: Wrap(
                          direction: Axis.vertical,
                          spacing: 20,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(
                                    'assets/images/default_user_image.png')),
                            Text(_userProfileController.nicknameController.text,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildLevelComponent(
                                    '24', 'Daily tasks finished'),
                                const SizedBox(width: 30),
                                _buildLevelComponent('24', 'Levels'),
                                const SizedBox(width: 30),
                                _buildLevelComponent('24', 'Entries'),
                                const SizedBox(width: 30),
                                _buildLevelComponent('24', 'Achievements'),
                              ],
                            )
                          ]),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30),
                        alignment: Alignment.bottomLeft,
                        child: Wrap(
                          runSpacing: 3,
                          children: [
                            Text('Personal Data',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: const Color(0xffACB2B4),
                                        fontWeight: FontWeight.w600)),
                            const Divider(
                              color: Color(0xffF0F1F1),
                              height: 25,
                              thickness: 1,
                            ),
                            _buildFieldComponent(
                                'First, Last Name & Nickname',
                                '${_userProfileController.firstNameController.text} ${_userProfileController.lastNameController.text}',
                                true, (() {
                              Get.toNamed('/userProfileNamesScreen');
                            })),
                            const Divider(
                              color: Color(0xffF0F1F1),
                              height: 25,
                              thickness: 1,
                            ),
                            _buildFieldComponent('Email',
                                _userProfileController.email, false, (() {}))
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      showLogoutConfirmation();
                    },
                    child: Text('Logout',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: const Color(0xffFC4C51),
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
