class MMKV {
  final _mmkv = <String, dynamic>{};

  static Future<String> initialize() {
    return Future.value('');
  }

  static defaultMMKV({String? cryptKey}) {
    return MMKV();
  }

  bool encodeBool(String key, bool value, [int? expireDurationInSecond]) {
    _mmkv[key] = value;
    return true;
  }

  bool decodeBool(String key, {bool defaultValue = false}) {
    final value = _mmkv[key];
    return value is bool ? value : defaultValue;
  }

  bool encodeInt32(String key, int value, [int? expireDurationInSecond]) {
    _mmkv[key] = value;
    return true;
  }

  int decodeInt32(String key, {int defaultValue = 0}) {
    final value = _mmkv[key];
    return value is int ? value : defaultValue;
  }

  bool encodeInt(String key, int value, [int? expireDurationInSecond]) {
    _mmkv[key] = value;
    return true;
  }

  int decodeInt(String key, {int defaultValue = 0}) {
    final value = _mmkv[key];
    return value is int ? value : defaultValue;
  }

  bool encodeDouble(String key, double value, [int? expireDurationInSecond]) {
    _mmkv[key] = value;
    return true;
  }

  double decodeDouble(String key, {double defaultValue = 0}) {
    final value = _mmkv[key];
    return value is double ? value : defaultValue;
  }

  bool encodeString(String key, String? value, [int? expireDurationInSecond]) {
    _mmkv[key] = value;
    return true;
  }

  String? decodeString(String key) {
    final value = _mmkv[key];
    return value is String ? value : null;
  }

  List<String> get allKeys => _mmkv.keys.toList(growable: false);

  bool containsKey(String key) => _mmkv.containsKey(key);

  int get count => _mmkv.length;

  void removeValue(String key) {
    _mmkv.remove(key);
  }

  void removeValues(List<String> keys) {
    for (var key in keys) {
      _mmkv.remove(key);
    }
  }

  void clearAll({bool keepSpace = false}) {
    _mmkv.clear();
  }
}
