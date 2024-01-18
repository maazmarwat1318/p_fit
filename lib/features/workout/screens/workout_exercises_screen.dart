import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/constants/spacing.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';
import 'package:p_fit/features/workout/widgets/workout_exercises_screen_widgets/exercise_view.dart';
import 'package:p_fit/features/workout/widgets/workout_exercises_screen_widgets/workout_linear_progress_indicator.dart';
import 'package:p_fit/features/workout/widgets/workout_title_hero.dart';

class WorkoutExercisesScreen extends ConsumerWidget {
  const WorkoutExercisesScreen({super.key});
  static const route = '/workout-exercises-screen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.read(workoutControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.scaffoldPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: WorkoutTitleHero(),
              ),
              WorkoutLinearProgressIndicator(exercises: exercises.exerciseList),
              Expanded(
                child: ExerciseView(exercises: exercises.exerciseList),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
