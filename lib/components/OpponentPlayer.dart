import 'dart:ui';

import 'package:Scopa/components/Player.dart';

class OpponentPlayer extends Player {
  OpponentPlayer(game) : super(game) {
    cardPosY = -cardHeight;
  }

  void update(double t) {
    cards.forEach((card) {
      card.visible = false;
      if (card.present2 == true && card.posY < -cardHeight / 2) {
        card.posY += 0.5;
      } else {
        card.present2 = false;
      }
      if (card.reveal == true && card.posY < cardHeight) {
        card.posY += 0.3;
      } else {
        //card.reveal = false;
      }
      card.update(t);
    });

    cards.forEach((card) {

      if (card.reveal == true && card.posY < -cardHeight) {
        card.posY += 0.5;
      } else {
        //card.reveal = false;
      }

      card.update(t);
    });
  }

}