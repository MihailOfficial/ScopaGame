import 'dart:math';
import 'dart:ui';

import 'package:Scopa/components/GameCard.dart';
import 'package:Scopa/components/OpponentPlayer.dart';
import 'package:Scopa/components/Player.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';

import 'GameCard.dart';
class StoreLocation{
  double x = 0;
  double y = 0;
  bool full = false;
}

class Board {
  List <StoreLocation> locations = new List<StoreLocation>();
  List<GameCard> cards;
  final game;
  List<GameCard> deleted;
  double cardPosX = 0;
  double cardPosY;
  double cardWidth;
  double cardHeight;
  List<int> summed = List<int>();
  double changed = 0;
  bool revertColor = false;
  bool revertColorR = false;
  Board(this.game) {

    cards = List<GameCard>();
    cardWidth = game.screenSize.width / 5;
    cardHeight = game.screenSize.height / 4.6;
    cardPosY = game.screenSize.height / 2 - game.screenSize.height / 6.8- game.screenSize.height / 6.8- (game.screenSize.height / 6.8)/2;

    for (int i = 0; i< 16; i++){
      StoreLocation temp = new StoreLocation();
      if (i< 4){
        //first row
        temp.x = cardWidth /2 + i * cardWidth;
        temp.y = cardPosY;
      } else if (i < 8){
        //second row
        temp.x = cardWidth /2 + (i-5) * cardWidth + cardWidth;
        temp.y =  cardPosY + 0.8 * cardHeight;
      } else if (i < 12){
        //thirst row
        temp.x = cardWidth /2 + (i-9) * cardWidth + cardWidth;
        temp.y =  cardPosY + 2* 0.8 * cardHeight;
      } else {
        temp.x = cardWidth /2 + (i-12) * cardWidth;
        temp.y =  cardPosY + 3* 0.8 * cardHeight;
    }
      print("carding///////////////");
      locations.add(temp);
    }

  }
  int move = 0;
  int oneTime = 0;
  double adr = -50;
  double incre = 1.1;
  int shrink = 0;
  int sizeCards = 0;


  void update(double t) {

    for (int i = 0; i< cards.length; i++) {
      GameCard card = cards[i];

      if (card.delete == true) {

        //eleted.add(card);
        if (card.cpuCard){
          revertColorR = true;
        } else {
          revertColor = true;
          HapticFeedback.vibrate();
        }
        cards.remove(card);
        card.fade = false;
        card.update(t);
      }
    }
    for (int i = 0; i< cards.length; i++) {
      GameCard card = cards[i];
      card.visible = true;
      card.update(t);
    }
  }

  void render(Canvas canvas) {

    int changed = 0;

    sizeCards ++;

    for (int i = 0; i< cards.length; i++){

      GameCard card = cards[i];
      if (card.delete == true) {
        //deleted.add(card);
        revertColor = true;
        revertColorR = true;
        if (card.cpuCard){
          revertColorR = true;
        } else {
          revertColor = true;
        }

        cards.remove(card);
        card.fade = false;
        revertColor = true;
        revertColorR = true;
      }
      if (!card.fade) {
        move++;
        card.height = game.screenSize.height / 6;

        if (card.move != 1) {
          double posXz;
          double posYz;
          int moveSpeed = 2;
          if (card.boardPosition == -1){
            StoreLocation findLocation = findFreeSpace(card);
            changed = mover(findLocation.x, findLocation.y, card, changed);
          } else {
            changed = mover(locations.elementAt(card.boardPosition).x, locations.elementAt(card.boardPosition).y, card, changed);
          }

        }
      }

      if (card.fade == true) {
        game.movingCard = true;
        card.isMoving = true;
        changed++;
        //card.height -= 1;
        if (card.posX < -cardWidth) {
          card.delete = true;


        }
      }

      if (card.revealFalse == true) {
        card.width -= 2;
        if (card.width < 0) {
          card.revealFalse = false;
          card.delete = true;
        }
      }
      if (game.movingCard = true) {
        card.render(canvas);
        card.isMoving = false;
      }

      card.offsetX = 0;
      card.offsetY = 0;
    }
    if (changed == 0){
      game.movingCard = false;

    }

    for (int i = 0; i< cards.length; i++) {
      GameCard card = cards[i];
      if (card.fade){
        card.render(canvas);
      }
    }

  }

