import '../utils/matrix_utils.dart';

abstract final class FarmMap {
  static final size = _MapSize(20, 20);
  static final regions = [
    _MapRegion(1, 1, 0, 0, overrides: [_RegionOverride(2, 2, 3)]),
    _MapRegion(0, 0, 100, 0),
    _MapRegion(1, 0, 100, 0),
    _MapRegion(2, 0, 100, 0),
    _MapRegion(0, 1, 100, 0),
    _MapRegion(2, 1, 100, 0),
    _MapRegion(0, 2, 100, 0),
    _MapRegion(1, 2, 100, 0),
    _MapRegion(2, 2, 100, 0),
  ];
}

class _MapSize {
  final int width;
  final int height;

  _MapSize(this.width, this.height);
}

class _MapRegion {
  final int x;
  final int y;
  final int price;
  final int tile;
  final List<_RegionOverride>? overrides;

  _MapRegion(this.x, this.y, this.price, this.tile, {this.overrides});

  List<List<int>> getMatrix(int width, int height) {
    final matrix = MatrixUtils.create2DMatrix(
      height,
      width,
      initialValue: tile,
    );
    if (overrides != null) {
      for (var o in overrides!) {
        if (o.y < 0 || o.y >= matrix.length) continue;
        if (o.x < 0 || o.x >= matrix[o.y].length) continue;
        matrix[o.y][o.x] = o.tile;
      }
    }
    return matrix;
  }
}

class _RegionOverride {
  final int x;
  final int y;
  final int tile;

  _RegionOverride(this.x, this.y, this.tile);
}
