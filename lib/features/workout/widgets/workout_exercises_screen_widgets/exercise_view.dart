import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:p_fit/core/models/exercise_model.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';
import 'package:p_fit/features/workout/widgets/workout_exercises_screen_widgets/exercise_view_widgets/exercise_timer.dart';
import 'package:p_fit/features/workout/widgets/workout_exercises_screen_widgets/exercise_view_widgets/page_view_navigation_buttons.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({
    super.key,
    required this.exercises,
  });

  final List<Exercise> exercises;

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  final PageController _pageViewController = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  void onNext() {
    _pageViewController.nextPage(
        duration: const Duration(milliseconds: 750), curve: Curves.ease);
  }

  void onBack() {
    _pageViewController.previousPage(
        duration: const Duration(milliseconds: 750), curve: Curves.ease);
  }

  void onTimerComplete(WidgetRef ref, int index) {
    final startPageIndex =
        ref.read(workoutControllerProvider.notifier).getStartPage();
    if (startPageIndex != 0 && index == 0) {
      _pageViewController.jumpToPage(
        startPageIndex,
      );
      return;
    }
    if (ref.read(autoProgressController)) {
      if (index != widget.exercises.length - 1) {
        onNext();
      }
    }
    ref.read(workoutControllerProvider.notifier).updateExerciseCompleteStatus(
          isComplete: true,
          exerciseIndex: index,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageViewController,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Column(
                    children: [
                      Text(
                        widget.exercises[index].name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'Repitions ${widget.exercises[index].repitions}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Consumer(builder: (context, ref, _) {
                        return ExerciseTimer(
                          time: widget.exercises[index].duration,
                          isComplete: ref
                              .read(workoutControllerProvider)
                              .exerciseList[index]
                              .isComplete,
                          onComplete: () => onTimerComplete(ref, index),
                        );
                      }),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child:
                              LottieBuilder.asset('assets/animations/exe.json'),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: widget.exercises.length,
            ),
          ),
          SizedBox(
            height: 70,
            child: PageViewNavigationButtons(
              onBack: onBack,
              onNext: onNext,
              numberOfViews: widget.exercises.length,
              currentIndex:
                  ref.read(workoutControllerProvider.notifier).getStartPage(),
            ),
          )
        ],
      );
    });
  }
}
