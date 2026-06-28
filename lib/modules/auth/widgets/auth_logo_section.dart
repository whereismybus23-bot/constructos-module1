import 'package:flutter/material.dart';

import '../../../app/widgets/common/app_logo.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_colors.dart';

class AuthLogoSection extends StatelessWidget {
  const AuthLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppLogo(width: 180),

        const SizedBox(height: 24),

        Text("ConstructOS", style: AppTextStyles.heading),

        const SizedBox(height: 8),

        const Text(
          "Building Construction\nSmarter & Faster",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
