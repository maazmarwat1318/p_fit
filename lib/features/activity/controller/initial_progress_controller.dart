import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/app_initialization/app_initialization.dart';
import 'package:p_fit/core/models/initial_progress.dart';
import 'package:p_fit/features/activity/repository/initial_progress_repo.dart';

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
}
