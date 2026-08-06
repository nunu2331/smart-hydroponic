import 'package:flutter/material.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';
import 'package:smart_hydroponic/widgets/common_widgets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _ph = true;
  bool _tds = true;
  bool _uv = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBackHeader(title: 'Notification'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _NotifTile(
                    title: 'pH Warning',
                    subtitle: 'Active if the pH is not normal',
                    value: _ph,
                    onChanged: (v) => setState(() => _ph = v),
                  ),
                  const SizedBox(height: 12),
                  _NotifTile(
                    title: 'TDS Warning',
                    subtitle: 'Active if the TDS is not normal',
                    value: _tds,
                    onChanged: (v) => setState(() => _tds = v),
                  ),
                  const SizedBox(height: 12),
                  _NotifTile(
                    title: 'UV Warning',
                    subtitle: 'Active if the UV is not normal',
                    value: _uv,
                    onChanged: (v) => setState(() => _uv = v),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotifTile extends StatelessWidget {
  const _NotifTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
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
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
