import 'dart:ui';
import 'package:Scopa/CoreGame.dart';
import 'package:flame/sprite.dart';

class HomeView {
  final CoreGame game;
  Rect titleRect;
  Sprite titleSprite;

  HomeView(this.game) {
    titleRect = Rect.fromLTWH(
      game.screenSize.width/2 - game.tileSize*2,
      (game.screenSize.height / 2) - (game.tileSize * 6),
      game.tileSize * 4,
      game.tileSize * 4,
    );
    titleSprite = Sprite('UI/title.png');
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void update(double t) {}
}