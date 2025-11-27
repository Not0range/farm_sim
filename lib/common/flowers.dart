import 'package:farm_sim/utils/constants.dart';
import 'package:flame/game.dart';

abstract class Flowers {
  static final a = Flower([
    Vector2(0, 1)..multiply(Constants.srcSize),
    Vector2(1, 1)..multiply(Constants.srcSize),
    Vector2(2, 1)..multiply(Constants.srcSize),
  ], 60);
}

class Flower {
  final List<Vector2> positions;
  final double growTime;

  Flower(this.positions, this.growTime);
}
