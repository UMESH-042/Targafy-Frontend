// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/src/parameters/view/model/user_target_model.dart';

// import '../controller/Add_target_controller.dart';

// class ParameterTargetScreen extends ConsumerStatefulWidget {
//   final String parameterName;
//   final String businessId;

//   const ParameterTargetScreen({
//     Key? key,
//     required this.parameterName,
//     required this.businessId,
//   }) : super(key: key);

//   @override
//   ConsumerState<ParameterTargetScreen> createState() =>
//       _ParameterTargetScreenState();
// }

// class _ParameterTargetScreenState extends ConsumerState<ParameterTargetScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _targetValueController = TextEditingController();
//   final TextEditingController _commentController = TextEditingController();
//   List<String> selectedUserIds = [];

//   @override
//   void initState() {
//     super.initState();
//     ref
//         .read(userProvider.notifier)
//         .fetchUsers(widget.parameterName, widget.businessId);
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
//                   targetState.when(
//                     data: (_) => ElevatedButton(
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           final target = Target(
//                             targetValue: _targetValueController.text,
//                             paramName: widget.parameterName,
//                             comment: _commentController.text,
//                             userIds: selectedUserIds,
//                           );
//                           await ref
//                               .read(targetProvider.notifier)
//                               .addTarget(target, widget.businessId);
//                           if (targetState is AsyncError) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                   content: Text(
//                                       'Failed to add target: ${(targetState as AsyncError).error}')),
//                             );
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('Target added successfully')),
//                             );
//                             Navigator.pop(context);
//                           }
//                         }
//                       },
//                       child: const Text('Add Target'),
//                     ),
//                     loading: () => const CircularProgressIndicator(),
//                     error: (error, stackTrace) => Text('Error: $error'),
//                   ),
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

// import '../controller/Add_target_controller.dart';

// class ParameterTargetScreen extends ConsumerStatefulWidget {
//   final String parameterName;
//   final String businessId;
//   final VoidCallback onDataAdded;

//   const ParameterTargetScreen({
//     Key? key,
//     required this.parameterName,
//     required this.businessId,
//     required this.onDataAdded,
//   }) : super(key: key);

//   @override
//   ConsumerState<ParameterTargetScreen> createState() =>
//       _ParameterTargetScreenState();
// }

// class _ParameterTargetScreenState extends ConsumerState<ParameterTargetScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _targetValueController = TextEditingController();
//   final TextEditingController _commentController = TextEditingController();
//   List<String> selectedUserIds = [];

//   @override
//   void initState() {
//     super.initState();
//     ref
//         .read(userProvider.notifier)
//         .fetchUsers(widget.parameterName, widget.businessId);
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
//                   targetState.when(
//                     data: (_) => ElevatedButton(
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           final target = Target(
//                             targetValue: _targetValueController.text,
//                             paramName: widget.parameterName,
//                             comment: _commentController.text,
//                             userIds: selectedUserIds,
//                           );
//                           await ref
//                               .read(targetProvider.notifier)
//                               .addTarget(target, widget.businessId);
//                           if (targetState is AsyncError) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                   content: Text(
//                                       'Failed to add target: ${(targetState as AsyncError).error}')),
//                             );
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('Target added successfully')),
//                             );
//                             widget.onDataAdded();
//                             Navigator.pop(context, true);
//                           }
//                         }
//                       },
//                       child: const Text('Add Target'),
//                     ),
//                     loading: () => const CircularProgressIndicator(),
//                     error: (error, stackTrace) => Text('Error: $error'),
//                   ),
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
import 'package:targafy/src/parameters/view/model/user_target_model.dart';
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
  final TextEditingController _targetValueController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  List<String> selectedUserIds = [];
  bool isLoading = false;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(userProvider);
    final targetState = ref.watch(targetProvider);

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
                  TextFormField(
                    controller: _targetValueController,
                    decoration:
                        const InputDecoration(labelText: 'Target Value'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a target value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _commentController,
                    decoration: const InputDecoration(labelText: 'Comment'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a comment';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  users.when(
                    data: (userList) {
                      return DropdownButtonFormField<String>(
                        items: userList.map((user) {
                          return DropdownMenuItem<String>(
                            value: user.userId,
                            child: Text(user.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null &&
                              !selectedUserIds.contains(value)) {
                            setState(() {
                              selectedUserIds.add(value);
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
                  Wrap(
                    children: selectedUserIds.map((userId) {
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
                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              final target = Target(
                                targetValue: _targetValueController.text,
                                paramName: widget.parameterName,
                                comment: _commentController.text,
                                userIds: selectedUserIds,
                              );
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
                                Navigator.pop(context, true);
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Failed to add target: $error')),
                                );
                                _clearFields();
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          child: const Text('Add Target'),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
