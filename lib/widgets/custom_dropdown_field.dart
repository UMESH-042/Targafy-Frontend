import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';

class CustomDropdownField extends StatelessWidget {
  final String labelText;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final String? value;

  const CustomDropdownField({
    Key? key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items,
      onChanged: onChanged,
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
    );
  }
}
