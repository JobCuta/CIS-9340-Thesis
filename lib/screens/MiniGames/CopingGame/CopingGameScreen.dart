import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/copingController.dart';
import 'package:flutter_application_1/enums/Province.dart';
import 'package:flutter_application_1/screens/MiniGames/CopingGame/ProvinceCards.dart';
import 'package:get/get.dart';

CopingController _copingController = Get.put(CopingController());

class CopingGameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CopingGameScreenState();
}

class CopingGameScreenState extends State<CopingGameScreen> {
  bool _infoSelected = false;
  CopingController _copingController = Get.put(CopingController());

  showCardDialog(AssetImage img, String info, String tipsTitle, String tips, int index) {
    setState(() {
      _copingController.updateCardCompletion(Province.Abra, index);
    });
    FlipCardController flipCardController = FlipCardController();
    print('infoSelected on start of dialog = $_infoSelected');

  return showDialog<String>(
      context: context,
      builder: (BuildContext context) { return StatefulBuilder(
        builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.green[900],
            content: FlipCard(
              flipOnTouch: false,
              controller: flipCardController,
              front: Container(
                
                height: 270,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: img,
                        fit: BoxFit.contain,
                      ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(radius: 24, backgroundColor: Theme.of(context).colorScheme.textileRed01,
                          child: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back))
                        ),
                        CircleAvatar(radius: 24, backgroundColor: Theme.of(context).colorScheme.textileRed01,
                          child: IconButton(
                            icon: Icon(Icons.info),
                            onPressed: () {
                              setState(() => _infoSelected = true);
                              flipCardController.toggleCard();
                            }
                          )
                        ),
                      ],
                    ),
      
                    Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(radius: 24, backgroundColor: Theme.of(context).colorScheme.textileRed01,
                        child: IconButton(
                          icon: Icon(Icons.subdirectory_arrow_right_sharp),
                          onPressed: () {
                            setState(() => _infoSelected = false);
                            flipCardController.toggleCard();
                          }, 
                        )
                      ),
                    ),
                  ],
                ),
              ),
      
              back: Container(
                height: 270,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(_infoSelected ? 'Did you know?' : tipsTitle, style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                        Text(_infoSelected ? info : tips, style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(radius: 24, backgroundColor: Theme.of(context).colorScheme.textileRed01,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            flipCardController.toggleCard();
                          }, 
                        )
                      ),
                    ),
                  ],
                )
                ),
              ),
            );
        }
      );
      }
    );
  }

  Padding _buildCards(Province province) {
    List<bool> cardsCompleted = _copingController.abraCardsCompleted.value;
    List<ProvinceCards> cards = provinceCards[province] as List<ProvinceCards>;

    return Padding(
      padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
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
              showCardDialog(card.image, card.info, card.tipsTitle, card.tips, index);
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
        _buildCards(selectedProvince),
      ])
    );
  }
}
