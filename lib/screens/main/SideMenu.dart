import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/apis/userSecureStorage.dart';
import 'package:get/get.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final padding = const EdgeInsets.symmetric(horizontal: 15);
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
    const userImage = 'assets/images/User_Icon.png';
    return SafeArea(
      child: Drawer(
        child: Material(
            color: Colors.white,
            child: ListView(
              padding: padding,
              children: <Widget>[
                buildHeader(
                  userImage: userImage,
                  name: usern,
                  email: email,
                  //OnClicked: (),
                ),
                const SizedBox(height: 12),
                const Divider(color: Colors.grey),
                const SizedBox(height: 8),
                buildMenuItem(
                  text: 'Check your statistics',
                  icon: Icons.timeline,
                  onClicked: () => selectedItem(context, 0),
                ),
                const SizedBox(height: 8),
                buildMenuItem(
                  text: 'Achievements',
                  icon: Icons.stars,
                ),
                const SizedBox(height: 8),
                buildMenuItem(
                  text: 'Daily Exercise',
                  icon: Icons.sports_gymnastics,
                ),
                const SizedBox(height: 8),
                buildMenuItem(
                  text: 'Hope Box',
                  icon: Icons.card_giftcard,
                ),
                const SizedBox(height: 8),
                const Divider(color: Colors.grey),
                const SizedBox(height: 8),
                buildMenuItem(
                  text: 'Mental Health Hotline',
                  icon: Icons.contact_phone,
                  onClicked: () => Get.toNamed('/MentalHealthOnlineScreen'),
                ),
                const SizedBox(height: 8),
                buildMenuItem(
                  text: 'Settings and User Profile',
                  icon: Icons.settings,
                  onClicked: () => Get.toNamed('/userProfileScreen'),
                ),
                const SizedBox(height: 100),
                TextButton(
                  child: const Text('Logout',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    var response = await UserProvider().logout();
                    print('logout $response');
                    Get.offAndToNamed('/accountScreen');
                  },
                ),
              ],
            )),
      ),
    );
  }

  Widget buildHeader({
    required String userImage,
    required String name,
    required String email,
  }) =>
      InkWell(
        child: Container(
          padding: padding.add(const EdgeInsets.only(top: 30)),
          child: Row(
            children: [
              CircleAvatar(radius: 35, backgroundImage: AssetImage(userImage)),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          color: const Color(0xff4ca7fc).withOpacity(1.0),
                          fontSize: 14,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(email,
                      style: TextStyle(
                          color: const Color(0xff4ca7fc).withOpacity(1.0),
                          fontSize: 14,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.grey;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text,
          style: TextStyle(
              color: const Color(0x00acb2b4).withOpacity(1.0),
              fontSize: 14,
              fontFamily: 'Proxima Nova',
              fontWeight: FontWeight.w400)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Get.toNamed('/homepage');
        break;
    }
  }
}
