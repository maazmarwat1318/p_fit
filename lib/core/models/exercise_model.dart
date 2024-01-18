import 'dart:convert';

enum ExerciseType {
  repitionExercise,
  durationExercise,
}

class Exercise {
  final String name;
  final ExerciseType exerciseType;
  final int duration;
  final int repitions;
  final bool isComplete;
  Exercise({
    required this.name,
    required this.exerciseType,
    required this.duration,
    required this.repitions,
    this.isComplete = false,
  });

  Exercise copyWith({
    String? name,
    ExerciseType? exerciseType,
    int? duration,
    int? repitions,
    bool? isComplete,
  }) {
    return Exercise(
      name: name ?? this.name,
      exerciseType: exerciseType ?? this.exerciseType,
      duration: duration ?? this.duration,
      repitions: repitions ?? this.repitions,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exerciseType': exerciseType.name,
      'duration': duration,
      'repitions': repitions,
      'isComplete': isComplete,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'] ?? '',
      exerciseType: ExerciseType.values.firstWhere(
        (element) => element.name == map['exerciseType'],
      ),
      duration: map['duration']?.toInt() ?? 0,
      repitions: map['repitions']?.toInt() ?? 0,
      isComplete: map['isComplete'] ?? false,
    );
  }

  factory Exercise.fromJson(String source) =>
      Exercise.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Exercise(name: $name, exerciseType: $exerciseType, duration: $duration, repitions: $repitions, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Exercise &&
        other.name == name &&
        other.exerciseType == exerciseType &&
        other.duration == duration &&
        other.repitions == repitions &&
        other.isComplete == isComplete;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        exerciseType.hashCode ^
        duration.hashCode ^
        repitions.hashCode ^
        isComplete.hashCode;
  }

  String toJson() => json.encode(toMap());
}
