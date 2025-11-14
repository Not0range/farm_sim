import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

const _spriteSize = 32.0;
final _sizeVector = Vector2(_spriteSize, _spriteSize);
final _columnCount = 4;

class SpriteButton extends StatelessWidget {
  final SpriteType type;
  final VoidCallback? onTap;

  const SpriteButton({super.key, required this.type, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: SpriteWidget.asset(
          path: 'logo.png',
          srcPosition: Vector2(
            (type.index % _columnCount) * 32.0,
            (type.index ~/ _columnCount) * 32.0,
          ),
          srcSize: _sizeVector,
        ),
      ),
    );
  }
}

enum SpriteType { settings, info }
