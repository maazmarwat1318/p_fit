import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p_fit/core/constants/spacing.dart';
import 'package:p_fit/features/authentication/controller/auth_controller.dart';
import 'package:p_fit/features/home/widgets/dark_mode_switch.dart';
import 'package:p_fit/features/home/widgets/reset_dialog.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayName = ref.read(authControllerProvider)!.displayName!;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.scaffoldPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                backgroundImage: AssetImage('assets/logos/logo.png'),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              displayName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    onTap: () {
                      _showResetAlertDialog(context);
                    },
                    title: const Text('Reset Progress'),
                    leading: const FaIcon(FontAwesomeIcons.trash),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    onTap: () {
                      ref
                          .read(authControllerProvider.notifier)
                          .signOut(context);
                    },
                    title: const Text('Sign Out'),
                    leading:
                        const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
                  ),
                  const DarkModeSwitch(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _showResetAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const ResetDialog();
    },
  );
}
