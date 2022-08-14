import 'package:Scopa/components/GameCard.dart';
import 'package:flame/game.dart';

class Deck {
  List<GameCard> deck;
  final game;

  Deck(this.game) {
    deck = List<GameCard>();

    deck.add(new GameCard(game, 1, "heart", 0));
    deck.add(new GameCard(game, 2, "heart", 0));
    deck.add(new GameCard(game, 3, "heart", 0));
    deck.add(new GameCard(game, 4, "heart", 0));
    deck.add(new GameCard(game, 5, "heart", 0));
    deck.add(new GameCard(game, 6, "heart", 0));
    deck.add(new GameCard(game, 7, "heart", 0));
    deck.add(new GameCard(game, 8, "heart", 0));
    deck.add(new GameCard(game, 9, "heart", 0));
    deck.add(new GameCard(game, 10, "heart", 0));


    deck.add(new GameCard(game, 1, "spade", 0));
    deck.add(new GameCard(game, 2, "spade", 0));
    deck.add(new GameCard(game, 3, "spade", 0));
    deck.add(new GameCard(game, 4, "spade", 0));
    deck.add(new GameCard(game, 5, "spade", 0));
    deck.add(new GameCard(game, 6, "spade", 0));
    deck.add(new GameCard(game, 7, "spade", 0));
    deck.add(new GameCard(game, 8, "spade", 0));
    deck.add(new GameCard(game, 9, "spade", 0));
    deck.add(new GameCard(game, 10, "spade", 0));

    deck.add(new GameCard(game, 1, "clover", 0));
    deck.add(new GameCard(game, 2, "clover", 0));
    deck.add(new GameCard(game, 3, "clover", 0));
    deck.add(new GameCard(game, 4, "clover", 0));
    deck.add(new GameCard(game, 5, "clover", 0));
    deck.add(new GameCard(game, 6, "clover", 0));
    deck.add(new GameCard(game, 7, "clover", 0));
    deck.add(new GameCard(game, 8, "clover", 0));
    deck.add(new GameCard(game, 9, "clover", 0));
    deck.add(new GameCard(game, 10, "clover", 0));

    deck.add(new GameCard(game, 1, "diamond", 0));
    deck.add(new GameCard(game, 2, "diamond", 0));
    deck.add(new GameCard(game, 3, "diamond", 0));
    deck.add(new GameCard(game, 4, "diamond", 0));
    deck.add(new GameCard(game, 5, "diamond", 0));
    deck.add(new GameCard(game, 6, "diamond", 0));
    deck.add(new GameCard(game, 7, "diamond", 0));
    deck.add(new GameCard(game, 8, "diamond", 0));
    deck.add(new GameCard(game, 9, "diamond", 0));
    deck.add(new GameCard(game, 10, "diamond", 0));

    deck.shuffle();
  }
}