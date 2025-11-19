import 'package:flutter/widgets.dart';

import '../components/sprite_button.dart';
import '../main_game.dart';

Widget gameOverlay(BuildContext context, MainGame game) {
  return _GameOverlay();
}

class _GameOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameOverlayState();
}

class _GameOverlayState extends State<_GameOverlay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SpriteButton(
              type: SpriteType.pause,
              size: 64,
              onTap: () => print('Pause'),
            ),
            SpriteButton(
              type: SpriteType.inventory,
              size: 64,
              onTap: () => print('Inventory'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SpriteButton(
              type: SpriteType.building,
              size: 64,
              onTap: () => print('Building'),
            ),
            SpriteButton(
              type: SpriteType.info,
              size: 64,
              onTap: () => print('a)'),
            ),
          ],
        ),
      ],
    );
  }
}
