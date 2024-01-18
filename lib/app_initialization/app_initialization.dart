import 'package:hive/hive.dart';
import 'package:p_fit/core/constants/hive_boxes.dart';
import 'package:p_fit/core/models/initial_progress.dart';
import 'package:p_fit/core/models/theme_prefference.dart';
import 'package:p_fit/core/models/workout_model.dart';
import 'package:p_fit/core/utilities/function.dart';
import 'package:path_provider/path_provider.dart';

class AppInitialization {
  static Future<void> initializeApp() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    final box = await Hive.openBox(BoxNames.initializationBox);
    if (box.isEmpty) {
      final workoutData =
          await UtilFunction.readJsonFile('workouts/Day_1.json');
      await box.putAll({
        BoxKeys.themeData: ThemePrefference.initial().toJson(),
        BoxKeys.initialProgressData: InitialProgressData.initial().toJson(),
        BoxKeys.workoutData: Workout.initial(workoutData).toJson(),
      });
    }
  }

  static InitialProgressData getInitialProgressData() {
    final data = Hive.box(
      BoxNames.initializationBox,
    ).get(
      BoxKeys.initialProgressData,
    );

    return InitialProgressData.fromJson(data);
  }

  static ThemePrefference getThemeData() {
    final data = Hive.box(
      BoxNames.initializationBox,
    ).get(
      BoxKeys.themeData,
    );
    return ThemePrefference.fromJson(data);
  }

  static Workout getWorkoutData() {
    final data = Hive.box(
      BoxNames.initializationBox,
    ).get(
      BoxKeys.workoutData,
    );
    return Workout.fromJson(data);
  }

  static bool getAutoProgressPref() {
    return false;
  }
}
