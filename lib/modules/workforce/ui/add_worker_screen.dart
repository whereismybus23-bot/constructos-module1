import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/worker_model.dart';
import '../services/workforce_service.dart';

class AddWorkerScreen extends StatefulWidget {
  const AddWorkerScreen({super.key});

  @override
  State<AddWorkerScreen> createState() => _AddWorkerScreenState();
}

class _AddWorkerScreenState extends State<AddWorkerScreen> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final role = TextEditingController();
  final wage = TextEditingController();

  final WorkforceService _service = WorkforceService();

  void saveWorker() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final worker = WorkerModel(
      id: FirebaseFirestore.instance.collection("workers").doc().id,
      companyId: uid,
      name: name.text,
      phone: phone.text,
      role: role.text,
      dailyWage: double.tryParse(wage.text) ?? 0,
      isActive: true,
    );

    await _service.addWorker(worker);

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Worker Added")));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Worker")),
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
            TextField(
              controller: wage,
              decoration: const InputDecoration(labelText: "Daily Wage"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveWorker,
              child: const Text("Save Worker"),
            ),
          ],
        ),
      ),
    );
  }
}
