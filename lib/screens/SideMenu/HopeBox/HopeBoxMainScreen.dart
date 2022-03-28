import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
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
            Container(
                padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHopeBoxComponent(
                            assetName: 'assets/images/hopebox_images.svg',
                            onTap: () {
                              Get.toNamed('/hopeBoxImages');
                            }),
                        _buildHopeBoxComponent(
                            assetName: 'assets/images/hopebox_videos.svg',
                            onTap: () {
                              Get.toNamed('/hopeBoxVideos');
                            }),
                        _buildHopeBoxComponent(
                            assetName: 'assets/images/hopebox_recordings.svg',
                            onTap: () {
                              Get.toNamed('/hopeBoxRecordings');
                            })
                      ],
                    ),
                    SvgPicture.asset('assets/images/basket.svg'),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: const Color(0xff3290FF).withOpacity(0.60),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Text(
                          'Add images, videos, and recordings of cherished moments you want to remember.',
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
                ))
          ],
        ));
  }

  _buildHopeBoxComponent({assetName, onTap}) {
    return Material(
        color: Colors.transparent,
        child: InkWell(onTap: onTap, child: SvgPicture.asset(assetName)));
  }
}
