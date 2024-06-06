import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    super.key,
    required this.onTap,
    required this.text,
    this.icon,
    this.currentSortType,
    this.bgColor,
    this.child,
  });

  final Function() onTap;
  final String text;
  final String? currentSortType;
  final IconData? icon;
  final Color? bgColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10),
            color: (currentSortType == text)
                ? primaryColor.withOpacity(0.8)
                : (bgColor != null)
                    ? bgColor
                    : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 9, bottom: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text, style: const TextStyle(color: Colors.white)),
                child ?? const SizedBox.shrink(),
                if (currentSortType == text)
                  Icon(
                    icon,
                    size: 14,
                    color: Colors.white,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
