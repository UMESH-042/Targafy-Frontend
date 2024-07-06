import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomInputField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: primaryColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
