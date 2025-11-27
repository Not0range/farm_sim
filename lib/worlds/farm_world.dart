import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';

import '../app_state.dart';
import '../common/flowers.dart';
import '../common/map.dart';
import '../components/map_region.dart';
import '../components/tile_objects/flower_place.dart';
import '../main_game.dart';
import '../utils/time_module.dart';

class FarmWorld extends World with HasGameReference<MainGame> {
  final _regions = <MapRegion>[];
  double? _startZoom;

  @override
  FutureOr<void> onLoad() async {
    final w = FarmMap.size.width;
    final h = FarmMap.size.height;

    final sprites = SpriteSheet(
      image: await game.images.load('tiles.png'),
      srcSize: Vector2.all(32),
    );
    for (var i = 0; i < FarmMap.regions.length; i++) {
      final r = FarmMap.regions[i];
      final region = MapRegion(sprites, r.getMatrix(w, h), r.x, r.y);
      _regions.add(region);
    }
    await addAll(_regions);

    await _regions[0].addAll([
      FlowerPlace(
        Block(0, 0),
        type: Flowers.a,
        lastHarvested: TimeModule.currentTime - 1,
      ),
      FlowerPlace(
        Block(2, 0),
        type: Flowers.a,
        lastHarvested: TimeModule.currentTime - 25,
      ),
      FlowerPlace(
        Block(4, 0),
        type: Flowers.a,
        lastHarvested: TimeModule.currentTime - 60,
      ),
    ]);
    //TODO load saved game
  }

  @override
  void onMount() {
    AppState.of(game.buildContext!, listen: false).gameState = GameState.farm;
    game.overlays.add('GameOverlay');
    game.camera.moveTo(_regions.first.center);
  }

  void onScroll(PointerScrollInfo info) {
    final d = info.scrollDelta.global.y;
    final viewfinder = game.camera.viewfinder;
    viewfinder.zoom = (viewfinder.zoom - 0.1 * d.sign).clamp(0.5, 2);
  }

  void onScaleStart(ScaleStartInfo info) {
    _startZoom = game.camera.viewfinder.zoom;
  }

  void onScaleUpdate(ScaleUpdateInfo info) {
    final camera = game.camera;
    if (!info.scale.global.isIdentity()) {
      if (_startZoom == null) return;
      final result = _startZoom! * info.scale.global.y;
      camera.viewfinder.zoom = (result).clamp(0.5, 2);
    } else {
      camera.moveBy(-info.delta.global / camera.viewfinder.zoom);
    }
  }

  void onScaleEnd(ScaleEndInfo info) {
    _startZoom = null;
  }
}
