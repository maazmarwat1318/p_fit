import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/core/common_widgets/messanger_widgets/snackbars.dart';
import 'package:p_fit/features/authentication/repository/auth_repo.dart';

enum AuthStates { signedOut, signedIn }

final signingLoadingStateProvider = StateProvider<bool>(
  (ref) => false,
);

final authControllerProvider =
    StateNotifierProvider<AuthController, User?>((ref) {
  return AuthController(ref: ref);
});

class AuthController extends StateNotifier<User?> {
  final Ref ref;
  AuthController({required this.ref})
      : super(FirebaseAuth.instance.currentUser);

  void signInGoogle({required BuildContext context}) async {
    final result = await ref.read(authRepoProvider).signInWithGoogle();
    result.fold(
      (l) => SnackBars.showErrorSnackbar(context: context, message: l.message),
      (r) => state = FirebaseAuth.instance.currentUser,
    );
  }

  void signInExistingEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    ref.read(signingLoadingStateProvider.notifier).update((state) => true);
    final result = await ref.read(authRepoProvider).signInWithEmailAndPassword(
          email: email,
          password: password,
        );
    ref.read(signingLoadingStateProvider.notifier).update((state) => false);
    result.fold(
      (l) => SnackBars.showErrorSnackbar(context: context, message: l.message),
      (r) => state = FirebaseAuth.instance.currentUser,
    );
  }

  void signInNewEmail({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    ref.read(signingLoadingStateProvider.notifier).update((state) => true);
    final result =
        await ref.read(authRepoProvider).signInWithNewEmailAndPassword(
              email: email,
              password: password,
              name: name,
            );
    ref.read(signingLoadingStateProvider.notifier).update((state) => false);
    result.fold(
      (l) => SnackBars.showErrorSnackbar(context: context, message: l.message),
      //Doing this due the updateDisplayName it does not update the credentials but the currentUser object, hence this fix
      (r) => state = FirebaseAuth.instance.currentUser,
    );
  }

  void signOut(BuildContext context) async {
    final result = await ref.read(authRepoProvider).signUserOut();
    result.fold(
        (l) => SnackBars.showErrorSnackbar(
              context: context,
              message: l.message,
            ),
        (r) => state = null);
  }

  void sendPasswordRecoveryEmail(
    BuildContext context,
    String email,
  ) async {
    ref.read(signingLoadingStateProvider.notifier).update((state) => true);
    final result = await ref.read(authRepoProvider).sendPasswordRecoveryEmail(
          email: email,
        );
    ref.read(signingLoadingStateProvider.notifier).update((state) => false);
    result.fold(
      (l) => SnackBars.showErrorSnackbar(context: context, message: l.message),
      //Doing this due the updateDisplayName it does not update the credentials but the currentUser object, hence this fix
      (r) {
        Navigator.of(context).pop();
        SnackBars.showSuccessSnackbar(
          context: context,
          message: 'Recovery Email sent Successfuly',
        );
      },
    );
  }

  String? validateEmail(String? email) {
    if (email == null) {
      return 'Provide an email';
    } else if (email.length < 5 || !email.contains('@')) {
      return 'Provide a valid email';
    } else {
      return null;
    }
  }

  String? validatePassword(String? pwd) {
    if (pwd == null) {
      return 'Provide a password';
    } else if (pwd.length < 7) {
      return 'Password must have atleast 7 characters';
    } else {
      return null;
    }
  }

  String? validateName(String? name) {
    if (name == null) {
      return 'Provide a name';
    } else if (name.length < 3) {
      return 'Provide a valid name';
    } else {
      return null;
    }
  }
}
