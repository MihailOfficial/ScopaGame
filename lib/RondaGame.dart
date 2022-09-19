import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:Scopa/view.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/GameCard.dart';
import 'components/Deck.dart';
import 'components/OpponentPlayer.dart';
import 'components/Player.dart';
import 'components/Board.dart';
import 'components/ScoreDisplay.dart';


class RondaGame {
  final coreGame;

  Deck deck;
  Player player;
  OpponentPlayer opponent;
  Board board;
  ScoreDisplay playerScoreDisplay;
  ScoreDisplay opponentScoreDisplay;
  int turn = 0;
  Stopwatch turnTime;
  RondaGame(this.coreGame) {
    initCards();
  }

  GameCard dealCard(int type) {

    GameCard card = deck.deck.last;

    if (type == 1){
    deck.deck.last.present = true;
    }
    if (type == 2){
      deck.deck.last.present2 = true;
    }
    if (type == 3){
      deck.deck.last.grow = true;
    }
    deck.deck.removeLast();
    return card;
  }

  void initCards() {
    deck = new Deck(coreGame);
    board = Board(coreGame);
    playerScoreDisplay = ScoreDisplay(coreGame);
    opponentScoreDisplay = ScoreDisplay(coreGame);
    //Flame.audio.play("sfx/dealmultiplescards.mp3");
    board.cards.add(dealCard(3));
    board.cards.add(dealCard(3));
    board.cards.add(dealCard(3));
    board.cards.add(dealCard(3));


    board.cards.add(dealCard(3));
    board.cards.add(dealCard(3));
    board.cards.add(dealCard(3));
    board.cards.add(dealCard(3));


    board.cards.add(dealCard(3));
    board.cards.add(dealCard(3));
    board.cards.add(dealCard(3));
    board.cards.add(dealCard(3));

    board.cards.add(dealCard(3));
    board.cards.add(dealCard(3));
    board.cards.add(dealCard(3));
    board.cards.add(dealCard(3));

    if (player == null) {
      player = new Player(coreGame);
      player.takeCard(dealCard(1));
      player.takeCard(dealCard(1));
      player.takeCard(dealCard(1));
    }
    if (opponent == null) {
      opponent = new OpponentPlayer(coreGame);
      opponent.takeCard(dealCard(2));
      opponent.takeCard(dealCard(2));
      opponent.takeCard(dealCard(2));
    }
    board.changed = 1;
  }

  void render(Canvas canvas) {
    board.render(canvas);
    player.render(canvas);
    opponent.render(canvas);
    playerScoreDisplay.render(canvas);
    opponentScoreDisplay.render(canvas);

  }

  void update(double t) {

    if (board.revertColor){

      print("need revert");
      if (coreGame.bValue > 2){coreGame.bValue -= 3;}
      else {board.revertColor = false;}
    }
    if (board.revertColorR){
      print("need revert");
      if (coreGame.rValue > 2){coreGame.rValue -= 3;}
      else {board.revertColorR = false;}
    }
    //print("moving: " + coreGame.movingCard.toString());
    opponent.update(t);
    board.update(t);
    playerScoreDisplay.update(t, player);
    opponentScoreDisplay.update(t, opponent);
    if (deck.deck.isNotEmpty && player.cards.isEmpty && opponent.cards.isEmpty) {
      //Flame.audio.play("sfx/dealmultiplescards.mp3");
      player.takeCard(dealCard(1));
      player.takeCard(dealCard(1));
      player.takeCard(dealCard(1));
      opponent.takeCard(dealCard(2));
      opponent.takeCard(dealCard(2));
      opponent.takeCard(dealCard(2));
      board.changed = 1;
    }
    if (deck.deck.isEmpty && player.cards.isEmpty && opponent.cards.isEmpty) {
      if (player.score > opponent.score) {
        coreGame.victory = true;
      }
      else {
        coreGame.victory = false;
      }
      coreGame.activeView = View.result;
    }
    const twentyMillis = Duration(milliseconds:3500);
    Timer(twentyMillis, () => opponentTurn());



  }

  void onTapDown(TapDownDetails d) {
    if (turn == 0) {
      if (!coreGame.movingCard){
        playerTurn(d, player);
      }

    }
  }

  void opponentTurn() {
    int result = 0;
    if (turn == 1 && !coreGame.movingCard) {

      Random rnd = new Random();
      int r = 0 + rnd.nextInt(opponent.cards.length - 0);
      result = board.playCard(opponent.cards[r], opponent);
      if (result != 1){
        opponent.cards[r].reveal = true;
      }
      const twentyMillis = Duration(milliseconds:2000);
      Timer(twentyMillis, () => opponent.cards.removeAt(r));
      //opponent.cards[r].fade = true;
      endTurn();
    }

  }

  void playerTurn(TapDownDetails d, Player player) {
    int playedCard = -1;
    int result;
    for (int i = 0; i< player.cards.length; i++){
      if (player.cards[i].cardRect.contains(d.globalPosition)) {
        HapticFeedback.selectionClick();
        //card.move = 1;
        result = board.playCard(player.cards[i], player);
        coreGame.movingCard = true;

        if (result != 1) {
           player.cards[i].fadeDown = true;
           print("///// Revealing ////");
        }
        const twentyMillis = Duration(milliseconds:1000);
        Timer(twentyMillis, () => player.cards.removeAt(i));


        //Flame.audio.play("sfx/dealcard.mp3");
        endTurn();
      }
    }
  }

  void endTurn() {
    if (turn == 0) {
      turn = 1;
    }
    else {
      turn = 0;
    }
  }
}