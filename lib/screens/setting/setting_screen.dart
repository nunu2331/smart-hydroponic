import 'package:flutter/material.dart';
import 'package:smart_hydroponic/routes/app_routes.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';
import 'package:smart_hydroponic/widgets/common_widgets.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  void _logout(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.welcome,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Setting',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              ProfileAvatarButton(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.profile),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SettingTile(
            icon: Icons.schedule,
            iconBg: AppColors.phBlue,
            title: 'Pump Schedule',
            subtitle: 'Set the pump light schedule',
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.schedule),
          ),
          const SizedBox(height: 12),
          _SettingTile(
            icon: Icons.notifications_outlined,
            iconBg: AppColors.uvOrange,
            title: 'Notification',
            subtitle: 'Set notification preferences',
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.notification),
          ),
          const SizedBox(height: 12),
          _SettingTile(
            icon: Icons.logout,
            iconBg: AppColors.danger,
            title: 'Log out',
            subtitle: null,
            showChevron: false,
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.showChevron = true,
  });

  final IconData icon;
  final Color iconBg;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconBg,
            child: Icon(icon, color: AppColors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          if (showChevron)
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
