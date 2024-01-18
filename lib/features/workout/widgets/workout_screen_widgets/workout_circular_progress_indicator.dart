import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/constants/colors.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WorkoutCircularProgressIndicator extends StatelessWidget {
  const WorkoutCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final percent =
          ref.watch(workoutControllerProvider.select((value) => value.percent));

      return CircularPercentIndicator(
        radius: 100,
        animation: true,
        animateFromLastPercent: true,
        animationDuration: 1000,
        percent: percent,
        lineWidth: 10.0,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: AppColors.progressBarBackgroundColor,
        progressColor: AppColors.progressBarColor,
        center: Text(
          '${(percent * 100).round()}%',
          style: const TextStyle(
            color: AppColors.progressAlternateTextColor,
            fontSize: 30,
          ),
        ),
      );
    });
  }
}
