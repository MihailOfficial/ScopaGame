import 'dart:ui';

import 'package:Scopa/components/Player.dart';

class OpponentPlayer extends Player {
  OpponentPlayer(game) : super(game) {
    cardPosY = -cardHeight;
  }
  bool hide = false;
  void update(double t) {

    cards.forEach((card) {
      card.visible = false;
      if (card.present2 == true && card.posY < -cardHeight / 2) {
        card.posY += 1;
      } else {

        card.present2 = false;
      }

      if (card.reveal && card.posY > -cardHeight) {
        card.posY -= 1;

      } else if (card.revealFalse){
        card.reveal = false;
      }



      card.update(t);
    });

  }

}