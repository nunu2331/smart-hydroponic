import 'package:flutter/material.dart';
import 'package:smart_hydroponic/mock/mock_data.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';
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
    if (result == null) return;
    setState(() {
      if (result.delete) {
        _schedules.removeAt(index);
      } else if (result.schedule != null) {
        _schedules[index] = result.schedule!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBackHeader(title: 'Pump Schedule'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  for (var i = 0; i < _schedules.length; i++) ...[
                    AppCard(
                      onTap: () => _openUpdateDialog(i),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _schedules[i].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${_schedules[i].startTime} - ${_schedules[i].endTime}',
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _schedules[i].enabled,
                            onChanged: (v) {
                              setState(() => _schedules[i].enabled = v);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _openAddDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Schedule'),
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

class _ScheduleFormResult {
  const _ScheduleFormResult({this.schedule, this.delete = false});

  final MockSchedule? schedule;
  final bool delete;
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Schedule Name',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _name,
              decoration: _fieldDecoration(),
              items: MockData.pumpNames
                  .map(
                    (name) => DropdownMenuItem(value: name, child: Text(name)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _name = value);
              },
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Start Time',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _startController,
                        decoration: _fieldDecoration(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'End Time',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _endController,
                        decoration: _fieldDecoration(),
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
                  child: OutlinedButton(
                    onPressed: _secondary,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.border),
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(widget.secondaryLabel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(widget.confirmLabel),
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
