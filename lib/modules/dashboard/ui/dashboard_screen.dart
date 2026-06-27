import 'package:flutter/material.dart';
import '../../workforce/ui/add_worker_screen.dart';
import '../../auth/ui/login_screen.dart';

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

      // HEADER
      appBar: AppBar(
        title: const Text("🏗️ ConstructOS"),
        backgroundColor: Colors.orange,

        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == "logout") logout();
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "site", child: Text("Hyderabad Site")),
              PopupMenuItem(value: "logout", child: Text("Logout")),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          children: [
            // SITE BAR
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("📍 Hyderabad Site"),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // CARDS
            Row(
              children: [
                _card("Workforce", "52 Present", Icons.people, () {
                  openScreen(const AddWorkerScreen());
                }),
                const SizedBox(width: 10),
                _card("Materials", "Low Stock", Icons.inventory, () {}),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                _card("Expenses", "₹82,450", Icons.money, () {}),
                const SizedBox(width: 10),
                _card("Progress", "42%", Icons.show_chart, () {}),
              ],
            ),

            const SizedBox(height: 20),

            // QUICK ACTIONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _action(Icons.person_add, "Labour", () {
                  openScreen(AddWorkerScreen());
                }),
                _action(Icons.inventory_2, "Matrl", () {}),
                _action(Icons.attach_money, "Exp", () {}),
                _action(Icons.trending_up, "Prog", () {}),
              ],
            ),

            const Spacer(),

            // BOTTOM NAV
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home, color: Colors.orange),
                  Icon(Icons.people),
                  Icon(Icons.inventory),
                  Icon(Icons.money),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CARD
  Widget _card(String title, String value, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
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
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ACTION
  Widget _action(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
