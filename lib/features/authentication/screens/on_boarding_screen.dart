import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p_fit/core/constants/spacing.dart';
import 'package:p_fit/features/authentication/controller/auth_controller.dart';
import 'package:p_fit/features/authentication/screens/email_signin_screen.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({super.key});
  static const route = '/onboarding';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(Spacing.scaffoldPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 250,
              width: 250,
              child: Hero(
                tag: 'main_logo',
                child: Image.asset('assets/logos/board_logo.png'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EmailSignInScreen.route,
                );
              },
              icon: const Icon(Icons.email),
              label: const Text(
                'Sign up using Email',
              ),
            ),
            const SizedBox(
              height: Spacing.inputFieldsSpace,
            ),
            ElevatedButton.icon(
              onPressed: () {
                ref
                    .read(authControllerProvider.notifier)
                    .signInGoogle(context: context);
              },
              icon: const FaIcon(FontAwesomeIcons.google),
              label: const Text(
                'Sign in with Google',
              ),
            ),
            const SizedBox(
              height: Spacing.inputFieldsSpace,
            ),
          ],
        ),
      )),
    );
  }
}
