import 'package:flutter/material.dart';
import '../services/workforce_service.dart';
import 'add_worker_screen.dart';

class WorkforceHomeScreen extends StatefulWidget {
  const WorkforceHomeScreen({super.key});

  @override
  State<WorkforceHomeScreen> createState() => _WorkforceHomeScreenState();
}

class _WorkforceHomeScreenState extends State<WorkforceHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final workers = WorkforceService.getWorkers();

    return Scaffold(
      backgroundColor: Colors.orange.shade50,

      appBar: AppBar(
        title: const Text("Workforce"),
        backgroundColor: Colors.orange,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          children: [
            // SUMMARY
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: const Border(
                  left: BorderSide(color: Colors.orange, width: 4),
                ),
              ),
              child: Text(
                "Total Workers: ${workers.length}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // EMPTY STATE
            if (workers.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    "No workers added yet",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: workers.length,
                  itemBuilder: (context, index) {
                    final w = workers[index];

                    return Card(
                      child: ListTile(
                        title: Text(w.name),
                        subtitle: Text(w.role),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // EDIT
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        AddWorkerScreen(editWorker: w),
                                  ),
                                ).then((_) => setState(() {}));
                              },
                            ),

                            // DELETE
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                WorkforceService.deleteWorker(w.id);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddWorkerScreen()),
          ).then((_) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
