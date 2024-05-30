import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final double height;
  const CustomTextField({
    this.obscure = false,
    required this.controller,
    required this.label,
    this.height = 0.04,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getScreenWidth(context) * 0.05,
        vertical: getScreenWidth(context) * 0.04,
      ).copyWith(bottom: 0),
      child: SizedBox(
        height: getScreenheight(context) * widget.height ,
        child: TextField(
          obscureText: widget.obscure,
          controller: widget.controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: getScreenWidth(context) * 0.0, left: getScreenWidth(context) * 0.02),
            hintText: widget.label,
            hintStyle: TextStyle(color: const Color(0xff787878), fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.035),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
