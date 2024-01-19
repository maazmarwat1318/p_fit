import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/app_initialization/app_initialization.dart';
import 'package:p_fit/core/common_widgets/messanger_widgets/snackbars.dart';
import 'package:p_fit/core/models/exercise_model.dart';
import 'package:p_fit/core/models/workout_model.dart';
import 'package:p_fit/core/utilities/function.dart';
import 'package:p_fit/features/activity/controller/initial_progress_controller.dart';
import 'package:p_fit/features/workout/repository/workout_repo.dart';

final workoutControllerProvider =
    StateNotifierProvider<WorkoutController, Workout>(
  (ref) => WorkoutController(
    ref: ref,
    initialState: AppInitialization.getWorkoutData(),
  ),
);

final autoProgressController =
    StateProvider<bool>((ref) => AppInitialization.getAutoProgressPref());

class WorkoutController extends StateNotifier<Workout> {
  final Ref ref;

  WorkoutController({
    required this.ref,
    required Workout initialState,
  }) : super(
          initialState,
        );

  void updateExerciseCompleteStatus({
    required bool isComplete,
    required int exerciseIndex,
  }) {
    final List<Exercise> updatedList = [];

    for (int i = 0; i < state.exerciseList.length; i++) {
      if (state.exerciseList[exerciseIndex].isComplete == true) {
        return;
      }
      if (i == exerciseIndex) {
        final updatedExercise =
            state.exerciseList[exerciseIndex].copyWith(isComplete: isComplete);

        updatedList.add(updatedExercise);

        continue;
      }
      updatedList.add(state.exerciseList[i]);
    }
    if (isComplete) {
      final percent = state.percent + (1 / updatedList.length);

      state = state.copyWith(
          exerciseList: updatedList,
          percent: percent >= 0.99
              ? 1.0
              : percent <= 1.0
                  ? percent
                  : 1.0);
      ref
          .read(initialProgressControllerProvider.notifier)
          .updateTime(state.exerciseList[exerciseIndex].duration);
      if (state.percent == 1.0) {
        ref.read(initialProgressControllerProvider.notifier).updateProgress(1);
      }
    }
    saveWorkoutState();
  }

  void saveWorkoutState() async {
    final result = await ref.read(workoutRepoProvider).saveWorkoutData(state);
    result.fold(
      (l) => null,
      (r) => null,
    );
  }

  bool isCorrectWorkout() {
    if (state.startDate == null) {
      return true;
    }
    final latebyDays = isLate();
    if (latebyDays > 0 && state.percent != 1) {
      Future.delayed(const Duration(microseconds: 0), () => resetWorkout());
      return true;
    } else if (latebyDays == 0) {
      return true;
    } else {
      return false;
    }
  }

  void resetWorkout() {
    final List<Exercise> updatedList = [];

    if (state.percent == 1.0) {
      ref.read(initialProgressControllerProvider.notifier).updateProgress(-1);
    }
    if (state.percent == 0.0) {
      return;
    }
    for (int i = 0; i < state.exerciseList.length; i++) {
      updatedList.add(state.exerciseList[i].copyWith(isComplete: false));
    }
    state = state.copyWith(exerciseList: updatedList, percent: 0.0);
    saveWorkoutState();
  }

  void loadNextWorkout(BuildContext context) async {
    final nextWorkoutNumber = int.parse(state.name[state.name.length - 1]);
    final nextWorkoutName = 'Day_${nextWorkoutNumber + 1}';
    final workoutJsonResult =
        await ref.read(workoutRepoProvider).getWorkoutData(nextWorkoutName);
    workoutJsonResult.fold(
        (l) => SnackBars.showErrorSnackbar(
            context: context,
            message: 'Failed to load workout'), (workout) async {
      if (workout.name != "Day 1") {
        //TOD) : check if this fix works
        state = workout.copyWith(
            startDate: state.startDate?.add(const Duration(days: 1)));
      } else {
        state = workout;
      }
      saveWorkoutState();
    });
  }

  void setWorkoutStartDate() {
    // To fix
    state = state.copyWith(startDate: UtilFunction.getDate());
  }

  int isLate() {
    if (state.startDate == null) {
      return 0;
    } else if (state.startDate != UtilFunction.getDate()) {
      final difference = -(state.startDate!.difference(UtilFunction.getDate()));
      return difference.inDays;
    } else {
      return 0;
    }
  }

  int getStartPage() {
    final pageIndex = (state.percent * state.exerciseList.length).round();
    return pageIndex;
  }

  //TODO: remove these methods as they are for testing purposes only
  // void setLateWorkoutStartDate() {
  //   // To fix
  //   final lateDate = UtilFunction.getDate().subtract(const Duration(days: 1));
  //   state = state.copyWith(startDate: lateDate);
  // }

  // void setTodayStartDate() {
  //   // To fix
  //   final lateDate = UtilFunction.getDate().subtract(const Duration(days: 1));
  //   state = state.copyWith(startDate: lateDate);
  // }
}
