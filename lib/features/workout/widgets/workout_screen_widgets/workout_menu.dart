import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/constants/spacing.dart';
import 'package:p_fit/features/workout/controller/workout_controller.dart';

class WorkoutMenu extends StatelessWidget {
  const WorkoutMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
              enabled: false,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        height: 50,
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                'Auto Progress',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                width: Spacing.inputFieldsSpace * 2,
                              )
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 5,
                        top: 0,
                        child: Tooltip(
                          message:
                              'Turn on if you want workout to progress automatically through exercises',
                          child: Icon(Icons.help),
                        ),
                      )
                    ],
                  ),
                  Consumer(builder: (context, ref, _) {
                    return Switch(
                        value: ref.watch(autoProgressController),
                        onChanged: (val) {
                          ref
                              .read(autoProgressController.notifier)
                              .update((state) => val);
                        });
                  }),
                ],
              ))
        ];
      },
      icon: const Icon(Icons.settings),
    );
  }
}
