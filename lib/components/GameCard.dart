import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/effects/scale_effect.dart';
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
  bool reveal = false;
  bool revealFalse = false;
  bool cpuCard =false;
  bool isMoving = false;
  double offsetX = 0;
  double offsetY = 0;
  bool deleteFade = false;
  bool fadeDown = false;
  bool grow = false;
  bool oneTime = false;
  //newCard 1 if just added from hand
  GameCard(this.game, int value, String type, int played) {
    this.updatePos = false;
    this.fade = false;
    this.played = played;
    move = 0;
    width = game.screenSize.width / 5.3;
    height = game.screenSize.height / 6.8;

    posX = game.screenSize.width / 2 - width / 2;
    posY = game.screenSize.height - height / 2;
    this.value = value;
    this.type = type;
    //this.cardSprite = Sprite("new/" + value.toString() + "_of_" + type + ".svg");

    cardRect = Rect.fromLTWH(posX, posY, width, height);
    this.delete = false;
  }
  final Color background = Color.fromRGBO(189, 0, 0, 1.0);
  Paint paint = Paint();
  double opacity = 0;

  void render(Canvas canvas) {

    cardRect = Rect.fromLTWH(posX, posY, width, height);
    canvas.drawRect(cardRect, paint..color = background.withOpacity(opacity));
    cardSprite.renderRect(canvas, cardRect);

  }

  void setPos (double posX, double posY , double height, double width){

    this.posX = posX;
    this.posY = posY;
    this.width = width;
    this.height = height;
  }
  void setPosXY (double posX, double posY ){

    this.posX = posX;
    this.posY = posY;
  }

   double _acceleration = 1;
  @override
  void update(double t) {


  if (fadeDown){
    this.posY += 1;
  }

    if (!visible ) {
      cardSprite = Sprite("tempo/back.png");
    }  else if (fade ){
      cardSprite = Sprite("tempo/" + value.toString() + type + ".png");
      this.posX -= _acceleration * 0.5;
      if (cpuCard){
        this.posY -= _acceleration;
        if (game.rValue < 177){
          game.rValue += 3;
        }

      } else {
        this.posY += _acceleration;
        if (game.bValue < 177){
          game.bValue += 3;
        }

      }

      _acceleration = _acceleration * 1.08;

        _acceleration = _acceleration * 1.08;


      //this.posY -= 0.5;


    } else {
      cardSprite = Sprite("tempo/" + value.toString() + type + ".png");

    }


    cardRect = Rect.fromLTWH(posX, posY, width, height);

  }

  void onTapDown() {

  }
}