import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenLoader extends StatelessWidget {
  const ScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      "assets/animations/loading_animation.json",
      height: 150,
      width: 150,
    );
  }
}
