import 'package:Scopa/components/GameCard.dart';
import 'package:flame/game.dart';

class Deck {
  List<GameCard> deck;
  final game;

  Deck(this.game) {
    deck = List<GameCard>();

    deck.add(new GameCard(game, 1, "hearts", 0));
    deck.add(new GameCard(game, 2, "hearts", 0));
    deck.add(new GameCard(game, 3, "hearts", 0));
    deck.add(new GameCard(game, 4, "hearts", 0));
    deck.add(new GameCard(game, 5, "hearts", 0));
    deck.add(new GameCard(game, 6, "hearts", 0));
    deck.add(new GameCard(game, 7, "hearts", 0));
    deck.add(new GameCard(game, 8, "hearts", 0));
    deck.add(new GameCard(game, 9, "hearts", 0));
    deck.add(new GameCard(game, 10, "hearts", 0));

    deck.add(new GameCard(game, 1, "clubs", 0));
    deck.add(new GameCard(game, 2, "clubs", 0));
    deck.add(new GameCard(game, 3, "clubs", 0));
    deck.add(new GameCard(game, 4, "clubs", 0));
    deck.add(new GameCard(game, 5, "clubs", 0));
    deck.add(new GameCard(game, 6, "clubs", 0));
    deck.add(new GameCard(game, 7, "clubs", 0));
    deck.add(new GameCard(game, 8, "clubs", 0));
    deck.add(new GameCard(game, 9, "clubs", 0));
    deck.add(new GameCard(game, 10, "clubs", 0));


    deck.add(new GameCard(game, 1, "spades", 0));
    deck.add(new GameCard(game, 2, "spades", 0));
    deck.add(new GameCard(game, 3, "spades", 0));
    deck.add(new GameCard(game, 4, "spades", 0));
    deck.add(new GameCard(game, 5, "spades", 0));
    deck.add(new GameCard(game, 6, "spades", 0));
    deck.add(new GameCard(game, 7, "spades", 0));
    deck.add(new GameCard(game, 8, "spades", 0));
    deck.add(new GameCard(game, 9, "spades", 0));
    deck.add(new GameCard(game, 10, "spades", 0));


    deck.add(new GameCard(game, 1, "diamonds", 0));
    deck.add(new GameCard(game, 2, "diamonds", 0));
    deck.add(new GameCard(game, 3, "diamonds", 0));
    deck.add(new GameCard(game, 4, "diamonds", 0));
    deck.add(new GameCard(game, 5, "diamonds", 0));
    deck.add(new GameCard(game, 6, "diamonds", 0));
    deck.add(new GameCard(game, 7, "diamonds", 0));
    deck.add(new GameCard(game, 8, "diamonds", 0));
    deck.add(new GameCard(game, 9, "diamonds", 0));
    deck.add(new GameCard(game, 10, "diamonds", 0));

    deck.shuffle();
  }
}