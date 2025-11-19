import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AppState extends ChangeNotifier {
  GameState _gameState = GameState.loading;

  GameState get gameState => _gameState;
  set gameState(GameState value) {
    _gameState = value;
    notifyListeners();
  }

  static AppState of(BuildContext context, {bool listen = true}) {
    return Provider.of(context, listen: listen);
  }
}

enum GameState { loading, mainMenu, farm }
