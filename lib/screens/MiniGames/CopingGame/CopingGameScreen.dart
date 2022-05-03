import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/adventureController.dart';
import 'package:flutter_application_1/controllers/copingController.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_application_1/enums/Province.dart';
import 'package:flutter_application_1/screens/MiniGames/CopingGame/ProvinceCards.dart';
import 'package:flutter_application_1/widgets/talkingPersonDialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

CopingController _copingController = Get.put(CopingController());

class CopingGameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CopingGameScreenState();
}

class CopingGameScreenState extends State<CopingGameScreen> {
  bool _infoSelected = false;
  CopingController _copingController = Get.put(CopingController());
  AdventureController _adventureController = Get.put(AdventureController());
  double height = 350;
  double width = 300;
  bool isComplete = false;
  bool willBeCompletedOnceOnly = false;

  showCardDialog(AssetImage img, String info, String tipsTitle, String tips,
      int index, Province province) {
    setState(() {
      willBeCompletedOnceOnly = _copingController.checkIfItWillBeCompletedSoon(province);
      _copingController.updateCardCompletion(province, index);
      isComplete = _copingController.getCompleteStatusOfProvinceCards(province);
    });
    FlipCardController flipCardController = FlipCardController();
    print('infoSelected on start of dialog = $_infoSelected');

    return showDialog<String>(
        barrierColor: const Color(0xff101010).withOpacity(0.60),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlipCard(
                    flipOnTouch: false,
                    controller: flipCardController,
                    front: Container(
                      height: height,
                      width: width,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width - 150,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.intGreen06,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Image(image: img),
                                ),
                              )),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () => Get.back(),
                                    child: SvgPicture.asset(
                                        'assets/images/coping_back_button_dark.svg'),
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
                                    child: SvgPicture.asset(
                                        'assets/images/coping_info_button.svg'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  setState(() => _infoSelected = false);
                                  flipCardController.toggleCard();
                                },
                                child: SvgPicture.asset(
                                    'assets/images/coping_tips_button.svg'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    back: Container(
                        height: height,
                        width: width,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width - 150,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralWhite01,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0))),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 10),
                                      child: Text(
                                        _infoSelected
                                            ? 'Did you know?'
                                            : tipsTitle,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .intGreen06),
                                      ),
                                    ),
                                    Divider(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite03,
                                      height: 5,
                                      indent: 10,
                                      endIndent: 10,
                                      thickness: 1,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(_infoSelected ? info : tips,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .neutralBlack02),
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () => flipCardController.toggleCard(),
                                  child: SvgPicture.asset(
                                      'assets/images/coping_back_button_light.svg'),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            );
          });
        }).then((value) {
      if (isComplete && willBeCompletedOnceOnly) {
        showTalkingPerson(
            context: context,
            dialog:
                "Congratulations! You beat the Coping Portion of the level! I'll bring you back to the list of task.");

        LevelController _levelController = Get.put(LevelController());
        _levelController.addXp('Coping (${province.name})', 50);
        _levelController.displayLevelXpModal(context);
      }
    });
  }

  Padding _buildCards(Province province) {
    List<bool> cardsCompleted = province == Province.Abra
        ? _copingController.abraCardsCompleted.value
        : province == Province.Apayao
            ? _copingController.apayaoCardsCompleted.value
            : province == Province.Benguet
                ? _copingController.benguetCardsCompleted.value
                : province == Province.Ifugao
                    ? _copingController.ifugaoCardsCompleted.value
                    : province == Province.Kalinga
                        ? _copingController.kalingaCardsCompleted.value
                        : _copingController
                            .mountainProvinceCardsCompleted.value;

    List<ProvinceCards> cards = provinceCards[province] as List<ProvinceCards>;

    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 50, 50, 25),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: cards.length,
          itemBuilder: (BuildContext context, index) {
            ProvinceCards card = cards[index];

            return InkWell(
              onTap: () {
                showCardDialog(card.image, card.info, card.tipsTitle, card.tips,
                    index, province);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.intGreen06,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(image: card.image),
                    ),
                    Visibility(
                        visible: cardsCompleted[index],
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context)
                                  .colorScheme
                                  .neutralBlack02
                                  .withOpacity(0.40),
                            ),
                            child: const Icon(Icons.check,
                                color: Color(0xff00BF58), size: 50.0))),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Province selectedProvince = _adventureController.selectedProvince.value;

    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Coping (${selectedProvince.name})',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: Theme.of(context).colorScheme.neutralWhite01,
                  fontWeight: FontWeight.w400),
            ),
            leading: BackButton(onPressed: () {
              Get.offAndToNamed('/ActivitiesGameScreen');
            }),
            elevation: 0,
            backgroundColor: Colors.transparent),
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/background_images/adventure_background.png',
                      ),
                      fit: BoxFit.cover))),
          const SizedBox(height: 10.0),
          SingleChildScrollView(child: _buildCards(selectedProvince)),
        ]));
  }
}
