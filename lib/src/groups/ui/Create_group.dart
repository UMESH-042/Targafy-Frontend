// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
// import 'package:targafy/src/groups/ui/controller/create_group_controller.dart';
// import 'package:targafy/src/groups/ui/model/create_group_model.dart';
// import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
// import 'package:targafy/src/users/ui/model/business_user_list_model.dart';
// import 'package:targafy/widgets/sort_dropdown_list.dart';
// import 'package:targafy/widgets/submit_button.dart';

// class CreateGroupPage extends ConsumerStatefulWidget {
//   const CreateGroupPage({super.key});

//   @override
//   _CreateGroupPageState createState() => _CreateGroupPageState();
// }

// class _CreateGroupPageState extends ConsumerState<CreateGroupPage> {
//   late final List<String> _selectedUsers = [];
//   final Map<String, String> _userNames = {};
//   bool _selectAll = false;
//   File? _logoImage;
//   final ImagePicker _picker = ImagePicker();
//   final TextEditingController _groupNameController = TextEditingController();
//   String _errorMessage = '';

//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _logoImage = File(image.path);
//       });
//     }
//   }

//   Future<void> _submitGroup() async {
//     final groupName = _groupNameController.text;
//     if (groupName.isEmpty || _selectedUsers.isEmpty) {
//       setState(() {
//         _errorMessage = 'Please fill in all required fields.';
//       });
//       return;
//     }

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('authToken');
//       final selectedBusinessData = ref.watch(currentBusinessProvider);
//       final selectedBusiness = selectedBusinessData?['business'] as Business?;
//       final businessId = selectedBusiness?.id;

//       String? logoUrl;
//       if (_logoImage != null) {
//         logoUrl =
//             await ref.read(groupControllerProvider).uploadLogo(_logoImage!);
//       }

//       final group = GroupModel(
//         groupName: groupName,
//         logo: logoUrl ?? '',
//         usersIds: _selectedUsers,
//       );
//       await ref
//           .read(groupControllerProvider)
//           .createGroup(group, businessId!, token!);

//       // Navigate back or show success message
//       Navigator.pop(context, true);
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to create group: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     final selectedBusinessData = ref.watch(currentBusinessProvider);
//     final selectedBusiness = selectedBusinessData?['business'] as Business?;
//     final businessId = selectedBusiness?.id;
//     final usersStream = ref.watch(businessUsersStreamProvider(businessId!));
//     print(_selectedUsers);

