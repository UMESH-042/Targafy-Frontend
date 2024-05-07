import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CustomText({
    super.key,
    required this.text,
    this.color = Colors.black,
    required this.fontSize,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontFamily: 'Sofia Pro', fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
