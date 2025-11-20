import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';

import '../app_state.dart';
import '../components/map_region.dart';
import '../main_game.dart';
import '../utils/matrix_utils.dart';

class FarmWorld extends World with HasGameReference<MainGame> {
  final _regions = <IsometricTileMapComponent>[];
  double? _startZoom;

  @override
  FutureOr<void> onLoad() async {
    final mapJson = jsonDecode(await rootBundle.loadString('assets/map.json'));

    final w = mapJson['size']['width'];
    final h = mapJson['size']['height'];
    final regions = mapJson['regions'] as List<dynamic>;

    final sprites = SpriteSheet(
      image: await game.images.load('tiles.png'),
      srcSize: Vector2.all(32),
    );
    for (var r in regions) {
      final matrix = MatrixUtils.create2DMatrix(h, w, initialValue: r['tile']);
      //TODO define overrides

      _regions.add(MapRegion(sprites, matrix, r['x'], r['y']));
    }
    addAll(_regions);
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
    if (d > 0) {
      viewfinder.zoom = math.max(0.5, viewfinder.zoom - 0.1);
    } else if (d < 0) {
      viewfinder.zoom = math.min(2, viewfinder.zoom + 0.1);
    }
  }

  void onScaleStart(ScaleStartInfo info) {
    _startZoom = game.camera.viewfinder.zoom;
  }

  void onScaleUpdate(ScaleUpdateInfo info) {
    final camera = game.camera;
    if (!info.scale.global.isIdentity()) {
      if (_startZoom == null) return;
      camera.viewfinder.zoom = (_startZoom! * info.scale.global.y).clamp(
        0.5,
        2,
      );
    } else {
      camera.moveBy(-info.delta.global / camera.viewfinder.zoom);
    }
  }

  void onScaleEnd(ScaleEndInfo info) {
    _startZoom = null;
  }
}
