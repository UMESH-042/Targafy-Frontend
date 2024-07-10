// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/src/parameters/view/model/user_target_model.dart';
// import 'package:targafy/widgets/submit_button.dart';
// import '../controller/Add_target_controller.dart';

// class ParameterTargetScreen extends ConsumerStatefulWidget {
//   final String parameterName;
//   final String businessId;
//   final VoidCallback onDataAdded;

//   const ParameterTargetScreen({
//     super.key,
//     required this.parameterName,
//     required this.businessId,
//     required this.onDataAdded,
//   });

//   @override
//   ConsumerState<ParameterTargetScreen> createState() =>
//       _ParameterTargetScreenState();
// }

// class _ParameterTargetScreenState extends ConsumerState<ParameterTargetScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _targetValueController = TextEditingController();
//   final TextEditingController _commentController = TextEditingController();
//   List<String> selectedUserIds = [];
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     ref
//         .read(userProvider.notifier)
//         .fetchUsers(widget.parameterName, widget.businessId);
//   }

//   void _clearFields() {
//     _formKey.currentState?.reset();
//     _targetValueController.clear();
//     _commentController.clear();
//     setState(() {
//       selectedUserIds.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final users = ref.watch(userProvider);
//     final targetState = ref.watch(targetProvider);

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CustomBackButton(text: '${widget.parameterName} Parameter'),
//             const SizedBox(height: 16),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _targetValueController,
//                     decoration:
//                         const InputDecoration(labelText: 'Target Value'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a target value';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _commentController,
//                     decoration: const InputDecoration(labelText: 'Comment'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a comment';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   users.when(
//                     data: (userList) {
//                       return DropdownButtonFormField<String>(
//                         items: userList.map((user) {
//                           return DropdownMenuItem<String>(
//                             value: user.userId,
//                             child: Text(user.name),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           if (value != null &&
//                               !selectedUserIds.contains(value)) {
//                             setState(() {
//                               selectedUserIds.add(value);
//                             });
//                           }
//                         },
//                         decoration:
//                             const InputDecoration(labelText: 'Assign Users'),
//                       );
//                     },
//                     loading: () => const CircularProgressIndicator(),
//                     error: (error, stackTrace) =>
//                         Text('Failed to load users: $error'),
//                   ),
//                   Wrap(
//                     children: selectedUserIds.map((userId) {
//                       return Chip(
//                         label: Text(users.when(
//                           data: (userList) => userList
//                               .firstWhere((user) => user.userId == userId)
//                               .name,
//                           loading: () => '',
//                           error: (error, stackTrace) => '',
//                         )),
//                         onDeleted: () {
//                           setState(() {
//                             selectedUserIds.remove(userId);
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 16),
//                   isLoading
//                       ? const CircularProgressIndicator()
//                       : SubmitButton(
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               setState(() {
//                                 isLoading = true;
//                               });
//                               final target = Target(
//                                 targetValue: _targetValueController.text,
//                                 paramName: widget.parameterName,
//                                 comment: _commentController.text,
//                                 userIds: selectedUserIds,
//                               );
//                               try {
//                                 await ref
//                                     .read(targetProvider.notifier)
//                                     .addTarget(target, widget.businessId);
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content:
//                                           Text('Target added successfully')),
//                                 );
//                                 widget.onDataAdded();
//                                 Navigator.pop(context, true);
//                               } catch (error) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content:
//                                           Text('Failed to add target: $error')),
//                                 );
//                                 _clearFields();
//                               } finally {
//                                 setState(() {
//                                   isLoading = false;
//                                 });
//                               }
//                             }
//                           },
//                           // child: const Text('Add Target'),
//                         ),
//                 ],
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
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/widgets/submit_button.dart';
// import '../controller/Add_target_controller.dart';

// class ParameterTargetScreen extends ConsumerStatefulWidget {
//   final String parameterName;
//   final String businessId;
//   final VoidCallback onDataAdded;

//   const ParameterTargetScreen({
//     super.key,
//     required this.parameterName,
//     required this.businessId,
//     required this.onDataAdded,
//   });

//   @override
//   ConsumerState<ParameterTargetScreen> createState() =>
//       _ParameterTargetScreenState();
// }

// class _ParameterTargetScreenState extends ConsumerState<ParameterTargetScreen> {
//   final _formKey = GlobalKey<FormState>();
//   List<String> selectedUserIds = [];
//   bool isLoading = false;
//   bool allSelected = false;

//   @override
//   void initState() {
//     super.initState();
//     ref
//         .read(userProvider.notifier)
//         .fetchUsers(widget.parameterName, widget.businessId);
//   }

//   void _clearFields() {
//     _formKey.currentState?.reset();
//     setState(() {
//       selectedUserIds.clear();
//       allSelected = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final users = ref.watch(userProvider);
//     print(selectedUserIds);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CustomBackButton(text: '${widget.parameterName} Parameter'),
//             const SizedBox(height: 16),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   users.when(
//                     data: (userList) {
//                       return DropdownButtonFormField<String>(
//                         items: [
//                           DropdownMenuItem<String>(
//                             value: 'select_all',
//                             child: const Text('Select All'),
//                           ),
//                           ...userList.map((user) {
//                             return DropdownMenuItem<String>(
//                               value: user.userId,
//                               child: Text(user.name),
//                             );
//                           }).toList(),
//                         ],
//                         onChanged: (value) {
//                           if (value == 'select_all') {
//                             setState(() {
//                               selectedUserIds =
//                                   userList.map((user) => user.userId).toList();
//                               allSelected = true;
//                             });
//                           } else if (value != null &&
//                               !selectedUserIds.contains(value)) {
//                             setState(() {
//                               selectedUserIds.add(value);
//                               allSelected = false;
//                             });
//                           }
//                         },
//                         decoration:
//                             const InputDecoration(labelText: 'Assign Users'),
//                       );
//                     },
//                     loading: () => const CircularProgressIndicator(),
//                     error: (error, stackTrace) =>
//                         Text('Failed to load users: $error'),
//                   ),
//                   const SizedBox(height: 16),
//                   Wrap(
//                     children: allSelected
//                         ? [
//                             Chip(
//                               label: const Text('All Selected'),
//                               onDeleted: () {
//                                 setState(() {
//                                   selectedUserIds.clear();
//                                   allSelected = false;
//                                 });
//                               },
//                             ),
//                           ]
//                         : selectedUserIds.map((userId) {
//                             return Chip(
//                               label: Text(users.when(
//                                 data: (userList) => userList
//                                     .firstWhere((user) => user.userId == userId)
//                                     .name,
//                                 loading: () => '',
//                                 error: (error, stackTrace) => '',
//                               )),
//                               onDeleted: () {
//                                 setState(() {
//                                   selectedUserIds.remove(userId);
//                                 });
//                               },
//                             );
//                           }).toList(),
//                   ),
//                   const SizedBox(height: 16),
//                   isLoading
//                       ? const CircularProgressIndicator()
//                       : SubmitButton(
//                           onPressed: () async {

//                           },
//                         ),
//                 ],
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
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/widgets/submit_button.dart';
// import '../controller/Add_target_controller.dart';

// class ParameterTargetScreen extends ConsumerStatefulWidget {
//   final String parameterName;
//   final String businessId;
//   final VoidCallback onDataAdded;

//   const ParameterTargetScreen({
//     super.key,
//     required this.parameterName,
//     required this.businessId,
//     required this.onDataAdded,
//   });

//   @override
//   ConsumerState<ParameterTargetScreen> createState() =>
//       _ParameterTargetScreenState();
// }

// class _ParameterTargetScreenState extends ConsumerState<ParameterTargetScreen> {
//   final _formKey = GlobalKey<FormState>();
//   List<String> selectedUserIds = [];
//   bool isLoading = false;
//   bool allSelected = false;
//   bool showTargets = false;

//   @override
//   void initState() {
//     super.initState();
//     ref
//         .read(userProvider.notifier)
//         .fetchUsers(widget.parameterName, widget.businessId);
//   }

//   void _clearFields() {
//     _formKey.currentState?.reset();
//     setState(() {
//       selectedUserIds.clear();
//       allSelected = false;
//     });
//   }

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

//   @override
//   Widget build(BuildContext context) {
//     final users = ref.watch(userProvider);
//     print(selectedUserIds);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CustomBackButton(text: '${widget.parameterName} Parameter'),
//             const SizedBox(height: 16),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   users.when(
//                     data: (userList) {
//                       return DropdownButtonFormField<String>(
//                         items: [
//                           DropdownMenuItem<String>(
//                             value: 'select_all',
//                             child: const Text('Select All'),
//                           ),
//                           ...userList.map((user) {
//                             return DropdownMenuItem<String>(
//                               value: user.userId,
//                               child: Text(user.name),
//                             );
//                           }).toList(),
//                         ],
//                         onChanged: (value) {
//                           if (value == 'select_all') {
//                             setState(() {
//                               selectedUserIds =
//                                   userList.map((user) => user.userId).toList();
//                               allSelected = true;
//                             });
//                           } else if (value != null &&
//                               !selectedUserIds.contains(value)) {
//                             setState(() {
//                               selectedUserIds.add(value);
//                               allSelected = false;
//                             });
//                           }
//                         },
//                         decoration:
//                             const InputDecoration(labelText: 'Assign Users'),
//                       );
//                     },
//                     loading: () => const CircularProgressIndicator(),
//                     error: (error, stackTrace) =>
//                         Text('Failed to load users: $error'),
//                   ),
//                   const SizedBox(height: 16),
//                   Wrap(
//                     children: allSelected
//                         ? [
//                             Chip(
//                               label: const Text('All Selected'),
//                               onDeleted: () {
//                                 setState(() {
//                                   selectedUserIds.clear();
//                                   allSelected = false;
//                                 });
//                               },
//                             ),
//                           ]
//                         : selectedUserIds.map((userId) {
//                             return Chip(
//                               label: Text(users.when(
//                                 data: (userList) => userList
//                                     .firstWhere((user) => user.userId == userId)
//                                     .name,
//                                 loading: () => '',
//                                 error: (error, stackTrace) => '',
//                               )),
//                               onDeleted: () {
//                                 setState(() {
//                                   selectedUserIds.remove(userId);
//                                 });
//                               },
//                             );
//                           }).toList(),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         showTargets = true;
//                       });
//                     },
//                     child: const Text('Get Targets'),
//                   ),
//                   const SizedBox(height: 16),
//                   if (showTargets)
//                     ...selectedUserIds.map((userId) {
//                       return users.when(
//                         data: (userList) {
//                           final user = userList
//                               .firstWhere((user) => user.userId == userId);
//                           return Card(
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 children: [
//                                   Table(
//                                     children: [
//                                       TableRow(
//                                         children: [
//                                           const Text('Name'),
//                                           const Text('Achievement'),
//                                           const Text('Target'),
//                                         ],
//                                       ),
//                                       TableRow(
//                                         children: [
//                                           Text(user.name),
//                                           const Text(
//                                               '0'), // Placeholder for achievement
//                                           const Text(
//                                               '0'), // Placeholder for target
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 8),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       _showSetTargetDialog(context, user.name);
//                                     },
//                                     child: const Text('Set Target'),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         loading: () => const CircularProgressIndicator(),
//                         error: (error, stackTrace) =>
//                             Text('Failed to load users: $error'),
//                       );
//                     }).toList(),
//                 ],
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
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/src/parameters/view/widgets/TargetCard.dart';
// import '../controller/Add_target_controller.dart';

// class ParameterTargetScreen extends ConsumerStatefulWidget {
//   final String parameterName;
//   final String businessId;
//   final VoidCallback onDataAdded;

//   const ParameterTargetScreen({
//     super.key,
//     required this.parameterName,
//     required this.businessId,
//     required this.onDataAdded,
//   });

//   @override
//   ConsumerState<ParameterTargetScreen> createState() =>
//       _ParameterTargetScreenState();
// }

// class _ParameterTargetScreenState extends ConsumerState<ParameterTargetScreen> {
//   final _formKey = GlobalKey<FormState>();
//   List<String> selectedUserIds = [];
//   bool isLoading = false;
//   bool allSelected = false;
//   bool showTargets = false;

//   @override
//   void initState() {
//     super.initState();
//     ref
//         .read(userProvider.notifier)
//         .fetchUsers(widget.parameterName, widget.businessId);
//   }

//   void _clearFields() {
//     _formKey.currentState?.reset();
//     setState(() {
//       selectedUserIds.clear();
//       allSelected = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final users = ref.watch(userProvider);
//     print(selectedUserIds);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CustomBackButton(text: '${widget.parameterName} Parameter'),
//             const SizedBox(height: 16),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   users.when(
//                     data: (userList) {
//                       return DropdownButtonFormField<String>(
//                         items: [
//                           DropdownMenuItem<String>(
//                             value: 'select_all',
//                             child: const Text('Select All'),
//                           ),
//                           ...userList.map((user) {
//                             return DropdownMenuItem<String>(
//                               value: user.userId,
//                               child: Text(user.name),
//                             );
//                           }).toList(),
//                         ],
//                         onChanged: (value) {
//                           if (value == 'select_all') {
//                             setState(() {
//                               selectedUserIds =
//                                   userList.map((user) => user.userId).toList();
//                               allSelected = true;
//                             });
//                           } else if (value != null &&
//                               !selectedUserIds.contains(value)) {
//                             setState(() {
//                               selectedUserIds.add(value);
//                               allSelected = false;
//                             });
//                           }
//                         },
//                         decoration:
//                             const InputDecoration(labelText: 'Assign Users'),
//                       );
//                     },
//                     loading: () => const CircularProgressIndicator(),
//                     error: (error, stackTrace) =>
//                         Text('Failed to load users: $error'),
//                   ),
//                   const SizedBox(height: 16),
//                   Wrap(
//                     children: allSelected
//                         ? [
//                             Chip(
//                               label: const Text('All Selected'),
//                               onDeleted: () {
//                                 setState(() {
//                                   selectedUserIds.clear();
//                                   allSelected = false;
//                                 });
//                               },
//                             ),
//                           ]
//                         : selectedUserIds.map((userId) {
//                             return Chip(
//                               label: Text(users.when(
//                                 data: (userList) => userList
//                                     .firstWhere((user) => user.userId == userId)
//                                     .name,
//                                 loading: () => '',
//                                 error: (error, stackTrace) => '',
//                               )),
//                               onDeleted: () {
//                                 setState(() {
//                                   selectedUserIds.remove(userId);
//                                 });
//                               },
//                             );
//                           }).toList(),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         showTargets = true;
//                       });
//                     },
//                     child: const Text('Get Targets'),
//                   ),
//                   const SizedBox(height: 16),
//                   if (showTargets)
//                     ...selectedUserIds.map((userId) {
//                       return users.when(
//                         data: (userList) {
//                           final user = userList
//                               .firstWhere((user) => user.userId == userId);
//                           return TargetCard(user: user);
//                         },
//                         loading: () => const CircularProgressIndicator(),
//                         error: (error, stackTrace) =>
//                             Text('Failed to load users: $error'),
//                       );
//                     }).toList(),
//                 ],
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
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/src/parameters/view/model/user_target_model.dart';
// import 'package:targafy/src/parameters/view/widgets/TargetCard.dart';
// import 'package:targafy/widgets/submit_button.dart';
// import '../controller/Add_target_controller.dart';

// class ParameterTargetScreen extends ConsumerStatefulWidget {
//   final String parameterName;
//   final String businessId;
//   final VoidCallback onDataAdded;

//   const ParameterTargetScreen({
//     super.key,
//     required this.parameterName,
//     required this.businessId,
//     required this.onDataAdded,
//   });

//   @override
//   ConsumerState<ParameterTargetScreen> createState() =>
//       _ParameterTargetScreenState();
// }

// class _ParameterTargetScreenState extends ConsumerState<ParameterTargetScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _targetValueController = TextEditingController();
//   final TextEditingController _commentController = TextEditingController();
//   List<String> selectedUserIds = [];
//   bool isLoading = false;
//   bool allSelected = false;
//   bool showTargets = false;

//   @override
//   void initState() {
//     super.initState();
//     ref
//         .read(userProvider.notifier)
//         .fetchUsers(widget.parameterName, widget.businessId);
//   }

//   void _clearFields() {
//     _formKey.currentState?.reset();
//     _targetValueController.clear();
//     _commentController.clear();
//     setState(() {
//       selectedUserIds.clear();
//       allSelected = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final users = ref.watch(userProvider);

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CustomBackButton(text: '${widget.parameterName} Parameter'),
//             const SizedBox(height: 16),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _targetValueController,
//                     decoration:
//                         const InputDecoration(labelText: 'Target Value'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a target value';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _commentController,
//                     decoration: const InputDecoration(labelText: 'Comment'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a comment';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   users.when(
//                     data: (userList) {
//                       return Column(
//                         children: [
//                           DropdownButtonFormField<String>(
//                             items: [
//                               DropdownMenuItem<String>(
//                                 value: 'select_all',
//                                 child: const Text('Select All'),
//                               ),
//                               ...userList.map((user) {
//                                 return DropdownMenuItem<String>(
//                                   value: user.userId,
//                                   child: Text(user.name),
//                                 );
//                               }).toList(),
//                             ],
//                             onChanged: (value) {
//                               if (value == 'select_all') {
//                                 setState(() {
//                                   selectedUserIds = userList
//                                       .map((user) => user.userId)
//                                       .toList();
//                                   allSelected = true;
//                                 });
//                               } else if (value != null &&
//                                   !selectedUserIds.contains(value)) {
//                                 setState(() {
//                                   selectedUserIds.add(value);
//                                   allSelected = false;
//                                 });
//                               }
//                             },
//                             decoration: const InputDecoration(
//                                 labelText: 'Assign Users'),
//                           ),
//                           const SizedBox(height: 16),
//                           Wrap(
//                             children: allSelected
//                                 ? [
//                                     Chip(
//                                       label: const Text('All Selected'),
//                                       onDeleted: () {
//                                         setState(() {
//                                           selectedUserIds.clear();
//                                           allSelected = false;
//                                         });
//                                       },
//                                     ),
//                                   ]
//                                 : selectedUserIds.map((userId) {
//                                     return Chip(
//                                       label: Text(users.when(
//                                         data: (userList) => userList
//                                             .firstWhere(
//                                                 (user) => user.userId == userId)
//                                             .name,
//                                         loading: () => '',
//                                         error: (error, stackTrace) => '',
//                                       )),
//                                       onDeleted: () {
//                                         setState(() {
//                                           selectedUserIds.remove(userId);
//                                         });
//                                       },
//                                     );
//                                   }).toList(),
//                           ),
//                         ],
//                       );
//                     },
//                     loading: () => const CircularProgressIndicator(),
//                     error: (error, stackTrace) =>
//                         Text('Failed to load users: $error'),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         showTargets = true;
//                       });
//                     },
//                     child: const Text('Get Targets'),
//                   ),
//                   const SizedBox(height: 16),
//                   DropdownButtonFormField<String>(
//                     items: [
//                       DropdownMenuItem<String>(
//                         value: 'option1',
//                         child: const Text('Option 1'),
//                       ),
//                       DropdownMenuItem<String>(
//                         value: 'option2',
//                         child: const Text('Option 2'),
//                       ),
//                     ],
//                     onChanged: (value) {
//                       // Handle change
//                     },
//                     decoration:
//                         const InputDecoration(labelText: 'New Dropdown'),
//                   ),
//                   const SizedBox(height: 16),
//                   isLoading
//                       ? const CircularProgressIndicator()
//                       : SubmitButton(
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               setState(() {
//                                 isLoading = true;
//                               });
//                               final target = Target(
//                                 targetValue: _targetValueController.text,
//                                 paramName: widget.parameterName,
//                                 comment: _commentController.text,
//                                 userIds: selectedUserIds,
//                               );
//                               try {
//                                 await ref
//                                     .read(targetProvider.notifier)
//                                     .addTarget(target, widget.businessId);
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content:
//                                           Text('Target added successfully')),
//                                 );
//                                 widget.onDataAdded();
//                                 Navigator.pop(context, true);
//                               } catch (error) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content:
//                                           Text('Failed to add target: $error')),
//                                 );
//                                 _clearFields();
//                               } finally {
//                                 setState(() {
//                                   isLoading = false;
//                                 });
//                               }
//                             }
//                           },
//                         ),
//                   const SizedBox(height: 16),
//                   if (showTargets)
//                     ...selectedUserIds.map((userId) {
//                       return users.when(
//                         data: (userList) {
//                           final user = userList
//                               .firstWhere((user) => user.userId == userId);
//                           return TargetCard(user: user);
//                         },
//                         loading: () => const CircularProgressIndicator(),
//                         error: (error, stackTrace) =>
//                             Text('Failed to load users: $error'),
//                       );
//                     }).toList(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/src/parameters/view/controller/get_target_controller.dart';
import 'package:targafy/src/parameters/view/model/target_data_model.dart';
import 'package:targafy/src/parameters/view/model/user_target_model.dart';
import 'package:targafy/src/parameters/view/widgets/TargetCard.dart';
import 'package:targafy/src/parameters/view/widgets/small_button.dart';
import 'package:targafy/widgets/Special_back_button.dart';
import 'package:targafy/widgets/custom_back_button.dart';
import 'package:targafy/widgets/custom_dropdown_field.dart';
import 'package:targafy/widgets/custom_text_field.dart';
import 'package:targafy/widgets/sort_dropdown_list.dart';
import 'package:targafy/widgets/submit_button.dart';
import '../controller/Add_target_controller.dart';

// class ParameterTargetScreen extends ConsumerStatefulWidget {
//   final String parameterName;
//   final String businessId;
//   final VoidCallback onDataAdded;

//   const ParameterTargetScreen({
//     super.key,
//     required this.parameterName,
//     required this.businessId,
//     required this.onDataAdded,
//   });

//   @override
//   ConsumerState<ParameterTargetScreen> createState() =>
//       _ParameterTargetScreenState();
// }

// class _ParameterTargetScreenState extends ConsumerState<ParameterTargetScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _targetValueController = TextEditingController();
//   final TextEditingController _commentController = TextEditingController();
//   List<String> selectedUserIds = [];
//   List<String> AssingSelectedUserIds = [];
//   bool isLoading = false;
//   bool allSelected = false;
//   bool additionalAllSelected = false;
//   bool showTargets = false;

//   Map<String, List<TargetData>> userTargetData = {};

//   @override
//   void initState() {
//     super.initState();
//     ref
//         .read(userProvider.notifier)
//         .fetchUsers(widget.parameterName, widget.businessId);
//   }

//   void _clearFields() {
//     _formKey.currentState?.reset();
//     _targetValueController.clear();
//     _commentController.clear();
//     setState(() {
//       selectedUserIds.clear();
//       AssingSelectedUserIds.clear();
//       allSelected = false;
//       additionalAllSelected = false;
//     });
//   }

//   Future<void> _fetchTargetDataForUser(String userId) async {
//     try {
//       final targets = await ref
//           .read(targetDataControllerProvider.notifier)
//           .fetchThreeMonthsData(
//               userId, widget.businessId, widget.parameterName);
//       // Store fetched targets in userTargetData map
//       setState(() {
//         userTargetData[userId] = targets;
//       });
//       print('Fetched targets for user $userId: $targets');
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to fetch targets for user $userId: $error'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final users = ref.watch(userProvider);
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     // print(AssingSelectedUserIds);
//     print(selectedUserIds);
//     print('This is the  map:- $userTargetData');

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               SpecialBackButton(text: '${widget.parameterName} Target'),
//               SizedBox(height: height * 0.05),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     CustomInputField(
//                       labelText: 'Target Value',
//                       controller: _targetValueController,
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a target value';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: height * 0.02),
//                     CustomInputField(
//                       labelText: 'Comment',
//                       controller: _commentController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a comment';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: height * 0.02),
//                     users.when(
//                       data: (userList) {
//                         final sortedUserList =
//                             sortList(userList, (user) => user.name);
//                         return Column(
//                           children: [
//                             CustomDropdownField(
//                               labelText: 'Assign Users',
//                               items: [
//                                 DropdownMenuItem<String>(
//                                   value: 'select_all',
//                                   child: const Text('Select All'),
//                                 ),
//                                 ...sortedUserList.map((user) {
//                                   return DropdownMenuItem<String>(
//                                     value: user.userId,
//                                     child: Text(user.name),
//                                   );
//                                 }).toList(),
//                               ],
//                               onChanged: (value) {
//                                 if (value == 'select_all') {
//                                   setState(() {
//                                     AssingSelectedUserIds = sortedUserList
//                                         .map((user) => user.userId)
//                                         .toList();
//                                     additionalAllSelected = true;
//                                   });
//                                 } else if (value != null &&
//                                     !AssingSelectedUserIds.contains(value)) {
//                                   setState(() {
//                                     AssingSelectedUserIds.add(value);
//                                     additionalAllSelected = false;
//                                   });
//                                 }
//                               },
//                             ),
//                             SizedBox(height: height * 0.02),
//                             Wrap(
//                               children: additionalAllSelected
//                                   ? [
//                                       Chip(
//                                         label: const Text('All Selected'),
//                                         onDeleted: () {
//                                           setState(() {
//                                             AssingSelectedUserIds.clear();
//                                             additionalAllSelected = false;
//                                           });
//                                         },
//                                       ),
//                                     ]
//                                   : AssingSelectedUserIds.map((userId) {
//                                       return Chip(
//                                         label: Text(userList
//                                             .firstWhere(
//                                                 (user) => user.userId == userId)
//                                             .name),
//                                         onDeleted: () {
//                                           setState(() {
//                                             AssingSelectedUserIds.remove(
//                                                 userId);
//                                           });
//                                         },
//                                       );
//                                     }).toList(),
//                             ),
//                           ],
//                         );
//                       },
//                       loading: () => const CircularProgressIndicator(),
//                       error: (error, stackTrace) =>
//                           Text('Failed to load users: $error'),
//                     ),
//                     SizedBox(height: height * 0.05),
//                     isLoading
//                         ? const CircularProgressIndicator()
//                         : SubmitButton(
//                             onPressed: () async {
//                               if (_formKey.currentState!.validate()) {
//                                 setState(() {
//                                   isLoading = true;
//                                 });
//                                 final target = Target(
//                                   targetValue: _targetValueController.text,
//                                   paramName: widget.parameterName,
//                                   comment: _commentController.text,
//                                   userIds: AssingSelectedUserIds,
//                                   monthIndex: DateTime.now().month.toString(),
//                                 );
//                                 try {
//                                   await ref
//                                       .read(targetProvider.notifier)
//                                       .addTarget(target, widget.businessId);
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         content:
//                                             Text('Target added successfully')),
//                                   );
//                                   widget.onDataAdded();
//                                   _clearFields();
//                                 } catch (error) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                         content: Text(
//                                             'Failed to add target: $error')),
//                                   );
//                                   _clearFields();
//                                 } finally {
//                                   setState(() {
//                                     isLoading = false;
//                                   });
//                                 }
//                               }
//                             },
//                           ),
//                     SizedBox(height: height * 0.1),
//                     users.when(
//                       data: (userList) {
//                         final sortedUserList =
//                             sortList(userList, (user) => user.name);
//                         return Column(
//                           children: [
//                             CustomDropdownField(
//                               labelText: 'Select Users',
//                               items: [
//                                 DropdownMenuItem<String>(
//                                   value: 'select_all',
//                                   child: const Text('Select All'),
//                                 ),
//                                 ...sortedUserList.map((user) {
//                                   return DropdownMenuItem<String>(
//                                     value: user.userId,
//                                     child: Text(user.name),
//                                   );
//                                 }).toList(),
//                               ],
//                               onChanged: (value) {
//                                 if (value == 'select_all') {
//                                   setState(() {
//                                     selectedUserIds = sortedUserList
//                                         .map((user) => user.userId)
//                                         .toList();
//                                     allSelected = true;
//                                   });
//                                 } else if (value != null &&
//                                     !selectedUserIds.contains(value)) {
//                                   setState(() {
//                                     selectedUserIds.add(value);
//                                     allSelected = false;
//                                   });
//                                 }
//                               },
//                             ),
//                             SizedBox(height: height * 0.02),
//                             Wrap(
//                               children: allSelected
//                                   ? [
//                                       Chip(
//                                         label: const Text('All Selected'),
//                                         onDeleted: () {
//                                           setState(() {
//                                             selectedUserIds.clear();
//                                             allSelected = false;
//                                           });
//                                         },
//                                       ),
//                                     ]
//                                   : selectedUserIds.map((userId) {
//                                       return Chip(
//                                         label: Text(users.when(
//                                           data: (userList) => userList
//                                               .firstWhere((user) =>
//                                                   user.userId == userId)
//                                               .name,
//                                           loading: () => '',
//                                           error: (error, stackTrace) => '',
//                                         )),
//                                         onDeleted: () {
//                                           setState(() {
//                                             selectedUserIds.remove(userId);
//                                           });
//                                         },
//                                       );
//                                     }).toList(),
//                             ),
//                           ],
//                         );
//                       },
//                       loading: () => const CircularProgressIndicator(),
//                       error: (error, stackTrace) =>
//                           Text('Failed to load users: $error'),
//                     ),
//                     SizedBox(height: height * 0.02),
//                     CustomSmallButton(
//                       title: 'Get Targets',
//                       onPressed: () {
//                         for (final userId in selectedUserIds) {
//                           _fetchTargetDataForUser(userId);
//                         }
//                         setState(() {
//                           showTargets = true;
//                         });
//                       },
//                     ),
//                     SizedBox(height: height * 0.02),
//                     if (showTargets)
//                       ...selectedUserIds.map((userId) {
//                         return users.when(
//                           data: (userList) {
//                             final user = userList
//                                 .firstWhere((user) => user.userId == userId);
//                             final targets = userTargetData[userId] ?? [];
//                             return TargetCard(
//                               user: user,
//                               targets: targets,
//                               parameterName: widget.parameterName,
//                               businessId: widget.businessId,
//                             );
//                           },
//                           loading: () => const CircularProgressIndicator(),
//                           error: (error, stackTrace) =>
//                               Text('Failed to load users: $error'),
//                         );
//                       }).toList(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ParameterTargetScreen extends ConsumerStatefulWidget {
  final String parameterName;
  final String businessId;
  final VoidCallback onDataAdded;

  const ParameterTargetScreen({
    super.key,
    required this.parameterName,
    required this.businessId,
    required this.onDataAdded,
  });

  @override
  ConsumerState<ParameterTargetScreen> createState() =>
      _ParameterTargetScreenState();
}

class _ParameterTargetScreenState extends ConsumerState<ParameterTargetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _targetValueController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  List<String> selectedUserIds = [];
  List<String> AssingSelectedUserIds = [];
  bool isLoading = false;
  bool allSelected = false;
  bool additionalAllSelected = false;
  bool showTargets = false;
  Map<String, List<TargetData>> userTargetData = {};

  // Controllers for benchmarks
  List<TextEditingController> _benchMarkControllers = [];

  @override
  void initState() {
    super.initState();
    ref
        .read(userProvider.notifier)
        .fetchUsers(widget.parameterName, widget.businessId);
  }

  void _clearFields() {
    _formKey.currentState?.reset();
    _targetValueController.clear();
    _commentController.clear();
    setState(() {
      selectedUserIds.clear();
      AssingSelectedUserIds.clear();
      allSelected = false;
      additionalAllSelected = false;
      _benchMarkControllers.forEach((controller) => controller.clear());
    });
  }

  void _addBenchMarkField() {
    setState(() {
      _benchMarkControllers.add(TextEditingController());
    });
  }

  void _removeBenchMarkField(int index) {
    setState(() {
      _benchMarkControllers.removeAt(index);
    });
  }

  Future<void> _fetchTargetDataForUser(String userId) async {
    try {
      final targets = await ref
          .read(targetDataControllerProvider.notifier)
          .fetchThreeMonthsData(
              userId, widget.businessId, widget.parameterName);
      // Store fetched targets in userTargetData map
      setState(() {
        userTargetData[userId] = targets;
      });
      print('Fetched targets for user $userId: $targets');
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch targets for user $userId: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(userProvider);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // print(AssingSelectedUserIds);
    print(selectedUserIds);
    print('This is the  map:- $userTargetData');

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SpecialBackButton(text: '${widget.parameterName} Target'),
              SizedBox(height: height * 0.05),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomInputField(
                      labelText: 'Target Value',
                      controller: _targetValueController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a target value';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomInputField(
                      labelText: 'Comment',
                      controller: _commentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a comment';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Column(
                      children: [
                        ..._benchMarkControllers.asMap().entries.map((entry) {
                          int index = entry.key;
                          TextEditingController controller = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    labelText: 'Benchmark',
                                    controller: controller,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a benchmark';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    _removeBenchMarkField(index);
                                  },
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        CustomSmallButton(
                          title: 'Add Benchmark',
                          onPressed: _addBenchMarkField,
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    users.when(
                      data: (userList) {
                        final sortedUserList =
                            sortList(userList, (user) => user.name);
                        return Column(
                          children: [
                            CustomDropdownField(
                              labelText: 'Assign Users',
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'select_all',
                                  child: const Text('Select All'),
                                ),
                                ...sortedUserList.map((user) {
                                  return DropdownMenuItem<String>(
                                    value: user.userId,
                                    child: Text(user.name),
                                  );
                                }).toList(),
                              ],
                              onChanged: (value) {
                                if (value == 'select_all') {
                                  setState(() {
                                    AssingSelectedUserIds = sortedUserList
                                        .map((user) => user.userId)
                                        .toList();
                                    additionalAllSelected = true;
                                  });
                                } else if (value != null &&
                                    !AssingSelectedUserIds.contains(value)) {
                                  setState(() {
                                    AssingSelectedUserIds.add(value);
                                    additionalAllSelected = false;
                                  });
                                }
                              },
                            ),
                            SizedBox(height: height * 0.02),
                            Wrap(
                              children: additionalAllSelected
                                  ? [
                                      Chip(
                                        label: const Text('All Selected'),
                                        onDeleted: () {
                                          setState(() {
                                            AssingSelectedUserIds.clear();
                                            additionalAllSelected = false;
                                          });
                                        },
                                      ),
                                    ]
                                  : AssingSelectedUserIds.map((userId) {
                                      return Chip(
                                        label: Text(userList
                                            .firstWhere(
                                                (user) => user.userId == userId)
                                            .name),
                                        onDeleted: () {
                                          setState(() {
                                            AssingSelectedUserIds.remove(
                                                userId);
                                          });
                                        },
                                      );
                                    }).toList(),
                            ),
                          ],
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stackTrace) =>
                          Text('Failed to load users: $error'),
                    ),
                    SizedBox(height: height * 0.05),
                    isLoading
                        ? const CircularProgressIndicator()
                        : SubmitButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                final benchMarks = _benchMarkControllers
                                    .map((controller) => controller.text)
                                    .toList();
                                print('This is $benchMarks');

                                final target = Target(
                                  targetValue: _targetValueController.text,
                                  paramName: widget.parameterName,
                                  comment: _commentController.text,
                                  userIds: AssingSelectedUserIds,
                                  monthIndex: DateTime.now().month.toString(),
                                  benchMarks: benchMarks,
                                );
                                print(benchMarks);
                                try {
                                  await ref
                                      .read(targetProvider.notifier)
                                      .addTarget(target, widget.businessId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Target added successfully')),
                                  );
                                  widget.onDataAdded();
                                  _clearFields();
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Failed to add target: $error')),
                                  );
                                  _clearFields();
                                } finally {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                          ),
                    SizedBox(height: height * 0.1),
                    users.when(
                      data: (userList) {
                        final sortedUserList =
                            sortList(userList, (user) => user.name);
                        return Column(
                          children: [
                            CustomDropdownField(
                              labelText: 'Select Users',
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'select_all',
                                  child: const Text('Select All'),
                                ),
                                ...sortedUserList.map((user) {
                                  return DropdownMenuItem<String>(
                                    value: user.userId,
                                    child: Text(user.name),
                                  );
                                }).toList(),
                              ],
                              onChanged: (value) {
                                if (value == 'select_all') {
                                  setState(() {
                                    selectedUserIds = sortedUserList
                                        .map((user) => user.userId)
                                        .toList();
                                    allSelected = true;
                                  });
                                } else if (value != null &&
                                    !selectedUserIds.contains(value)) {
                                  setState(() {
                                    selectedUserIds.add(value);
                                    allSelected = false;
                                  });
                                }
                              },
                            ),
                            SizedBox(height: height * 0.02),
                            Wrap(
                              children: allSelected
                                  ? [
                                      Chip(
                                        label: const Text('All Selected'),
                                        onDeleted: () {
                                          setState(() {
                                            selectedUserIds.clear();
                                            allSelected = false;
                                          });
                                        },
                                      ),
                                    ]
                                  : selectedUserIds.map((userId) {
                                      return Chip(
                                        label: Text(users.when(
                                          data: (userList) => userList
                                              .firstWhere((user) =>
                                                  user.userId == userId)
                                              .name,
                                          loading: () => '',
                                          error: (error, stackTrace) => '',
                                        )),
                                        onDeleted: () {
                                          setState(() {
                                            selectedUserIds.remove(userId);
                                          });
                                        },
                                      );
                                    }).toList(),
                            ),
                          ],
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stackTrace) =>
                          Text('Failed to load users: $error'),
                    ),
                    SizedBox(height: height * 0.02),
                    CustomSmallButton(
                      title: 'Get Targets',
                      onPressed: () {
                        for (final userId in selectedUserIds) {
                          _fetchTargetDataForUser(userId);
                        }
                        setState(() {
                          showTargets = true;
                        });
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    if (showTargets)
                      ...selectedUserIds.map((userId) {
                        return users.when(
                          data: (userList) {
                            final user = userList
                                .firstWhere((user) => user.userId == userId);
                            final targets = userTargetData[userId] ?? [];
                            return TargetCard(
                              user: user,
                              targets: targets,
                              parameterName: widget.parameterName,
                              businessId: widget.businessId,
                            );
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (error, stackTrace) =>
                              Text('Failed to load users: $error'),
                        );
                      }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
