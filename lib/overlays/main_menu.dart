import 'package:flame/widgets.dart' hide SpriteButton;
import 'package:flutter/material.dart';

import '../app_state.dart';
import '../components/sprite_button.dart';
import '../main_game.dart';

Widget mainMenuOverlay(BuildContext context, MainGame game) {
  final state = AppState.of(context).gameState;
  return Stack(
    children: [
      GestureDetector(behavior: HitTestBehavior.opaque, onTap: game.start),
      AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: state == GameState.mainMenu ? 1 : 0,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpriteButton(
                  type: SpriteType.empty,
                  size: 64,
                  onTap: () => print('Info'),
                ),
                SpriteButton(
                  type: SpriteType.empty,
                  size: 64,
                  onTap: () => print('Settings'),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: const FractionalOffset(0.5, 0.3),
                // child: SpriteWidget.asset(path: 'logo.png'),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
