import 'package:farm_sim/overlays/main_menu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mmkv/mmkv.dart';

import 'main_game.dart';

void main() async {
  await MMKV.initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget<MainGame>(
      game: MainGame(),
      overlayBuilderMap: {'MainMenu': mainMenuOverlay},
    );
  }
}
