import 'package:flutter/material.dart';
import 'package:smart_hydroponic/mock/mock_data.dart';
import 'package:smart_hydroponic/routes/app_routes.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';
import 'package:smart_hydroponic/widgets/common_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _pumpA = true;
  bool _pumpB = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const LeafLogo(size: 36),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Smart\nHydroponic',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.15,
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
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.wifi, color: AppColors.white),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'System Status',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'The system runs normally',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Online',
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle('Monitoring Real Time'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  icon: Icons.water_drop,
                  iconBg: AppColors.phBlue,
                  label: 'Water pH',
                  value: MockData.ph,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  icon: Icons.graphic_eq,
                  iconBg: AppColors.tdsPurple,
                  label: 'Water TDS',
                  value: MockData.tds,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  icon: Icons.wb_sunny,
                  iconBg: AppColors.uvOrange,
                  label: 'UV Light',
                  value: MockData.uv,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionTitle('Pump Control'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _PumpCard(
                  title: 'Nutrition Pump A',
                  subtitle: 'Nutrition Circulation',
                  enabled: _pumpA,
                  onChanged: (v) => setState(() => _pumpA = v),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PumpCard(
                  title: 'Nutrition Pump B',
                  subtitle: 'Nutrition Circulation',
                  enabled: _pumpB,
                  onChanged: (v) => setState(() => _pumpB = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionTitle('System Status'),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              children: const [
                _StatusRow(label: 'Sensor', value: 'Normal', ok: true),
                Divider(height: 20),
                _StatusRow(
                  label: 'Nutrition Circulation',
                  value: 'Running',
                  ok: true,
                ),
                Divider(height: 20),
                _StatusRow(
                  label: 'Water Circulation',
                  value: 'Stopped',
                  ok: false,
                ),
                Divider(height: 20),
                _StatusRow(
                  label: 'Inter Connection',
                  value: 'Online',
                  ok: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.iconBg,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconBg;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: iconBg,
            child: Icon(icon, color: AppColors.white, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _PumpCard extends StatelessWidget {
  const _PumpCard({
    required this.title,
    required this.subtitle,
    required this.enabled,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.water, color: AppColors.white, size: 16),
              ),
              const Spacer(),
              Switch(value: enabled, onChanged: onChanged),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            enabled ? 'ON' : 'OFF',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: enabled ? AppColors.primaryDark : AppColors.danger,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.label,
    required this.value,
    required this.ok,
  });

  final String label;
  final String value;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: AppColors.textPrimary),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: ok ? AppColors.primaryDark : AppColors.danger,
          ),
        ),
      ],
    );
  }
}
