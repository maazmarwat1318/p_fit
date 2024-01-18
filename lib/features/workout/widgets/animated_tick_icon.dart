import 'package:flutter/material.dart';
import 'package:p_fit/core/constants/colors.dart';

class AnimatedTickIcon extends StatelessWidget {
  AnimatedTickIcon({
    super.key,
    required this.isDone,
  });
  final bool isDone;
  final tween = ColorTween(
      begin: AppColors.progressBarBackgroundColor,
      end: AppColors.progressAlternateTextColor);

  @override
  Widget build(BuildContext context) {
    return isDone
        ? TweenAnimationBuilder(
            tween: tween,
            duration: const Duration(
              seconds: 1,
            ),
            builder: (context, value, _) {
              return Icon(
                Icons.check_circle,
                color: value,
              );
            })
        : const Icon(
            Icons.check_circle,
            color: AppColors.progressBarBackgroundColor,
          );
  }
}
