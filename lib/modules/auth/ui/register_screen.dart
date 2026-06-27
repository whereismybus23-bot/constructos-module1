import 'package:flutter/material.dart';
import '../../dashboard/ui/dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final company = TextEditingController();
  final owner = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();

  void createCompany() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,

      appBar: AppBar(title: const Text("Create Company")),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Company Setup 🏗️"),

                TextField(
                  controller: company,
                  decoration: const InputDecoration(labelText: "Company *"),
                ),

                TextField(
                  controller: owner,
                  decoration: const InputDecoration(labelText: "Owner *"),
                ),

                TextField(
                  controller: phone,
                  decoration: const InputDecoration(labelText: "Phone *"),
                ),

                TextField(
                  controller: email,
                  decoration: const InputDecoration(labelText: "Email"),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: createCompany,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Create Company"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
