import 'package:flutter/material.dart';

class MaxWidthContainer extends StatelessWidget {
  final double maxWidth;
  final Widget child;

  const MaxWidthContainer(
      {super.key, required this.maxWidth, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > maxWidth) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: child,
            ),
          );
        } else {
          return child;
        }
      },
    );
  }
}
