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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/core/shared/components/back_button.dart';
import 'package:targafy/widgets/submit_button.dart';
import '../controller/Add_target_controller.dart';

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
  List<String> selectedUserIds = [];
  bool isLoading = false;
  bool allSelected = false;
  bool showTargets = false;

  @override
  void initState() {
    super.initState();
    ref
        .read(userProvider.notifier)
        .fetchUsers(widget.parameterName, widget.businessId);
  }

  void _clearFields() {
    _formKey.currentState?.reset();
    setState(() {
      selectedUserIds.clear();
      allSelected = false;
    });
  }

  void _showSetTargetDialog(BuildContext context, String userName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Set Target for $userName'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'Target Value'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Set target logic
                Navigator.of(context).pop();
              },
              child: const Text('Set Target'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(userProvider);
    print(selectedUserIds);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomBackButton(text: '${widget.parameterName} Parameter'),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  users.when(
                    data: (userList) {
                      return DropdownButtonFormField<String>(
                        items: [
                          DropdownMenuItem<String>(
                            value: 'select_all',
                            child: const Text('Select All'),
                          ),
                          ...userList.map((user) {
                            return DropdownMenuItem<String>(
                              value: user.userId,
                              child: Text(user.name),
                            );
                          }).toList(),
                        ],
                        onChanged: (value) {
                          if (value == 'select_all') {
                            setState(() {
                              selectedUserIds =
                                  userList.map((user) => user.userId).toList();
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
                        decoration:
                            const InputDecoration(labelText: 'Assign Users'),
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stackTrace) =>
                        Text('Failed to load users: $error'),
                  ),
                  const SizedBox(height: 16),
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
                                    .firstWhere((user) => user.userId == userId)
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
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showTargets = true;
                      });
                    },
                    child: const Text('Get Targets'),
                  ),
                  const SizedBox(height: 16),
                  if (showTargets)
                    ...selectedUserIds.map((userId) {
                      return users.when(
                        data: (userList) {
                          final user = userList.firstWhere((user) => user.userId == userId);
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          const Text('Name'),
                                          const Text('Achievement'),
                                          const Text('Target'),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          Text(user.name),
                                          const Text('0'), // Placeholder for achievement
                                          const Text('0'), // Placeholder for target
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      _showSetTargetDialog(context, user.name);
                                    },
                                    child: const Text('Set Target'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stackTrace) => Text('Failed to load users: $error'),
                      );
                    }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
