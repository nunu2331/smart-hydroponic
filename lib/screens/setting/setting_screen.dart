import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_hydroponic/auth/auth_service.dart';
import 'package:smart_hydroponic/routes/app_routes.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';
import 'package:smart_hydroponic/theme/app_fonts.dart';
import 'package:smart_hydroponic/widgets/common_widgets.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await AuthService.instance.signOut();
    if (!context.mounted) return;
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
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
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
            iconAsset: 'assets/icons/ic_time.svg',
            iconBg: AppColors.phBlue,
            title: 'Pump Schedule',
            subtitle: 'Set the pump light schedule',
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.schedule),
          ),
          const SizedBox(height: 12),
          _SettingTile(
            iconAsset: 'assets/icons/ic_notif.svg',
            iconBg: AppColors.uvOrange,
            title: 'Notification',
            subtitle: 'Set notification preferences',
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.notification),
          ),
          const SizedBox(height: 12),
          _SettingTile(
            iconAsset: 'assets/icons/ic_keluar.svg',
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
    required this.iconAsset,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.showChevron = true,
  });

  final String iconAsset;
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
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              iconAsset,
              width: 16,
              height: 16,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: AppFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
              ],
            ),
          ),
          if (showChevron)
            const Icon(Icons.chevron_right, color: AppColors.textPrimary),
        ],
      ),
    );
  }
}
