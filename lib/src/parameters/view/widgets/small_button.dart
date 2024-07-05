import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';

class CustomSmallButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomSmallButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
     style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? const CircularProgressIndicator() : Text(title),
    );
  }
}





class SmallButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;

  const SmallButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width = 100,  // Default width
    this.height = 40,  // Default height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,  // Adjust font size if needed
          ),
        ),
      ),
    );
  }
}
