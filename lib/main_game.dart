import 'dart:async';

import 'package:farm_sim/utils/time_module.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'app_state.dart';
import 'main.dart';
import 'worlds/farm_world.dart';
import 'worlds/menu_world.dart';

class MainGame extends FlameGame
    with ScrollDetector, ScaleDetector, MouseMovementDetector {
  late MenuWorld _menuWorld;
  FarmWorld? _farmWorld;

  late final AppState state;

  MainGame() : super(world: MenuWorld());

  @override
  FutureOr<void> onLoad() async {
    pauseWhenBackgrounded = false;
    _menuWorld = world as MenuWorld;
    overlays.add('Loading', priority: 999);

    try {
      final format = DateFormat("EEE, dd MMM yyyy HH:mm:ss z", 'en_US');
      final res = await http.head(Uri.https('google.com'));
      final date = format.parse(res.headers['Date']!);
      TimeModule.diff = date.difference(DateTime.now()).inSeconds;
    } on Exception {
      if (kDebugMode) print('Skip date getting');
    }
  }

  @override
  void onAttach() {
    state = AppState.of(buildContext, listen: false);
  }

  @override
  Color backgroundColor() {
    return Colors.blue;
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    info.handled = false;
  }

  @override
  void onScroll(PointerScrollInfo info) {
    if (world == _farmWorld) _farmWorld?.onScroll(info);
  }

  @override
  void onScaleStart(ScaleStartInfo info) {
    if (world == _farmWorld) _farmWorld?.onScaleStart(info);
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    if (world == _farmWorld) _farmWorld?.onScaleUpdate(info);
  }

  @override
  void onScaleEnd(ScaleEndInfo info) {
    if (world == _farmWorld) _farmWorld?.onScaleEnd(info);
  }

  void clearOverlays() {
    overlays.removeAll(
      gameOverlays.keys.where((e) => !persistOverlays.contains(e)),
    );
  }

  void start() {
    state.gameState = GameState.loading;
    Future.delayed(Duration(seconds: 1), () {
      camera.moveTo(Vector2.zero());
      clearOverlays();
      _farmWorld ??= FarmWorld();
      world = _farmWorld!;
    });
  }

  void returnToMainMenu() {
    state.gameState = GameState.loading;
    Future.delayed(Duration(seconds: 1), () {
      camera.moveTo(Vector2.zero());
      camera.viewfinder.zoom = 1;
      clearOverlays();
      world = _menuWorld;
    });
  }
}
