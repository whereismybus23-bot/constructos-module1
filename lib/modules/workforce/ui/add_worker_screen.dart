import 'package:flutter/material.dart';
import '../models/worker_model.dart';
import '../services/workforce_service.dart';

class AddWorkerScreen extends StatefulWidget {
  final Worker? editWorker;

  const AddWorkerScreen({super.key, this.editWorker});

  @override
  State<AddWorkerScreen> createState() => _AddWorkerScreenState();
}

class _AddWorkerScreenState extends State<AddWorkerScreen> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final role = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.editWorker != null) {
      name.text = widget.editWorker!.name;
      phone.text = widget.editWorker!.phone;
      role.text = widget.editWorker!.role;
    }
  }

  void save() {
    if (widget.editWorker == null) {
      WorkforceService.addWorker(
        Worker(
          id: DateTime.now().toString(),
          name: name.text,
          phone: phone.text,
          role: role.text,
        ),
      );
    } else {
      WorkforceService.updateWorker(
        Worker(
          id: widget.editWorker!.id,
          name: name.text,
          phone: phone.text,
          role: role.text,
        ),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editWorker == null ? "Add Worker" : "Edit Worker"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: phone,
              decoration: const InputDecoration(labelText: "Phone"),
            ),

            TextField(
              controller: role,
              decoration: const InputDecoration(labelText: "Role"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: save,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
