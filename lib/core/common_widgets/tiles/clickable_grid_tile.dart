import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p_fit/core/common_widgets/text_widgets/single_line_text.dart';

class ClickableGridTile extends StatelessWidget {
  const ClickableGridTile(
      {super.key,
      required this.text,
      required this.onTap,
      required this.color});
  final String text;
  final Color color;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final scrrenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: kElevationToShadow[3],
        ),
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: SignleLineText(
                    text: text,
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18 + (scrrenWidth * 0.01)),
                  ),
                ),
                const FaIcon(FontAwesomeIcons.circleArrowRight)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
