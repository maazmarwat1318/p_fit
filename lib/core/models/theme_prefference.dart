import 'dart:convert';

import 'package:flutter/material.dart';

class ThemePrefference {
  final ThemeMode mode;
  ThemePrefference({
    required this.mode,
  });

  ThemePrefference copyWith({
    ThemeMode? mode,
  }) {
    return ThemePrefference(
      mode: mode ?? this.mode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mode': mode.name,
    };
  }

  factory ThemePrefference.fromMap(Map<String, dynamic> map) {
    return ThemePrefference(
      mode: ThemeMode.values.firstWhere(
        (element) => element.name == map['mode'],
      ),
    );
  }

  factory ThemePrefference.initial() {
    return ThemePrefference(
      mode: ThemeMode.dark,
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemePrefference.fromJson(String source) =>
      ThemePrefference.fromMap(json.decode(source));

  @override
  String toString() => 'ThemePrefference(mode: $mode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThemePrefference && other.mode == mode;
  }

  @override
  int get hashCode => mode.hashCode;
}
