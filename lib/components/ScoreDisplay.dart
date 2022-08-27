import 'dart:ui';
import 'package:Scopa/components/OpponentPlayer.dart';
import 'package:flutter/painting.dart';

import '../CoreGame.dart';
import 'Player.dart';

class ScoreDisplay {
  final CoreGame game;
  TextPainter textPainter;
  TextStyle textStyle;
  Offset position;

  ScoreDisplay(this.game) {
    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xfffff8dc),
      fontSize: 40,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xffd0b987),
          offset: Offset(3, 3),
        ),
      ],
    );
    position = Offset.zero;
  }

  void render(Canvas c) {
    textPainter.paint(c, position);
  }

  void update(double t, Player player) {
    if ((textPainter.text ?? '') != player.score.toString()) {
      textPainter.text = TextSpan(
        text: player.score.toString(),
        style: textStyle,
      );

      textPainter.layout();


      if (player is OpponentPlayer) {
        position = Offset(
            game.screenSize.width - game.tileSize * 1.5,
            10
        );
      }
      else {
        position = Offset(
            game.screenSize.width - game.tileSize * 1.5,
            player.cardPosY - 50
        );
      }
    }
  }
}