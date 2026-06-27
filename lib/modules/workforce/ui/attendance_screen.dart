import 'package:flutter/material.dart';
import '../services/workforce_service.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final Map<String, bool> attendance = {};

  @override
  Widget build(BuildContext context) {
    final workers = WorkforceService.getWorkers();

    return Scaffold(
      appBar: AppBar(title: const Text("Attendance")),

      body: workers.isEmpty
          ? const Center(child: Text("No workers available"))
          : ListView.builder(
              itemCount: workers.length,
              itemBuilder: (context, index) {
                final w = workers[index];

                return Card(
                  child: ListTile(
                    title: Text(w.name),
                    subtitle: Text(w.role),
                    trailing: Switch(
                      activeThumbColor: Colors.green,
                      value: attendance[w.id] ?? false,
                      onChanged: (val) {
                        setState(() {
                          attendance[w.id] = val;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
