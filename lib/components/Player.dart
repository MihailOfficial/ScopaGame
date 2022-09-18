import 'dart:ui';

import 'package:flame/sprite.dart';

import 'GameCard.dart';

class Player {
  final game;

  List<GameCard> cards;
  double cardPosX = 0;
  double cardPosY = 0;
  double cardHeight = 0;
  double cardWidth = 0;


  int score = 0;

  Player(this.game) {
    cards = List<GameCard>();
    cardWidth = game.screenSize.width / 5.3;
    cardHeight = game.screenSize.height / 6.8;
    cardPosY = game.screenSize.height - 10;
    //game.screenSize.height - cardHeight / 2;
  }

  void takeCard(GameCard card) {
    cardHeight = card.height;
    cardWidth = card.width;
    if (cards.length < 3) {
      cards.add(card);
      double posX = (cardWidth * cards.length);
      card.cardRect = Rect.fromLTWH(posX, cardPosY, cardWidth, cardHeight);
      card.setPos(posX, cardPosY, cardHeight, cardWidth);
      card.cardSprite = Sprite("tempo/back.png");
      card.present = true;
    }
  }
  double slideNum = 1;
  void render(Canvas canvas) {
    cards.forEach((element) {if (element.fadeDown){element.posY += 2;}element.render(canvas);});
    cards.forEach((card) {
      if (card.present == true && card.posY > game.screenSize.height - (2*card.height / 3)) {
        card.posY -= slideNum;
        slideNum = slideNum*slideNum;
      } else {
        card.present = false;
        slideNum = 1;
        card.cardSprite = Sprite("tempo/" + card.value.toString() +  card.type + ".png");
      }

    });
    cards.forEach((element) {element.render(canvas);});

  }
}