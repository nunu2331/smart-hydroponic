import 'package:flutter/material.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';

/// Foundation stub — replaced in feature/main-tabs.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home (placeholder)',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
