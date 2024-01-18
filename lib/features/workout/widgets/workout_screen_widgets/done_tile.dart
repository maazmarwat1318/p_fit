import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/constants/colors.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';

class DoneTitle extends StatelessWidget {
  const DoneTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final status = ref.watch(workoutControllerProvider).percent;
      final isLate = ref.read(workoutControllerProvider.notifier).isLate();

      return Center(
        child: Text(
          status == 1
              ? 'Your are done for today, come back tomorrow'
              : isLate == 0
                  ? 'Your workout is ready'
                  : 'You missed your workout by $isLate day(s), your workout is reset',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: status == 1
                    ? AppColors.progressAlternateTextColor
                    : isLate != 0
                        ? Colors.redAccent
                        : AppColors.progressAlternateTextColor,
              ),
        ),
      );
    });
  }
}
