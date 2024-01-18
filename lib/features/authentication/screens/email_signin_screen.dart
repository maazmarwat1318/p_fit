import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/common_widgets/loader_widgets/inbutton_loader.dart';
import 'package:p_fit/core/common_widgets/text_widgets/hint_text.dart';
import 'package:p_fit/core/common_widgets/text_widgets/tapable_text.dart';
import 'package:p_fit/core/constants/spacing.dart';
import 'package:p_fit/features/authentication/controller/auth_controller.dart';
import 'package:p_fit/features/authentication/screens/forgot_password_screen.dart';

class EmailSignInScreen extends ConsumerStatefulWidget {
  const EmailSignInScreen({super.key});
  static const route = '/email-signin';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmailSignInScreenState();
}

class _EmailSignInScreenState extends ConsumerState<EmailSignInScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _pwdController;
  late GlobalKey<FormState> _formState;
  bool newSignIn = true;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _pwdController = TextEditingController();
    _formState = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  void signIn() {
    final valid = _formState.currentState!.validate();
    if (valid) {
      if (newSignIn) {
        ref.read(authControllerProvider.notifier).signInNewEmail(
              context: context,
              email: _emailController.text,
              password: _pwdController.text,
              name: _nameController.text,
            );
      } else {
        ref.read(authControllerProvider.notifier).signInExistingEmail(
              context: context,
              email: _emailController.text,
              password: _pwdController.text,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (_, currentUser) {
      if (currentUser != null) {
        Navigator.of(context).pop();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: newSignIn
            ? const Text('Sign up using Email')
            : const Text('Sign in using Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.scaffoldPadding),
        child: Column(
          children: [
            Hero(
              tag: 'main_logo',
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset('assets/logos/logo.png'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (newSignIn)
                        TextFormField(
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          validator: (value) => ref
                              .read(authControllerProvider.notifier)
                              .validateName(value),
                          decoration: const InputDecoration(hintText: 'Name'),
                        ),
                      const SizedBox(
                        height: Spacing.inputFieldsSpace,
                      ),
                      TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        validator: (value) => ref
                            .read(authControllerProvider.notifier)
                            .validateEmail(value),
                        decoration: const InputDecoration(hintText: 'Email'),
                      ),
                      const SizedBox(
                        height: Spacing.inputFieldsSpace,
                      ),
                      TextFormField(
                        controller: _pwdController,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => signIn(),
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) => ref
                            .read(authControllerProvider.notifier)
                            .validatePassword(value),
                        decoration: const InputDecoration(hintText: 'Password'),
                      ),
                      const SizedBox(
                        height: Spacing.inputFieldsSpace,
                      ),
                      if (newSignIn)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const HintText(text: 'Already have an account'),
                            const SizedBox(
                              width: Spacing.inputFieldsSpace,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    newSignIn = false;
                                  });
                                },
                                child: const TapableText(text: 'Sign in'))
                          ],
                        ),
                      if (!newSignIn)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const HintText(text: 'Forgot your password'),
                            const SizedBox(
                              width: Spacing.inputFieldsSpace,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  ForgotPasswordScreen.route,
                                );
                              },
                              child: const TapableText(text: 'Recover'),
                            )
                          ],
                        ),
                      const SizedBox(
                        height: Spacing.inputFieldsSpace,
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final isLoading =
                              ref.watch(signingLoadingStateProvider);
                          return ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              signIn();
                            },
                            child: isLoading
                                ? const InButtonLoader()
                                : newSignIn
                                    ? const Text('Sign Up')
                                    : const Text('Sign In'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
