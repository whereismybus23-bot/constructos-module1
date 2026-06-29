import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'fab_menu_item.dart';

class ExpandableFab extends StatefulWidget {
  final List<FabMenuItem> items;

  const ExpandableFab({super.key, required this.items});

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;

  void toggleFab() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isOpen)
          ...widget.items.reversed.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: FloatingActionButton.extended(
                heroTag: item.title,
                backgroundColor: AppColors.card,
                foregroundColor: AppColors.textPrimary,
                elevation: 4,
                icon: Icon(item.icon, color: AppColors.primary),
                label: Text(item.title),
                onPressed: () {
                  toggleFab();
                  item.onTap();
                },
              ),
            ),
          ),

        FloatingActionButton(
          heroTag: "main_fab",
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          onPressed: toggleFab,
          child: AnimatedRotation(
            turns: isOpen ? 0.125 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
