import 'package:flutter/material.dart';

class SignleLineText extends StatelessWidget {
  const SignleLineText({super.key, required this.text, this.textStyle});
  final String text;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
