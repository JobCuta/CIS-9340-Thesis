import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';

class HopeBoxVideosScreen extends StatefulWidget {
  const HopeBoxVideosScreen({Key? key}) : super(key: key);

  @override
  State<HopeBoxVideosScreen> createState() => _HopeBoxVideosScreenState();
}

class _HopeBoxVideosScreenState extends State<HopeBoxVideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Videos',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Theme.of(context).colorScheme.neutralBlack02,
                fontWeight: FontWeight.w400),
          ),
          leading:
              BackButton(color: Theme.of(context).colorScheme.accentBlue02),
          elevation: 1,
          primary: true,
          backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
        ),
        body: Container(
            alignment: Alignment.center,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 10,
              children: [
                SvgPicture.asset('assets/images/missing_video.svg'),
                Text('Nothing here yet...',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.neutralGray01,
                        fontWeight: FontWeight.w600))
              ],
            )));
  }
}
