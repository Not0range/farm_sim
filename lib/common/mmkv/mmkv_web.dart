import 'package:web/web.dart';

class MMKV {
  static Future<String> initialize() {
    return Future.value('');
  }

  static defaultMMKV({String? cryptKey}) {
    return MMKV();
  }

  bool encodeBool(String key, bool value, [int? expireDurationInSecond]) {
    return true;
  }

  bool decodeBool(String key, {bool defaultValue = false}) {
    return true;
  }

  bool encodeInt32(String key, int value, [int? expireDurationInSecond]) {
    return true;
  }

  int decodeInt32(String key, {int defaultValue = 0}) {
    return 0;
  }

  bool encodeInt(String key, int value, [int? expireDurationInSecond]) {
    return true;
  }

  int decodeInt(String key, {int defaultValue = 0}) {
    return 0;
  }

  bool encodeDouble(String key, double value, [int? expireDurationInSecond]) {
    return true;
  }

  double decodeDouble(String key, {double defaultValue = 0}) {
    return 0.0;
  }

  bool encodeString(String key, String? value, [int? expireDurationInSecond]) {
    return true;
  }

  String? decodeString(String key) {
    return '';
  }

  List<String> get allKeys => List.generate(
    window.localStorage.length,
    (i) => window.localStorage.key(i),
  ).cast<String>();

  bool containsKey(String key) {
    return window.localStorage.getItem(key) != null;
  }

  int get count => window.localStorage.length;

  void removeValue(String key) {
    window.localStorage.removeItem(key);
  }

  void removeValues(List<String> keys) {
    for (var key in keys) {
      window.localStorage.removeItem(key);
    }
  }

  void clearAll({bool keepSpace = false}) {
    window.localStorage.clear();
  }
}
