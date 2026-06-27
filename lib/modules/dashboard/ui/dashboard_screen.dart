import 'package:flutter/material.dart';

import '../../auth/ui/login_screen.dart';
import '../../workforce/ui/add_worker_screen.dart';
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
              PopupMenuItem(value: "site", child: Text("📍 Hyderabad Site")),
              PopupMenuItem(value: "logout", child: Text("Logout")),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Site Selector
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "📍 Hyderabad Site",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Summary Cards
            Row(
              children: [
                _card("Workforce", "52 Present", Icons.people, () {
                  openScreen(const AddWorkerScreen());
                }),
                const SizedBox(width: 10),
                _card("Materials", "Low Stock", Icons.inventory, () {
                  openScreen(const MaterialsScreen());
                }),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                _card("Expenses", "₹82,450", Icons.attach_money, () {
                  openScreen(const ExpensesScreen());
                }),
                const SizedBox(width: 10),
                _card("Progress", "42%", Icons.trending_up, () {
                  openScreen(const ProgressScreen());
                }),
              ],
            ),

            const SizedBox(height: 25),

            // Quick Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _action(Icons.person_add, "Labour", () {
                  openScreen(const AddWorkerScreen());
                }),
                _action(Icons.inventory_2, "Matrl", () {
                  openScreen(const MaterialsScreen());
                }),
                _action(Icons.attach_money, "Exp", () {
                  openScreen(const ExpensesScreen());
                }),
                _action(Icons.trending_up, "Prog", () {
                  openScreen(const ProgressScreen());
                }),
              ],
            ),

            const Spacer(),

            // Bottom Navigation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: selectedIndex == 0 ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => selectedIndex = 0);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.people,
                      color: selectedIndex == 1 ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => selectedIndex = 1);
                      openScreen(const AddWorkerScreen());
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.inventory,
                      color: selectedIndex == 2 ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => selectedIndex = 2);
                      openScreen(const MaterialsScreen());
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.attach_money,
                      color: selectedIndex == 3 ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => selectedIndex = 3);
                      openScreen(const ExpensesScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _action(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
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