//     return SafeArea(
//       child: Stack(
//         children: [
//           Scaffold(
//             appBar: PreferredSize(
//               preferredSize: Size.fromHeight(height * .19),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                     vertical: height * 0.02, horizontal: width * .04),
//                 child: const Row(
//                   children: [
//                     BackButton(),
//                     SizedBox(width: 20),
//                     Text(
//                       "Create Group",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: const Row(
//                         children: [
//                           Text(
//                             "Name* ",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontFamily: "Poppins",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             textAlign: TextAlign.left,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: height * 0.01),
//                     TextField(
//                       controller: _groupNameController,
//                       decoration: InputDecoration(
//                         labelText: "Name*",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                       ),
//                     ),
//                     // SizedBox(height: height * 0.02),
//                     // Container(
//                     //   alignment: Alignment.centerLeft,
//                     //   child: const Row(
//                     //     children: [
//                     //       Text(
//                     //         "Add Logo Image: ",
//                     //         style: TextStyle(
//                     //           color: Colors.black,
//                     //           fontFamily: "Poppins",
//                     //           fontSize: 14,
//                     //           fontWeight: FontWeight.w600,
//                     //         ),
//                     //         textAlign: TextAlign.left,
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     // SizedBox(height: height * 0.01),
//                     // GestureDetector(
//                     //   onTap: _pickImage,
//                     //   child: Container(
//                     //     height: 150,
//                     //     width: double.infinity,
//                     //     decoration: BoxDecoration(
//                     //       borderRadius: BorderRadius.circular(15.0),
//                     //       border: Border.all(color: Colors.grey),
//                     //     ),
//                     //     child: _logoImage == null
//                     //         ? const Icon(
//                     //             Icons.add_a_photo,
//                     //             color: Colors.grey,
//                     //             size: 50,
//                     //           )
//                     //         : ClipRRect(
//                     //             borderRadius: BorderRadius.circular(15.0),
//                     //             child: Image.file(
//                     //               _logoImage!,
//                     //               fit: BoxFit.cover,
//                     //             ),
//                     //           ),
//                     //   ),
//                     // ),
//                     SizedBox(height: height * 0.02),
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: const Row(
//                         children: [
//                           Text(
//                             "Select Users To Add: ",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontFamily: "Poppins",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                             ),
//                             textAlign: TextAlign.left,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: height * 0.02),
//                     // usersStream.when(
//                     //   data: (users) {
//                     //     final sortedUsers =
//                     //         sortList(users, (user) => user.name);
//                     //     return DropdownButtonFormField<String>(
//                     //       items: sortedUsers.map((BusinessUserModel user) {
//                     //         return DropdownMenuItem<String>(
//                     //           value: user.userId,
//                     //           child: Text(user.name),
//                     //         );
//                     //       }).toList(),
//                     //       onChanged: (String? newValue) {
//                     //         setState(() {
//                     //           if (newValue != null &&
//                     //               !_selectedUsers.contains(newValue)) {
//                     //             _selectedUsers.add(newValue);
//                     //             final selectedUser = users.firstWhere(
//                     //                 (user) => user.userId == newValue);
//                     //             _userNames[newValue] = selectedUser.name;
//                     //           }
//                     //         });
//                     //       },
//                     //       hint: const Text('Choose Users'),
//                     //       decoration: InputDecoration(
//                     //         contentPadding: const EdgeInsets.symmetric(
//                     //             vertical: 15, horizontal: 10),
//                     //         border: OutlineInputBorder(
//                     //           borderRadius: BorderRadius.circular(15.0),
//                     //         ),
//                     //       ),
//                     //     );
//                     //   },
//                     //   loading: () => const CircularProgressIndicator(),
//                     //   error: (error, stackTrace) => Text('Error: $error'),
//                     // ),
//                     // SizedBox(height: height * 0.02),
//                     // Wrap(
//                     //   spacing: 8,
//                     //   children: _selectedUsers.map((userId) {
//                     //     return Padding(
//                     //       padding: const EdgeInsets.symmetric(horizontal: 4),
//                     //       child: Chip(
//                     //         label: Text(_userNames[userId]!),
//                     //         onDeleted: () {
//                     //           setState(() {
//                     //             _selectedUsers.remove(userId);
//                     //             _userNames.remove(userId);
//                     //           });
//                     //         },
//                     //       ),
//                     //     );
//                     //   }).toList(),
//                     // ),
//                     usersStream.when(
//                       data: (users) {
//                         final sortedUsers =
//                             sortList(users, (user) => user.name);
//                         return DropdownButtonFormField<String>(
//                           items: [
//                             DropdownMenuItem<String>(
//                               value: 'SelectAll',
//                               child: Text('Select All'),
//                             ),
//                             ...sortedUsers.map((BusinessUserModel user) {
//                               return DropdownMenuItem<String>(
//                                 value: user.userId,
//                                 child: Text(user.name),
//                               );
//                             }).toList(),
//                           ],
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               if (newValue == 'SelectAll') {
//                                 _selectedUsers.clear();
//                                 _userNames.clear();
//                                 _selectedUsers
//                                     .addAll(users.map((user) => user.userId));
//                                 users.forEach((user) {
//                                   _userNames[user.userId] = user.name;
//                                 });
//                                 _selectAll = true;
//                               } else if (newValue != null &&
//                                   !_selectedUsers.contains(newValue)) {
//                                 _selectedUsers.add(newValue);
//                                 final selectedUser = users.firstWhere(
//                                     (user) => user.userId == newValue);
//                                 _userNames[newValue] = selectedUser.name;
//                                 _selectAll =
//                                     _selectedUsers.length == users.length;
//                               }
//                             });
//                           },
//                           hint: const Text('Choose Users'),
//                           decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 15, horizontal: 10),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                           ),
//                         );
//                       },
//                       loading: () => const CircularProgressIndicator(),
//                       error: (error, stackTrace) => Text('Error: $error'),
//                     ),
//                     SizedBox(height: height * 0.02),
//                     Wrap(
//                       spacing: 8,
//                       children: _selectedUsers.isEmpty
//                           ? []
//                           : _selectAll
//                               ? [
//                                   Chip(
//                                     label: Text('All Selected'),
//                                     onDeleted: () {
//                                       setState(() {
//                                         _selectedUsers.clear();
//                                         _userNames.clear();
//                                         _selectAll = false;
//                                       });
//                                     },
//                                   )
//                                 ]
//                               : _selectedUsers.map((userId) {
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 4),
//                                     child: Chip(
//                                       label: Text(_userNames[userId]!),
//                                       onDeleted: () {
//                                         setState(() {
//                                           _selectedUsers.remove(userId);
//                                           _userNames.remove(userId);
//                                           _selectAll = false;
//                                         });
//                                       },
//                                     ),
//                                   );
//                                 }).toList(),
//                     ),

//                     SizedBox(height: height * 0.02),
//                     if (_errorMessage.isNotEmpty)
//                       Text(
//                         _errorMessage,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     SubmitButton(onPressed: _submitGroup)
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/src/groups/ui/controller/create_group_controller.dart';
import 'package:targafy/widgets/Special_back_button.dart';
import 'package:targafy/widgets/submit_button.dart';

class DepartmentCreatePage extends ConsumerStatefulWidget {
  const DepartmentCreatePage({super.key});

  @override
  _DepartmentCreatePageState createState() => _DepartmentCreatePageState();
}

class _DepartmentCreatePageState extends ConsumerState<DepartmentCreatePage> {
  final List<String> _departmentNames = [];
  final TextEditingController _nameController = TextEditingController();
  String _errorMessage = '';

  Future<void> _submitGroup() async {
    if (_departmentNames.isEmpty) {
      setState(() {
        _errorMessage = 'Please add at least one department name';
      });
      return;
    }

    final selectedBusinessData = ref.read(currentBusinessProvider);
    final selectedBusiness = selectedBusinessData?['business'] as Business?;
    final businessId = selectedBusiness?.id;

    if (businessId != null) {
      try {
        await ref
            .read(createDepartmentProvider)
            .createDepartments(_departmentNames, businessId);
        setState(() {
          _departmentNames.clear();
          _nameController.clear();
          _errorMessage = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Departments created successfully')),
        );
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to create departments';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Invalid business ID';
      });
    }
  }

  void _addDepartment() {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      setState(() {
        _departmentNames.add(name);
        _nameController.clear();
      });
    }
  }

  void _removeDepartment(String name) {
    setState(() {
      _departmentNames.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            // appBar: PreferredSize(
            //   preferredSize: Size.fromHeight(height * .19),
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(
            //         vertical: height * 0.02, horizontal: width * .04),
            //     child: const Row(
            //       children: [
            //         SpecialBackButton(text: 'Create Departments',),
            //         // SizedBox(width: 20),
            //         // Text(
            //         //   "Create Departments",
            //         //   style: TextStyle(
            //         //     color: Colors.black,
            //         //     fontFamily: "Poppins",
            //         //     fontWeight: FontWeight.bold,
            //         //     fontSize: 18,
            //         //   ),
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
            body: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SpecialBackButton(
                      text: 'Create Departments',
                    ),
                    SizedBox(
                      height: getScreenheight(context) * 0.05,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Row(
                        children: [
                          Text(
                            "Name* ",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: "Name*",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _addDepartment,
                          icon: Icon(Icons.add, color: Colors.black),
                          color: Colors.blue,
                          tooltip: 'Add Department',
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    if (_departmentNames.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _departmentNames
                            .map(
                              (name) => Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      name,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => _removeDepartment(name),
                                    icon: Icon(Icons.close, color: Colors.red),
                                    tooltip: 'Remove',
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    SizedBox(height: height * 0.02),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: height * 0.02),
                    SubmitButton(onPressed: _submitGroup),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
