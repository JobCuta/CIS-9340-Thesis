class MemoryGameCards {
  final String hiddenCardPath = 'assets/images/hidden_card.png';
  List<String>? cardImages;

  final List<String> benguetCardsList = [
    'assets/coping_game/benguet/benguet_bark_beater.png', 'assets/coping_game/benguet/benguet_bark_beater.png',
    'assets/coping_game/benguet/benguet_kalsa.png', 'assets/coping_game/benguet/benguet_kalsa.png',
    'assets/coping_game/benguet/benguet_kayabang_basket.png', 'assets/coping_game/benguet/benguet_kayabang_basket.png',
    'assets/coping_game/benguet/benguet_kiyag.png', 'assets/coping_game/benguet/benguet_kiyag.png',
    'assets/coping_game/benguet/benguet_lions_head.png', 'assets/coping_game/benguet/benguet_lions_head.png',
    'assets/coping_game/benguet/benguet_obukay.png', 'assets/coping_game/benguet/benguet_obukay.png',
    'assets/coping_game/benguet/benguet_shield.png', 'assets/coping_game/benguet/benguet_shield.png',
    'assets/coping_game/benguet/benguet_solibao.png', 'assets/coping_game/benguet/benguet_solibao.png'
  ];

  final List<String> kalingaCardsList = [
    "assets/coping_game/kalinga/kalinga_bamboo_container.png"

  ];

  List<Map<int, String>> matchCheck = [];

  final int cardCount = 16;

  void initMemoryGameCards() {
    cardImages = List.generate(cardCount, (index) => hiddenCardPath);
  }
}