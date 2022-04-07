
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemoryGameState();
}

List<Image> benguetImages = [
  const Image(image: AssetImage('assets/coping_game/benguet/benguet_bark_beater.png')), const Image(image: AssetImage('assets/coping_game/benguet/benguet_bark_beater.png')),
  const Image(image: AssetImage('assets/coping_game/benguet/benguet_kalsa.png')), const Image(image: AssetImage('assets/coping_game/benguet/benguet_kalsa.png')),
  const Image(image: AssetImage('assets/coping_game/benguet/benguet_kayabang_basket.png')), const Image(image: AssetImage('assets/coping_game/benguet/benguet_kayabang_basket.png')),
  const Image(image: AssetImage('assets/coping_game/benguet/benguet_kiyag.png')), const Image(image: AssetImage('assets/coping_game/benguet/benguet_kiyag.png')),
  const Image(image: AssetImage('assets/coping_game/benguet/benguet_lions_head.png')), const Image(image: AssetImage('assets/coping_game/benguet/benguet_lions_head.png')),
  const Image(image: AssetImage('assets/coping_game/benguet/benguet_obukay.png')), const Image(image: AssetImage('assets/coping_game/benguet/benguet_obukay.png')),
  const Image(image: AssetImage('assets/coping_game/benguet/benguet_shield.png')), const Image(image: AssetImage('assets/coping_game/benguet/benguet_shield.png')),
  const Image(image: AssetImage('assets/coping_game/benguet/benguet_solibao.png')), const Image(image: AssetImage('assets/coping_game/benguet/benguet_solibao.png')),
];

class _MemoryGameState extends State<MemoryGameScreen> {
  @override
  void initState() {
    super.initState();
    benguetImages.shuffle();
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
                    onFlip: () {

                    },
                    flipOnTouch: true,
                    back: SizedBox(
                      height: 120,
                      child: Card(
                        color: const Color(0xffe9a4f6),
                        child: Center(
                          child: benguetImages[index],
                          ),
                        ),
                      ),
                    front: const SizedBox(
                      height: 120,
                      child: Card(
                        child: Center(
                          child: Image(image: AssetImage('assets/images/hidden_card.png')),
                        ),
                      ),
                    )
                  ),
                  itemCount: benguetImages.length,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}