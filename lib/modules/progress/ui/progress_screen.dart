import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Progress"),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          "Progress Module\nComing Soon",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
