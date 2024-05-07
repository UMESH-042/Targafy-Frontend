import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/utils/texts.dart';

class SelectableParameterWidget extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String text;

  const SelectableParameterWidget({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.035) ,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : const Color.fromRGBO(0, 0, 0, 0.16),
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey,
              width: 1,
            ),
          ),
          child: Center(
            child: CustomText(text: text, fontSize: getScreenWidth(context) * 0.035, color: isSelected ? primaryColor : const Color(0xff535353), fontWeight: FontWeight.w400,)
          ),
        ));
  }
}
