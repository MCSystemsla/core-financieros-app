import 'package:flutter/material.dart';

class ModuleIconTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final double size;
  const ModuleIconTile({
    super.key,
    required this.icon,
    required this.color,
    required this.background,
    this.size = 42,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, size: size * 0.5, color: color),
    );
  }
}
