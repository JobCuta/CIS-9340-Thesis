import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/hopeBoxController.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';

import '../../main/SideMenu.dart';

class HopeBoxMainScreen extends StatefulWidget {
  const HopeBoxMainScreen({Key? key}) : super(key: key);

  @override
  State<HopeBoxMainScreen> createState() => _HopeBoxMainScreenState();
}

class _HopeBoxMainScreenState extends State<HopeBoxMainScreen> {
  final HopeBoxController _hopeController = Get.put(HopeBoxController());
  bool boxOpen = false;

  // This key will be used to find the box's coordinates
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Coordinates
    double _x = MediaQuery.of(context).size.width / 3 - 50,
        _y = MediaQuery.of(context).size.height / 2 - 90;
    RenderBox? box = _key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    if (position != null) {
      setState(() {
        _x = position.dx;
        _y = position.dy;
      });
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Hope Basket',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Theme.of(context).colorScheme.neutralWhite01,
                fontWeight: FontWeight.w400),
          ),
          elevation: 0,
          primary: true,
          backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
        ),
        drawer: const SideMenu(),
        body: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/background_images/blue_background.png',
                        ),
                        fit: BoxFit.cover))),
            Stack(
              children: [
                AnimatedPositioned(
                  child: _buildHopeBoxComponent(
                      assetName: 'assets/images/hopebox_images.svg',
                      onTap: () {
                        Get.toNamed('/hopeBoxImages');
                      }),
                  left: boxOpen ? _x - 60 : _x + 70,
                  top: boxOpen ? _y - 140 : _y + 20,
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(seconds: 1),
                ),
                AnimatedPositioned(
                  child: _buildHopeBoxComponent(
                      assetName: 'assets/images/hopebox_videos.svg',
                      onTap: () {
                        Get.toNamed('/hopeBoxVideos');
                      }),
                  left: boxOpen ? _x + 40 : _x + 70,
                  top: boxOpen ? (_y - 140) : _y + 20,
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(seconds: 1),
                ),
                AnimatedPositioned(
                  child: _buildHopeBoxComponent(
                      assetName: 'assets/images/hopebox_recordings.svg',
                      onTap: () {
                        Get.toNamed('/hopeBoxRecordings');
                      }),
                  left: boxOpen ? _x + 120 : _x + 70,
                  top: boxOpen ? (_y - 140) : _y + 20,
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(seconds: 1),
                ),
                AnimatedPositioned(
                  child: _buildHopeBoxComponent(
                      assetName: 'assets/images/hopebox_contact.svg',
                      onTap: () {
                        _hopeController.firstNameController.text == ''
                            ? showContactSetupConfirmation(context)
                            : Get.toNamed('/hopeBoxContact');
                      }),
                  left: boxOpen ? _x + 230 : _x + 70,
                  top: boxOpen ? (_y - 140) : _y + 20,
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(seconds: 1),
                )
              ],
            ),
            Center(
              child: Container(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.spaceBetween,
                    runSpacing: 50,
                    children: [
                      Container(height: 100),
                      InkWell(
                          key: _key,
                          onTap: () {
                            setState(() {
                              boxOpen = !boxOpen;
                            });
                          },
                          child: SvgPicture.asset('assets/images/basket.svg')),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color(0xff3290FF).withOpacity(0.60),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: Text(
                            'Add images, videos, and recordings of cherished moments you want to\nremember.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    height: 1.5,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralWhite01,
                                    fontWeight: FontWeight.w600)),
                      )
                    ],
                  )),
            )
          ],
        ));
  }

  _buildHopeBoxComponent({assetName, onTap}) {
    return Material(
        color: Colors.transparent,
        child: InkWell(onTap: onTap, child: SvgPicture.asset(assetName)));
  }
}

showContactSetupConfirmation(context) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          insetPadding: const EdgeInsets.all(50.0),
          title: Text(
            'Add Emergency Contact Person',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                color: Theme.of(context).colorScheme.neutralBlack02,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Wrap(
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  Text(
                      'You currently have no emergency contact set. Would you like to set one now?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.neutralBlack02)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: Text(
                            'Yes',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .intGreenMain,
                                    fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Get.back();
                            Get.toNamed('/hopeBoxContactSetup');
                          },
                        ),
                        TextButton(
                            child: Text(
                              'Cancel',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralBlack02,
                                      fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              Get.back();
                            }),
                      ])
                ]),
          )));
}
