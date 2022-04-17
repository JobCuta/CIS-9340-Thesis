import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdventureHomeScreen extends StatefulWidget {
  const AdventureHomeScreen({key}) : super(key: key);

  @override
  State<AdventureHomeScreen> createState() => _AdventureHomeScreenState();
}

class _AdventureHomeScreenState extends State<AdventureHomeScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_images/adventure_background.png',),
                  fit: BoxFit.cover))
            ),
        const SizedBox(height: 10.0),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                  'assets/images/default_user_image.png')),
        ),
        const SizedBox(height: 10.0),
        const Divider(
          color: Colors.white,
          thickness: 2,
        ),
        const SizedBox(height: 10.0),
        SafeArea(
          child:SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Welcome, Adventurer!',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(color: const Color(0xffFFC122), fontWeight: FontWeight.w600)),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      decoration: const BoxDecoration(
                          color: Color(0xffFF8A00),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child:Text('"You may have to fight a battle more than once."/n - Margaret Thatcher',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400)),
                    ),
                    const SizedBox(height: 10.0),
                      const Text('Level Bar to be put Here'),
                      const SizedBox(height: 10.0),
                      InkWell(
                        onTap: () {
                          Get.offAndToNamed('/userJourney');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Start New Adventure',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Go',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                        color: const Color(0xFF216CB2).withOpacity(1.0))),
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Icon(Icons.keyboard_arrow_right_sharp,
                                        color: const Color(0xFF216CB2).withOpacity(1.0)))
                              ]),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color(0xffF0F1F1),
                        height: 25,
                        thickness: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Get.offAndToNamed('/userJourney');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Continue Adventure',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Go',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                        color: const Color(0xFF216CB2).withOpacity(1.0))),
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Icon(Icons.keyboard_arrow_right_sharp,
                                        color: const Color(0xFF216CB2).withOpacity(1.0)))
                              ]),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color(0xffF0F1F1),
                        height: 25,
                        thickness: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Get.offAndToNamed('/achievementsScreen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('View Achievements',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Go',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                        color: const Color(0xFF216CB2).withOpacity(1.0))),
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Icon(Icons.keyboard_arrow_right_sharp,
                                        color: const Color(0xFF216CB2).withOpacity(1.0)))
                              ]),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color(0xffF0F1F1),
                        height: 25,
                        thickness: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Get.offAndToNamed('/AdventureSettings');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Adventure Settings',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(color: const Color(0xff161818).withOpacity(1.0))),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Go',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                        color: const Color(0xFF216CB2).withOpacity(1.0))),
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Icon(Icons.keyboard_arrow_right_sharp,
                                        color: const Color(0xFF216CB2).withOpacity(1.0)))
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      ),
      ],),
    );
  }

}
