// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/widgets/custom_button.dart';
// import '../controller/sub_office_controller.dart';

// final subOfficeProvider = Provider<SubOfficeController>((ref) {
//   return SubOfficeController();
// });

// class NextPage2 extends ConsumerStatefulWidget {
//   final Map<String, dynamic> response;

//   const NextPage2({
//     required this.response,
//   });

//   @override
//   _NextPage2State createState() => _NextPage2State();
// }

// class _NextPage2State extends ConsumerState<NextPage2> {
//   List<FieldData> fieldDataList = [];
//   List<String> dropdownOptions = [];
//   bool _isProcessing = false; // Track if the operation is in progress

//   @override
//   void initState() {
//     super.initState();
//     final businessName = widget.response['data']['business']['name'];
//     dropdownOptions.add(businessName);
//     fieldDataList.add(FieldData(text: '', dropdownValue: businessName));
//   }

//   void _addField() {
//     setState(() {
//       fieldDataList
//           .add(FieldData(text: '', dropdownValue: dropdownOptions.first));
//     });
//   }

//   void _onOkPressed() {
//     setState(() {
//       // Update dropdown options with the new text values
//       for (var field in fieldDataList) {
//         if (!dropdownOptions.contains(field.text)) {
//           dropdownOptions.add(field.text);
//         }
//       }
//     });

//     // Print the structured data to the console (or store it as needed)
//     var officesArray = fieldDataList
//         .map((field) => [field.text, field.dropdownValue])
//         .toList();
//     print({'officesArray': officesArray});
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Data Added')),
//     );
//   }

//   Future<void> _onDonePressed(BuildContext context) async {
//     if (_isProcessing) return; // Do nothing if already processing

//     setState(() {
//       _isProcessing = true; // Set processing to true to disable the button
//     });

//     var officesArray = fieldDataList
//         .map((field) => [field.text, field.dropdownValue])
//         .toList();
//     final _id = widget.response['data']['business']['_id'];

//     try {
//       await ref.read(subOfficeProvider).createSubOffices(_id, officesArray);
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Success'),
//             content: Text('Sub-offices created successfully'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   // Navigator.pushAndRemoveUntil(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => BottomNavigationAndAppBar(
//                   //       token: bearerToken,
//                   //     ),
//                   //   ),
//                   //   (route) => false,
//                   // );
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to create sub-offices: $e')),
//       );
//     } finally {
//       setState(() {
//         _isProcessing = false; // Set processing to false to enable the button
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Offices'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: fieldDataList.length,
//                 itemBuilder: (context, index) {
//                   return Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           onChanged: (value) {
//                             setState(() {
//                               fieldDataList[index].text = value;
//                             });
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Enter text',
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: DropdownButton<String>(
//                           value: fieldDataList[index].dropdownValue,
//                           onChanged: (value) {
//                             setState(() {
//                               fieldDataList[index].dropdownValue = value!;
//                             });
//                           },
//                           items: dropdownOptions.map((String option) {
//                             return DropdownMenuItem<String>(
//                               value: option,
//                               child: Text(option),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       IconButton(
//                         icon: Icon(Icons.add),
//                         onPressed: () {
//                           setState(() {
//                             fieldDataList.add(FieldData(
//                                 text: '',
//                                 dropdownValue: dropdownOptions.first));
//                           });
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CustomButton(
//                   onPressed: _onOkPressed,
//                   buttonText: 'OK',
//                 ),
//                 // ElevatedButton(
//                 //   onPressed:
//                 //       _isProcessing ? null : () => _onDonePressed(context),
//                 //   child: Text('Done'),
//                 // ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 _isProcessing
//                     ? CircularProgressIndicator() // Show a loading indicator instead of the button when processing
//                     : CustomButton(
//                         buttonText: 'Done',
//                         onPressed: () => _onDonePressed(context),
//                       ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FieldData {
//   String text;
//   String dropdownValue;

//   FieldData({required this.text, required this.dropdownValue});
// }
