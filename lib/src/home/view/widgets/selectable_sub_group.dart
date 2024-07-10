import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';

class SelectableSubGroupWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  

  const SelectableSubGroupWidget({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0), // Space between items
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : const Color.fromARGB(255, 145, 173, 216),
          borderRadius: BorderRadius.circular(20), // Circular rectangle
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black, // Change text color based on isSelected
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
