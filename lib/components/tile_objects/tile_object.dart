import 'package:flame/components.dart';

import '../map_region.dart';

abstract class TileObject extends SpriteComponent with ParentIsA<MapRegion> {
  UnionType unionType;
  late Block _pos;

  TileObject(super.image, Block position, this.unionType) : super.fromImage() {
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

enum UnionType {
  nothing,
  n,
  e,
  s,
  w,
  ns,
  we,
  ne,
  se,
  nw,
  sw,
  wne,
  nes,
  wse,
  nws,
  full,
}
