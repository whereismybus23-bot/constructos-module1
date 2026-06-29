import 'package:flutter/material.dart';

class DashboardCardModel {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  final bool enabled;

  const DashboardCardModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.enabled = true,
  });
}
