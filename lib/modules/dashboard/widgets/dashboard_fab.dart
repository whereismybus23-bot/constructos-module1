import 'package:flutter/material.dart';

class DashboardFAB extends StatelessWidget {
  const DashboardFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      elevation: 6,

      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Quick Actions",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  _item(context, Icons.people, "Add Worker", () {
                    Navigator.pop(context);
                  }),

                  _item(context, Icons.inventory, "Add Material", () {
                    Navigator.pop(context);
                  }),

                  _item(context, Icons.currency_rupee, "Add Expense", () {
                    Navigator.pop(context);
                  }),

                  _item(context, Icons.trending_up, "Update Progress", () {
                    Navigator.pop(context);
                  }),

                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },

      child: const Icon(Icons.add),
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.red.shade50,
        child: Icon(icon, color: Colors.red),
      ),
      title: Text(title),
      onTap: onTap,
    );
  }
}
