// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final ValueChanged<String>? onChanged;
//   final String labelText;
//   final double height;
//   final double width;

//   const CustomTextField({
//     super.key,
//     required this.controller,
//     this.onChanged,
//     required this.labelText,
//     this.height = 0.01,
//     this.width = 1.8,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double heightOfScreen = MediaQuery.of(context).size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(width: 5),
//         Text(
//           labelText,
//           style: const TextStyle(
//             color: Colors.black,
//             fontFamily: "Poppins",
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//           textAlign: TextAlign.left,
//         ),
//         SizedBox(height: height * heightOfScreen),
//         TextField(
//           textCapitalization:
//               TextCapitalization.sentences, // or TextCapitalization.words
//           keyboardType: TextInputType.text,
//           controller: controller,
//           onChanged: onChanged,
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.all(14),
//             filled: false,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(11),
//               borderSide: const BorderSide(color: Colors.grey),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(11),
//               borderSide: const BorderSide(color: Colors.grey),
//             ),
//           ),
//           cursorColor: Colors.black,
//           cursorHeight: 22,
//           cursorWidth: width,
//         ),
//         SizedBox(height: height * heightOfScreen * 1.2),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class CustomTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final ValueChanged<String>? onChanged;
//   final String labelText;
//   final double height;
//   final double width;

//   const CustomTextField({
//     super.key,
//     required this.controller,
//     this.onChanged,
//     required this.labelText,
//     this.height = 0.01,
//     this.width = 1.8,
//   });

//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   @override
//   Widget build(BuildContext context) {
//     double heightOfScreen = MediaQuery.of(context).size.height;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(width: 5),
//         Text(
//           widget.labelText,
//           style: const TextStyle(
//             color: Colors.black,
//             fontFamily: "Poppins",
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//           textAlign: TextAlign.left,
//         ),
//         SizedBox(height: widget.height * heightOfScreen),
//         TextField(
//           textCapitalization: TextCapitalization.sentences,
//           keyboardType: TextInputType.text,
//           controller: widget.controller,
//           onChanged: widget.onChanged,
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.all(14),
//             filled: false,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(11),
//               borderSide: const BorderSide(color: Colors.grey),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(11),
//               borderSide: const BorderSide(color: Colors.grey),
//             ),
//           ),
//           cursorColor: Colors.black,
//           cursorHeight: 22,
//           cursorWidth: widget.width,
//         ),
//         SizedBox(height: widget.height * heightOfScreen * 1.2),
//       ],
//     );
//   }
// }
