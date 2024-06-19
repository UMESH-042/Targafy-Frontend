import 'package:flutter/material.dart';
import 'package:targafy/utils/colors.dart';

class PlainText extends StatelessWidget {
  final String name;
  final TextAlign textAlign;
  final double fontsize;
  final FontWeight fontWeight;
  final Color? color;
  final int? maxLines;
  final TextDecoration? decoration;

  const PlainText({
    super.key,
    required this.name,
    this.fontsize = 16,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines = 3,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}