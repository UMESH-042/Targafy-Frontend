// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
// import 'package:targafy/src/groups/ui/controller/create_group_controller.dart';
// import 'package:targafy/src/groups/ui/controller/create_subgroup_controller.dart';
// import 'package:targafy/src/groups/ui/model/create_group_model.dart';
// import 'package:targafy/src/groups/ui/model/create_sub_group_model.dart';
// import 'package:targafy/src/groups/ui/model/group_data_moderl.dart';
// import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
// import 'package:targafy/src/users/ui/model/business_user_list_model.dart';
// import 'package:targafy/widgets/submit_button.dart';

// class CreateSubGroupPage extends ConsumerStatefulWidget {
//   final GroupDataModel group;
//   const CreateSubGroupPage(this.group, {super.key});

//   @override
//   _CreateSubGroupPageState createState() => _CreateSubGroupPageState();
// }

// class _CreateSubGroupPageState extends ConsumerState<CreateSubGroupPage> {
//   late List<String> _selectedUsers = [];
//   Map<String, String> _userNames = {};
//   bool selectAll = false;
//   File? _logoImage;
//   final ImagePicker _picker = ImagePicker();
//   final TextEditingController _subgroupNameController = TextEditingController();
//   String _errorMessage = '';

//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _logoImage = File(image.path);
//       });
//     }
//   }

//   Future<void> _submitSubGroup() async {
//     final subgroupName = _subgroupNameController.text;
//     if (subgroupName.isEmpty || _logoImage == null || _selectedUsers.isEmpty) {
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

//       final logoUrl = await ref
//           .read(SubgroupControllerProvider)
//           .uploadLogo(_logoImage!, token);
//       final group = SubGroupModel(
//         subgroupName: subgroupName,
//         logo: logoUrl,
//         usersIds: _selectedUsers,
//       );

//       await ref
//           .read(SubgroupControllerProvider)
//           .createSubGroup(group, businessId!, token!);

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
//                       "Create Sub group",
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
//                       controller: _subgroupNameController,
//                       decoration: InputDecoration(
//                         labelText: "Name*",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: height * 0.02),
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: const Row(
//                         children: [
//                           Text(
//                             "Add Logo Image: ",
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
//                     GestureDetector(
//                       onTap: _pickImage,
//                       child: Container(
//                         height: 150,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15.0),
//                           border: Border.all(color: Colors.grey),
//                         ),
//                         child: _logoImage == null
//                             ? const Icon(
//                                 Icons.add_a_photo,
//                                 color: Colors.grey,
//                                 size: 50,
//                               )
//                             : ClipRRect(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 child: Image.file(
//                                   _logoImage!,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                       ),
//                     ),
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
//                     usersStream.when(
//                       data: (users) {
//                         return DropdownButtonFormField<String>(
//                           items: users.map((BusinessUserModel user) {
//                             return DropdownMenuItem<String>(
//                               value: user.userId,
//                               child: Text(user.name),
//                             );
//                           }).toList(),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               if (newValue != null &&
//                                   !_selectedUsers.contains(newValue)) {
//                                 _selectedUsers.add(newValue);
//                                 final selectedUser = users.firstWhere(
//                                     (user) => user.userId == newValue);
//                                 _userNames[newValue] = selectedUser.name;
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
//                       children: _selectedUsers.map((userId) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 4),
//                           child: Chip(
//                             label: Text(_userNames[userId]!),
//                             onDeleted: () {
//                               setState(() {
//                                 _selectedUsers.remove(userId);
//                                 _userNames.remove(userId);
//                               });
//                             },
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                     SizedBox(height: height * 0.02),
//                     if (_errorMessage.isNotEmpty)
//                       Text(
//                         _errorMessage,
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     SubmitButton(onPressed: _submitSubGroup)
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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/src/groups/ui/controller/create_subgroup_controller.dart';
import 'package:targafy/src/groups/ui/controller/sub_group_user_list_controller.dart';
import 'package:targafy/src/groups/ui/model/create_sub_group_model.dart';
import 'package:targafy/src/groups/ui/model/group_data_moderl.dart';

import 'package:targafy/widgets/submit_button.dart';

class CreateSubGroupPage extends ConsumerStatefulWidget {
  final GroupDataModel group;
  const CreateSubGroupPage(this.group, {super.key});

  @override
  _CreateSubGroupPageState createState() => _CreateSubGroupPageState();
}

class _CreateSubGroupPageState extends ConsumerState<CreateSubGroupPage> {
  late final List<String> _selectedUsers = [];
  final Map<String, String> _userNames = {};
  File? _logoImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _subgroupNameController = TextEditingController();
  String _errorMessage = '';

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _logoImage = File(image.path);
      });
    }
  }

  Future<void> _submitSubGroup() async {
    final subgroupName = _subgroupNameController.text;
    if (subgroupName.isEmpty || _logoImage == null || _selectedUsers.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all required fields.';
      });
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final selectedBusinessData = ref.watch(currentBusinessProvider);
      final selectedBusiness = selectedBusinessData?['business'] as Business?;
      final businessId = selectedBusiness?.id;

      final logoUrl = await ref
          .read(SubgroupControllerProvider)
          .uploadLogo(_logoImage!, token);
      final group = SubGroupModel(
        subgroupName: subgroupName,
        logo: logoUrl,
        usersIds: _selectedUsers,
      );
      print(group);
      await ref
          .read(SubgroupControllerProvider)
          .createSubGroup(group, widget.group.id, token!);

      // Navigate back or show success message
      Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to create group: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final selectedBusiness = selectedBusinessData?['business'] as Business?;
    final businessId = selectedBusiness?.id;
    final usersStream = ref
        .watch(subgroupUsersControllerProvider)
        .fetchGroupUserList(businessId!, widget.group.id);

    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(height * .19),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.02, horizontal: width * .04),
                child: const Row(
                  children: [
                    BackButton(),
                    SizedBox(width: 20),
                    Text(
                      "Create Sub group",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                    TextField(
                      controller: _subgroupNameController,
                      decoration: InputDecoration(
                        labelText: "Name*",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Row(
                        children: [
                          Text(
                            "Add Logo Image: ",
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
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: _logoImage == null
                            ? const Icon(
                                Icons.add_a_photo,
                                color: Colors.grey,
                                size: 50,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.file(
                                  _logoImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Row(
                        children: [
                          Text(
                            "Select Users To Add: ",
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
                    SizedBox(height: height * 0.02),
                    FutureBuilder<List<SubgroupUserModel>>(
                      future: usersStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // While waiting for data, show a loading indicator
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // If there's an error, display the error message
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // If data is available, build the UI with the data
                          final users = snapshot.data!;
                          return DropdownButtonFormField<String>(
                            items: users.map((SubgroupUserModel user) {
                              return DropdownMenuItem<String>(
                                value: user.id,
                                child: Text(user.name),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                if (newValue != null &&
                                    !_selectedUsers.contains(newValue)) {
                                  _selectedUsers.add(newValue);
                                  final selectedUser = users.firstWhere(
                                      (user) => user.id == newValue);
                                  _userNames[newValue] = selectedUser.name;
                                }
                              });
                            },
                            hint: const Text('Choose Users'),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Wrap(
                      spacing: 8,
                      children: _selectedUsers.map((userId) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                            label: Text(_userNames[userId]!),
                            onDeleted: () {
                              setState(() {
                                _selectedUsers.remove(userId);
                                _userNames.remove(userId);
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: height * 0.02),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    SubmitButton(onPressed: _submitSubGroup)
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
