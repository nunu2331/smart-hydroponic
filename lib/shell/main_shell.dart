import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_hydroponic/screens/chart/chart_screen.dart';
import 'package:smart_hydroponic/screens/home/home_screen.dart';
import 'package:smart_hydroponic/screens/setting/setting_screen.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';
import 'package:smart_hydroponic/theme/app_fonts.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _pages = [
    HomeScreen(),
    ChartScreen(),
    SettingScreen(),
  ];

  static const _tabs = [
    (off: 'assets/icons/ic_home_off.svg', on: 'assets/icons/ic_home_on.svg', label: 'Home'),
    (off: 'assets/icons/ic_chart_off.svg', on: 'assets/icons/ic_chart_on.svg', label: 'Chart'),
    (
      off: 'assets/icons/ic_settings_off.svg',
      on: 'assets/icons/ic_settings_on.svg',
      label: 'Setting',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Material(
        color: AppColors.white,
        elevation: 8,
        child: Padding(
          // Top = Figma 23. Bottom = home-indicator OR 23 (jangan SafeArea+23 dobel).
          padding: EdgeInsets.only(
            top: 23,
            bottom: bottomInset > 0 ? bottomInset : 23,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < _tabs.length; i++) ...[
                if (i > 0) const SizedBox(width: 88),
                _NavItem(
                  label: _tabs[i].label,
                  asset: _index == i ? _tabs[i].on : _tabs[i].off,
                  selected: _index == i,
                  onTap: () => setState(() => _index = i),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.asset,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String asset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textPrimary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            asset,
            width: 24,
            height: 24,
            colorFilter: selected
                ? const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)
                : null,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
