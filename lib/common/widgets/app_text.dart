import 'package:flutter/material.dart';
import 'package:task_wala/constant/app_colors.dart';

class AppText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color color;
  final double fontSize;
  final TextAlign alignment;
  final int maxLines;
  const AppText(
      {super.key,
      required this.text,
      this.fontWeight = FontWeight.w500,
      this.color = AppColor.blackColor,
      this.fontSize = 15,
      this.alignment = TextAlign.right,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
