import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/common_widgets/text_widgets/single_line_text.dart';
import 'package:p_fit/core/constants/colors.dart';
import 'package:p_fit/features/activity/controller/initial_progress_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressIndicators extends StatelessWidget {
  const ProgressIndicators({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: kElevationToShadow[4],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SignleLineText(
                    text: 'Progress',
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final completedWorkouts = ref.watch(
                      initialProgressControllerProvider.select(
                        (value) => value.completedWorkouts,
                      ),
                    );
                    final totalWorkouts = ref.watch(
                      initialProgressControllerProvider.select(
                        (value) => value.totalWorkouts,
                      ),
                    );

                    return CircularPercentIndicator(
                      radius: 70,
                      animation: true,
                      animationDuration: 1000,
                      lineWidth: 10.0,
                      percent: completedWorkouts / totalWorkouts,
                      backgroundColor: AppColors.progressBarBackgroundColor,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: AppColors.progressBarColor,
                      center: RichText(
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: '$completedWorkouts',
                          style: const TextStyle(
                            color: AppColors.progressTextColor,
                            fontSize: 25,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' / $totalWorkouts',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            TextSpan(
                              text: '\nWorkouts',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SignleLineText(
                  text: 'Time Spent',
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                height: 140,
                width: 140,
                child: Consumer(
                  builder: (context, ref, child) {
                    final int totalSeconds = ref.watch(
                      initialProgressControllerProvider.select(
                        (value) => value.totalTimeSpentSeconds,
                      ),
                    );
                    final int hoursSpent = (totalSeconds ~/ 3600);
                    final int minutesSpent =
                        ((totalSeconds % 3600) / 60).round();

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '$hoursSpent',
                            style: const TextStyle(
                              fontSize: 40,
                              color: AppColors.progressTextColor,
                            ),
                            children: const [
                              TextSpan(
                                text: ' Hr.',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: AppColors.progressAlternateTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: '$minutesSpent',
                            style: const TextStyle(
                              fontSize: 30,
                              color: AppColors.progressTextColor,
                            ),
                            children: const [
                              TextSpan(
                                text: ' min.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.progressAlternateTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
