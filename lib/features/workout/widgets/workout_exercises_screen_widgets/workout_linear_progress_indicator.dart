import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/constants/colors.dart';
import 'package:p_fit/core/enums.dart';
import 'package:p_fit/core/models/exercise_model.dart';
import 'package:p_fit/features/catalog/controller/temp_workout_controller.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WorkoutLinearProgressIndicator extends StatelessWidget {
  const WorkoutLinearProgressIndicator({
    super.key,
    required this.exercises,
    required this.forType,
  });

  final List<Exercise> exercises;
  final WorkoutType forType;

  @override
  Widget build(BuildContext context) {
    // debugPrint("Linear Progress built");
    return Consumer(builder: (context, ref, _) {
      final int completeExercises = forType == WorkoutType.main
          ? (ref.watch(
                    workoutControllerProvider.select(
                      (value) => value.percent,
                    ),
                  ) *
                  exercises.length)
              .round()
          : (ref.watch(
                    tempWorkoutControllerProvider.select(
                      (value) => value!.percent,
                    ),
                  ) *
                  exercises.length)
              .round();
      return LinearPercentIndicator(
        lineHeight: 25.0,
        barRadius: const Radius.circular(15),
        animateFromLastPercent: true,
        animation: true,
        animationDuration: 500,
        progressColor: AppColors.linearProgressBarColor,
        percent: completeExercises / exercises.length,
        center: Text(
          'Completed $completeExercises/${exercises.length}',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.progressBarBackgroundColor,
      );
    });
  }
}
