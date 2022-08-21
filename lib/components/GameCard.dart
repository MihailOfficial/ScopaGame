import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class GameCard extends Component{
  final game;

  int value;
  String type;
  bool visible = true;

  Sprite cardSprite;
  Rect cardRect;
  double width;
  double height;
  double posX;
  double posY;
  int played;
   bool fade = false;
  bool touched = false;
  Offset targetLocation;
  double get speed => game.tileSize * 50;
  int move = 0;
  bool delete = false;
  SpriteComponent spriteT;
  bool updatePos;
  bool present = false;
  bool present2 = false;
  //newCard 1 if just added from hand
  GameCard(this.game, int value, String type, int played) {
    this.updatePos = false;
    this.fade = false;
    this.played = played;
    move = 0;
    width = game.screenSize.width / 5;
    height = game.screenSize.height / 5;
    posX = game.screenSize.width / 2 - width / 2;
    posY = game.screenSize.height - height / 2;
    this.value = value;
    this.type = type;
    this.cardSprite = Sprite("Cards/card_" + value.toString() + "_" + type + ".png");

    cardRect = Rect.fromLTWH(posX, posY, width, height);
    this.delete = false;
  }

  void render(Canvas canvas) {

    cardRect = Rect.fromLTWH(posX, posY, width, height);
    cardSprite.renderRect(canvas, cardRect);



  }

  void setPos (double posX, double posY , double height, double width){

    this.posX = posX;
    this.posY = posY;
    this.width = width;
    this.height = height;
  }
  int incre = 0;
  @override
  void update(double t) {

    if (!visible) {
      cardSprite = Sprite("Cards/back.png");
    }
    else {
      cardSprite = Sprite("Cards/card_" + value.toString() + "_" + type + ".png");
    }


    cardRect = Rect.fromLTWH(posX, posY, width, height);

  }

  void onTapDown() {

  }
}