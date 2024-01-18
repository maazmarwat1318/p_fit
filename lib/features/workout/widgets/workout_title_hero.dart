import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';

class WorkoutTitleHero extends StatelessWidget {
  const WorkoutTitleHero({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'title',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          child: Consumer(builder: (context, ref, _) {
            final workoutName = ref
                .read(workoutControllerProvider.select((value) => value.name));
            return Text(workoutName,
                style: Theme.of(context).textTheme.displaySmall);
          }),
        ),
      ),
    );
  }
}
