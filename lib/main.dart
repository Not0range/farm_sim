import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'common/mmkv/mmkv.dart';
import 'main_game.dart';
import 'overlays/game_overlay.dart';
import 'overlays/info_menu.dart';
import 'overlays/loading_overlay.dart';
import 'overlays/main_menu.dart';
import 'overlays/pause_menu.dart';
import 'overlays/settings_menu.dart';

void main() async {
  await MMKV.initialize();
  runApp(
    ChangeNotifierProvider(create: (_) => AppState(), child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget<MainGame>(
      game: MainGame(),
      overlayBuilderMap: gameOverlays,
    );
  }
}

const gameOverlays = {
  'MainMenu': mainMenuOverlay,
  'InfoMenu': infoMenuOverlay,
  'Settings': settingsMenuOverlay,
  'GameOverlay': gameOverlay,
  'PauseMenu': pauseMenuOverlay,
  'Loading': loadingOverlay,
};
const persistOverlays = ['Loading'];
