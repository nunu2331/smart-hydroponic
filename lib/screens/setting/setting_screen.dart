import 'package:flutter/material.dart';
import 'package:smart_hydroponic/routes/app_routes.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';

/// Foundation stub with route stubs — filled in feature/main-tabs.
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Setting (placeholder)',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Pump Schedule'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.schedule),
          ),
          ListTile(
            title: const Text('Notification'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.notification),
          ),
          ListTile(
            title: const Text('Profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.profile),
          ),
          ListTile(
            title: const Text(
              'Log out',
              style: TextStyle(color: AppColors.danger),
            ),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.welcome,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
