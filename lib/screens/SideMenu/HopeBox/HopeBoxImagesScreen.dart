import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';

class HopeBoxImagesScreen extends StatefulWidget {
  const HopeBoxImagesScreen({Key? key}) : super(key: key);

  @override
  State<HopeBoxImagesScreen> createState() => _HopeBoxImagesScreenState();
}

class _HopeBoxImagesScreenState extends State<HopeBoxImagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Images',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: Theme.of(context).colorScheme.neutralBlack02,
                  fontWeight: FontWeight.w400),
            ),
            leading:
                BackButton(color: Theme.of(context).colorScheme.accentBlue02),
            elevation: 1,
            primary: true,
            backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
            actions: <Widget>[
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add,
                      color: Theme.of(context).colorScheme.neutralBlack02))
            ]),
        body: Container(
            alignment: Alignment.center,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 10,
              children: [
                SvgPicture.asset('assets/images/missing_image.svg'),
                Text('Nothing here yet...',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.neutralGray01,
                        fontWeight: FontWeight.w600))
              ],
            )));
  }
}
