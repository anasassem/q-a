import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      required this.label,
      this.fontSize = 18,
      this.color,
      this.fontWeight,
      this.isMath = false})
      : super(key: key);

  final String label;
  final double fontSize;
  final Color? color;
  final bool isMath;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return isMath
        ? Math.tex(
      mathStyle: MathStyle.display,
            label,
            // textAlign: TextAlign.justify,
            textStyle: TextStyle(
              color: color ?? Colors.white,
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.w500,
            ),
          )
        : Text(
            label,
            // textAlign: TextAlign.justify,
            style: TextStyle(
              color: color ?? Colors.white,
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.w500,
            ),
          );
    ;
  }
}
