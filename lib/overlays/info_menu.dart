import 'package:flutter/material.dart';

import '../main_game.dart';
import 'components/menu_button.dart';

Widget infoMenuOverlay(BuildContext context, MainGame game) {
  final overlays = game.overlays;
  closeCb() => overlays.remove('InfoMenu');

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: closeCb,
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
            Text('Info', textAlign: TextAlign.center),
            MenuButton('Close', onTap: closeCb),
          ],
        ),
      ),
    ),
  );
}
