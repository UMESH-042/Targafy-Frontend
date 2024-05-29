import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String labelText;
  final double height;
  final double width;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.onChanged,
    required this.labelText,
    this.height = 0.01,
    this.width = 1.8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightOfScreen = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 5),
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: height * heightOfScreen),
        TextField(
          textCapitalization:
              TextCapitalization.sentences, // or TextCapitalization.words
          keyboardType: TextInputType.text,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(14),
            filled: false,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          cursorColor: Colors.black,
          cursorHeight: 22,
          cursorWidth: width,
        ),
        SizedBox(height: height * heightOfScreen * 1.2),
      ],
    );
  }
}