import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_hydroponic/mock/mock_data.dart';
import 'package:smart_hydroponic/routes/app_routes.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';
import 'package:smart_hydroponic/theme/app_fonts.dart';
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
                      'Monitoring Chart',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _ParamChip(
                    label: 'Water pH',
                    iconAsset: 'assets/icons/ic_water.svg',
                    selected: _selectedParam == 0,
                    onTap: () => setState(() => _selectedParam = 0),
                  ),
                ),
                Expanded(
                  child: _ParamChip(
                    label: 'Water TDS',
                    iconAsset: 'assets/icons/ic_tds.svg',
                    selected: _selectedParam == 1,
                    onTap: () => setState(() => _selectedParam = 1),
                  ),
                ),
                Expanded(
                  child: _ParamChip(
                    label: 'UV Light',
                    iconAsset: 'assets/icons/ic_uv.svg',
                    selected: _selectedParam == 2,
                    onTap: () => setState(() => _selectedParam = 2),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle('Temperature Chart (°c)'),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            width: double.infinity,
            child: CustomPaint(
              painter: _LineChartPainter(
                green: MockData.chartPointsGreen,
                blue: MockData.chartPointsBlue,
              ),
            ),
          ),
          const SizedBox(height: 30),
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
    required this.iconAsset,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String iconAsset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: selected ? const EdgeInsets.all(4) : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: selected ? AppColors.primary4 : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconAsset,
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
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
          style: AppFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.item});

  final MockHistoryItem item;

  String get _iconAsset {
    switch (item.label) {
      case 'Water TDS':
        return 'assets/icons/ic_tds.svg';
      case 'UV Light':
        return 'assets/icons/ic_uv.svg';
      default:
        return 'assets/icons/ic_water.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          _iconAsset,
          width: 34,
          height: 34,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
                style: AppFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              item.value,

              style: AppFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              item.timestamp,
              
              style: AppFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({required this.green, required this.blue});

  final List<double> green;
  final List<double> blue;

  static const _axisMax = 9.0;
  static const _leftPad = 24.0;
  static const _bottomPad = 22.0;
  static const _topPad = 8.0;
  static const _rightPad = 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    final chartOrigin = const Offset(_leftPad, _topPad);
    final chartSize = Size(
      size.width - _leftPad - _rightPad,
      size.height - _topPad - _bottomPad,
    );

    final gridPaint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;

    final axisPaint = Paint()
      ..color = AppColors.textSecondary
      ..strokeWidth = 1.2;

    Offset pointFor(double xValue, double yValue) {
      final x = chartOrigin.dx + chartSize.width * (xValue / _axisMax);
      final y = chartOrigin.dy +
          chartSize.height * (1 - (yValue / _axisMax).clamp(0.0, 1.0));
      return Offset(x, y);
    }

    // Grid 0–9 → kotak-kotak
    for (var i = 0; i <= 9; i++) {
      final v = i.toDouble();
      final x = pointFor(v, 0).dx;
      final y = pointFor(0, v).dy;

      canvas.drawLine(
        Offset(x, chartOrigin.dy),
        Offset(x, chartOrigin.dy + chartSize.height),
        gridPaint,
      );
      canvas.drawLine(
        Offset(chartOrigin.dx, y),
        Offset(chartOrigin.dx + chartSize.width, y),
        gridPaint,
      );
    }

    // Axis border
    canvas.drawRect(
      Rect.fromLTWH(
        chartOrigin.dx,
        chartOrigin.dy,
        chartSize.width,
        chartSize.height,
      ),
      axisPaint..style = PaintingStyle.stroke,
    );

    final dataMin = [...green, ...blue].reduce(math.min);
    final dataMax = [...green, ...blue].reduce(math.max);
    final dataRange = (dataMax - dataMin).abs() < 0.001 ? 1.0 : dataMax - dataMin;

    double toAxisY(double value) => ((value - dataMin) / dataRange) * _axisMax;

    void drawSeries(List<double> points, Color color) {
      if (points.isEmpty) return;
      final path = Path();
      for (var i = 0; i < points.length; i++) {
        final xValue = points.length == 1
            ? 0.0
            : _axisMax * (i / (points.length - 1));
        final p = pointFor(xValue, toAxisY(points[i]));
        if (i == 0) {
          path.moveTo(p.dx, p.dy);
        } else {
          path.lineTo(p.dx, p.dy);
        }
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..strokeJoin = StrokeJoin.round,
      );
    }

    drawSeries(blue, AppColors.phBlue);
    drawSeries(green, AppColors.primary);

    final labelStyle = const TextStyle(
      fontSize: 10,
      color: AppColors.textSecondary,
    );

    for (var i = 0; i <= 9; i++) {
      final text = '$i';
      final tp = TextPainter(
        text: TextSpan(text: text, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      // X labels (bottom)
      final x = pointFor(i.toDouble(), 0).dx - tp.width / 2;
      tp.paint(
        canvas,
        Offset(x, chartOrigin.dy + chartSize.height + 6),
      );

      // Y labels (left)
      final y = pointFor(0, i.toDouble()).dy - tp.height / 2;
      tp.paint(
        canvas,
        Offset(chartOrigin.dx - tp.width - 6, y),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.green != green || oldDelegate.blue != blue;
  }
}
