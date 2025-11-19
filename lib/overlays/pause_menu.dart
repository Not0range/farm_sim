import 'package:flutter/material.dart';

import '../main_game.dart';
import 'components/menu_button.dart';

Widget pauseMenuOverlay(BuildContext context, MainGame game) {
  final overlays = game.overlays;
  resumeCb() => overlays.remove('PauseMenu');

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: resumeCb,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.black.withAlpha(32)),
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Pause menu', textAlign: TextAlign.center),
            MenuButton('Resume', onTap: resumeCb),
            MenuButton('Settings', onTap: () => overlays.add('Settings')),
            MenuButton('Quit', onTap: game.returnToMainMenu),
          ],
        ),
      ),
    ),
  );
}
