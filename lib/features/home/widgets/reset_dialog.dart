import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/enums.dart';
import 'package:p_fit/features/activity/controller/initial_progress_controller.dart';

class ResetDialog extends ConsumerStatefulWidget {
  const ResetDialog({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResetDialogState();
}

class _ResetDialogState extends ConsumerState<ResetDialog> {
  late TextEditingController _fieldController;
  late GlobalKey<FormFieldState> _fieldKey;
  ResetType _widgetState = ResetType.full;
  @override
  void initState() {
    super.initState();
    _fieldKey = GlobalKey<FormFieldState>();
    _fieldController = TextEditingController();
  }

  @override
  void dispose() {
    _fieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ref.read(initialProgressControllerProvider).completedWorkouts < 1) {
      return AlertDialog(
        title: const Text("Reset Warning!"),
        content: const Text("You haven't completed any workout yet"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'))
        ],
      );
    }
    return AlertDialog(
      title: const Text('Reset Workout!'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
                'This action will reset your progress to ${_widgetState == ResetType.full ? 'Day 1' : 'specified'} and your workout catalog will also be reset'),
            RadioListTile(
              contentPadding: const EdgeInsets.all(0),
              value: ResetType.full,
              groupValue: _widgetState,
              onChanged: (value) {
                setState(() {
                  _widgetState = value!;
                });
              },
              title: const Text('Full reset'),
            ),
            RadioListTile(
              contentPadding: const EdgeInsets.all(0),
              value: ResetType.day,
              groupValue: _widgetState,
              onChanged: (value) {
                setState(() {
                  _widgetState = value!;
                });
              },
              title: const Text('Reset to day'),
            ),
            if (_widgetState == ResetType.day)
              TextFormField(
                key: _fieldKey,
                controller: _fieldController,
                validator: ref
                    .read(initialProgressControllerProvider.notifier)
                    .validateResetPlanField,
                decoration: InputDecoration(
                  label: Text(
                      'Day (max ${ref.read(initialProgressControllerProvider).completedWorkouts})'),
                ),
                keyboardType: TextInputType.number,
              )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Reset',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          onPressed: () async {
            if (_widgetState == ResetType.full) {
              ref
                  .read(initialProgressControllerProvider.notifier)
                  .resetWorkoutPlan(1);
              Navigator.of(context).pop();
            } else {
              if (_fieldKey.currentState!.validate()) {
                ref
                    .read(initialProgressControllerProvider.notifier)
                    .resetWorkoutPlan(int.parse(_fieldController.text));
                Navigator.of(context).pop();
              }
            }
          },
        ),
      ],
    );
  }
}
