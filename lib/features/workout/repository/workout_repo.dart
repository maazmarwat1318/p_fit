import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:p_fit/core/constants/hive_boxes.dart';
import 'package:p_fit/core/models/workout_model.dart';
import 'package:p_fit/core/utilities/error.dart';
import 'package:p_fit/core/utilities/function.dart';

final workoutRepoProvider = Provider<WorkoutRepo>((ref) {
  return WorkoutRepo();
});

class WorkoutRepo {
  Future<Either<Failure, void>> saveWorkoutData(Workout workout) async {
    try {
      await Hive.box(BoxNames.initializationBox)
          .put(BoxKeys.workoutData, workout.toJson());
      return const Right(null);
    } catch (_) {
      return Left(Failure(message: 'Failed to save workout progress'));
    }
  }

  Future<Either<Failure, Workout>> getWorkoutData(String name) async {
    try {
      final workoutJson =
          await UtilFunction.readJsonFile('workouts/$name.json');

      return Right(Workout.fromJson(workoutJson));
    } catch (_) {
      return Left(Failure(message: 'Failed to get next workout'));
    }
  }
}
