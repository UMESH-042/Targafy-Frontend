// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';
// import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/widgets/custom_dropdown_field.dart';
// import 'package:targafy/widgets/custom_text_field.dart';
// import 'package:targafy/widgets/sort_dropdown_list.dart';
// import 'package:targafy/widgets/submit_button.dart';

// class AddParameter extends ConsumerStatefulWidget {
//   const AddParameter({super.key});

//   @override
//   ConsumerState<AddParameter> createState() => _AddParameterState();
// }

// class _AddParameterState extends ConsumerState<AddParameter> {
//   final TextEditingController _parameterNameController =
//       TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final List<String> _selectedUserIds = [];
//   final List<String> _selectedUsersNames = [];
//   String _selectedChart = 'Line Chart';
//   String _selectedDuration = '1stTo31st';

//   @override
//   void initState() {
//     super.initState();
//     // Fetch the businessId from the current selected business
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     if (businessId != null) {
//       ref.read(businessUsersProvider.notifier).fetchBusinessUsers(businessId);
//     }
//   }

//   void _submitParameter() {
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     print(businessId);
//     if (businessId != null &&
//         _parameterNameController.text.isNotEmpty &&
//         _selectedUserIds.isNotEmpty &&
//         _descriptionController.text.isNotEmpty) {
//       ref
//           .read(parameterNotifierProvider.notifier)
//           .addParameter(
//             businessId,
//             _parameterNameController.text,
//             _selectedUserIds,
//             _selectedChart,
//             _selectedDuration,
//             _descriptionController.text,
//           )
//           .then((success) {
//         if (success) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Parameter added successfully')),
//           );
//           Navigator.of(context).pop(true);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Failed to submit parameter')),
//           );
//         }
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields')),
//       );
//     }
//   }

//   Widget _buildChips() {
//     if (_selectedUsersNames.isEmpty) {
//       return const SizedBox
//           .shrink(); // Return an empty widget if there are no selected users
//     }
//     return Wrap(
//       spacing: 8.0,
//       runSpacing: 4.0,
//       children: _selectedUsersNames.map((userName) {
//         return InputChip(
//           label: Text(userName),
//           onDeleted: () {
//             setState(() {
//               final index = _selectedUsersNames.indexOf(userName);
//               if (index >= 0 && index < _selectedUsersNames.length) {
//                 _selectedUsersNames.removeAt(index);
//                 _selectedUserIds.removeAt(index);
//               }
//             });
//           },
//         );
//       }).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final asyncUsers = ref.watch(businessUsersProvider);
//     print(_selectedUserIds);
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const CustomBackButton(
//                 text: 'Add Parameter',
//               ),
//               SizedBox(height: height * 0.02),
//               CustomInputField(
//                 labelText: 'Enter Parameter Name',
//                 controller: _parameterNameController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter Parameter Name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: height * 0.02),

//               // asyncUsers.when(
//               //   data: (users) {
//               //     final sortedUsers = sortList(users, (user) => user.name);
//               //     return DropdownButtonFormField<String>(
//               //       decoration: const InputDecoration(labelText: 'Select User'),
//               //       value: null,
//               //       items: sortedUsers.map((user) {
//               //         return DropdownMenuItem<String>(
//               //           value: user.userId,
//               //           child: Text(user.name),
//               //         );
//               //       }).toList(),
//               //       onChanged: (value) {
//               //         if (value != null && !_selectedUserIds.contains(value)) {
//               //           setState(() {
//               //             _selectedUserIds.add(value);
//               //             _selectedUsersNames.add(sortedUsers
//               //                 .firstWhere((user) => user.userId == value)
//               //                 .name);
//               //           });
//               //         }
//               //       },
//               //       selectedItemBuilder: (BuildContext context) {
//               //         return _selectedUsersNames.map<Widget>((String item) {
//               //           return Text(item);
//               //         }).toList();
//               //       },
//               //       isExpanded: true,
//               //       hint: const Text('Select Users'),
//               //       icon: const Icon(Icons.arrow_drop_down),
//               //       iconSize: 24,
//               //       elevation: 16,
//               //       style: const TextStyle(color: Colors.deepPurple),
//               //     );
//               //   },
//               //   loading: () => const Center(child: CircularProgressIndicator()),
//               //   error: (error, stackTrace) =>
//               //       Text('Failed to load users: $error'),
//               // ),
//               asyncUsers.when(
//                 data: (users) {
//                   final sortedUsers = sortList(users, (user) => user.name);

//                   return CustomDropdownField(
//                     labelText: 'Select User',
//                     value: null,
//                     items: [
//                       ...sortedUsers.map((user) {
//                         return DropdownMenuItem<String>(
//                           value: user.userId,
//                           child: Text(user.name),
//                         );
//                       }).toList(),
//                     ],
//                     onChanged: (value) {
//                       if (value != null && !_selectedUserIds.contains(value)) {
//                         setState(() {
//                           _selectedUserIds.add(value);
//                           _selectedUsersNames.add(sortedUsers
//                               .firstWhere((user) => user.userId == value)
//                               .name);
//                         });
//                       }
//                     },
//                   );
//                 },
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 error: (error, stackTrace) =>
//                     Text('Failed to load users: $error'),
//               ),
//               SizedBox(height: height * 0.01),
//               _buildChips(),
//               // const SizedBox(height: 20),
//               // CustomFieldParameter(
//               //   label: 'Select charts',
//               //   dropdownValue: _selectedChart,
//               //   dropdownItems: const [
//               //     DropdownMenuItem(
//               //         value: 'Line Chart', child: Text('Line Chart')),
//               //     DropdownMenuItem(value: 'Table', child: Text('Table')),
//               //     DropdownMenuItem(
//               //         value: 'Pie Chart', child: Text('Pie Chart')),
//               //     DropdownMenuItem(value: 'Lines', child: Text('Lines')),
//               //   ],
//               //   onChanged: (value) {
//               //     setState(() {
//               //       _selectedChart = value;
//               //     });
//               //   },
//               // ),
//               // const SizedBox(height: 20),
//               // CustomFieldParameter(
//               //   label: 'Duration',
//               //   dropdownValue: _selectedDuration,
//               //   dropdownItems: const [
//               //     DropdownMenuItem(
//               //         value: '1stTo31st', child: Text('1stTo31st')),
//               //     DropdownMenuItem(
//               //         value: 'upto30days', child: Text('upto30days')),
//               //     DropdownMenuItem(value: '30days', child: Text('30days')),
//               //   ],
//               //   onChanged: (value) {
//               //     setState(() {
//               //       _selectedDuration = value;
//               //     });
//               //   },
//               // ),
//               SizedBox(height: height * 0.02),
//               CustomInputField(
//                 controller: _descriptionController,
//                 labelText: 'Enter Description',
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter description';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: height * 0.05),

//               // ElevatedButton(
//               //   onPressed: _submitParameter,
//               //   child: const Text('Submit'),
//               // ),
//               SubmitButton(onPressed: _submitParameter),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';
// import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/widgets/custom_dropdown_field.dart';
// import 'package:targafy/widgets/custom_text_field.dart';
// import 'package:targafy/widgets/sort_dropdown_list.dart';
// import 'package:targafy/widgets/submit_button.dart';

// class AddParameter extends ConsumerStatefulWidget {
//   const AddParameter({super.key});

//   @override
//   ConsumerState<AddParameter> createState() => _AddParameterState();
// }

// class _AddParameterState extends ConsumerState<AddParameter> {
//   final TextEditingController _parameterNameController =
//       TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final List<String> _selectedUserIds = [];
//   final List<String> _selectedUsersNames = [];
//   String _selectedChart = 'Line Chart';
//   String _selectedDuration = '1stTo31st';
//   bool _allSelected = false;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch the businessId from the current selected business
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     if (businessId != null) {
//       ref.read(businessUsersProvider.notifier).fetchBusinessUsers(businessId);
//     }
//   }

//   void _submitParameter() {
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     print(businessId);
//     if (businessId != null &&
//         _parameterNameController.text.isNotEmpty &&
//         _selectedUserIds.isNotEmpty &&
//         _descriptionController.text.isNotEmpty) {
//       ref
//           .read(parameterNotifierProvider.notifier)
//           .addParameter(
//             businessId,
//             _parameterNameController.text,
//             _selectedUserIds,
//             _descriptionController.text,
//           )
//           .then((success) {
//         if (success) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Parameter added successfully')),
//           );
//           Navigator.of(context).pop(true);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Failed to submit parameter')),
//           );
//         }
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields')),
//       );
//     }
//   }

//   Widget _buildChips() {
//     if (_allSelected) {
//       return InputChip(
//         label: const Text('All Selected'),
//         onDeleted: () {
//           setState(() {
//             _allSelected = false;
//             _selectedUserIds.clear();
//             _selectedUsersNames.clear();
//           });
//         },
//       );
//     }
//     if (_selectedUsersNames.isEmpty) {
//       return const SizedBox
//           .shrink(); // Return an empty widget if there are no selected users
//     }
//     return Wrap(
//       spacing: 8.0,
//       runSpacing: 4.0,
//       children: _selectedUsersNames.map((userName) {
//         return InputChip(
//           label: Text(userName),
//           onDeleted: () {
//             setState(() {
//               final index = _selectedUsersNames.indexOf(userName);
//               if (index >= 0 && index < _selectedUsersNames.length) {
//                 _selectedUsersNames.removeAt(index);
//                 _selectedUserIds.removeAt(index);
//               }
//             });
//           },
//         );
//       }).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final asyncUsers = ref.watch(businessUsersProvider);
//     print(_selectedUserIds);
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const CustomBackButton(
//                 text: 'Add Parameter',
//               ),
//               SizedBox(height: height * 0.02),
//               CustomInputField(
//                 labelText: 'Enter Parameter Name',
//                 controller: _parameterNameController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter Parameter Name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: height * 0.02),
//               asyncUsers.when(
//                 data: (users) {
//                   final sortedUsers = sortList(users, (user) => user.name);
//                   final allUsersIds =
//                       sortedUsers.map((user) => user.userId).toList();
//                   final allUsersNames =
//                       sortedUsers.map((user) => user.name).toList();

//                   return CustomDropdownField(
//                     labelText: 'Select User',
//                     value: null,
//                     items: [
//                       const DropdownMenuItem<String>(
//                         value: 'selectAll',
//                         child: Text('Select All'),
//                       ),
//                       ...sortedUsers.map((user) {
//                         return DropdownMenuItem<String>(
//                           value: user.userId,
//                           child: Text(user.name),
//                         );
//                       }).toList(),
//                     ],
//                     onChanged: (value) {
//                       if (value == 'selectAll') {
//                         setState(() {
//                           _allSelected = true;
//                           _selectedUserIds.clear();
//                           _selectedUsersNames.clear();
//                           _selectedUserIds.addAll(allUsersIds);
//                           _selectedUsersNames.addAll(allUsersNames);
//                         });
//                       } else if (value != null &&
//                           !_selectedUserIds.contains(value)) {
//                         setState(() {
//                           _allSelected = false;
//                           _selectedUserIds.add(value);
//                           _selectedUsersNames.add(sortedUsers
//                               .firstWhere((user) => user.userId == value)
//                               .name);
//                         });
//                       }
//                     },
//                   );
//                 },
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 error: (error, stackTrace) =>
//                     Text('Failed to load users: $error'),
//               ),
//               SizedBox(height: height * 0.01),
//               _buildChips(),
//               SizedBox(height: height * 0.02),
//               CustomInputField(
//                 controller: _descriptionController,
//                 labelText: 'Enter Description',
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter description';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: height * 0.05),
//               SubmitButton(onPressed: _submitParameter),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/core/shared/components/back_button.dart';
import 'package:targafy/src/home/view/screens/controller/Department_controller.dart';
import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/widgets/custom_dropdown_field.dart';
import 'package:targafy/widgets/custom_text_field.dart';
import 'package:targafy/widgets/sort_dropdown_list.dart';
import 'package:targafy/widgets/submit_button.dart';

class AddParameter extends ConsumerStatefulWidget {
  const AddParameter({super.key});

  @override
  ConsumerState<AddParameter> createState() => _AddParameterState();
}

class _AddParameterState extends ConsumerState<AddParameter> {
  final TextEditingController _parameterNameController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> _selectedDepartmentIds = [];
  final List<String> _selectedDepartmentNames = [];
  bool _allSelected = false;

  @override
  void initState() {
    super.initState();
    // Fetch the businessId from the current selected business
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    if (businessId != null) {
      ref.read(departmentProvider(businessId));
    }
  }

  void _submitParameter() {
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    print(businessId);
    if (businessId != null &&
        _parameterNameController.text.isNotEmpty &&
        _selectedDepartmentIds.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      ref
          .read(parameterNotifierProvider.notifier)
          .addParameter(
            businessId,
            _parameterNameController.text,
            _selectedDepartmentIds,
            _descriptionController.text,
            context
          )
          .then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Parameter added successfully')),
          );
          Navigator.of(context).pop(true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to submit parameter')),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  Widget _buildChips() {
    if (_allSelected) {
      return InputChip(
        label: const Text('All Selected'),
        onDeleted: () {
          setState(() {
            _allSelected = false;
            _selectedDepartmentIds.clear();
            _selectedDepartmentNames.clear();
          });
        },
      );
    }
    if (_selectedDepartmentNames.isEmpty) {
      return const SizedBox
          .shrink(); // Return an empty widget if there are no selected departments
    }
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: _selectedDepartmentNames.map((departmentName) {
        return InputChip(
          label: Text(departmentName),
          onDeleted: () {
            setState(() {
              final index = _selectedDepartmentNames.indexOf(departmentName);
              if (index >= 0 && index < _selectedDepartmentNames.length) {
                _selectedDepartmentNames.removeAt(index);
                _selectedDepartmentIds.removeAt(index);
              }
            });
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    final asyncDepartments = ref.watch(departmentProvider(businessId ?? ''));

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    print(_selectedDepartmentIds);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(
                text: 'Add Parameter',
              ),
              SizedBox(height: height * 0.02),
              CustomInputField(
                labelText: 'Enter Parameter Name',
                controller: _parameterNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Parameter Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: height * 0.02),
              asyncDepartments.when(
                data: (departments) {
                  final sortedDepartments =
                      sortList(departments, (department) => department.name);
                  final allDepartmentIds =
                      sortedDepartments.map((dept) => dept.id).toList();
                  final allDepartmentNames =
                      sortedDepartments.map((dept) => dept.name).toList();

                  return CustomDropdownField(
                    labelText: 'Select Department',
                    value: null,
                    items: [
                      const DropdownMenuItem<String>(
                        value: 'selectAll',
                        child: Text('Select All'),
                      ),
                      ...sortedDepartments.map((department) {
                        return DropdownMenuItem<String>(
                          value: department.id,
                          child: Text(department.name),
                        );
                      }).toList(),
                    ],
                    onChanged: (value) {
                      if (value == 'selectAll') {
                        setState(() {
                          _allSelected = true;
                          _selectedDepartmentIds.clear();
                          _selectedDepartmentNames.clear();
                          _selectedDepartmentIds.addAll(allDepartmentIds);
                          _selectedDepartmentNames.addAll(allDepartmentNames);
                        });
                      } else if (value != null &&
                          !_selectedDepartmentIds.contains(value)) {
                        setState(() {
                          _allSelected = false;
                          _selectedDepartmentIds.add(value);
                          _selectedDepartmentNames.add(sortedDepartments
                              .firstWhere((dept) => dept.id == value)
                              .name);
                        });
                      }
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Text('Failed to load departments: $error'),
              ),
              SizedBox(height: height * 0.01),
              _buildChips(),
              SizedBox(height: height * 0.02),
              CustomInputField(
                controller: _descriptionController,
                labelText: 'Enter Description',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              SizedBox(height: height * 0.05),
              SubmitButton(onPressed: _submitParameter),
            ],
          ),
        ),
      ),
    );
  }
}
