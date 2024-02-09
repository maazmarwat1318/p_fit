import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/constants/spacing.dart';
import 'package:p_fit/core/enums.dart';
import 'package:p_fit/features/catalog/controller/temp_workout_controller.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';
import 'package:p_fit/features/workout/widgets/workout_exercises_screen_widgets/exercise_view.dart';
import 'package:p_fit/features/workout/widgets/workout_exercises_screen_widgets/workout_linear_progress_indicator.dart';
import 'package:p_fit/features/workout/widgets/workout_title_hero.dart';

class WorkoutExercisesScreen extends ConsumerWidget {
  const WorkoutExercisesScreen({super.key, required this.type});
  final WorkoutType type;
  static const route = '/workout-exercises-screen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("WorkoutExercises Screen build");
    final workout = type == WorkoutType.main
        ? ref.read(workoutControllerProvider)
        : ref.read(tempWorkoutControllerProvider)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.scaffoldPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: WorkoutTitleHero(
                  title: workout.name,
                ),
              ),
              WorkoutLinearProgressIndicator(
                exercises: workout.exerciseList,
                forType: type,
              ),
              Expanded(
                child: ExerciseView(
                    exercises: workout.exerciseList, forType: type),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
