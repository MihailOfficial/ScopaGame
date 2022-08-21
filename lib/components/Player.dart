import 'dart:ui';

import 'package:flame/sprite.dart';

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
    cardPosY = game.screenSize.height - 10;
    //game.screenSize.height - cardHeight / 2;
  }

  void takeCard(GameCard card) {

    if (cards.length < 3) {
      cards.add(card);
      double posX = cardWidth * cards.length;
      card.cardRect = Rect.fromLTWH(posX, cardPosY, cardWidth, cardHeight);
      card.setPos(posX, cardPosY, cardHeight, cardWidth);
      card.cardSprite = Sprite("Cards/back.png");
      card.present = true;
    }
  }

  void render(Canvas canvas) {
    cards.forEach((element) {element.render(canvas);});
    cards.forEach((card) {
      if (card.present == true && card.posY > game.screenSize.height - cardHeight / 2) {
        card.posY -= 0.5;
      } else {
        card.present = false;
        card.cardSprite = Sprite("Cards/card_" + card.value.toString() + "_" + card.type + ".png");
      }

    });

  }
}