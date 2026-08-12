import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_hydroponic/mock/mock_data.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';
import 'package:smart_hydroponic/theme/app_fonts.dart';
import 'package:smart_hydroponic/widgets/common_widgets.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late List<MockSchedule> _schedules;

  @override
  void initState() {
    super.initState();
    _schedules = MockData.initialSchedules();
  }

  Future<void> _openAddDialog() async {
    final result = await showDialog<MockSchedule>(
      context: context,
      builder: (_) => _ScheduleFormDialog(
        title: 'Add Schedule',
        confirmLabel: 'Save Schedule',
        secondaryLabel: 'Cancel',
        isUpdate: false,
        initial: MockSchedule(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: MockData.pumpNames.first,
          startTime: '06.00',
          endTime: '08.00',
        ),
      ),
    );
    if (result != null) {
      setState(() => _schedules.add(result));
    }
  }

  Future<void> _openUpdateDialog(int index) async {
    final current = _schedules[index];
    final result = await showDialog<_ScheduleFormResult>(
      context: context,
      builder: (_) => _ScheduleFormDialog(
        title: 'Add Schedule',
        confirmLabel: 'Update',
        secondaryLabel: 'Delete',
        isUpdate: true,
        initial: MockSchedule(
          id: current.id,
          name: current.name,
          startTime: current.startTime,
          endTime: current.endTime,
          enabled: current.enabled,
        ),
      ),
    );
    if (result == null || !mounted) return;

    if (result.delete) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => const _DeleteConfirmDialog(),
      );
      if (confirmed == true && mounted) {
        setState(() => _schedules.removeAt(index));
      }
      return;
    }

    if (result.schedule != null) {
      setState(() => _schedules[index] = result.schedule!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBackHeader(
                title: 'Pump Schedule',
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                  for (var i = 0; i < _schedules.length; i++) ...[
                    AppCard(
                      onTap: () => _openUpdateDialog(i),
                      color: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _schedules[i].name,
                                  style: AppFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  '${_schedules[i].startTime} - ${_schedules[i].endTime}',
                                  style: AppFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Switch(
                                value: _schedules[i].enabled,
                                onChanged: (v) {
                                  setState(() => _schedules[i].enabled = v);
                                },
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                  const SizedBox(height: 15),
                  OutlinedButton.icon(
                    onPressed: _openAddDialog,
                    icon: SvgPicture.asset(
                      'assets/icons/ic_plus.svg',
                      width: 14,
                      height: 14,
                    ),
                    label: Text(
                      'Add Schedule',
                      style: AppFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      textStyle: AppFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}

class _ScheduleFormResult {
  const _ScheduleFormResult({this.schedule, this.delete = false});

  final MockSchedule? schedule;
  final bool delete;
}

class _DeleteConfirmDialog extends StatelessWidget {
  const _DeleteConfirmDialog();

  static const _btnPadding = EdgeInsets.symmetric(
    horizontal: 7.83,
    vertical: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure want to delete?',
              textAlign: TextAlign.center,
              style: AppFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      backgroundColor: AppColors.white,
                      side: const BorderSide(color: AppColors.border),
                      padding: _btnPadding,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'No',
                      style: AppFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.danger,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      padding: _btnPadding,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Yes',
                      style: AppFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleFormDialog extends StatefulWidget {
  const _ScheduleFormDialog({
    required this.title,
    required this.confirmLabel,
    required this.secondaryLabel,
    required this.isUpdate,
    required this.initial,
  });

  final String title;
  final String confirmLabel;
  final String secondaryLabel;
  final bool isUpdate;
  final MockSchedule initial;

  @override
  State<_ScheduleFormDialog> createState() => _ScheduleFormDialogState();
}

class _ScheduleFormDialogState extends State<_ScheduleFormDialog> {
  late String _name;
  late TextEditingController _startController;
  late TextEditingController _endController;

  @override
  void initState() {
    super.initState();
    _name = widget.initial.name;
    _startController = TextEditingController(text: widget.initial.startTime);
    _endController = TextEditingController(text: widget.initial.endTime);
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.white,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }

  void _submit() {
    final schedule = MockSchedule(
      id: widget.initial.id,
      name: _name,
      startTime: _startController.text.trim(),
      endTime: _endController.text.trim(),
      enabled: widget.initial.enabled,
    );
    if (widget.isUpdate) {
      Navigator.of(context).pop(_ScheduleFormResult(schedule: schedule));
    } else {
      Navigator.of(context).pop(schedule);
    }
  }

  void _secondary() {
    if (widget.isUpdate) {
      Navigator.of(context).pop(const _ScheduleFormResult(delete: true));
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),

            Text(
              widget.title,
              style: AppFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 26),
            Text(
              'Schedule Name',
              style: AppFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 18),
            DropdownButtonFormField<String>(
              initialValue: _name,
              isDense: true,
              style: AppFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
              decoration: _fieldDecoration(),
              dropdownColor: AppColors.white,
              icon: SvgPicture.asset(
                'assets/icons/ic_arrow_down.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
              iconEnabledColor: AppColors.textPrimary,
              iconDisabledColor: AppColors.textPrimary,
              focusColor: Colors.transparent,
              items: MockData.pumpNames
                  .map(
                    (name) => DropdownMenuItem(
                      value: name,
                      child: Text(
                        name,
                        style: AppFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _name = value);
              },
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Time',
                        style: AppFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 17),
                      TextField(
                        controller: _startController,
                        textAlign: TextAlign.center,
                        style: AppFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                        decoration: _fieldDecoration().copyWith(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End Time',
                        style: AppFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 17),
                      TextField(
                        controller: _endController,
                        textAlign: TextAlign.center,
                        style: AppFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                        decoration: _fieldDecoration().copyWith(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: widget.isUpdate
                      ? ElevatedButton(
                          onPressed: _secondary,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.danger,
                            foregroundColor: AppColors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7.83,
                              vertical: 10,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            textStyle: AppFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            widget.secondaryLabel,
                            style: AppFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: _secondary,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: const BorderSide(color: AppColors.border),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7.83,
                              vertical: 10,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            textStyle: AppFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            widget.secondaryLabel,
                            style: AppFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7.83,
                        vertical: 10,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: AppFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      widget.confirmLabel,
                      style: AppFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
