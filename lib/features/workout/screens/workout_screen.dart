import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/audio/audio_manager.dart';
import 'package:p_fit/core/common_widgets/loader_widgets/loader.dart';

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
      ref.watch(workoutControllerProvider);
      if (ref.read(initialProgressControllerProvider).completedWorkouts ==
          ref.read(initialProgressControllerProvider).totalWorkouts) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ScreenLoader(),
                Text(
                  'Congratulations You have completed your Workout Plan',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }

      if (!ref.read(workoutControllerProvider.notifier).isCorrectWorkout()) {
        Future.delayed(const Duration(seconds: 1), () {
          ref.read(workoutControllerProvider.notifier).loadNextWorkout(context);
        });
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ScreenLoader(),
                Text(
                  'Preparing your workout',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        );
      }
      ref.read(audioManagerProvider).initAudioManager();
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: WorkoutTitleHero(
            title: ref.read(workoutControllerProvider).name,
          ),
          actions: const [WorkoutMenu()],
        ),
        //
        // ignore: prefer_const_constructors, beacuse we want the button to change from state when the screen re appears
        floatingActionButton: const WorkoutStartButton(),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.scaffoldPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WorkoutCircularProgressIndicator(),
              SizedBox(
                height: 12.5,
              ),
              DoneTitle(),
              SizedBox(
                height: 12.5,
              ),
              Expanded(child: ExerciseList()),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }
}
