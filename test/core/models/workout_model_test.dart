import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:p_fit/core/models/workout_model.dart';
import 'package:p_fit/core/utilities/function.dart';

void main() {
  group('Workout Model Tests - with null start Date', () {
    final workoutWithNullStartDate = Workout(
      name: 'Test',
      exerciseList: [],
      percent: 0,
      startDate: null,
    );
    final workoutMapWithNullStartDate = {
      'name': 'Test',
      'exerciseList': [],
      'percent': 0.0,
      'startDate': null,
    };

    final stringjson = json.encode(workoutMapWithNullStartDate);

    test('Workout to map', () {
      final outputMap = workoutWithNullStartDate.toMap();
      expect(outputMap, workoutMapWithNullStartDate);
    });

    test('Workout from map', () {
      final outputMap = Workout.fromMap(workoutMapWithNullStartDate);
      expect(outputMap, workoutWithNullStartDate);
    });

    test('Workout to encodedJson', () {
      final encodedJsonWorkout = workoutWithNullStartDate.toJson();
      expect(encodedJsonWorkout, stringjson);
    });

    test('Workout from encodedJson', () {
      final encodedJsonWorkout = Workout.fromJson(stringjson);
      expect(encodedJsonWorkout, workoutWithNullStartDate);
    });
  });

  group('Workout Model Tests - with start Date', () {
    final workoutWithStartDate = Workout(
      name: 'Test',
      exerciseList: [],
      percent: 0,
      startDate: UtilFunction.getDate(),
    );
    final workoutMapWithStartDate = {
      'name': 'Test',
      'exerciseList': [],
      'percent': 0.0,
      'startDate': UtilFunction.getDate().toString(),
    };

    final stringjson = json.encode(workoutMapWithStartDate);

    test('Workout to map', () {
      final outputMap = workoutWithStartDate.toMap();
      expect(outputMap, workoutMapWithStartDate);
    });

    test('Workout from map', () {
      final outputMap = Workout.fromMap(workoutMapWithStartDate);
      expect(outputMap, workoutWithStartDate);
    });

    test('Workout to encodedJson', () {
      final encodedJsonWorkout = workoutWithStartDate.toJson();
      expect(encodedJsonWorkout, stringjson);
    });

    test('Workout from encodedJson', () {
      final encodedJsonWorkout = Workout.fromJson(stringjson);
      expect(encodedJsonWorkout, workoutWithStartDate);
    });
  });
}
