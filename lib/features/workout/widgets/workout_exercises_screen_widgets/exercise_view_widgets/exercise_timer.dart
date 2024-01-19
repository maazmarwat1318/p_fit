import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/audio/audio_manager.dart';
import 'package:p_fit/core/constants/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExerciseTimer extends ConsumerStatefulWidget {
  const ExerciseTimer(
      {super.key,
      required this.isComplete,
      required this.onComplete,
      required this.time});
  final bool isComplete;
  final Function onComplete;
  final int time;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExerciseTimerState();
}

class _ExerciseTimerState extends ConsumerState<ExerciseTimer> {
  int currentTime = -5;
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (!widget.isComplete) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
        setState(() {
          currentTime += 1;
        });
        if (currentTime == 0) {
          ref.read(audioManagerProvider).playAudio(AudioManager.startBeep);
        }
        if (currentTime == -4) {
          ref.read(audioManagerProvider).playAudio(AudioManager.startCount3);
        }
        if (currentTime == widget.time) {
          ref.read(audioManagerProvider).playAudio(AudioManager.stopBeep);
          Future.delayed(
              const Duration(microseconds: 0), () => widget.onComplete());
          _timer!.cancel();
        }
      });
    } else {
      Future.delayed(const Duration(seconds: 0), () => widget.onComplete());
      setState(() {
        currentTime = widget.time;
      });

      _timer = null;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Timer Built");
    return RepaintBoundary(
      child: CircularPercentIndicator(
        radius: 60,
        progressColor: AppColors.progressAlternateTextColor,
        animation: true,
        animateFromLastPercent: true,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: AppColors.progressBarBackgroundColor,
        percent: currentTime < 0 ? 0 : currentTime / widget.time,
        center: Text(
          getTimeString(
            widget.time,
            currentTime,
            widget.isComplete,
          ),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: currentTime < 0
                    ? AppColors.progressAlternateTextColor
                    : AppColors.progressTextColor,
                fontSize: currentTime < 0 ? 20 : null,
              ),
        ),
      ),
    );
  }
}

String getTimeString(int totalTime, int currentTime, bool isComplete) {
  if (currentTime == totalTime || isComplete) {
    return 'Complete';
  }
  int remainingTime = totalTime - currentTime;
  if (currentTime < 0) {
    return 'Starting\nin ${-(currentTime)}s';
  }
  if (remainingTime > 60) {
    int remainingTimeMin = (remainingTime / 60).ceil();
    return '$remainingTimeMin min';
  }

  return '${remainingTime}s';
}
