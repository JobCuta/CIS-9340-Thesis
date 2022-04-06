
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/MiniGames/MemoryGame/MemoryGameCards.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGameScreen> {
  final MemoryGameCards _memoryGameCards = MemoryGameCards();

  @override
  void initState() {
    super.initState();
    _memoryGameCards.initMemoryGameCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.height,
            child: GridView.builder(
              itemCount: _memoryGameCards.benguetCardsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: MediaQuery.of(context).size.height * 0.01388,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.01388,
              ),
              itemBuilder: (content, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _memoryGameCards.cardImages![index] =
                      _memoryGameCards.benguetCardsList[index];
                      _memoryGameCards.matchCheck;
                    });
                    if (_memoryGameCards.matchCheck.length == 2) {
                      if (_memoryGameCards.matchCheck[0].values.first == _memoryGameCards.matchCheck[1].values.first) {
                        _memoryGameCards.matchCheck.clear();
                      }
                    } else {
                      Future.delayed(const Duration(microseconds: 500), () {
                        setState(() {
                          _memoryGameCards.cardImages![_memoryGameCards.matchCheck[0].keys.first] = _memoryGameCards.hiddenCardPath;
                          _memoryGameCards.cardImages![_memoryGameCards.matchCheck[1].keys.first] = _memoryGameCards.hiddenCardPath;
                          _memoryGameCards.matchCheck.clear();
                        });
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB46A),
                      image: DecorationImage(
                        image: AssetImage(_memoryGameCards.cardImages![index]),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

}