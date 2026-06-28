import 'package:flutter/material.dart';

class SiteSelectorWidget extends StatelessWidget {
  final String selectedSite;
  final VoidCallback onTap;

  const SiteSelectorWidget({
    super.key,
    required this.selectedSite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black12)],
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.orange),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Site",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    selectedSite,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
