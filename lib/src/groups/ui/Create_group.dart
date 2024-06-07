import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
import 'package:targafy/widgets/submit_button.dart';
import 'package:targafy/src/users/ui/model/business_user_list_model.dart';

class CreateGroupPage extends ConsumerStatefulWidget {
  const CreateGroupPage({super.key});

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends ConsumerState<CreateGroupPage> {
  late List<String> _selectedUsers = []; // Change to store only user IDs
  Map<String, String> _userNames = {}; // Map to store user ID to name mapping
  bool selectAll = false;
  File? _logoImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _logoImage = File(image.path);
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
    final usersStream = ref.watch(businessUsersStreamProvider(businessId!));

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
                      "Create Group",
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
                    decoration: InputDecoration(
                      labelText: "Name*",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onChanged: (p0) {},
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
                  usersStream.when(
                    data: (users) {
                      return DropdownButtonFormField<String>(
                        items: users.map((BusinessUserModel user) {
                          return DropdownMenuItem<String>(
                            value: user.userId,
                            child: Text(user.name),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            if (newValue != null &&
                                !_selectedUsers.contains(newValue)) {
                              _selectedUsers.add(newValue);
                              final selectedUser = users.firstWhere(
                                  (user) => user.userId == newValue);
                              _userNames[newValue] =
                                  selectedUser.name; // Store the user name
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
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stackTrace) => Text('Error: $error'),
                  ),
                  SizedBox(height: height * 0.02),
                  Wrap(
                    spacing: 8, // Adjust the spacing as needed
                    children: _selectedUsers.map((userId) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4), // Adjust the padding as needed
                        child: Chip(
                          label: Text(
                              _userNames[userId]!), // Display the user name
                          onDeleted: () {
                            setState(() {
                              _selectedUsers.remove(userId);
                              _userNames.remove(
                                  userId); // Remove from the map as well
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: height * 0.02),
                  SubmitButton(onPressed: () {
                    print(_selectedUsers);
                    // Perform submission logic here, with user IDs available in _selectedUsers
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
