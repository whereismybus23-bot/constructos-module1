import 'package:flutter/material.dart';

class FabMenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const FabMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
