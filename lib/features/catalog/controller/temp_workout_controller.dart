import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/app_initialization/app_initialization.dart';
import 'package:p_fit/core/common_widgets/messanger_widgets/snackbars.dart';
import 'package:p_fit/core/models/exercise_model.dart';
import 'package:p_fit/core/models/workout_model.dart';
import 'package:p_fit/features/activity/controller/initial_progress_controller.dart';
import 'package:p_fit/features/workout/repository/workout_repo.dart';

final tempWorkoutControllerProvider =
    StateNotifierProvider<TempWorkoutController, Workout?>(
        (ref) => TempWorkoutController(ref: ref, initialState: null));

final tempAutoProgressController =
    StateProvider<bool>((ref) => AppInitialization.getAutoProgressPref());

class TempWorkoutController extends StateNotifier<Workout?> {
  final Ref ref;

  TempWorkoutController({
    required this.ref,
    required Workout? initialState,
  }) : super(
          initialState,
        );

  void updateExerciseCompleteStatus({
    required bool isComplete,
    required int exerciseIndex,
  }) {
    final List<Exercise> updatedList = [];

    for (int i = 0; i < state!.exerciseList.length; i++) {
      if (state!.exerciseList[exerciseIndex].isComplete == true) {
        return;
      }
      if (i == exerciseIndex) {
        final updatedExercise =
            state!.exerciseList[exerciseIndex].copyWith(isComplete: isComplete);

        updatedList.add(updatedExercise);

        continue;
      }
      updatedList.add(state!.exerciseList[i]);
    }
    if (isComplete) {
      //State not updated yet hence +1
      final percent = (getCompletedExercises() + 1) / getTotalExercises();
      // To fix this implementation instead of percent use completeExercises

      state = state?.copyWith(exerciseList: updatedList, percent: percent);
      ref
          .read(initialProgressControllerProvider.notifier)
          .updateTime(state!.exerciseList[exerciseIndex].duration);
    }
  }

  Future<void> loadWorkout(BuildContext context, String workoutName) async {
    final workoutJsonResult =
        await ref.read(workoutRepoProvider).getWorkoutData(workoutName);
    workoutJsonResult.fold(
        (l) => SnackBars.showErrorSnackbar(
            context: context,
            message: 'Failed to load workout'), (workout) async {
      state = workout;
    });
  }

  void resetWorkout() {
    debugPrint("workout reset");
    state = null;
  }

  int getStartPage() {
    final pageIndex = (state!.percent * state!.exerciseList.length).round();
    return pageIndex;
  }

  int getTotalExercises() {
    return state!.exerciseList.length;
  }

  int getCompletedExercises() {
    int completedExercises = 0;
    for (Exercise exercise in state!.exerciseList) {
      if (exercise.isComplete) {
        completedExercises++;
      }
    }
    return completedExercises;
  }
}
