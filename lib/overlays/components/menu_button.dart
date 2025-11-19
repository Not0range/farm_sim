import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const MenuButton(this.text, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 4),
            child: Text(text, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
