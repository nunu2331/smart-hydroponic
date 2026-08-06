import 'package:flutter/material.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';
import 'package:smart_hydroponic/widgets/common_widgets.dart';

/// Foundation stub — replaced in feature/pump-schedule.
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            AppBackHeader(title: 'Pump Schedule'),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text('Schedule (placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}
