// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';

// class AddParameter extends ConsumerStatefulWidget {
//   const AddParameter({Key? key}) : super(key: key);

//   @override
//   _AddParameterState createState() => _AddParameterState();
// }

// class _AddParameterState extends ConsumerState<AddParameter> {
//   final TextEditingController _parameterNameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _chartsController = TextEditingController();
//   List<String> _selectedUsers = [];
//   String? _selectedChart;
//   String? _selectedDuration;

//   @override
//   void initState() {
//     super.initState();
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     if (businessId != null) {
//       ref.read(businessUsersProvider.notifier).fetchBusinessUsers(businessId);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final asyncUsers = ref.watch(businessUsersProvider);

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CustomBackButton(
//               text: 'Add Parameter',
//             ),
//             SizedBox(height: 20),
//             CustomFieldParameter(
//               controller: _parameterNameController,
//               label: 'Enter Parameter Name',
//             ),
//             SizedBox(height: 20),
//             asyncUsers.when(
//               data: (users) => CustomFieldParameter(
//                 label: 'Select User',
//                 dropdownValue: _selectedUsers,
//                 dropdownItems: users.map((user) {
//                   return DropdownMenuItem<String>(
//                     value: user.userId,
//                     child: Text(user.name),
//                   );
//                 }).toList(),
//                 onChanged: (List<String>? value) {
//                   setState(() {
//                     _selectedUsers = value ?? [];
//                   });
//                 },
//                 isMultiSelect: true,
//               ),
//               loading: () => Center(child: CircularProgressIndicator()),
//               error: (error, stackTrace) => Text('Failed to load users: $error'),
//             ),
//             SizedBox(height: 20),
//             CustomFieldParameter(
//               label: 'Select charts',
//               dropdownValue: _selectedChart,
//               dropdownItems: [
//                 DropdownMenuItem(value: 'Line Chart', child: Text('Line Chart')),
//                 DropdownMenuItem(value: 'Table', child: Text('Table')),
//                 DropdownMenuItem(value: 'Pie Chart', child: Text('Pie Chart')),
//                 DropdownMenuItem(value: 'Lines', child: Text('Lines')),
//               ],
//               onChanged: (String? value) {
//                 setState(() {
//                   _selectedChart = value;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             CustomFieldParameter(
//               label: 'Duration',
//               dropdownValue: _selectedDuration,
//               dropdownItems: [
//                 DropdownMenuItem(value: '1stTo31st', child: Text('1stTo31st')),
//                 DropdownMenuItem(value: 'upto30days', child: Text('upto30days')),
//                 DropdownMenuItem(value: '30days', child: Text('30days')),
//               ],
//               onChanged: (String? value) {
//                 setState(() {
//                   _selectedDuration = value;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             CustomFieldParameter(
//               controller: _descriptionController,
//               label: 'Enter Description',
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _submitParameter(context),
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _submitParameter(BuildContext context) async {
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     if (businessId != null) {
//       final notifier = ref.read(parameterProvider.notifier);
//       final isSuccess = await notifier.addParameter(
//         businessId,
//         _parameterNameController.text,
//         _selectedUsers,
//         _selectedChart ?? '',
//         _selectedDuration ?? '',
//         _descriptionController.text,
//       );

//       if (isSuccess) {
//         Navigator.of(context).pop(); // Close the page if submission is successful
//       }
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/core/shared/components/back_button.dart';
import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';
import 'package:targafy/src/parameters/view/widgets/CustomParameterField.dart';
import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';

class AddParameter extends ConsumerStatefulWidget {
  const AddParameter({Key? key}) : super(key: key);

  @override
  ConsumerState<AddParameter> createState() => _AddParameterState();
}

class _AddParameterState extends ConsumerState<AddParameter> {
  final TextEditingController _parameterNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<String> _selectedUserIds = [];
  List<String> _selectedUsersNames = [];
  String? _selectedChart;
  String? _selectedDuration;

  @override
  void initState() {
    super.initState();
    // Fetch the businessId from the current selected business
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    if (businessId != null) {
      ref.read(businessUsersProvider.notifier).fetchBusinessUsers(businessId);
    }
  }

  void _submitParameter() {
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    print(businessId);
    if (businessId != null &&
        _parameterNameController.text.isNotEmpty &&
        _selectedUserIds.isNotEmpty &&
        _selectedChart != null &&
        _selectedDuration != null &&
        _descriptionController.text.isNotEmpty) {
      ref
          .read(parameterNotifierProvider.notifier)
          .addParameter(
            businessId,
            _parameterNameController.text,
            _selectedUserIds,
            _selectedChart!,
            _selectedDuration!,
            _descriptionController.text,
          )
          .then((success) {
        if (success) {
          Navigator.of(context).pop(true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit parameter')),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  Widget _buildChips() {
    if (_selectedUsersNames.isEmpty) {
      return SizedBox.shrink(); // Return an empty widget if there are no selected users
    }
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: _selectedUsersNames.map((userName) {
        return InputChip(
          label: Text(userName),
          onDeleted: () {
            setState(() {
              final index = _selectedUsersNames.indexOf(userName);
              if (index >= 0 && index < _selectedUsersNames.length) {
                _selectedUsersNames.removeAt(index);
                _selectedUserIds.removeAt(index);
              }
            });
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncUsers = ref.watch(businessUsersProvider);
    print(_selectedUserIds);
 
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomBackButton(
              text: 'Add Parameter',
            ),
            SizedBox(height: 20),
            CustomFieldParameter(
              controller: _parameterNameController,
              label: 'Enter Parameter Name',
            ),
            SizedBox(height: 20),
            asyncUsers.when(
              data: (users) => DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select User'),
                value: null,
                items: users.map((user) {
                  return DropdownMenuItem<String>(
                    value: user.userId,
                    child: Text(user.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null && !_selectedUserIds.contains(value)) {
                    setState(() {
                      _selectedUserIds.add(value);
                      _selectedUsersNames.add(users
                          .firstWhere((user) => user.userId == value)
                          .name);
                    });
                  }
                },
                selectedItemBuilder: (BuildContext context) {
                  return _selectedUsersNames.map<Widget>((String item) {
                    return Text(item);
                  }).toList();
                },
                isExpanded: true,
                hint: Text('Select Users'),
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Text('Failed to load users: $error'),
            ),
            SizedBox(height: 20),
            _buildChips(),
            SizedBox(height: 20),
            CustomFieldParameter(
              label: 'Select charts',
              dropdownValue: _selectedChart,
              dropdownItems: const [
                DropdownMenuItem(value: 'Line Chart', child: Text('Line Chart')),
                DropdownMenuItem(value: 'Table', child: Text('Table')),
                DropdownMenuItem(value: 'Pie Chart', child: Text('Pie Chart')),
                DropdownMenuItem(value: 'Lines', child: Text('Lines')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedChart = value;
                });
              },
            ),
            SizedBox(height: 20),
            CustomFieldParameter(
              label: 'Duration',
              dropdownValue: _selectedDuration,
              dropdownItems: [
                DropdownMenuItem(value: '1stTo31st', child: Text('1stTo31st')),
                DropdownMenuItem(value: 'upto30days', child: Text('upto30days')),
                DropdownMenuItem(value: '30days', child: Text('30days')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedDuration = value;
                });
              },
            ),
            SizedBox(height: 20),
            CustomFieldParameter(
              controller: _descriptionController,
              label: 'Enter Description',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitParameter,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
