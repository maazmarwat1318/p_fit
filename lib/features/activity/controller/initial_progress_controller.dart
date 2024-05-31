import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/app_initialization/app_initialization.dart';
import 'package:p_fit/core/models/initial_progress.dart';
import 'package:p_fit/core/models/workout_model.dart';
import 'package:p_fit/core/utilities/function.dart';
import 'package:p_fit/features/activity/repository/initial_progress_repo.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';
import 'package:p_fit/features/workout/repository/workout_repo.dart';

final initialProgressControllerProvider =
    StateNotifierProvider<InitialProgressController, InitialProgressData>(
  (ref) => InitialProgressController(ref: ref),
);

class InitialProgressController extends StateNotifier<InitialProgressData> {
  final Ref ref;
  InitialProgressController({required this.ref})
      : super(
          AppInitialization.getInitialProgressData(),
        );
  void updateTime(int seconds) async {
    state = state.copyWith(
        totalTimeSpentSeconds: state.totalTimeSpentSeconds + seconds);
    ref.read(initialProgressRepoProvider).saveData(state);
  }

  void updateProgress(int value) async {
    if (state.completedWorkouts + value < 0) {
      value = 0;
    }
    state = state.copyWith(completedWorkouts: state.completedWorkouts + value);
    ref.read(initialProgressRepoProvider).saveData(state);
  }

  void resetWorkoutPlan(int day) async {
    final workoutData =
        await UtilFunction.readJsonFile('workouts/Day_$day.json');
    Workout workout = Workout.fromJson(workoutData)
        .copyWith(startDate: UtilFunction.getDate());
    updateProgress(-day);
    ref.read(workoutRepoProvider).saveWorkoutData(workout);
    ref.read(workoutControllerProvider.notifier).state = workout;
  }

  String? validateResetPlanField(String? value) {
    if (value == null || value.length == 0) {
      return "Enter a valid day";
    }
    final day = int.tryParse(value);
    if (day == null) {
      return "Enter a valid day number";
    }
    if (day < 1 || day > state.completedWorkouts) {
      return "You only have completed ${state.completedWorkouts} workout(s)";
    }
    return null;
  }
}
