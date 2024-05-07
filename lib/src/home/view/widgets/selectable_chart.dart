import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';

class CustomSelectableContainer extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String imagePath;

  const CustomSelectableContainer({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: getScreenWidth(context) * 0.2,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : const Color.fromRGBO(0, 0, 0, 0.16),
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey,
              width: 1,
            ),
          ),
          child: Center(
            child: Image.asset(imagePath),
          ),
        ));
  }
}
