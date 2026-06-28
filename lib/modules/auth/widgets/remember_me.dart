import 'package:flutter/material.dart';

class RememberMe extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const RememberMe({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          activeColor: Colors.orange,
          onChanged: onChanged,
        ),

        const Text("Remember Me", style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
