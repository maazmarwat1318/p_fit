import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:p_fit/core/models/workout_model.dart';
import 'package:p_fit/core/utilities/function.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';

import 'workout_controller_test.mocks.dart';

@GenerateMocks([Ref])
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final json = await UtilFunction.readJsonFile('workouts/Day_1.json');

  group('isLate function Test', () {
    final workout = Workout.fromJson(json);

    final controller = WorkoutController(
      ref: MockRef(),
      initialState: workout,
    );

    test('Late Test - Should return null', () {
      final result = controller.isLate();
      expect(result, null);
    });

    test('Late Test - Should return null', () {
      final result = controller.isLate();
      expect(result, null);
    });

    test('Late Test - Should return string', () {
      const daysLate = 3;
      final todayDate = UtilFunction.getDate();
      final lateDate = todayDate.add(
        const Duration(
          days: daysLate,
        ),
      );
      controller.state = controller.state.copyWith(startDate: lateDate);

      final result = controller.isLate();
      expect(result, daysLate.toString());
    });
  });

  group('isCorrectWorkout function Test', () {
    final workout = Workout.fromJson(json);

    final controller = WorkoutController(
      ref: MockRef(),
      initialState: workout,
    );

    test('isCorrectWorkout for startdate null - Should return true', () {
      final result = controller.isCorrectWorkout();
      expect(result, true);
    });

    test(
        'isCorrectWorkout for startdate today and workout complete - Should return true',
        () {
      final todayDate = UtilFunction.getDate();

      controller.state =
          controller.state.copyWith(startDate: todayDate, percent: 1);
      final result = controller.isCorrectWorkout();
      expect(result, true);
    });

    test(
        'isCorrectWorkout for startdate today and workout incomplete - Should return true',
        () {
      final todayDate = UtilFunction.getDate();

      controller.state =
          controller.state.copyWith(startDate: todayDate, percent: 0.4);

      final result = controller.isCorrectWorkout();
      expect(result, true);
    });

    test(
        'isCorrectWorkout for startdate late and workout complete - Should return false',
        () {
      const daysLate = 3;
      final todayDate = UtilFunction.getDate();
      final lateDate = todayDate.subtract(
        const Duration(
          days: daysLate,
        ),
      );
      controller.state =
          controller.state.copyWith(startDate: lateDate, percent: 1);

      final result = controller.isCorrectWorkout();
      expect(result, false);
    });

    test(
        'isCorrectWorkout for startdate late and workout incomplete - Should return true',
        () {
      const daysLate = 3;
      final todayDate = UtilFunction.getDate();
      final lateDate = todayDate.subtract(
        const Duration(
          days: daysLate,
        ),
      );
      controller.state =
          controller.state.copyWith(startDate: lateDate, percent: 0.4);

      final result = controller.isCorrectWorkout();
      expect(result, true);
    });
  });
}
