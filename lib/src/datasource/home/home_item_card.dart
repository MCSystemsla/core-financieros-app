import 'package:flutter/material.dart';

class HomeItemCard {
  final String title;
  final String subtitle;
  final Icon icon;
  final Color color;
  final VoidCallback onTap;
  final bool visible;

  HomeItemCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
    this.visible = true,
  });
}
