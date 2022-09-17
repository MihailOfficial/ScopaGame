import 'package:Scopa/components/GameCard.dart';
import 'package:flame/game.dart';

class Deck {
  List<GameCard> deck;
  final game;

  Deck(this.game) {
    deck = List<GameCard>();

    deck.add(new GameCard(game, 1, "H", 0));
    deck.add(new GameCard(game, 2, "H", 0));
    deck.add(new GameCard(game, 3, "H", 0));
    deck.add(new GameCard(game, 4, "H", 0));
    deck.add(new GameCard(game, 5, "H", 0));
    deck.add(new GameCard(game, 6, "H", 0));
    deck.add(new GameCard(game, 7, "H", 0));
    deck.add(new GameCard(game, 8, "H", 0));
    deck.add(new GameCard(game, 9, "H", 0));
    deck.add(new GameCard(game, 10, "H", 0));

    deck.add(new GameCard(game, 1, "C", 0));
    deck.add(new GameCard(game, 2, "C", 0));
    deck.add(new GameCard(game, 3, "C", 0));
    deck.add(new GameCard(game, 4, "C", 0));
    deck.add(new GameCard(game, 5, "C", 0));
    deck.add(new GameCard(game, 6, "C", 0));
    deck.add(new GameCard(game, 7, "C", 0));
    deck.add(new GameCard(game, 8, "C", 0));
    deck.add(new GameCard(game, 9, "C", 0));
    deck.add(new GameCard(game, 10, "C", 0));


    deck.add(new GameCard(game, 1, "S", 0));
    deck.add(new GameCard(game, 2, "S", 0));
    deck.add(new GameCard(game, 3, "S", 0));
    deck.add(new GameCard(game, 4, "S", 0));
    deck.add(new GameCard(game, 5, "S", 0));
    deck.add(new GameCard(game, 6, "S", 0));
    deck.add(new GameCard(game, 7, "S", 0));
    deck.add(new GameCard(game, 8, "S", 0));
    deck.add(new GameCard(game, 9, "S", 0));
    deck.add(new GameCard(game, 10, "S", 0));


    deck.add(new GameCard(game, 1, "D", 0));
    deck.add(new GameCard(game, 2, "D", 0));
    deck.add(new GameCard(game, 3, "D", 0));
    deck.add(new GameCard(game, 4, "D", 0));
    deck.add(new GameCard(game, 5, "D", 0));
    deck.add(new GameCard(game, 6, "D", 0));
    deck.add(new GameCard(game, 7, "D", 0));
    deck.add(new GameCard(game, 8, "D", 0));
    deck.add(new GameCard(game, 9, "D", 0));
    deck.add(new GameCard(game, 10, "D", 0));

    deck.shuffle();
  }
}