import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:p_fit/core/constants/hive_boxes.dart';
import 'package:p_fit/core/models/initial_progress.dart';

final initialProgressRepoProvider = Provider((ref) => InitialProgressRepo());

class InitialProgressRepo {
  void saveData(InitialProgressData data) async {
    await Hive.box(BoxNames.initializationBox).put(
      BoxKeys.initialProgressData,
      data.toJson(),
    );
  }
}