  int playCard(GameCard card, Player player) {
    move = 0 ;
    int result = 0;

    List<GameCard> found = List<GameCard>();
    summed.clear();
    // look for matching card
    for (GameCard boardCard in cards){
      if (card.value == boardCard.value) {

        if (player is OpponentPlayer){
          boardCard.cpuCard = true;
        }
        boardCard.fade = true;
        player.score += 1;
        return 0;
      }
    }
    // no matching card
    if (found.isEmpty) {
      List<int> sol = List<int>(cards.length);
      find(cards, 0, 0, card.value,  sol);

      if (summed.isEmpty) {
        changed = 1;
        result = 1;
        cards.add(card);
        card.played = 1;

      } else {
        for (int a = 0; a<cards.length; a++) {
          for (int i = 0; i < summed.length; i++) {
            if (summed[i] == cards.elementAt(a).value) {
              //found.add(boardCard);
              print(" ident: " + cards.elementAt(a).value.toString());
              found.add(cards.elementAt(a));
              player.score += 1;

              //handle score later
            }
          }
        }
      }
    }

    // removes here to not go out of bounds in loop above
    for (GameCard boardCard in found){

      if (player is OpponentPlayer){
        boardCard.cpuCard = true;
      }
      boardCard.fade = true;

    }

    if (player is OpponentPlayer == false) {
        //Flame.audio.play("sfx/win.mp3");
    }
    return result;
  }

  void find(var A, int currSum, int index, int sum, var solution) {
    if (currSum == sum) {
      for (int i = 0; i < solution.length; i++) {
        if (solution[i] == 1) {
          summed.add(A.elementAt(i).value);
        }
        int res = 0;
        for (int a = 0; a<summed.length; a++){
          res += summed.elementAt(a);
        }
        if (res == sum){return;}
      }

    } else if (index == A.length) {
      return;
    } else {
      solution[index] = 1; // select the element
      currSum += A.elementAt(index).value;
      find(A, currSum, index + 1, sum, solution);
      currSum -= A.elementAt(index).value;
      solution[index] = 0; // do not select the element
      find(A, currSum, index + 1, sum, solution);
    }
  }

  StoreLocation findFreeSpace(GameCard card){
    StoreLocation temp = new StoreLocation();
    for (int i = 0; i< 16; i++){
      if (!locations.elementAt(i).full){
        temp.x = locations.elementAt(i).x;
        temp.y = locations.elementAt(i).y;
        card.boardPosition = i;
        locations.elementAt(i).full = true;
        break;
      }
    }
    return temp;
  }
  int mover (double posXz, double posYz, GameCard card, int changed){
    int moveSpeed = 2;
    double distance ;

      if (card.offsetX == 0 && (posXz - card.posX).abs() > 0.3) {
        if (card.offsetX == 0) {
          card.offsetX = (posXz - card.posX).abs() / 10;
          if (card.offsetX < 0.01){card.offsetX = 0.01;}
        }

        game.movingCard = true;
        card.isMoving = true;
        changed++;
        distance = 2;
        if (posXz > card.posX) {
          card.posX += card.offsetX;
        }
        else {
          card.posX -= card.offsetX;
        }
      }
      if (card.offsetY == 0 && (posYz - card.posY).abs() > 0.3) {
        game.movingCard = true;
        card.isMoving = true;
        changed++;
        distance = 2;
        if (card.offsetY == 0) {
          card.offsetY = (posYz - card.posY).abs() / 10;
          if (card.offsetY < 0.01){card.offsetY = 0.01;}
        }
        if (posYz > card.posY) {
          card.posY += card.offsetY;
        }
        else {
          card.posY -= card.offsetY;
        }
      }

    return changed;
  }
}


