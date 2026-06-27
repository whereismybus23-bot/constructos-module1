import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/worker_model.dart';
import '../services/workforce_service.dart';

class WorkforceHomeScreen extends StatefulWidget {
  const WorkforceHomeScreen({super.key});

  @override
  State<WorkforceHomeScreen> createState() => _WorkforceHomeScreenState();
}

class _WorkforceHomeScreenState extends State<WorkforceHomeScreen> {
  final WorkforceService _service = WorkforceService();

  String get companyId => FirebaseAuth.instance.currentUser!.uid;

  void deleteWorker(String id) async {
    await _service.deleteWorker(id);

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Worker Deleted")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workforce"),
        backgroundColor: Colors.orange,
      ),

      body: StreamBuilder<List<WorkerModel>>(
        stream: _service.getWorkers(companyId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Workers Found"));
          }

          final workers = snapshot.data!;

          return ListView.builder(
            itemCount: workers.length,
            itemBuilder: (context, index) {
              final w = workers[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.orange),

                  title: Text(w.name),
                  subtitle: Text("${w.role} • ${w.phone}"),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteWorker(w.id),
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/add-worker");
        },
      ),
    );
  }
}
