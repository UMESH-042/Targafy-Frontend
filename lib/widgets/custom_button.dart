import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButton({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 45,
        width: 240,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(
                primaryColor), // Customize with your desired color
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
