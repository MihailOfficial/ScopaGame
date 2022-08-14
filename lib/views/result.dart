import 'dart:ui';
import 'package:Scopa/CoreGame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class Result {
  final CoreGame game;

  TextPainter textPainter;
  TextStyle textStyle;
  Offset position;

  Result(this.game) {
    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 50,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );
    position = Offset.zero;
  }

  void render(Canvas c) {
    textPainter.paint(c, position);
  }

  void update(double t) {
    if (game.victory == true) {
      textPainter.text = TextSpan(
        text: "YOU WIN",
        style: textStyle,
      );
    }
    else {
      textPainter.text = TextSpan(
        text: "YOU LOSE",
        style: textStyle,
      );
    }
    textPainter.layout();
    position = Offset(
        game.screenSize.width / 2 - textPainter.width / 2,
        game.screenSize.height / 4,
    );
  }
}