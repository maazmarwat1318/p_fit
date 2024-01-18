import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:p_fit/app_initialization/app_initialization.dart';
import 'package:p_fit/core/constants/hive_boxes.dart';
import 'package:p_fit/core/models/theme_prefference.dart';

final themeManagerProvider =
    StateNotifierProvider<ThemePrefferenceController, ThemePrefference>(
  (ref) => ThemePrefferenceController(ref: ref),
);

class ThemePrefferenceController extends StateNotifier<ThemePrefference> {
  final Ref ref;
  ThemePrefferenceController({required this.ref})
      : super(
          AppInitialization.getThemeData(),
        );

  void changeTheme(bool isDark) {
    if (isDark) {
      state = state.copyWith(mode: ThemeMode.dark);
    } else {
      state = state.copyWith(mode: ThemeMode.light);
    }
    saveData();
  }

  void saveData() async {
    await Hive.box(BoxNames.initializationBox).put(
      BoxKeys.themeData,
      state.toJson(),
    );
  }
}
