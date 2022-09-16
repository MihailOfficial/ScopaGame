import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CoreGame.dart';

void main() {
  CoreGame game = new CoreGame();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(game.widget);

  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);

  Flame.images.loadAll(<String>[
    "tempo/",
  ]);

  Flame.audio.disableLog();
  Flame.audio.loadAll(<String>[
    'sfx/dealcard.mp3',
    'sfx/win.mp3',
    'sfx/dealmultiplescards.mp3'
  ]);
}