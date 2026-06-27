import 'package:flutter/material.dart';

import '../../auth/ui/login_screen.dart';
import '../../workforce/ui/workforce_home_screen.dart';
import '../../materials/ui/materials_screen.dart';
import '../../expenses/ui/expenses_screen.dart';
import '../../progress/ui/progress_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void openScreen(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("🏗️ ConstructOS"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "logout") {
                logout();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "site", child: Text("📍 Site")),
              PopupMenuItem(value: "logout", child: Text("Logout")),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 10),

            Row(
              children: [
                _card("Workforce", Icons.people, () {
                  openScreen(const WorkforceHomeScreen());
                }),
                const SizedBox(width: 10),
                _card("Materials", Icons.inventory, () {
                  openScreen(const MaterialsScreen());
                }),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                _card("Expenses", Icons.attach_money, () {
                  openScreen(const ExpensesScreen());
                }),
                const SizedBox(width: 10),
                _card("Progress", Icons.trending_up, () {
                  openScreen(const ProgressScreen());
                }),
              ],
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomIcon(Icons.home, 0),
                _bottomIcon(Icons.people, 1),
                _bottomIcon(Icons.inventory, 2),
                _bottomIcon(Icons.attach_money, 3),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _card(String title, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: const Border(
              left: BorderSide(color: Colors.orange, width: 4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.orange),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: selectedIndex == index ? Colors.orange : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}
