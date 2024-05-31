import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/models/exercise_model.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';
import 'package:p_fit/features/workout/widgets/animated_tick_icon.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final List<Exercise> exercises =
          ref.read(workoutControllerProvider).exerciseList;

      return ListView.builder(
        itemBuilder: (context, index) {
          return Consumer(builder: (context, ref, _) {
            final exercise = exercises[index];
            final duration = (exercise.duration / 60);

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: const Icon(Icons.run_circle_outlined),
              title: Text(
                exercise.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                  'Duration: ${duration.toStringAsFixed(1)} min  Reps: ${exercise.repitions}'),
              trailing: Consumer(builder: (context, ref, _) {
                final isDone = ref.watch(workoutControllerProvider
                    .select((value) => value.exerciseList[index].isComplete));
                return AnimatedTickIcon(
                  isDone: isDone,
                );
              }),
            );
          });
        },
        itemCount: exercises.length,
      );
    });
  }
}
