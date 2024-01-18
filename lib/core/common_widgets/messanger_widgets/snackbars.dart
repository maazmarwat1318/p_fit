import 'package:flutter/material.dart';

class SnackBars {
  static showErrorSnackbar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  static showSuccessSnackbar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
      ),
    );
  }
}
