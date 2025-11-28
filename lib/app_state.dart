import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'common/flowers.dart';

class AppState extends ChangeNotifier {
  GameState _gameState = GameState.loading;
  final _streamController = StreamController<GameEvent>.broadcast();

  var _currentExp = 0.0;

  var _level = 0;
  var _minExp = 0.0;
  var _maxExp = _startLevelExp;

  late final resources = Resources(onResourceChanged);

  TileInfo? _info;

  GameState get gameState => _gameState;
  set gameState(GameState value) {
    _gameState = value;
    notifyListeners();
  }

  Stream<GameEvent> get gameStream => _streamController.stream;

  double get currentExp => _currentExp;
  set currentExp(double value) {
    _currentExp = value;

    if (_currentExp >= _maxExp) {
      _minExp = _maxExp;
      _maxExp = _maxExp * _levelMultiplicator;
      _level++;
      _streamController.add(GameEvent('levelUp', params: {'level': _level}));
    }
    notifyListeners();
  }

  int get level => _level;
  double get minExp => _minExp;
  double get maxExp => _maxExp;

  void initExp(double exp) {
    _currentExp = exp;
    while (_currentExp >= _maxExp) {
      _minExp = _maxExp;
      _maxExp = _maxExp * _levelMultiplicator;
      _level++;
    }
    notifyListeners();
  }

  void onResourceChanged(String type, double value) {
    _streamController.add(
      GameEvent('${type}Changed', params: {'value': value}),
    );
    notifyListeners();
  }

  TileInfo? get info => _info;
  set info(TileInfo? value) {
    if (_info == value) return;
    _info = value;
    notifyListeners();
  }

  void updateRemainTime(double value) {
    final t = value.round();
    if (t == 0) {
      _info = null;
      notifyListeners();
      return;
    }

    if (_info?.remainTime == t) return;
    _info?.remainTime = t;
    notifyListeners();
  }

  static AppState of(BuildContext? context, {bool listen = true}) {
    if (context == null) throw Exception('BuildContext is null');
    return Provider.of(context, listen: listen);
  }
}

enum GameState { loading, mainMenu, farm }

class GameEvent {
  final String type;
  final Map<String, dynamic>? params;

  const GameEvent(this.type, {this.params});
}

const _startLevelExp = 100.0;
const _levelMultiplicator = 1.5;

Tuple2<double, double> getLevelExpWindow(int level) {
  if (level <= 1) return Tuple2(0, _startLevelExp);
  final current = getLevelExpWindow(level - 1);
  return Tuple2(current.item2, current.item2 * _levelMultiplicator);
}

class Resources {
  final void Function(String type, double value) onChange;

  var _coins = 0.0;

  Resources(this.onChange);

  double get coins => _coins;
  void changeCoins(double value) {
    _coins += value;
    onChange('coins', _coins);
  }
}

class TileInfo {
  final int id;
  final double x;
  final double y;
  final Flower flower;
  int remainTime;

  TileInfo(this.id, this.x, this.y, this.flower, this.remainTime);
}
