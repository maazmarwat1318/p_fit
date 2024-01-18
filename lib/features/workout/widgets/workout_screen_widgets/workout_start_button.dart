import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/audio/audio_manager.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';
import 'package:p_fit/features/workout/screens/workout_exercises_screen.dart';

class WorkoutStartButton extends StatelessWidget {
  const WorkoutStartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("here in start button");
    return Consumer(builder: (context, ref, _) {
      final percent =
          ref.watch(workoutControllerProvider.select((value) => value.percent));
      return FloatingActionButton.extended(
        onPressed: () async {
          ref.read(workoutControllerProvider.notifier).setWorkoutStartDate();
          if (percent == 1) {
            ref.read(workoutControllerProvider.notifier).resetWorkout();
          }
          // TODO: FIx this , link this to buttons in ExerciseView or AUtomate this this problem occurs only when we go back unexpectedly hence use PopScope
          Navigator.of(context)
              .pushNamed(WorkoutExercisesScreen.route)
              .then((value) => ref.read(audioManagerProvider).stopAudio());
        },
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer(builder: (context, ref, _) {
              return Text(
                percent == 1 ? 'Restart Workout' : 'Start Workout',
                style: Theme.of(context).textTheme.titleMedium,
              );
            }),
            const Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 25,
            )
          ],
        ),
      );
    });
  }
}
