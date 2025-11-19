import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'app_state.dart';
import 'main.dart';
import 'worlds/farm_world.dart';
import 'worlds/menu_world.dart';

class MainGame extends FlameGame
    with ScrollDetector, ScaleDetector, MouseMovementDetector {
  late MenuWorld _menuWorld;
  FarmWorld? _farmWorld;

  MainGame() : super(world: MenuWorld());

  @override
  FutureOr<void> onLoad() async {
    _menuWorld = world as MenuWorld;
    overlays.add('Loading', priority: 999);
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
    AppState.of(buildContext!, listen: false).gameState = GameState.loading;
    Future.delayed(Duration(seconds: 1), () {
      camera.moveTo(Vector2.zero());
      clearOverlays();
      _farmWorld ??= FarmWorld();
      world = _farmWorld!;
    });
  }

  void returnToMainMenu() {
    AppState.of(buildContext!, listen: false).gameState = GameState.loading;
    Future.delayed(Duration(seconds: 1), () {
      camera.moveTo(Vector2.zero());
      clearOverlays();
      world = _menuWorld;
    });
  }
}
