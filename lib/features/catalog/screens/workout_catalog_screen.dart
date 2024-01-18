import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/common_widgets/messanger_widgets/snackbars.dart';
import 'package:p_fit/core/constants/colors.dart';
import 'package:p_fit/core/constants/spacing.dart';
import 'package:p_fit/features/activity/controller/initial_progress_controller.dart';
import 'package:p_fit/features/catalog/controller/temp_workout_controller.dart';
import 'package:p_fit/features/catalog/screens/temp_workout_overview_screen.dart';

class WorkoutCatalogScreen extends ConsumerWidget {
  const WorkoutCatalogScreen({super.key});
  static const route = '/workout-catalog-screen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalWorkouts =
        ref.read(initialProgressControllerProvider).totalWorkouts;
    final completedWorkouts =
        ref.read(initialProgressControllerProvider).completedWorkouts;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Catalog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.scaffoldPadding),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                if (index >= completedWorkouts) {
                  SnackBars.showSuccessSnackbar(
                      context: context,
                      message: 'To unlock complete the workout first');
                } else {
                  await ref
                      .read(tempWorkoutControllerProvider.notifier)
                      .loadWorkout(context, "Day_${index + 1}");
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamed(
                    TempWorkoutOverviewScreen.route,
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index >= completedWorkouts
                        ? Theme.of(context).colorScheme.surfaceVariant
                        : AppColors.progressAlternateTextColor),
                child: Center(
                    child: Hero(
                  tag: 'Day ${index + 1}',
                  child: Text(
                    'Day ${index + 1}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )),
              ),
            );
          },
          itemCount: totalWorkouts,
        ),
      ),
    );
  }
}
