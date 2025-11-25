import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'tile_objects/tile_object.dart';

class MapRegion extends IsometricTileMapComponent with TapCallbacks {
  int xPos;
  int yPos;
  bool visible = true;
  late final List<List<TileObject?>> objects;

  MapRegion(super.tileset, super.matrix, this.xPos, this.yPos)
    : super(destTileSize: Vector2.all(64), tileHeight: 16) {
    position = getBlockRenderPositionInts(
      matrix[0].length * xPos,
      matrix.length * yPos,
    );
    priority = xPos + yPos;
    objects = List.generate(
      matrix.length,
      (_) => List.generate(matrix[0].length, (_) => null),
    );
  }

  @override
  void render(Canvas canvas) {
    if (visible) super.render(canvas);
  }

  @override
  void onTapUp(TapUpEvent event) {
    final block = getBlock(event.localPosition + position);
    if (!containsBlock(block) || blockValue(block) == -1) {
      return;
    }
    objects[block.y][block.x]?.onTap();
  }
}
