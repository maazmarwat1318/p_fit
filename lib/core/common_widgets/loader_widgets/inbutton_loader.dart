import 'package:flutter/material.dart';

class InButtonLoader extends StatelessWidget {
  const InButtonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(5),
      child: CircularProgressIndicator(strokeWidth: 3),
    );
  }
}
