import 'dart:convert';

class InitialProgressData {
  final int completedWorkouts;
  final int totalWorkouts;

  final int totalTimeSpentSeconds;

  InitialProgressData({
    required this.completedWorkouts,
    required this.totalWorkouts,
    required this.totalTimeSpentSeconds,
  });

  InitialProgressData copyWith({
    int? completedWorkouts,
    int? totalWorkouts,
    int? totalTimeSpentSeconds,
  }) {
    return InitialProgressData(
      completedWorkouts: completedWorkouts ?? this.completedWorkouts,
      totalWorkouts: totalWorkouts ?? this.totalWorkouts,
      totalTimeSpentSeconds:
          totalTimeSpentSeconds ?? this.totalTimeSpentSeconds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'completedWorkouts': completedWorkouts,
      'totalWorkouts': totalWorkouts,
      'totalTimeSpentSeconds': totalTimeSpentSeconds,
    };
  }

  factory InitialProgressData.fromMap(Map<String, dynamic> map) {
    return InitialProgressData(
      completedWorkouts: map['completedWorkouts']?.toInt() ?? 0,
      totalWorkouts: map['totalWorkouts']?.toInt() ?? 0,
      totalTimeSpentSeconds: map['totalTimeSpentSeconds']?.toInt() ?? 0,
    );
  }

  factory InitialProgressData.initial() {
    return InitialProgressData(
      completedWorkouts: 0,
      totalWorkouts: 7,
      totalTimeSpentSeconds: 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory InitialProgressData.fromJson(String source) =>
      InitialProgressData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InitialProgressData(completedWorkouts: $completedWorkouts, totalWorkouts: $totalWorkouts, totalTimeSpentSeconds: $totalTimeSpentSeconds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InitialProgressData &&
        other.completedWorkouts == completedWorkouts &&
        other.totalWorkouts == totalWorkouts &&
        other.totalTimeSpentSeconds == totalTimeSpentSeconds;
  }

  @override
  int get hashCode {
    return completedWorkouts.hashCode ^
        totalWorkouts.hashCode ^
        totalTimeSpentSeconds.hashCode;
  }
}
