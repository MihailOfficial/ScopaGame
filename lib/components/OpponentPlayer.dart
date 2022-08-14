import 'dart:ui';

import 'package:Scopa/components/Player.dart';

class OpponentPlayer extends Player {
  OpponentPlayer(game) : super(game) {
    cardPosY = -cardHeight / 2;
  }

  void update(double t) {
    cards.forEach((card) {
      card.visible = false;
      card.update(t);
    });
  }

}