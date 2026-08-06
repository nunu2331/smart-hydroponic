import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:smart_hydroponic/mock/mock_data.dart';
import 'package:smart_hydroponic/routes/app_routes.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';
import 'package:smart_hydroponic/widgets/common_widgets.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  int _selectedParam = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chart',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      'Monitoring Chart',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              ProfileAvatarButton(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.profile),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ParamChip(
                  label: 'Water pH',
                  icon: Icons.water_drop,
                  color: AppColors.phBlue,
                  selected: _selectedParam == 0,
                  onTap: () => setState(() => _selectedParam = 0),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ParamChip(
                  label: 'Water TDS',
                  icon: Icons.graphic_eq,
                  color: AppColors.tdsPurple,
                  selected: _selectedParam == 1,
                  onTap: () => setState(() => _selectedParam = 1),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ParamChip(
                  label: 'UV Light',
                  icon: Icons.wb_sunny,
                  color: AppColors.uvOrange,
                  selected: _selectedParam == 2,
                  onTap: () => setState(() => _selectedParam = 2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionTitle('Temperature Chart (°c)'),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            width: double.infinity,
            child: CustomPaint(
              painter: _LineChartPainter(
                green: MockData.chartPointsGreen,
                blue: MockData.chartPointsBlue,
              ),
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Row(
              children: const [
                Expanded(
                  child: _StatCell(label: 'Minimum', value: '25.0'),
                ),
                Expanded(
                  child: _StatCell(label: 'Average', value: '28.2'),
                ),
                Expanded(
                  child: _StatCell(label: 'Maximum', value: '31.0'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle('Data History'),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              children: [
                for (var i = 0; i < MockData.history.length; i++) ...[
                  if (i > 0) const Divider(height: 20),
                  _HistoryRow(item: MockData.history[i]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ParamChip extends StatelessWidget {
  const _ParamChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? color.withValues(alpha: 0.18) : AppColors.card,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.item});

  final MockHistoryItem item;

  IconData get _icon {
    switch (item.label) {
      case 'Water TDS':
        return Icons.graphic_eq;
      case 'UV Light':
        return Icons.wb_sunny;
      default:
        return Icons.water_drop;
    }
  }

  Color get _color {
    switch (item.label) {
      case 'Water TDS':
        return AppColors.tdsPurple;
      case 'UV Light':
        return AppColors.uvOrange;
      default:
        return AppColors.phBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: _color,
          child: Icon(_icon, color: AppColors.white, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                item.timestamp,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Text(
          item.value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({required this.green, required this.blue});

  final List<double> green;
  final List<double> blue;

  @override
  void paint(Canvas canvas, Size size) {
    final minY = 24.0;
    final maxY = 32.0;

    final axisPaint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      axisPaint,
    );
    canvas.drawLine(Offset.zero, Offset(0, size.height), axisPaint);

    void drawSeries(List<double> points, Color color) {
      if (points.isEmpty) return;
      final path = Path();
      for (var i = 0; i < points.length; i++) {
        final x = points.length == 1
            ? 0.0
            : size.width * (i / (points.length - 1));
        final normalized = (points[i] - minY) / (maxY - minY);
        final y = size.height - (normalized * size.height);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(path, paint);
    }

    drawSeries(blue, AppColors.phBlue);
    drawSeries(green, AppColors.primary);

    final labelStyle = TextPainter(
      textDirection: TextDirection.ltr,
    );
    for (var i = 0; i <= 9; i++) {
      labelStyle.text = TextSpan(
        text: '$i',
        style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
      );
      labelStyle.layout();
      final x = size.width * (i / 9) - labelStyle.width / 2;
      labelStyle.paint(canvas, Offset(math.max(0, x), size.height + 4));
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.green != green || oldDelegate.blue != blue;
  }
}
