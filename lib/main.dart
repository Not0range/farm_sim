import 'package:farm_sim/locale/app_localizations.dart';
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
import 'overlays/tile_info.dart';

void main() async {
  await MMKV.initialize();
  runApp(
    ChangeNotifierProvider(create: (_) => AppState(), child: const MainApp()),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  var _locale = AppLocalizations.supportedLocales[0];

  @override
  void initState() {
    super.initState();
    _locale = basicLocaleListResolution(
      WidgetsBinding.instance.platformDispatcher.locales,
      AppLocalizations.supportedLocales,
    );
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    setState(() {
      _locale = basicLocaleListResolution(
        locales,
        AppLocalizations.supportedLocales,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: _locale,
      delegates: AppLocalizations.localizationsDelegates,
      child: GameWidget<MainGame>(
        game: MainGame(),
        overlayBuilderMap: gameOverlays,
      ),
    );
  }
}

const gameOverlays = {
  'MainMenu': mainMenuOverlay,
  'InfoMenu': infoMenuOverlay,
  'Settings': settingsMenuOverlay,
  'GameOverlay': gameOverlay,
  'PauseMenu': pauseMenuOverlay,
  'TileInfo': tileInfoOverlay,
  'Loading': loadingOverlay,
};
const persistOverlays = ['Loading'];
