import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/copingController.dart';
import 'package:flutter_application_1/enums/Province.dart';
import 'package:flutter_application_1/screens/MiniGames/CopingGame/ProvinceCards.dart';
import 'package:flutter_application_1/widgets/talkingPersonDialog.dart';
import 'package:get/get.dart';

CopingController _copingController = Get.put(CopingController());

class CopingGameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CopingGameScreenState();
}

class CopingGameScreenState extends State<CopingGameScreen> {
  bool _infoSelected = false;
  CopingController _copingController = Get.put(CopingController());

  showCardDialog(AssetImage img, String info, String tipsTitle, String tips, int index, Province province) {
    // TODO: Move completion later on
    setState(() {
      _copingController.updateCardCompletion(province, index);
      bool isComplete = _copingController.getCompleteStatusOfProvinceCards(province);
      if (isComplete) {
        showTalkingPerson(context: context, dialog: "Congratulations! You beat the Coping Portion of the level! I'll bring you back to the list of task.");
      }
    });
    FlipCardController flipCardController = FlipCardController();
    print('infoSelected on start of dialog = $_infoSelected');

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) { return StatefulBuilder(
        builder: (context, setState) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0.00),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
          backgroundColor: Theme.of(context).colorScheme.intGreen06,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlipCard(
                  flipOnTouch: false,
                  controller: flipCardController,
                  front: Container(
                    height: 270,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.intGreen06,
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
                            InkWell(
                              onTap: () => Get.back(),
                              child: const Image(image: AssetImage('assets/images/coping_back_button_dark.png')),
                            ),
                            // CircleAvatar(radius: 24, backgroundColor: Theme.of(context).colorScheme.textileRed01,
                            //   child: IconButton(
                            //     icon: Icon(Icons.info),
                            //     onPressed: () {
                            //       setState(() => _infoSelected = true);
                            //       flipCardController.toggleCard();
                            //     }
                            //   )
                            // ),

                            InkWell(
                              onTap: () {
                                setState(() => _infoSelected = true);
                                flipCardController.toggleCard();
                              },
                              child: const Image(image: AssetImage('assets/images/coping_info_button.png')),
                            ),
                          ],
                        ),
      
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              setState(() => _infoSelected = false);
                              flipCardController.toggleCard();
                            },
                            child: const Image(image: AssetImage('assets/images/coping_tips_button.png')),
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  back: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.neutralWhite01,
                        borderRadius: const BorderRadius.all(Radius.circular(32.0))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(_infoSelected ? 'Did you know?' : tipsTitle, style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.intGreen06), textAlign: TextAlign.center),
                            ),
                            Divider(
                              color: Theme.of(context).colorScheme.neutralWhite03,
                              height: 25,
                              thickness: 1,
                            ),
                            Text(_infoSelected ? info : tips, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).colorScheme.neutralBlack02), textAlign: TextAlign.center),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => flipCardController.toggleCard(),
                            child: const Image(image: AssetImage('assets/images/coping_back_button_light.png')),
                          ),
                        ),
                      ],
                    )
                    ),
                  ),
              ],
            ),
            );
        }
      );
      }
    );
  }

  Padding _buildCards(Province province) {
    List<bool> cardsCompleted = 
        province == Province.Abra ? _copingController.abraCardsCompleted.value
        : province == Province.Apayao ? _copingController.apayaoCardsCompleted.value
        : province == Province.Benguet ? _copingController.benguetCardsCompleted.value
        : province == Province.Ifugao ? _copingController.ifugaoCardsCompleted.value
        : province == Province.Kalinga ? _copingController.kalingaCardsCompleted.value
        : _copingController.mountainProvinceCardsCompleted.value; 

    
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
              showCardDialog(card.image, card.info, card.tipsTitle, card.tips, index, province);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: cardsCompleted[index] ? Theme.of(context).colorScheme.intGreen06 : Theme.of(context).colorScheme.intGreen03,
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