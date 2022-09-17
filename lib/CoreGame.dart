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
  double bValue = 0;
  double rValue = 0;
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
    Rect rectTop = Rect.fromLTWH(0, 0, screenSize.width, 120);
    Rect rectBottom = Rect.fromLTWH(0, screenSize.height - 120, screenSize.width, 120);
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color.fromRGBO(240, 190, 166, wideX),
          Color.fromRGBO(136, 186, 205, wideX),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(bgRect);
    final paintTop = Paint()
      ..shader = LinearGradient(
        colors: [

          Color.fromRGBO(231, 189, 209, 0),

          Color.fromRGBO(231, 189, 209, rValue),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(rectTop);
    final paintBottom = Paint()
      ..shader = LinearGradient(
        colors: [

          Color.fromRGBO(149, 181, 148, bValue),
          Color.fromRGBO(149, 181, 148, 0),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(rectBottom);
    //canvas.drawRect(bgRect, paint);
   // tempSprite.renderRect(canvas, bgRect);
    canvas.drawRect(bgRect, paint);
    canvas.drawRect(rectTop, paintTop);
    canvas.drawRect(rectBottom, paintBottom);

  }

  @override
  void update(double t) {
    if (wideX < 0.97){wideX += 0.03;}
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