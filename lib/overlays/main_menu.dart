// import 'package:flame/widgets.dart' hide SpriteButton;
import 'package:farm_sim/locale/app_localizations.dart';
import 'package:flutter/material.dart';

import '../app_state.dart';
import '../components/sprite_button.dart';
import '../main_game.dart';

Widget mainMenuOverlay(BuildContext context, MainGame game) {
  final overlays = game.overlays;
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
                  onTap: () => overlays.add('InfoMenu'),
                ),
                SpriteButton(
                  type: SpriteType.empty,
                  size: 64,
                  onTap: () => overlays.add('Settings'),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SpriteWidget.asset(path: 'logo.png'),
                  _StartInviteText(),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

const _startTextStyle = TextStyle(
  color: Colors.white,
  shadows: [
    Shadow(color: Colors.black, offset: Offset(2, 0), blurRadius: 1),
    Shadow(color: Colors.black, offset: Offset(-2, 0), blurRadius: 1),
    Shadow(color: Colors.black, offset: Offset(0, -2), blurRadius: 1),
    Shadow(color: Colors.black, offset: Offset(0, 2), blurRadius: 1),
  ],
  letterSpacing: 3,
);

class _StartInviteText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StartInviteTextState();
}

class _StartInviteTextState extends State<_StartInviteText>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween<double>(begin: 0.8, end: 1.2).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return ScaleTransition(
      scale: animation,
      child: Text(locale.startInvite, style: _startTextStyle),
    );
  }
}
