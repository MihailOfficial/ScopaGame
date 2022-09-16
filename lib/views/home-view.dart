import 'dart:ui';
import 'package:Scopa/CoreGame.dart';
import 'package:flame/sprite.dart';

class HomeView {
  final CoreGame game;
  Rect titleRect;
  Rect backRect;
  Sprite titleSprite;
  Sprite backSprite;

  HomeView(this.game) {
    titleRect = Rect.fromLTWH(
      game.screenSize.width/2 - game.tileSize*2,
      (game.screenSize.height / 2) - (game.tileSize * 6),
      game.tileSize * 4,
      game.tileSize * 4,
    );
    backRect = Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
    backSprite = Sprite('UI/italy.jpg');
    titleSprite = Sprite('UI/title.png');
  }

  void render(Canvas c) {
    backSprite.renderRect(c, backRect);
    titleSprite.renderRect(c, titleRect);

  }

  void update(double t) {}
}