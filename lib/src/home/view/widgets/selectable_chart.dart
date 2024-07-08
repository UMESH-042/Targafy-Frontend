import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';

class SelectableChartWidget extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableChartWidget({
    super.key,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:
            const EdgeInsets.symmetric(horizontal: 4.0), // Space between items
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          // color: isSelected
          //     ? primaryColor
          //     : const Color.fromARGB(255, 145, 173, 216),
          color: isSelected
              ? Colors.black
              : Colors.grey[500],
          borderRadius: BorderRadius.circular(20), // Circular rectangle
        ),
        child: Image.asset(
          imagePath,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
