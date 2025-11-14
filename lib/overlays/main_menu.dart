import 'package:flame/widgets.dart' hide SpriteButton;
import 'package:flutter/material.dart';

import '../components/sprite_button.dart';
import '../main_game.dart';

Widget mainMenuOverlay(BuildContext context, MainGame game) {
  return _MainMenu();
}

class _MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainMenuState();
}

class _MainMenuState extends State<_MainMenu> {
  bool _inited = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() => _inited = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: _inited ? 1 : 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpriteButton(type: SpriteType.info),
              SpriteButton(type: SpriteType.settings),
            ],
          ),
          Expanded(
            child: Align(
              alignment: const FractionalOffset(0.5, 0.3),
              child: SpriteWidget.asset(path: 'logo.png'),
            ),
          ),
        ],
      ),
    );
  }
}
