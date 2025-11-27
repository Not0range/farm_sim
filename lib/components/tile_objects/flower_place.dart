import 'dart:async';
import 'dart:math' as math;

import 'package:farm_sim/utils/constants.dart';
import 'package:farm_sim/utils/time_module.dart';
import 'package:flame/components.dart';

import '../../common/flowers.dart';
import '../../main_game.dart';
import 'tile_object.dart';

class FlowerPlace extends TileObject with HasGameReference<MainGame> {
  Flower? _type;
  SpriteGroupComponent? _sprite;
  double _remainTime = 0;

  FlowerPlace(super.position, {Flower? type, int lastHarvested = 0}) {
    _type = type;
    if (type != null) {
      _remainTime =
          type.growTime -
          (TimeModule.currentTime - lastHarvested).clamp(0, type.growTime);
    }
  }

  Flower? get type => _type;
  set type(Flower? value) {
    _type = value;
    if (_sprite != null) {
      remove(_sprite!);
      _sprite = null;
    }
    _updateType();
  }

  void _updateType() async {
    if (_type != null) {
      var img = await game.images.load('vegetables.png');
      final current = _remainTime == 0
          ? 2
          : _remainTime < _type!.growTime / 2
          ? 1
          : 0;
      _sprite = SpriteGroupComponent(
        sprites: {
          0: Sprite(
            img,
            srcPosition: _type!.positions[0],
            srcSize: Constants.srcSize,
          ),
          1: Sprite(
            img,
            srcPosition: _type!.positions[1],
            srcSize: Constants.srcSize,
          ),
          2: Sprite(
            img,
            srcPosition: _type!.positions[2],
            srcSize: Constants.srcSize,
          ),
        },
        current: current,
        size: Constants.destSize,
      );
      add(_sprite!);
    }
  }

  @override
  void update(double dt) {
    _remainTime = math.max(0, _remainTime - dt);
    final current = _remainTime == 0
        ? 2
        : _remainTime < _type!.growTime / 2
        ? 1
        : 0;
    _sprite?.current = current;
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    var img = await game.images.load('vegetables.png');
    sprite = Sprite(img, srcPosition: Vector2(32, 0), srcSize: Vector2.all(32));
    if (_type != null) {
      final current = _remainTime == 0
          ? 2
          : _remainTime < _type!.growTime / 2
          ? 1
          : 0;
      _sprite = SpriteGroupComponent(
        sprites: {
          0: Sprite(
            img,
            srcPosition: _type!.positions[0],
            srcSize: Constants.srcSize,
          ),
          1: Sprite(
            img,
            srcPosition: _type!.positions[1],
            srcSize: Constants.srcSize,
          ),
          2: Sprite(
            img,
            srcPosition: _type!.positions[2],
            srcSize: Constants.srcSize,
          ),
        },
        current: current,
        size: Constants.destSize,
      );
      add(_sprite!);
    }
  }

  @override
  void onTap() {
    if (_remainTime <= 0) {
      print('Harvest');
    } else {
      print('Show info');
    }
  }
}
