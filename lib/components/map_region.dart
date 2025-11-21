import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class MapRegion extends IsometricTileMapComponent with TapCallbacks {
  int xPos;
  int yPos;
  bool visible = true;

  MapRegion(super.tileset, super.matrix, this.xPos, this.yPos)
    : super(destTileSize: Vector2.all(64), tileHeight: 16) {
    position = getBlockRenderPositionInts(
      matrix[0].length * xPos,
      matrix.length * yPos,
    );
    priority = xPos + yPos;
  }

  @override
  void render(Canvas canvas) {
    if (visible) super.render(canvas);
  }
}
