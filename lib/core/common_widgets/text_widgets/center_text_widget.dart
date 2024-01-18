import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  const CenterText({super.key, required this.text, this.textStyle});
  final String text;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    );
  }
}
