import 'dart:ui';

import 'package:Scopa/view.dart';
import 'package:Scopa/views/home-view.dart';
import 'package:Scopa/views/result.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import 'RondaGame.dart';
import 'components/StartButton.dart';

class CoreGame extends Game {

  bool victory;
  Size screenSize;
  double tileSize;
  RondaGame rondaGame;
  HomeView homeView;
  View activeView = View.home;
  StartButton startButton;
  Result resultView;
  bool movingCard = false;
  Sprite tempSprite;
  int bValue = 0;
  int rValue = 0;
  CoreGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    homeView = HomeView(this);
    startButton = StartButton(this);
    resultView = Result(this);
    tempSprite =  Sprite("UI/geoback2.jpg");
  }

  @override
  void render(Canvas canvas) {

    drawBackground(canvas);
    if (activeView == View.home) {
      homeView.render(canvas);
      startButton.render(canvas);
    }
    else if (activeView == View.playing) {
      rondaGame.render(canvas);
    }
    else if (activeView == View.result) {
      resultView.render(canvas);
      startButton.render(canvas);
    }
  }
  double wideX = 0.0;
  void drawBackground(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    //Paint bgPaint = Paint();
    //bgPaint.color = Color(0xff162111);
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color.fromRGBO(180-bValue, 250, 180-bValue, 1),
          Color.fromRGBO(250, 180-rValue, 180-rValue, 1.0),

        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(bgRect);
    canvas.drawRect(bgRect, paint);


  }

  @override
  void update(double t) {

    if (activeView == View.playing) {
      rondaGame.update(t);

    }
    if (activeView == View.result) {
      resultView.update(t);
    }

  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;

  }

  void onTapDown(TapDownDetails d) {
    if (startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.result) {
        startButton.onTapDown();
        rondaGame = RondaGame(this);
      }
    }
    if (activeView == View.playing) {
      rondaGame.onTapDown(d);
    }
  }

}