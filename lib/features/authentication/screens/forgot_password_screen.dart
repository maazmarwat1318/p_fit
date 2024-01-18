import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:p_fit/core/common_widgets/loader_widgets/inbutton_loader.dart';
import 'package:p_fit/core/common_widgets/text_widgets/center_text_widget.dart';
import 'package:p_fit/core/constants/spacing.dart';
import 'package:p_fit/features/authentication/controller/auth_controller.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const route = '/forgot-password';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  late TextEditingController _emailController;
  late GlobalKey<FormState> _formState;
  @override
  void initState() {
    _emailController = TextEditingController();
    _formState = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void sendRecoveryEmail() {
    if (_formState.currentState!.validate()) {
      ref
          .read(authControllerProvider.notifier)
          .sendPasswordRecoveryEmail(context, _emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.scaffoldPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: Spacing.inputFieldsSpace,
            ),
            Form(
              key: _formState,
              child: TextFormField(
                controller: _emailController,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) => sendRecoveryEmail(),
                validator: (value) => ref
                    .read(authControllerProvider.notifier)
                    .validateEmail(value),
                decoration: const InputDecoration(hintText: 'Email'),
              ),
            ),
            const SizedBox(
              height: Spacing.inputFieldsSpace,
            ),
            const CenterText(
              text:
                  'An email with reset password link will be sent on this email address with in 3 minutes',
            ),
            const SizedBox(
              height: Spacing.inputFieldsSpace,
            ),
            Consumer(
              builder: (context, ref, child) {
                final isLoading = ref.watch(signingLoadingStateProvider);
                return ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    sendRecoveryEmail();
                  },
                  child: isLoading
                      ? const InButtonLoader()
                      : const Text('Send Recovery Mail'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
