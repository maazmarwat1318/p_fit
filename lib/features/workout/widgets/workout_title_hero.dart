import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutTitleHero extends StatelessWidget {
  const WorkoutTitleHero({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'title',
      child: Consumer(builder: (context, ref, _) {
        return Text(title,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25));
      }),
    );
  }
}
