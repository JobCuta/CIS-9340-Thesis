import 'package:get/get.dart';
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

  _buildFieldComponent(String fieldName, String fieldValue) {
    return InkWell(
      onTap: () {},
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
            const WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.keyboard_arrow_right_sharp,
                    color: Color(0xffC7CBCC)))
          ]),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                          Text('_USERNAME_',
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
                              'First, Last Name', 'Joe Apples'),
                          const Divider(
                            color: Color(0xffF0F1F1),
                            height: 25,
                            thickness: 1,
                          ),
                          _buildFieldComponent('Nickname', 'Appley'),
                          const Divider(
                            color: Color(0xffF0F1F1),
                            height: 25,
                            thickness: 1,
                          ),
                          _buildFieldComponent('Email', 'apples@gmail.com')
                        ],
                      )),
                ],
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
                      dispose();
                      Get.toNamed('/wellnessScreen');
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
