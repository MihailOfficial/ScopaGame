import 'dart:ui';

import 'GameCard.dart';

class Player {
  final game;

  List<GameCard> cards;
  double cardPosX = 0;
  double cardPosY;
  double cardWidth;
  double cardHeight;

  int score = 0;

  Player(this.game) {
    cards = List<GameCard>();
    cardWidth = game.screenSize.width / 5;
    cardHeight = game.screenSize.height / 5;
    cardPosY = game.screenSize.height - cardHeight / 2;
  }

  void takeCard(GameCard card) {
    if (cards.length < 3) {
      cards.add(card);
      double posX = cardWidth * cards.length;
      card.cardRect = Rect.fromLTWH(posX, cardPosY, cardWidth, cardHeight);
      card.setPos(posX, cardPosY, cardHeight, cardWidth);
    }
  }

  void render(Canvas canvas) {
    cards.forEach((element) {element.render(canvas);});
  }
}