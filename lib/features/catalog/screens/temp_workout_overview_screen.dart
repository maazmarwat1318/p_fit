import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/constants/spacing.dart';
import 'package:p_fit/features/catalog/controller/temp_workout_controller.dart';
import 'package:p_fit/features/workout/widgets/animated_tick_icon.dart';
import 'package:p_fit/features/workout/widgets/workout_screen_widgets/workout_menu.dart';

class TempWorkoutOverviewScreen extends ConsumerWidget {
  const TempWorkoutOverviewScreen({super.key});

  static const route = "/temp-workout-overview-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.read(tempWorkoutControllerProvider)!.exerciseList;

    return Scaffold(
      appBar: AppBar(
        actions: const [WorkoutMenu()],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Go to Workout",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 25,
              )
            ],
          )),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Spacing.scaffoldPadding),
        child: Column(
          children: [
            Hero(
              tag: ref.read(tempWorkoutControllerProvider)!.name,
              child: Text(ref.read(tempWorkoutControllerProvider)!.name,
                  style: Theme.of(context).textTheme.displaySmall),
            ),
            const SizedBox(height: Spacing.normalWidgetSpacing),
            Text(
              'Exercises',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: Spacing.normalWidgetSpacing),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  final duration = (exercise.duration / 60);
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: const Icon(Icons.run_circle_outlined),
                    title: Text(
                      exercise.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                        'Duration: ${duration.toStringAsFixed(1)} min  Reps: ${exercise.repitions}'),
                    trailing: Consumer(builder: (context, ref, _) {
                      final isDone = ref.watch(
                          tempWorkoutControllerProvider.select((value) =>
                              value!.exerciseList[index].isComplete));
                      return AnimatedTickIcon(
                        isDone: isDone,
                      );
                    }),
                  );
                },
                itemCount: exercises.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}