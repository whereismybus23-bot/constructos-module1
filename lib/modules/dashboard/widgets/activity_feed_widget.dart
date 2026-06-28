import 'package:flutter/material.dart';

class ActivityFeedWidget extends StatelessWidget {
  final String siteId;

  const ActivityFeedWidget({super.key, required this.siteId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Activity",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          _activityTile(
            Icons.people,
            Colors.blue,
            "Ravi",
            "Attendance Marked",
            "09:15 AM",
          ),

          const Divider(),

          _activityTile(
            Icons.inventory,
            Colors.orange,
            "Materials",
            "Cement +50 Bags",
            "09:45 AM",
          ),

          const Divider(),

          _activityTile(
            Icons.currency_rupee,
            Colors.green,
            "Expense",
            "Diesel ₹4,500",
            "10:20 AM",
          ),

          const Divider(),

          _activityTile(
            Icons.trending_up,
            Colors.purple,
            "Progress",
            "Slab Completed",
            "11:30 AM",
          ),
        ],
      ),
    );
  }

  Widget _activityTile(
    IconData icon,
    Color color,
    String title,
    String subtitle,
    String time,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        // FIX: Replaced deprecated .withOpacity with .withValues(alpha: ...)
        backgroundColor: color.withValues(alpha: 0.12),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Text(
        time,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}
