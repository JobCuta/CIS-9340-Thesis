import 'dart:async';
import 'package:flip_card/flip_card.dart';
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

CopingController _copingController = Get.put(CopingController());

class CopingGameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CopingGameScreenState();
}

class CopingGameScreenState extends State<CopingGameScreen> {
  CopingController _copingController = Get.put(CopingController());
  Map<Province, List<ProvinceCards>> provinceCards = {
    Province.Abra: [
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_atsuete.png'), info: 'info', tips: 'tips'),
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_barkilya.png'), info: 'info2', tips: 'tips2'),
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_suyod.png'), info: 'info3', tips: 'tips3'),
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_tabungaw_hats.png'), info: 'info4', tips: 'tips4'),
      ProvinceCards(image: AssetImage('assets/coping_game/abra/abra_talisay.png'), info: 'info5', tips: 'tips5'),
    ],
  };

   showCardDialog(AssetImage img, String info, String tips, int index) {
     setState(() {
        _copingController.updateCardCompletion(Province.Abra, index);
     });

    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Align(alignment: Alignment.centerLeft, child: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back))),
          actions: [
            IconButton(onPressed: () => {}, icon: Icon(Icons.info)),
            IconButton(onPressed: () => {}, icon: Icon(Icons.subdirectory_arrow_right_sharp)),
          ],
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsOverflowDirection: VerticalDirection.down,
          backgroundColor: Colors.green[900],
            content: FlipCard(
              flipOnTouch: true,    // change later
              front: Container(
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: img,
                        fit: BoxFit.contain,
                      ),
                ),
              ),

              back: Container(
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(15),
                ),
                child: Text(tips)
                ),
              ),
            ),
        );
  }

  Padding _buildCards(Province province, List<bool> cardsCompleted) {
    List<ProvinceCards> cards = provinceCards[province] as List<ProvinceCards>;

    return Padding(
      padding: EdgeInsets.fromLTRB(25, 50, 25, 0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: cards.length,
        itemBuilder: (BuildContext context, index) {
          ProvinceCards card = cards[index];

          return InkWell(
            onTap: () {
              print('test $index');
              showCardDialog(card.image, card.info, card.tips, index);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: cardsCompleted[index] ? Colors.green[900] : Colors.green[800],
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: card.image,
                      fit: BoxFit.contain,
                      opacity: cardsCompleted[index] ? 0.7 : 1.0
                    ),
              ),
              child: Visibility(
                visible: cardsCompleted[index],
                child: Icon(Icons.check, color: Theme.of(context).colorScheme.accentGreen04, size: 46.0)
              )
            ),
          );
        }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Province selectedProvince = _copingController.selectedProvince.value;
    List<bool> cardsCompleted = _copingController.abraCardsCompleted.value;

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
        _buildCards(selectedProvince, cardsCompleted),
      ])
    );
  }
}
