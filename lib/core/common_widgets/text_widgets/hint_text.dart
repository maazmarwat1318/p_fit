import 'package:flutter/material.dart';
import 'package:p_fit/core/common_widgets/text_widgets/center_text_widget.dart';

class HintText extends StatelessWidget {
  const HintText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return CenterText(
      text: text,
      textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).hintColor,
          ),
    );
  }
}
