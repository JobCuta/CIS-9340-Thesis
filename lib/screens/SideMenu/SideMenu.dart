import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/userSecureStorage.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';

import '../../widgets/LogoutDialog.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final LevelController _levelController = Get.put(LevelController());

  final padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 5);
  static var usern = "";
  static var email = "";

  @override
  void initState() {
    super.initState();
    UserSecureStorage.getUsern().then((value) {
      setState(() {
        usern = value.toString();
      });
    });
    UserSecureStorage.getEmail().then((value) {
      setState(() {
        log('value $value');
        email = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Material(
            color: Theme.of(context).colorScheme.neutralWhite01,
            child: ListView(
              padding: padding,
              children: <Widget>[
                buildHeader(
                    userLevel: _levelController.currentLevel.value,
                    name: usern,
                    email: email),
                const Divider(
                  color: Color(0xffC4C4C4),
                  thickness: 1.5,
                ),
                buildMenuItem(
                  text: 'Homepage',
                  icon: 'assets/images/homepage_icon.svg',
                  onClicked: () =>
                      ModalRoute.of(context)!.settings.name != '/homepage'
                          ? Get.offAndToNamed('/homepage')
                          : Get.back(),
                ),
                buildMenuItem(
                  text: 'Check your statistics',
                  icon: 'assets/images/statistics_icon.svg',
                  onClicked: () => ModalRoute.of(context)!.settings.name !=
                          '/statisticsScreen'
                      ? Get.offAndToNamed('/statisticsScreen')
                      : Get.back(),
                ),
                buildMenuItem(
                  text: 'Achievements',
                  icon: 'assets/images/achievement_icon.svg',
                  onClicked: () => ModalRoute.of(context)!.settings.name !=
                          '/achievementsScreen'
                      ? Get.offAndToNamed('/achievementsScreen')
                      : Get.back(),
                ),
                buildMenuItem(
                  text: 'Daily Exercise',
                  icon: 'assets/images/exercise_icon.svg',
                  onClicked: () =>
                      ModalRoute.of(context)!.settings.name != '/wellnessScreen'
                          ? Get.offAndToNamed('/wellnessScreen')
                          : Get.back(),
                ),
                buildMenuItem(
                  text: 'Hope Box',
                  icon: 'assets/images/hopebox_icon.svg',
                  onClicked: () =>
                      ModalRoute.of(context)!.settings.name != '/hopeBox'
                          ? Get.offAndToNamed('/hopeBox')
                          : Get.back(),
                ),
                const Divider(
                  color: Color(0xffC4C4C4),
                  thickness: 1.5,
                ),
                buildMenuItem(
                  text: 'Mental Health Facilities',
                  icon: 'assets/images/facilities_icon.svg',
                  onClicked: () => ModalRoute.of(context)!.settings.name !=
                          '/MentalHealthFacilitiesScreen'
                      ? Get.offAndToNamed('/MentalHealthFacilitiesScreen')
                      : Get.back(),
                ),
                buildMenuItem(
                  text: 'Mental Health Hotline',
                  icon: 'assets/images/hotline_icon.svg',
                  onClicked: () => ModalRoute.of(context)!.settings.name !=
                          '/MentalHealthOnlineScreen'
                      ? Get.offAndToNamed('/MentalHealthOnlineScreen')
                      : Get.back(),
                ),
                buildMenuItem(
                  text: 'Let us know what you think',
                  icon: 'assets/images/star_icon.svg',
                  onClicked: () =>
                      ModalRoute.of(context)!.settings.name != '/contactScreen'
                          ? Get.offAndToNamed('/contactScreen')
                          : Get.back(),
                ),
                buildMenuItem(
                  text: 'Settings and User Profile',
                  icon: 'assets/images/settings_icon.svg',
                  onClicked: () => ModalRoute.of(context)!.settings.name !=
                          '/userProfileScreen'
                      ? Get.offAndToNamed('/userProfileScreen')
                      : Get.back(),
                ),
                buildMenuItem(
                  text: 'Logout',
                  icon: 'assets/images/logout_icon.svg',
                  onClicked: () async {
                    showLogoutConfirmation(context);
                  },
                ),
              ],
            )),
      ),
    );
  }

  Widget buildHeader(
          {required int userLevel,
          required String name,
          required String email}) =>
      InkWell(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: padding.add(const EdgeInsets.only(top: 10)),
          child: Expanded(
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:
                                Theme.of(context).colorScheme.sunflowerYellow01,
                            border: Border.all(
                                width: 2.0,
                                color: Theme.of(context)
                                    .colorScheme
                                    .sunflowerYellow01)),
                        child: Container(
                            height: 39,
                            width: 39,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    width: 2.0,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralWhite01)),
                            child: Center(
                                child: Text(userLevel.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralWhite01)))))),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Hey there, $name',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .accentIndigo02,
                                  fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('$email ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color:
                                  Theme.of(context).colorScheme.accentIndigo02,
                              fontWeight: FontWeight.w400)),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required icon,
    VoidCallback? onClicked,
  }) {
    return InkWell(
      onTap: onClicked,
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: SvgPicture.asset(icon),
              ),
              Text(text,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: text != 'Logout'
                          ? Theme.of(context).colorScheme.neutralGray03
                          : Theme.of(context).colorScheme.accentRed02,
                      fontWeight: FontWeight.w400))
            ],
          )),
    );
  }
}
