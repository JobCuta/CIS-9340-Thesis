import 'dart:io';

import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/controllers/dailyController.dart';
import 'package:flutter_application_1/controllers/emotionController.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_application_1/controllers/settingsController.dart';
import 'package:flutter_application_1/controllers/userProfileController.dart';
import 'package:flutter_application_1/screens/main/SideMenu.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

import '../../../widgets/LogoutDialog.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final SettingsController _settingsController = Get.put(SettingsController());
  final LevelController _levelController = Get.put(LevelController());
  final UserProfileController _userProfileController =
      Get.put(UserProfileController());
  final EmotionController _emotionController = Get.put(EmotionController());
  final DailyController _dailyController = Get.put(DailyController());
  int dailyTaskCount = 0;

  @override
  void initState() {
    super.initState();
    _settingsController.resetAllValues();
    if (_dailyController.isDailyEntryDone.value) {
      dailyTaskCount++;
    }
    if (_dailyController.isDailyExerciseDone.value) {
      dailyTaskCount++;
    }
  }

  _buildLevelComponent(String value, String title) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      spacing: 5,
      children: [
        Text(value,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: Theme.of(context).colorScheme.neutralWhite01,
                fontWeight: FontWeight.w600)),
        Text(title,
            style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.neutralWhite01,
                fontWeight: FontWeight.w400))
      ],
    );
  }

  _buildFieldComponent(
      {required String fieldName,
      required bool isEditable,
      String? fieldValue,
      Function()? onTap}) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.neutralGray02,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(fieldName,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralBlack02)),
          RichText(
            text: TextSpan(children: <InlineSpan>[
              TextSpan(
                  text: fieldValue,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.neutralGray01,
                      fontWeight: FontWeight.w600)),
              isEditable
                  ? WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(Icons.keyboard_arrow_right_sharp,
                          color: Theme.of(context).colorScheme.neutralGray01))
                  : const TextSpan(text: '')
            ]),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _pinned = true;
    bool _snap = true;
    bool _floating = true;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
      drawer: const SideMenu(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            collapsedHeight: 75,
            expandedHeight: 50,
            title: Text('Settings and User Profile',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Theme.of(context).colorScheme.neutralWhite01,
                    fontWeight: FontWeight.w400)),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child: Wrap(
                  direction: Axis.vertical,
                  spacing: 15,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: (_settingsController.imagePath.value != '')
                          ? CircleAvatar(
                              radius: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  File(_settingsController.imagePath.value),
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ))
                          : SvgPicture.asset(
                              'assets/images/default_user_image.svg',
                              width: 100),
                    ),
                    GetBuilder<UserProfileController>(
                      builder: (value) => Text(
                          _userProfileController.nicknameController.text,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01,
                                  fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 25, right: 25),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildLevelComponent(dailyTaskCount.toString(),
                                'Daily tasks finished'),
                            const SizedBox(width: 30),
                            _buildLevelComponent(
                                _levelController.currentLevel.value.toString(),
                                'Level'),
                            const SizedBox(width: 30),
                            _buildLevelComponent(
                                _emotionController.validEntriesCount.value
                                    .toString(),
                                'Entries'),
                            const SizedBox(width: 30),
                            _buildLevelComponent('24', 'Achievements'),
                          ]),
                    )
                  ]),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/background_images/blue_background.png',
                  ),
                  fit: BoxFit.cover,
                ),
              )),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.neutralWhite01,
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Wrap(
                  runSpacing: 5,
                  children: [
                    _buildFieldComponent(
                        fieldName: 'Edit Profile',
                        isEditable: true,
                        onTap: (() {
                          Get.toNamed('/userProfileEditScreen');
                        })),
                    Divider(
                      color: Theme.of(context).colorScheme.neutralWhite03,
                      height: 25,
                      thickness: 1,
                    ),
                    _buildFieldComponent(
                        fieldName: 'Notifications',
                        isEditable: true,
                        onTap: (() {
                          Get.toNamed('/userProfileNotificationsScreen');
                        })),
                    _buildFieldComponent(
                        fieldName: 'Language',
                        isEditable: true,
                        onTap: (() {
                          Get.toNamed('/userProfileLanguageScreen');
                        })),
                    Divider(
                      color: Theme.of(context).colorScheme.neutralWhite03,
                      height: 25,
                      thickness: 1,
                    ),
                    _buildFieldComponent(
                        fieldName: 'Contact Us',
                        isEditable: true,
                        onTap: (() {
                          Get.toNamed('/userProfileContactScreen');
                        })),
                    _buildFieldComponent(
                        fieldName: 'Account',
                        isEditable: true,
                        onTap: (() {
                          Get.toNamed('/userProfileAccountScreen');
                        })),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              showLogoutConfirmation(context);
                            },
                            child: Text('Logout',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .accentRed02,
                                        fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
