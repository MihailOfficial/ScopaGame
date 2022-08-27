import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:Scopa/view.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

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
    opponentTurn();
  }

  void onTapDown(TapDownDetails d) {
    if (turn == 0) {
      playerTurn(d, player);
    }
  }

  void opponentTurn() {

    if (turn == 1 && !coreGame.movingCard) {

      Random rnd = new Random();
      int r = 0 + rnd.nextInt(opponent.cards.length - 0);
      board.playCard(opponent.cards[r], opponent);
      opponent.cards[r].reveal = true;
      const twentyMillis = Duration(milliseconds:1000);
      Timer(twentyMillis, () => opponent.cards.removeAt(r));

      endTurn();
    }

  }

  void playerTurn(TapDownDetails d, Player player) {
    int playedCard = -1;
    player.cards.forEach((GameCard card) {
      if (card.cardRect.contains(d.globalPosition)) {
        //card.move = 1;
        board.playCard(card, player);
        coreGame.movingCard = true;
        playedCard = player.cards.indexOf(card);
        //Flame.audio.play("sfx/dealcard.mp3");
        endTurn();

      }
    });
    if (playedCard != -1) {
      player.cards.removeAt(playedCard);
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