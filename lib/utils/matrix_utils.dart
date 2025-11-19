class MatrixUtils {
  static List<List<int>> create2DMatrix(
    int rows,
    int columns, {
    int initialValue = -1,
  }) {
    return List.generate(
      rows,
      (_) => List.generate(columns, (_) => initialValue),
    );
  }
}
