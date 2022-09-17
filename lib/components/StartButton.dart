import 'dart:ui';
import 'package:Scopa/CoreGame.dart';
import 'package:Scopa/view.dart';
import 'package:flame/sprite.dart';

class StartButton {
  final CoreGame game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    rect = Rect.fromLTWH(
      game.screenSize.width/2 - game.tileSize* 1.5,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 3,
      game.tileSize * 3,
    );
    sprite = Sprite('UI/play.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void onTapDown() {
    game.wideX = 0;
    game.activeView = View.playing;
  }
}