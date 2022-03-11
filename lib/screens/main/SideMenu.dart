import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/debug/HomepageScreen.dart';

class SideMenu extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 15);
  @override
  Widget build(BuildContext context) {
    const name = 'Hey there, _USERNAME_!';
    const userImage = 'assets/images/User_Icon.png';
    return Drawer(
      child: Material(
        color:  Colors.white,
        child: ListView(
          padding: padding,
          children: <Widget>[
            buildHeader(
              userImage: userImage,
              name: name,
              //OnClicked: (),
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.grey),

            const SizedBox(height: 8),
            buildMenuItem(
              text: 'Check your statistics',
              icon:Icons.timeline,
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
            const Divider(color: Colors.grey),

            const SizedBox(height: 8),
            buildMenuItem(
              text: 'Mental Health Hotline',
              icon: Icons.contact_phone,
            ),
            const SizedBox(height: 8),
            buildMenuItem(
              text: 'Settings and User Profile',
              icon: Icons.settings,
            ),

            const SizedBox(height: 100),
            TextButton(
              child: const Text('Logout', style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold)),
              onPressed: () {},
              ),
          ],
        )
      ),
    );
  }

  Widget buildHeader({
    required String userImage,
    required String name,
})=>
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
                  Text(
                    name,
                      style: TextStyle(
                          color: const Color(0xff4ca7fc).withOpacity(1.0),
                          fontSize: 14,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.bold)                  ),
                  const SizedBox(height: 10),
                  Text(
                    'What''s on your mind?',
                      style: TextStyle(
                          color: const Color(0xff4ca7fc).withOpacity(1.0),
                          fontSize: 14,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w400)
                  ),
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
      title: Text(text, style: TextStyle(
          color: const Color(0xACB2B4).withOpacity(1.0),
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
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePageScreen(),
        ));
        break;
    }
  }
}
