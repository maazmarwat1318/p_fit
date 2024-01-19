import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/constants/colors.dart';
import 'package:p_fit/core/enums.dart';
import 'package:p_fit/features/catalog/controller/temp_workout_controller.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';

class PageViewNavigationButtons extends StatefulWidget {
  const PageViewNavigationButtons({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.numberOfViews,
    required this.currentIndex,
    required this.forType,
  });
  final void Function() onNext;
  final void Function() onBack;
  final int numberOfViews;
  final int currentIndex;
  final WorkoutType forType;

  @override
  State<PageViewNavigationButtons> createState() =>
      _PageViewNavigationButtonsState();
}

class _PageViewNavigationButtonsState extends State<PageViewNavigationButtons> {
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  void onBack() {
    widget.onBack();
    setState(() {
      currentIndex -= 1;
    });
  }

  @override
  void didUpdateWidget(covariant PageViewNavigationButtons oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    currentIndex = widget.currentIndex;
  }

  void onNext() {
    widget.onNext();
    setState(() {
      currentIndex += 1;
    });
  }

  void onFinish(WidgetRef ref) {
    Navigator.of(context).pop();
  }

  onLeave(WidgetRef ref) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Page Navs Built");
    return Consumer(builder: (context, ref, _) {
      if (ref.read(autoProgressController)) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () => onFinish(ref),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        minimumSize: const Size(120, 50),
                      ),
                      child: Text(
                        'Exit',
                        style: Theme.of(context).textTheme.titleLarge,
                      ))),
            ],
          ),
        );
      }
      final isComplete = widget.forType == WorkoutType.main
          ? ref.watch(workoutControllerProvider
              .select((value) => value.exerciseList[currentIndex].isComplete))
          : ref.watch(tempWorkoutControllerProvider
              .select((value) => value!.exerciseList[currentIndex].isComplete));

      return Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 50),
                  backgroundColor: currentIndex != 0 ? null : Colors.redAccent),
              onPressed: isComplete
                  ? currentIndex != 0
                      ? onBack
                      : () => onLeave(ref)
                  : null,
              child: Text(
                currentIndex != 0 ? 'Back' : 'Leave',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 50),
                  backgroundColor: currentIndex != widget.numberOfViews - 1
                      ? null
                      : AppColors.progressAlternateTextColor),
              onPressed: isComplete
                  ? currentIndex != widget.numberOfViews - 1
                      ? onNext
                      : () => onFinish(ref)
                  : null,
              child: Text(
                currentIndex != widget.numberOfViews - 1 ? 'Next' : 'Finish',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      );
    });
  }
}
