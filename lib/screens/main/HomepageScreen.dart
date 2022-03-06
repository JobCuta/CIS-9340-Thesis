import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed('/shakeScreen', arguments: {'initial?': false});
          },
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(290, 15, 0, 0),
              child: SvgPicture.asset(
                'assets/images/meditating.svg',
                height: 95,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 100,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xffFFC122).withOpacity(0.60),
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  const Text('Daily Wellness Exercise',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Proxima Nova')),
                  Text('Keep your mind and body in shape!',
                      style: Theme.of(context).textTheme.bodyText2?.apply(
                          color: Colors.white, fontFamily: 'Proxima Nova'))
                ],
              ),
            ),
          ]),
        ),
      ],
    ));
  }
}
