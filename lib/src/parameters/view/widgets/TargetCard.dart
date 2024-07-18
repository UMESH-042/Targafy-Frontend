// import 'package:flutter/material.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/src/parameters/view/model/user_target_model.dart';

// class TargetCard extends StatelessWidget {
//   final User user;

//   const TargetCard({Key? key, required this.user}) : super(key: key);

//   void _showSetTargetDialog(BuildContext context, String userName) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Set Target for $userName'),
//           content: TextField(
//             decoration: const InputDecoration(labelText: 'Target Value'),
//             keyboardType: TextInputType.number,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Set target logic
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Set Target'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   List<String> _getLastThreeMonths() {
//     final now = DateTime.now();
//     final List<String> months = [];
//     for (int i = 0; i < 3; i++) {
//       final date = DateTime(now.year, now.month - i, now.day);
//       months.add('${date.year}-${date.month.toString().padLeft(2, '0')}');
//     }
//     return months;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final months = _getLastThreeMonths();
//     return Card(
//       color: lightblue,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Table(
//               children: [
//                 TableRow(
//                   children: [
//                     const Text('Month'),
//                     const Text('Target'),
//                     const Text('Achievement'),
//                   ],
//                 ),
//                 for (final month in months)
//                   TableRow(
//                     children: [
//                       Text(month),
//                       const Text('0'), // Placeholder for target
//                       const Text('0'), // Placeholder for achievement
//                     ],
//                   ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () {
//                 _showSetTargetDialog(context, user.name);
//               },
//               child: const Text('Set Target'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/src/parameters/view/model/user_target_model.dart';
// import 'package:targafy/src/parameters/view/widgets/small_button.dart';

// class TargetCard extends StatelessWidget {
//   final User user;

//   const TargetCard({Key? key, required this.user}) : super(key: key);

//   void _showSetTargetDialog(BuildContext context, String userName) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Update Target for $userName'),
//           content: TextField(
//             decoration: const InputDecoration(labelText: 'Target Value'),
//             keyboardType: TextInputType.number,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Set target logic
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Update Target'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   List<String> _getLastThreeMonths() {
//     final now = DateTime.now();
//     final List<String> months = [];
//     for (int i = 0; i < 3; i++) {
//       final date = DateTime(now.year, now.month - i, now.day);
//       final monthName =
//           DateFormat.MMMM().format(date); // Using DateFormat to get month name
//       months.add(monthName);
//     }
//     return months;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final months = _getLastThreeMonths();
//     return Card(
//       color: lightblue,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               '${user.name}\'s Data',
//               // style: ,
//             ),
//             const SizedBox(height: 16),
//             Table(
//               border: TableBorder.all(), // Add borders to the table
//               columnWidths: const {
//                 0: FlexColumnWidth(1),
//                 1: FlexColumnWidth(1),
//                 2: FlexColumnWidth(1),
//               },
//               children: [
//                 TableRow(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(child: Text('Month')),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(child: Text('Target')),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(child: Text('Achievement')),
//                     ),
//                   ],
//                 ),
//                 for (final month in months)
//                   TableRow(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Center(child: Text(month)),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child:
//                             Center(child: Text('0')), // Placeholder for target
//                       ),
//                       const Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Center(
//                             child: Text('0')), // Placeholder for achievement
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//             const SizedBox(height: 16), // Increase the spacing for card height
//             Center(
//               child: CustomSmallButton(
//                 title: 'Update Target',
//                 onPressed: () {
//                   _showSetTargetDialog(context, user.name);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/src/parameters/view/model/target_data_model.dart';
// import 'package:targafy/src/parameters/view/model/user_target_model.dart';

// import 'package:targafy/src/parameters/view/widgets/small_button.dart';

// class TargetCard extends ConsumerStatefulWidget {
//   final User user;
//   final List<TargetData> targets; // List of TargetData

//   const TargetCard({
//     Key? key,
//     required this.user,
//     required this.targets,
//   }) : super(key: key);

//   @override
//   ConsumerState<TargetCard> createState() => _TargetCardState();
// }

// class _TargetCardState extends ConsumerState<TargetCard> {
//   @override
//   Widget build(BuildContext context) {
//     print('This the Target:-${widget.targets}');
//     return Card(
//       color: lightblue,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               '${widget.user.name}\'s Data',
//               // style: ,
//             ),
//             const SizedBox(height: 16),
//             Table(
//               border: TableBorder.all(),
//               columnWidths: const {
//                 0: FlexColumnWidth(1),
//                 1: FlexColumnWidth(1),
//                 2: FlexColumnWidth(1),
//               },
//               children: [
//                 TableRow(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(child: Text('Month')),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(child: Text('Target')),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(child: Text('Achievement')),
//                     ),
//                   ],
//                 ),
//                 ...widget.targets
//                     .map((target) => TableRow(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Center(
//                                   child: Text(_getMonthName(target.month))),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Center(
//                                 child: Text(
//                                   target.targetValue.isNotEmpty
//                                       ? target.targetValue.toString()
//                                       : '0',
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Center(
//                                 child: Text(
//                                   target.targetDone.isNotEmpty
//                                       ? target.targetDone
//                                       : '0',
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ))
//                     .toList(),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Center(
//               child: CustomSmallButton(
//                 title: 'Update Target',
//                 onPressed: () {
//                   _showSetTargetDialog(context, widget.user.name);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _getMonthName(String month) {
//     final monthNumber = int.tryParse(month);
//     if (monthNumber != null && monthNumber >= 1 && monthNumber <= 12) {
//       return DateFormat.MMMM().format(DateTime(2000, monthNumber));
//     }
//     return 'Unknown';
//   }

