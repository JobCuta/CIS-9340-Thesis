
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class MemoryGameScreen extends StatefulWidget {

  const MemoryGameScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemoryGameState();
}


class _MemoryGameState extends State<MemoryGameScreen> {
  late FlipCardController _controller;
  int _previousIndex = -1;
  bool _flip = false;
  bool _wait = false;

  List<bool> _cardFlips = getInitialItemState();
  List<GlobalKey<FlipCardState>> _cardStateKeys = getCardStateKeys();
  List<String> _data = benguetCards();

  @override
  void initState() {
    super.initState();
    _data.shuffle();
  }

  Widget getItem(int index) {
    return SizedBox(
      height: 120,
      child: Card(
        color: const Color(0xffe9a4f6),
        child: Center(
          child: Image.asset(_data[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background_images/adventure_background.png'),
                  fit: BoxFit.cover)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.10),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (context, index) => FlipCard(
                    key: _cardStateKeys[index],
                    onFlip: () {
                      if (!_flip) {
                        _flip = true;
                        _previousIndex = index;
                      } else {
                        _flip = false;
                        if (_previousIndex != index) {
                          if (_data[_previousIndex] != _data[index]) {
                            _wait = true;

                            Future.delayed(const Duration(milliseconds: 1000), () {
                              _cardStateKeys[_previousIndex].currentState!.toggleCard();
                              _previousIndex = index;
                              _cardStateKeys[_previousIndex].currentState!.toggleCard();
                                }
                            );

                            Future.delayed(const Duration(milliseconds: 160), () {
                              setState(() {
                                _wait = false;
                              });
                            }
                            );
                          }
                        } else {
                          _cardFlips[_previousIndex] = false;
                          _cardFlips[index] = false;
                        }
                      }
                    },
                    flipOnTouch: _wait ? false : _cardFlips[index],
                    front: const SizedBox(
                      height: 120,
                      child: Card(
                        child: Center(
                          child: Image(image: AssetImage('assets/images/hidden_card.png')),
                        ),
                      ),
                    ),
                    back: getItem(index),
                  ),
                  itemCount: _data.length,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}


List getCards(Province province) {
  List<String> provinceCardsList = <String>[];
  List cardSource;
  if (province == Province.abra) {
    cardSource = abraCards();
    for (var element in cardSource) {
      provinceCardsList.add(element);
    }
  } else if (province == Province.apayao) {
    cardSource = apayaoCards();
    for (var element in cardSource) {
      provinceCardsList.add(element);
    }
  } else if (province == Province.benguet) {
    cardSource = benguetCards();
    for (var element in cardSource) {
      provinceCardsList.add(element);
    }
  } else if (province == Province.ifugao) {
    cardSource = ifugaoCards();
    for (var element in cardSource) {
      provinceCardsList.add(element);
    }
  } else if (province == Province.kalinga) {
    cardSource = kalingaCards();
    for (var element in cardSource) {
      provinceCardsList.add(element);
    }
  } else {
    cardSource = mtProvinceCards();
    for (var element in cardSource) {
      provinceCardsList.add(element);
    }
  }
  return provinceCardsList;

}

List<GlobalKey<FlipCardState>> getCardStateKeys() {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[];
  for (int i = 0; i < 16; i++) {
    cardStateKeys.add(GlobalKey<FlipCardState>());
  }
  return cardStateKeys;
}

List<bool> getInitialItemState() {
  List<bool> initialItemState = <bool>[];
  for (int i = 0; i < 16; i++) {
    initialItemState.add(true);
  }
  return initialItemState;
}


enum Province { abra, apayao, benguet, ifugao, kalinga, mountainProvince }

List<String> abraCards() {
  return [];
}

List<String> apayaoCards() {
  return [];
}

List<String> benguetCards() {
  return [
    'assets/coping_game/benguet/benguet_bark_beater.png', 'assets/coping_game/benguet/benguet_bark_beater.png',
    'assets/coping_game/benguet/benguet_kalsa.png', 'assets/coping_game/benguet/benguet_kalsa.png',
    'assets/coping_game/benguet/benguet_kayabang_basket.png', 'assets/coping_game/benguet/benguet_kayabang_basket.png',
    'assets/coping_game/benguet/benguet_kiyag.png', 'assets/coping_game/benguet/benguet_kiyag.png',
    'assets/coping_game/benguet/benguet_lions_head.png', 'assets/coping_game/benguet/benguet_lions_head.png',
    'assets/coping_game/benguet/benguet_obukay.png', 'assets/coping_game/benguet/benguet_obukay.png',
    'assets/coping_game/benguet/benguet_shield.png', 'assets/coping_game/benguet/benguet_shield.png',
    'assets/coping_game/benguet/benguet_solibao.png', 'assets/coping_game/benguet/benguet_solibao.png'
  ];
}

List<String> ifugaoCards() {
  return [];
}

List<String> kalingaCards() {
  return [];
}

List<String> mtProvinceCards() {
  return [];
}

