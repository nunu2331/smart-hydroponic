import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_hydroponic/mock/mock_data.dart';
import 'package:smart_hydroponic/routes/app_routes.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';
import 'package:smart_hydroponic/theme/app_fonts.dart';
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
              const LeafLogo(size: 60),
              const SizedBox(width: 2),
              const Expanded(
                child: Text(
                  'Smart\nHydroponic',
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
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_wifi.svg',
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'System Status',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
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
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Online',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Monitoring Real Time',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _MetricCard(
                icon: SvgPicture.asset(
                  'assets/icons/ic_water.svg',
                  width: 40,
                  height: 40,
                ),
                label: 'Water pH',
                value: MockData.ph,
              ),
              _MetricCard(
                icon: SvgPicture.asset(
                  'assets/icons/ic_tds.svg',
                  width: 40,
                  height: 40,
                ),
                label: 'Water TDS',
                value: MockData.tds,
              ),
              _MetricCard(
                icon: SvgPicture.asset(
                  'assets/icons/ic_uv.svg',
                  width: 40,
                  height: 40,
                ),
                label: 'UV Light',
                value: MockData.uv,
              ),
            ],
          ),
          const SizedBox(height: 30),
          const SectionTitle('Pump Control'),
          const SizedBox(height: 20),
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
    required this.label,
    required this.value,
  });

  final Widget icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.inter(
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
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/icons/ic_pump.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              const Spacer(),
              Switch(value: enabled, onChanged: onChanged),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            subtitle,
            style: AppFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            enabled ? 'ON' : 'OFF',
            style: AppFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
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
