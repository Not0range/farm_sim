import 'dart:async';

import 'package:flame/components.dart';
// import 'package:flame/parallax.dart';

import '../main_game.dart';

class MenuWorld extends World with HasGameReference<MainGame> {
  MenuWorld({bool initial = true});

  @override
  FutureOr<void> onLoad() async {
    //TODO transit: animation start state

    game.camera.viewfinder.position = Vector2.zero();
    // final parallax = await game.loadParallaxComponent([
    //   ParallaxImageData('menu/'),
    //   ParallaxImageData('menu/'),
    //   ParallaxImageData('menu/'),
    // ]);
    // game.camera.backdrop = parallax;
    //TODO loading assets & change progress if needed

    //TODO transit: to menu
    //TODO after animation end
    game.overlays.add('MainMenu');
  }
}
