import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:p_fit/core/models/exercise_model.dart';

class Workout {
  final String name;
  final List<Exercise> exerciseList;
  final double percent;
  final DateTime? startDate;
  Workout({
    required this.name,
    required this.exerciseList,
    required this.percent,
    this.startDate,
  });

  Workout copyWith(
      {String? name,
      List<Exercise>? exerciseList,
      double? percent,
      DateTime? startDate}) {
    return Workout(
      name: name ?? this.name,
      exerciseList: exerciseList ?? this.exerciseList,
      percent: percent ?? this.percent,
      startDate: startDate ?? this.startDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exerciseList': exerciseList.map((x) => x.toMap()).toList(),
      'percent': percent,
      'startDate': startDate?.toString(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      name: map['name'] ?? '',
      exerciseList: List<Exercise>.from(
          map['exerciseList']?.map((x) => Exercise.fromMap(x))),
      percent: map['percent']?.toDouble() ?? 0.0,
      startDate:
          map['startDate'] == null ? null : DateTime.parse(map['startDate']),
    );
  }

  factory Workout.initial(String json) {
    return Workout.fromJson(json).copyWith(startDate: null);
  }

  String toJson() => json.encode(toMap());

  factory Workout.fromJson(String source) =>
      Workout.fromMap(json.decode(source));

  @override
  String toString() =>
      'Workout(name: $name, exerciseList: $exerciseList, percent: $percent)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Workout &&
        other.name == name &&
        listEquals(other.exerciseList, exerciseList) &&
        other.percent == percent &&
        other.startDate == startDate;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      exerciseList.hashCode ^
      percent.hashCode ^
      startDate.hashCode;
}
