// import 'package:flutter/material.dart';

// class ProgressBarWidget extends StatelessWidget {
//   final String label;
//   final double value;

//   const ProgressBarWidget({
//     Key? key,
//     required this.label,
//     required this.value,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Text(label),
//           SizedBox(width: 8.0),
//           Expanded(
//             child: LinearProgressIndicator(
//               value: value / 100,
//               backgroundColor: Colors.grey[300],
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//             ),
//           ),
//           SizedBox(width: 8.0),
//           Text('${value.toStringAsFixed(1)}%'),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class ProgressBarWidget extends StatelessWidget {
//   final String label;
//   final double value;
//   final Color color;

//   const ProgressBarWidget({
//     Key? key,
//     required this.label,
//     required this.value,
//     required this.color,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0), // Added margin
//       child: Row(
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           SizedBox(width: 8.0),
//           Expanded(
//             child: Container(
//               height: 20, // Increased thickness
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: color,
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: LinearProgressIndicator(
//                   value: value / 100,
//                   backgroundColor: color,
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 8.0),
//           Text(
//             '${value.toStringAsFixed(1)}%',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class ProgressBarWidget extends StatelessWidget {
//   final String label;
//   final double value;
//   final Color color;

//   const ProgressBarWidget({
//     Key? key,
//     required this.label,
//     required this.value,
//     required this.color,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0), // Added margin
//       child: Row(
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           SizedBox(width: 8.0),
//           Expanded(
//             child: Stack(
//               children: [
//                 Container(
//                   height: 20, // Increased thickness
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.grey[300],
//                   ),
//                 ),
//                 Container(
//                   height: 20, // Increased thickness
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: color,
//                   ),
//                   width: (value / 100) * MediaQuery.of(context).size.width,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 8.0),
//           Text(
//             '${value.toStringAsFixed(1)}%',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class ProgressBarWidget extends StatelessWidget {
//   final String label;
//   final double value;
//   final Color color;

//   const ProgressBarWidget({
//     Key? key,
//     required this.label,
//     required this.value,
//     required this.color,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0), // Added margin
//       child: Row(
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           SizedBox(width: 8.0),
//           Expanded(
//             child: Stack(
//               children: [
//                 Container(
//                   height: 20, // Increased thickness
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.grey[300],
//                   ),
//                 ),
//                 Container(
//                   height: 20, // Increased thickness
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: color,
//                   ),
//                   width: (value / 100) * MediaQuery.of(context).size.width,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 8.0),
//           Text(
//             '${value.toStringAsFixed(1)}%',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class ProgressBarWidget extends StatelessWidget {
//   final String label;
//   final int Targetvalue;
//   final int AchievedValue;
//   final Color color;

//   const ProgressBarWidget({
//     Key? key,
//     required this.label,
//     required this.Targetvalue,
//     required this.AchievedValue,
//     required this.color,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print('This is Target Value $Targetvalue');
//     print('This is Achieved Value $AchievedValue');
//     final percentage = (AchievedValue / Targetvalue) * 100;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0), // Added margin
//       child: Row(
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           SizedBox(width: 8.0),
//           Expanded(
//             child: LinearProgressIndicator(
//               value: percentage / 100,
//               backgroundColor: Colors.grey[300],
//               valueColor: AlwaysStoppedAnimation<Color>(color),
//               minHeight: 20, // Increased thickness
//             ),
//           ),
//           SizedBox(width: 8.0),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 '${percentage.toStringAsFixed(1)}%',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 '$AchievedValue / $Targetvalue',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProgressBarWidget extends StatelessWidget {
  final String label;
  final int TargetValue;
  final int AchievedValue;
  final Color color;

  const ProgressBarWidget({
    Key? key,
    required this.label,
    required this.TargetValue,
    required this.AchievedValue,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      if (TargetValue == 0) {
        throw Exception("Target value cannot be zero.");
      }
      
      final percentage = (AchievedValue / TargetValue) * 100;
      
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0), // Added margin
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 20, // Increased thickness
              ),
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '$AchievedValue / $TargetValue',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/empty_list.json',
              height: 200,
              width: 200,
            ),
            const Text(
              "Nothing to display",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
  }
}
