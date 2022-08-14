import 'dart:ui';

import 'package:Scopa/components/GameCard.dart';
import 'package:Scopa/components/OpponentPlayer.dart';
import 'package:Scopa/components/Player.dart';
import 'package:flame/flame.dart';

import 'GameCard.dart';

class Board {
  List<GameCard> cards;
  final game;

  double cardPosX = 0;
  double cardPosY;
  double cardWidth;
  double cardHeight;
  List<int> summed = List<int>();
  double changed = 0;
  Board(this.game) {
    cards = List<GameCard>();
    cardWidth = game.screenSize.width / 5;
    cardHeight = game.screenSize.height / 5;
    cardPosY = game.screenSize.height / 2 - cardHeight;
  }
  int move = 0;
  int oneTime = 0;
  double adr = -50;
  double incre = 1.1;
  int shrink = 0;
  void render(Canvas canvas) {
    cards.forEach((card) {

      move++;
      if (move < 50 && oneTime == 0) {
        cardPosY += 0.00016*move*move;
        card.cardRect = Rect.fromLTWH(
            cards.indexOf(card) * cardWidth + cardWidth,
            cardPosY,
            cardWidth - 5,
            0.8 * cardHeight - 5);
      } else {
        oneTime = 1;
      }

     if ( card.move != 1){
        if (cards.indexOf(card) < 3) {
          card.cardRect = Rect.fromLTWH(
              cards.indexOf(card) * cardWidth + cardWidth,
              cardPosY,
              cardWidth - 5,
              0.8 * cardHeight - 5);
          card.setPos(cards.indexOf(card) * cardWidth + cardWidth, cardPosY,
              0.8 * cardHeight - 5, cardWidth - 5);
        } else if (cards.indexOf(card) < 6) {
          card.cardRect = Rect.fromLTWH(
              (cards.indexOf(card) * cardWidth + cardWidth) - 3 * cardWidth,
              cardPosY + 0.8 * cardHeight,
              cardWidth - 5,
              0.8 * cardHeight - 5);
          card.setPos(
              (cards.indexOf(card) * cardWidth + cardWidth) - 3 * cardWidth,
              cardPosY + 0.8 * cardHeight, 0.8 * cardHeight - 5, cardWidth - 5);
        } else if (cards.indexOf(card) == 6) {
          card.cardRect =
              Rect.fromLTWH(0, cardPosY, cardWidth - 5, 0.8 * cardHeight - 5);
          card.setPos(0, cardPosY, 0.8 * cardHeight - 5, cardWidth - 5);
        } else if (cards.indexOf(card) == 7) {
          card.cardRect = Rect.fromLTWH(game.screenSize.width - cardWidth,
              cardPosY, cardWidth - 5, 0.8 * cardHeight - 5);
          card.setPos(
              game.screenSize.width - cardWidth, cardPosY, 0.8 * cardHeight - 5,
              cardWidth - 5);
        } else if (cards.indexOf(card) == 8) {
          card.cardRect = Rect.fromLTWH(0, cardPosY + 0.8 * cardHeight,
              cardWidth - 5, 0.8 * cardHeight - 5);
          card.setPos(0, cardPosY + 0.8 * cardHeight, 0.8 * cardHeight - 5,
              cardWidth - 5);
        } else if (cards.indexOf(card) == 9) {
          card.cardRect = Rect.fromLTWH(game.screenSize.width - cardWidth,
              cardPosY + 0.8 * cardHeight, cardWidth - 5, 0.8 * cardHeight - 5);
          card.setPos(
              game.screenSize.width - cardWidth, cardPosY + 0.8 * cardHeight,
              0.8 * cardHeight - 5, cardWidth - 5);
        }
      }
  if(card.move == 1){
    adr += incre*incre*0.005;
    incre++;
    if (cards.indexOf(card) < 3) {
      card.cardRect = Rect.fromLTWH( cards.indexOf(card) * cardWidth + cardWidth, cardPosY +  adr  , cardWidth - 5, 0.8 * cardHeight - 5);
      card.setPos(cards.indexOf(card) * cardWidth + cardWidth, cardPosY + adr, 0.8 * cardHeight - 5, cardWidth - 5);
    } else if (cards.indexOf(card) < 6) {
      card.cardRect = Rect.fromLTWH((cards.indexOf(card) * cardWidth + cardWidth) - 3 * cardWidth, adr + cardPosY + 0.8 * cardHeight,  cardWidth - 5, 0.8 * cardHeight - 5);
      card.setPos((cards.indexOf(card) * cardWidth + cardWidth) - 3 * cardWidth, adr + cardPosY + 0.8 * cardHeight, 0.8 * cardHeight - 5, cardWidth - 5);
    } else if (cards.indexOf(card) == 6) {
      card.cardRect = Rect.fromLTWH(0, adr + cardPosY, cardWidth - 5, 0.8 * cardHeight - 5);
      card.setPos(0, adr + cardPosY, 0.8 * cardHeight - 5, cardWidth - 5);
    } else if (cards.indexOf(card) == 7) {
      card.cardRect = Rect.fromLTWH(game.screenSize.width - cardWidth, adr + cardPosY, cardWidth - 5, 0.8 * cardHeight - 5);
      card.setPos(game.screenSize.width - cardWidth, cardPosY + adr, 0.8 * cardHeight - 5, cardWidth - 5);
    } else if (cards.indexOf(card) == 8) {
      card.cardRect = Rect.fromLTWH(0, adr + cardPosY + 0.8 * cardHeight, cardWidth - 5, 0.8 * cardHeight - 5);
      card.setPos(0, adr + cardPosY + 0.8 * cardHeight, 0.8 * cardHeight - 5, cardWidth - 5);
    } else if (cards.indexOf(card) == 9) {
      card.cardRect = Rect.fromLTWH(game.screenSize.width - cardWidth, adr + cardPosY + 0.8 * cardHeight, cardWidth - 5, 0.8 * cardHeight - 5);
      card.setPos(game.screenSize.width - cardWidth, adr + cardPosY + 0.8 * cardHeight, 0.8 * cardHeight - 5, cardWidth - 5);
    }
    if (adr > 0){ card.move = 0; adr = -50; }
  }
      if (card.delete == true){cards.remove(card);}
      if (card.fade == true){
        print("fading");
        shrink ++;

        if (shrink == 20){
          card.fade = false;
          card.delete = true;
          shrink = 0;
        }
      }
      card.render(canvas);
    });

  }

  void playCard(GameCard card, Player player) {
    move = 0 ;


    List<GameCard> found = List<GameCard>();
    summed.clear();
    // look for matching card
    for (GameCard boardCard in cards){
      if (card.value == boardCard.value) {
        boardCard.fade = true;

        player.score += 1;
        return;
      }
    };
    // no matching card
    if (found.isEmpty) {
      List<int> sol = List<int>(cards.length);
      find(cards, 0, 0, card.value,  sol);

      if (summed.isEmpty) {
        changed = 1;

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

      cards.remove(boardCard);
    }

    if (player is OpponentPlayer == false) {
        //Flame.audio.play("sfx/win.mp3");
    }

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
    return;
  }

  void update(double t) {
    cards.forEach((card) {
      card.visible = true;
      card.update(t);
    });
  }
}
