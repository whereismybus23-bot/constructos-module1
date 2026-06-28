import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String userName;

  const HeaderWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),

      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),

      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Good Morning ☀️",
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),

                const SizedBox(height: 5),

                Text(
                  "Welcome, $userName 👋",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
