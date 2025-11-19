import 'package:flutter/material.dart';

import '../app_state.dart';
import '../main_game.dart';

Widget loadingOverlay(BuildContext context, MainGame game) {
  final state = AppState.of(context).gameState;
  return _Loading(state: state);
}

class _Loading extends StatefulWidget {
  final GameState state;

  const _Loading({required this.state});

  @override
  State<StatefulWidget> createState() => _LoadingState();
}

class _LoadingState extends State<_Loading> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double pos = switch (widget.state) {
      GameState.farm => -1,
      GameState.mainMenu => 1,
      GameState.loading => 0,
    };

    return AbsorbPointer(
      absorbing: widget.state == GameState.loading,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedPositioned(
            top: pos * size.height,
            height: size.height,
            left: 0,
            width: size.width,
            duration: Duration(seconds: 1),
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(255, 0, 0, 0.3)),
            ),
          ),
        ],
      ),
    );
  }
}
