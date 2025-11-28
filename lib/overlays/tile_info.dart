import 'package:farm_sim/locale/app_localizations.dart';
import 'package:flutter/material.dart';

import '../app_state.dart';
import '../main_game.dart';

Widget tileInfoOverlay(BuildContext context, MainGame game) {
  final state = AppState.of(context);
  final info = state.info;
  if (info == null) return SizedBox.shrink();
  final str = _timeFormat(context, info.remainTime);
  return Stack(
    children: [
      Positioned(
        top: info.y,
        left: info.x,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text('$str'),
        ),
      ),
    ],
  );
}

String _timeFormat(BuildContext context, int seconds) {
  final locale = AppLocalizations.of(context);
  if (seconds >= 3600) {
    return '${seconds ~/ 3600} ${locale.hours} '
        '${seconds % 3600 ~/ 60} ${locale.minutes}';
  }
  return '${seconds ~/ 60} ${locale.minutes} ${seconds % 60} ${locale.seconds}';
}
