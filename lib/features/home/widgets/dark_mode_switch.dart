import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/themes/theme_manager.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeManagerProvider);

        return SwitchListTile.adaptive(
          contentPadding: const EdgeInsets.all(0),
          title: const Text('Dark Mode'),
          value: themeMode.mode == ThemeMode.dark,
          onChanged: (isDark) {
            ref.read(themeManagerProvider.notifier).changeTheme(isDark);
          },
        );
      },
    );
  }
}
