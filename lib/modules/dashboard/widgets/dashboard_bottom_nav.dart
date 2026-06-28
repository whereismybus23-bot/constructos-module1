import 'package:flutter/material.dart';

class DashboardBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const DashboardBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,

      type: BottomNavigationBarType.fixed,

      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),

        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