//   void _showSetTargetDialog(BuildContext context, String userName) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Update Target for $userName'),
//           content: TextField(
//             decoration: const InputDecoration(labelText: 'Target Value'),
//             keyboardType: TextInputType.number,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Set target logic
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Update Target'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/src/parameters/view/controller/get_target_controller.dart';
// import 'package:targafy/src/parameters/view/model/target_data_model.dart';
// import 'package:targafy/src/parameters/view/widgets/small_button.dart';

// class TargetCard extends ConsumerStatefulWidget {

//   final String userId;
//   final List<TargetData> targets; // List of TargetData
//   final String parameterName;
//   final String businessId;

//   const TargetCard(
//       {Key? key,
//       required this.userId,
//       required this.targets,
//       required this.parameterName,
//       required this.businessId})
//       : super(key: key);

//   @override
//   ConsumerState<TargetCard> createState() => _TargetCardState();
// }

// class _TargetCardState extends ConsumerState<TargetCard> {
//   @override
//   Widget build(BuildContext context) {
//     print('This the Target:-${widget.targets}');
//     return Card(
//       color: lightblue,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               '${widget.parameterName}\'s Data',
//               // style: ,
//             ),
//             const SizedBox(height: 16),
//             Table(
//               border: TableBorder.all(),
//               columnWidths: const {
//                 0: FlexColumnWidth(1),
//                 1: FlexColumnWidth(1),
//                 2: FlexColumnWidth(1),
//               },
//               children: [
//                 TableRow(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(child: Text('Month')),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(child: Text('Target')),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(child: Text('Achievement')),
//                     ),
//                   ],
//                 ),
//                 ...widget.targets
//                     .map((target) => TableRow(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Center(
//                                   child: Text(_getMonthName(target.month))),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Center(
//                                 child: Text(
//                                   target.targetValue.isNotEmpty
//                                       ? target.targetValue.toString()
//                                       : '0',
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Center(
//                                 child: Text(
//                                   target.targetDone.isNotEmpty
//                                       ? target.targetDone
//                                       : '0',
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ))
//                     .toList(),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Center(
//               child: CustomSmallButton(
//                 title: 'Update Target',
//                 onPressed: () {
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _getMonthName(String month) {
//     final monthNumber = int.tryParse(month);
//     if (monthNumber != null && monthNumber >= 1 && monthNumber <= 12) {
//       return DateFormat.MMMM().format(DateTime(2000, monthNumber));
//     }
//     return 'Unknown';
//   }

// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/src/parameters/view/controller/get_target_controller.dart';
import 'package:targafy/src/parameters/view/model/target_data_model.dart';
import 'package:targafy/src/parameters/view/widgets/small_button.dart';

class TargetCard extends ConsumerStatefulWidget {
  final String userId;
  final List<TargetData> targets; // List of TargetData
  final String parameterName;
  final String businessId;

  const TargetCard(
      {Key? key,
      required this.userId,
      required this.targets,
      required this.parameterName,
      required this.businessId})
      : super(key: key);

  @override
  ConsumerState<TargetCard> createState() => _TargetCardState();
}

class _TargetCardState extends ConsumerState<TargetCard> {
  final TextEditingController _editingController = TextEditingController();
  bool _isEditing = false;
  int _editingRowIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: lightblue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${widget.parameterName}\'s Data',
              // style: ,
            ),
            const SizedBox(height: 16),
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('Month')),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('Achievement')),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('Target')),
                    ),
                  ],
                ),
                ...widget.targets
                    .asMap()
                    .map((index, target) => MapEntry(
                          index,
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(_getMonthName(target.month))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    target.targetDone.isNotEmpty
                                        ? target.targetDone
                                        : '0',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: _isEditing && index == _editingRowIndex
                                      ? TextField(
                                          controller: _editingController,
                                          onChanged: (newValue) {
                                            setState(() {
                                              widget.targets[index]
                                                  .targetValue = newValue;
                                            });
                                          },
                                          onSubmitted: (newValue) {
                                            setState(() {
                                              widget.targets[index]
                                                  .targetValue = newValue;
                                              _isEditing = false;
                                              _editingRowIndex = -1;
                                            });
                                          },
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            if (index == 0) {
                                              setState(() {
                                                _isEditing = true;
                                                _editingRowIndex = index;
                                                _editingController.text =
                                                    target.targetValue;
                                              });
                                            }
                                          },
                                          child: Text(
                                            target.targetValue.isNotEmpty
                                                ? target.targetValue.toString()
                                                : '0',
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .values
                    .toList(),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: CustomSmallButton(
                title: 'Update Target',
                onPressed: () {
                  _updateTarget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(String month) {
    final monthNumber = int.tryParse(month);
    if (monthNumber != null && monthNumber >= 1 && monthNumber <= 12) {
      return DateFormat.MMMM().format(DateTime(2000, monthNumber));
    }
    return 'Unknown';
  }

  void _updateTarget() async {
    try {
      final controller = ref.read(targetDataControllerProvider.notifier);
      final userTargets = {
        'userId': widget.userId,
        'newTargetValue': widget.targets[0].targetValue,
      };

      print(userTargets);
      await controller.updateTarget([userTargets], widget.parameterName,
          DateTime.now().month.toString(), widget.businessId);

      setState(() {
        _isEditing = false;
        _editingRowIndex = -1;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Target updated successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update target: $error')),
      );
    }
  }
}
