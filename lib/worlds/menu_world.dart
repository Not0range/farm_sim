import 'dart:async';

import 'package:flame/components.dart';

import '../main_game.dart';

class MenuWorld extends World with HasGameReference<MainGame> {
  @override
  FutureOr<void> onLoad() async {
    //TODO loading assets & change progress
    //TODO transit to menu
  }
}
