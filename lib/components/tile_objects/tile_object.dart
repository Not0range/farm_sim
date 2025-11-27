import 'package:flame/components.dart';

import '../map_region.dart';

abstract class TileObject extends SpriteComponent with ParentIsA<MapRegion> {
  late Block _pos;

  TileObject(Block position) : super(size: Vector2.all(64)) {
    _pos = position;
  }

  @override
  void onMount() {
    super.onMount();
    position = parent.getBlockRenderPosition(_pos);
    priority = _pos.x + _pos.y;
    parent.objects[_pos.y][_pos.x] = this;
  }

  @override
  void onRemove() {
    super.onRemove();
    parent.objects[_pos.y][_pos.x] = null;
  }

  Block get pos => _pos;
  set pos(Block value) {
    _pos = value;
    position = parent.getBlockRenderPosition(value);
    priority = value.x + value.y;
  }

  void onTap();
}
