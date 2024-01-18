import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:p_fit/core/models/workout_model.dart';
import 'package:p_fit/core/utilities/error.dart';
import 'package:p_fit/core/utilities/function.dart';
import 'package:p_fit/features/workout/repository/workout_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final workoutJson = await UtilFunction.readJsonFile('workouts/Day_1.json');
  final workout = Workout.fromJson(workoutJson);
  final repo = WorkoutRepo();
  group('Get workout data test', () {
    test('Valid name test', () async {
      final result = await repo.getWorkoutData('Day_1');
      result.fold((l) => fail('Unexpected value'), (r) => expect(r, workout));
    });

    test('Invalid name test', () async {
      final result = await repo.getWorkoutData('error');
      result.fold((l) => expect(l, const TypeMatcher<Failure>()),
          (r) => fail('Unexpected value'));
    });
  });
}
