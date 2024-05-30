// import 'package:flutter/material.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';

// class SelectableChartWidget extends StatelessWidget {
//   final bool isSelected;
//   final VoidCallback onTap;
//   final String imagePath;

//   const SelectableChartWidget({
//     super.key,
//     required this.isSelected,
//     required this.onTap,
//     required this.imagePath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           width: getScreenWidth(context) * 0.2,
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.white : const Color.fromRGBO(0, 0, 0, 0.16),
//             border: Border.all(
//               color: isSelected ? primaryColor : Colors.grey,
//               width: 1,
//             ),
//           ),
//           child: Center(
//             child: Image.asset(imagePath),
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';

class SelectableChartWidget extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableChartWidget({
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0), // Space between items
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor: const Color.fromARGB(255, 74, 142, 243),
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
