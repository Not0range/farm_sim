abstract class TimeModule {
  static int diff = 0;
  static int get currentTime =>
      DateTime.now().millisecondsSinceEpoch ~/ 1000 + diff;
}
