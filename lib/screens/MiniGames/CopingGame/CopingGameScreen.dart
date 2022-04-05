import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/copingController.dart';
import 'package:flutter_application_1/enums/Province.dart';
import 'package:get/get.dart';

class ProvinceCards {
  AssetImage image;
  String info;
  String tips;

  ProvinceCards({required this.image, required this.info, required this.tips});
}

class CopingGameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CopingGameScreenState();
}

class CopingGameScreenState extends State<CopingGameScreen> {
  CopingController _copingController = Get.put(CopingController());
  Map<Province, List<ProvinceCards>> provinceCards = {
    Province.Abra: [
      // ProvinceCards(image: image, info: info, tips: tips),
    ],
  };

  @override
  Widget build(BuildContext context) {
    Province selectedProvince = _copingController.selectedProvince.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coping (${selectedProvince.name})',
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: Theme.of(context).colorScheme.neutralWhite01,
              fontWeight: FontWeight.w400),
        ),
        leading: BackButton(onPressed: () {
          Get.back();
        }),
        elevation: 0,
        backgroundColor: const Color(0xff216CB2).withOpacity(0.40)
      ),

      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_images/adventure_background.png',),
                  fit: BoxFit.cover))
            ),
        const SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // first row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(52.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.accentGreen04,
                          borderRadius: const BorderRadius.all(Radius.circular(12))
                      ),
                      child: Text('test'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(52.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.accentGreen04,
                          borderRadius: const BorderRadius.all(Radius.circular(12))
                      ),
                      child: Text('test'),
                    ),
                  ),
                ],
              ),

              // second row
              Row(
                children: [
                  Container(

                  ),

                  Container(
                    
                  ),
                ],
              )
            ],
          ),
        )
      ])
    );
  }
}
