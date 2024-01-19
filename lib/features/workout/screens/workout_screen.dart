import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:p_fit/core/constants/spacing.dart';
import 'package:p_fit/features/activity/controller/initial_progress_controller.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';

import 'package:p_fit/features/workout/widgets/workout_screen_widgets/done_tile.dart';
import 'package:p_fit/features/workout/widgets/workout_screen_widgets/exercise_list.dart';
import 'package:p_fit/features/workout/widgets/workout_screen_widgets/workout_circular_progress_indicator.dart';
import 'package:p_fit/features/workout/widgets/workout_screen_widgets/workout_menu.dart';
import 'package:p_fit/features/workout/widgets/workout_screen_widgets/workout_start_button.dart';
import 'package:p_fit/features/workout/widgets/workout_title_hero.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});
  static const route = '/workout-screen';
  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      if (ref.read(initialProgressControllerProvider).completedWorkouts ==
          ref.read(initialProgressControllerProvider).totalWorkouts) {
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text('Congratulations You have completed your Workout Plan'),
              ],
            ),
          ),
        );
      }

      if (!ref.read(workoutControllerProvider.notifier).isCorrectWorkout()) {
        ref.read(workoutControllerProvider.notifier).loadNextWorkout(context);
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text('Preparing your workout'),
              ],
            ),
          ),
        );
      }
      //TODO: Make sure this works or not
      // ref.read(audioManagerProvider).initAudioManager();
      return Scaffold(
        appBar: AppBar(
          actions: const [WorkoutMenu()],
        ),
        //
        // ignore: prefer_const_constructors, beacuse we want the button to change from state when the screen re appears
        floatingActionButton: const WorkoutStartButton(),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Spacing.scaffoldPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WorkoutTitleHero(
                title: ref.read(workoutControllerProvider).name,
              ),
              const WorkoutCircularProgressIndicator(),
              const SizedBox(
                height: 12.5,
              ),
              const DoneTitle(),
              const SizedBox(
                height: 12.5,
              ),
              const Expanded(child: ExerciseList()),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }
}
