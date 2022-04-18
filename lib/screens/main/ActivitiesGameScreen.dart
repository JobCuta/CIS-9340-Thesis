import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_application_1/screens/main/HomepageScreen.dart';
import 'package:get/get.dart';

class ActivitiesGameScreen extends StatefulWidget {
  const ActivitiesGameScreen({key}) : super(key: key);

  @override
  State<ActivitiesGameScreen> createState() => _ActivitiesGameScreenState();
}

class _ActivitiesGameScreenState extends State<ActivitiesGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Your Adventure',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Theme.of(context).colorScheme.neutralWhite01,
                fontWeight: FontWeight.w400),
          ),
          leading: BackButton(onPressed: () => {Get.off(HomePageScreen(3))}),
          primary: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/background_images/adventure_background.png',
                        ),
                        fit: BoxFit.cover))),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 15),
                          child: Wrap(
                            runSpacing: 10,
                            children: [
                              Text('Your Activities',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              Text('Start your Journey to Wellness!',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              Divider(
                                color:
                                Theme.of(context).colorScheme.neutralWhite03,
                                height: 10,
                                thickness: 1,
                              ),
                              _buildFieldComponent(
                                title: 'Memory',
                                onTap: () {
                                  Get.toNamed('/memoryGameScreen');
                                },
                              ),
                              Divider(
                                color:
                                Theme.of(context).colorScheme.neutralWhite03,
                                height: 10,
                                thickness: 1,
                              ),
                              _buildFieldComponent(
                                title: 'Coping',
                                onTap: () {
                                  Get.toNamed('/copingGame');
                                },
                              ),
                              Divider(
                                color:
                                Theme.of(context).colorScheme.neutralWhite03,
                                height: 10,
                                thickness: 1,
                              ),
                              _buildFieldComponent(
                                title: 'Sudoku',
                                onTap: () {
                                  Get.toNamed('/sudoku');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  _buildFieldComponent({title, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralBlack02)),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Go',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffFFC122))),
              const WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.keyboard_arrow_right_sharp,
                      color: Color(0xffFFC122)))
            ]),
          ),
        ],
      ),
    );
  }
}