import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'worlds/menu_world.dart';

class MainGame extends FlameGame
    with ScrollDetector, ScaleDetector, MouseMovementDetector {
  MainGame() : super(world: MenuWorld());
}
