import 'dart:async';

import 'package:flame/components.dart';
// import 'package:flame/parallax.dart';

import '../app_state.dart';
import '../main_game.dart';

class MenuWorld extends World with HasGameReference<MainGame> {
  MenuWorld({bool initial = true});

  @override
  FutureOr<void> onLoad() async {
    // final parallax = await game.loadParallaxComponent([
    //   ParallaxImageData('menu/'),
    //   ParallaxImageData('menu/'),
    //   ParallaxImageData('menu/'),
    // ]);
    // game.camera.backdrop = parallax;
    //TODO loading assets & change progress if needed
  }

  @override
  void onMount() {
    //TODO transit: to menu
    //TODO after animation end
    game.clearOverlays();
    game.overlays.add('MainMenu');
    game.state.gameState = GameState.mainMenu;
  }
}
