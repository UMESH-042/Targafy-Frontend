// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/src/home/view/screens/controller/user_profile_data_controller.dart';
// import 'model/user_business_model_drawer.dart';

// class UserProfile extends ConsumerStatefulWidget {
//   const UserProfile({super.key});

//   @override
//   ConsumerState<UserProfile> createState() => _UserProfileState();
// }

// class _UserProfileState extends ConsumerState<UserProfile> {
//   late User _user;
//   XFile? _profileImage;
//   bool _uploading = false;

//   String? _profileImageUrl;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserAvatar();
//   }

//   Future<void> _fetchUserAvatar() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken');
//     final controller = ref.read(userProfileLogoControllerProvider);
//     try {
//       final avatarUrl = await controller.fetchUserAvatar(token!);
//       setState(() {
//         _profileImageUrl = avatarUrl;
//       });
//     } catch (e) {
//       print('Error fetching user avatar: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final asyncValue = ref.watch(userProvider);

//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//         centerTitle: true,
//         title: const Text(
//           "User Profile",
//           style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: asyncValue.when(
//         data: (user) {
//           _user = user;
//           return _buildUserProfile();
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stackTrace) => Center(child: Text(error.toString())),
//       ),
//     );
//   }

//   Widget _buildUserProfile() {
//     return SafeArea(
//       child: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           GestureDetector(
//             onTap: _changePicture,
//             child: Center(
//               child: _buildAvatar(),
//             ),
//           ),
//           const SizedBox(height: 20),
//           _buildInfoTile("Name", _user.name, Icons.person),
//           const SizedBox(height: 10),
//           _buildInfoTile("Email", _user.email, Icons.email),
//           const SizedBox(height: 10),
//           _buildInfoTile(
//               "Phone Number",
//               "${_user.contactNumber['countryCode']} ${_user.contactNumber['number']}",
//               Icons.phone),
//           const SizedBox(height: 10),
//           // Add more info tiles as needed
//         ],
//       ),
//     );
//   }

//   Widget _buildAvatar() {
//     return Stack(
//       children: [
//         CircleAvatar(
//           radius: 60,
//           backgroundImage: _profileImage != null
//               ? FileImage(File(_profileImage!.path))
//               : (_profileImageUrl != null
//                       ? NetworkImage(_profileImageUrl!)
//                       : const AssetImage("assets/images/placeholder.png"))
//                   as ImageProvider,
//         ),
//         if (_uploading)
//           const Positioned.fill(
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildInfoTile(String label, String value, IconData icon) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label),
//           Text(
//             value,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//       tileColor: const Color(0xffF3EEEA),
//     );
//   }

//   Future<void> _changePicture() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _profileImage = pickedImage;
//         _uploading = true;
//       });

//       final controller = ref.read(userProfileLogoControllerProvider);

//       try {
//         final imageUrl = await controller.uploadLogo(File(pickedImage.path));
//         await controller.updateUserProfileLogo(imageUrl);
//         setState(() {
//           _uploading = false;
//         });
//       } catch (e) {
//         setState(() {
//           _uploading = false;
//         });
//         print('Error uploading image: $e');
//       }
//     }
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/src/home/view/screens/controller/mandatory_Filed_name_controller.dart';
// import 'package:targafy/src/home/view/screens/controller/user_profile_data_controller.dart';
// import 'package:targafy/utils/remote_routes.dart';
// import 'model/user_business_model_drawer.dart';
// class UserProfile extends ConsumerStatefulWidget {
//   const UserProfile({super.key});

//   @override
//   ConsumerState<UserProfile> createState() => _UserProfileState();
// }

// class _UserProfileState extends ConsumerState<UserProfile> {
//   late User _user;
//   XFile? _profileImage;
//   bool _uploading = false;

//   String? _profileImageUrl;
//   final TextEditingController _nameController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserAvatar();
//   }

//   Future<void> _fetchUserAvatar() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken');
//     final controller = ref.read(userProfileLogoControllerProvider);
//     try {
//       final avatarUrl = await controller.fetchUserAvatar(token!);
//       setState(() {
//         _profileImageUrl = avatarUrl;
//       });
//     } catch (e) {
//       print('Error fetching user avatar: $e');
//     }
//   }

//   Future<void> _updateName() async {
//     try {
//       await ref.read(nameControllerProvider.notifier).updateName(_nameController.text);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Name updated successfully')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update name: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final asyncValue = ref.watch(userProvider);

//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//         centerTitle: true,
//         title: const Text(
//           "User Profile",
//           style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: asyncValue.when(
//         data: (user) {
//           _user = user;
//           _nameController.text = user.name; // Initialize the text controller with the current name
//           return _buildUserProfile();
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stackTrace) => Center(child: Text(error.toString())),
//       ),
//     );
//   }

//   Widget _buildUserProfile() {
//     return SafeArea(
//       child: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           GestureDetector(
//             onTap: _changePicture,
//             child: Center(
//               child: _buildAvatar(),
//             ),
//           ),
//           const SizedBox(height: 20),
//           _buildEditableInfoTile("Name", _nameController, Icons.person, _updateName),
//           const SizedBox(height: 10),
//           _buildInfoTile("Email", _user.email, Icons.email),
//           const SizedBox(height: 10),
//           _buildInfoTile(
//               "Phone Number",
//               "${_user.contactNumber['countryCode']} ${_user.contactNumber['number']}",
//               Icons.phone),
//           const SizedBox(height: 10),
//           // Add more info tiles as needed
//         ],
//       ),
//     );
//   }

//   Widget _buildAvatar() {
//     return Stack(
//       children: [
//         CircleAvatar(
//           radius: 60,
//           backgroundImage: _profileImage != null
//               ? FileImage(File(_profileImage!.path))
//               : (_profileImageUrl != null
//                       ? NetworkImage(_profileImageUrl!)
//                       : const AssetImage("assets/images/placeholder.png"))
//                   as ImageProvider,
//         ),
//         if (_uploading)
//           const Positioned.fill(
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildEditableInfoTile(String label, TextEditingController controller, IconData icon, VoidCallback onSave) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label),
//           TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: "Enter $label",
//             ),
//           ),
//           ElevatedButton(
//             onPressed: onSave,
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//       tileColor: const Color(0xffF3EEEA),
//     );
//   }

//   Widget _buildInfoTile(String label, String value, IconData icon) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label),
//           Text(
//             value,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//       tileColor: const Color(0xffF3EEEA),
//     );
//   }

//   Future<void> _changePicture() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _profileImage = pickedImage;
//         _uploading = true;
//       });

//       final controller = ref.read(userProfileLogoControllerProvider);

//       try {
//         final imageUrl = await controller.uploadLogo(File(pickedImage.path));
//         await controller.updateUserProfileLogo(imageUrl);
//         setState(() {
//           _uploading = false;
//         });
//       } catch (e) {
//         setState(() {
//           _uploading = false;
//         });
//         print('Error uploading image: $e');
//       }
//     }
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/core/shared/custom_button.dart';
import 'package:targafy/src/home/view/screens/controller/mandatory_Filed_name_controller.dart';
import 'package:targafy/src/home/view/screens/controller/user_profile_data_controller.dart';
import 'package:targafy/utils/remote_routes.dart';
import 'model/user_business_model_drawer.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  ConsumerState<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  late User _user;
  XFile? _profileImage;
  bool _uploading = false;

  String? _profileImageUrl;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserAvatar();
  }

  Future<void> _fetchUserAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final controller = ref.read(userProfileLogoControllerProvider);
    try {
      final avatarUrl = await controller.fetchUserAvatar(token!);
      setState(() {
        _profileImageUrl = avatarUrl;
      });
    } catch (e) {
      print('Error fetching user avatar: $e');
    }
  }

  Future<void> _updateProfile() async {
    try {
      await ref
          .read(nameControllerProvider.notifier)
          .updateName(_nameController.text);
      // Add other updates here if there are additional fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const Text(
          "User Profile",
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: asyncValue.when(
        data: (user) {
          _user = user;
          _nameController.text =
              user.name; // Initialize the text controller with the current name
          return _buildUserProfile();
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }

  Widget _buildUserProfile() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: _changePicture,
            child: Center(
              child: _buildAvatar(),
            ),
          ),
          const SizedBox(height: 20),
          _buildEditableInfoTile("Name", _nameController, Icons.person),
          const SizedBox(height: 10),
          _buildInfoTile("Email", _user.email, Icons.email),
          const SizedBox(height: 10),
          _buildInfoTile(
              "Phone Number",
              "${_user.contactNumber['countryCode']} ${_user.contactNumber['number']}",
              Icons.phone),
          const SizedBox(height: 10),
          // Add more info tiles as needed
          const SizedBox(height: 20),
          CustomButton(
            text: 'Save',
            function: () {
              _updateProfile();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: _profileImage != null
              ? FileImage(File(_profileImage!.path))
              : (_profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!)
                      : NetworkImage(
                          'https://randomuser.me/api/portraits/lego/2.jpg'))
                  as ImageProvider,
        ),
        if (_uploading)
          const Positioned.fill(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  Widget _buildEditableInfoTile(
      String label, TextEditingController controller, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter $label",
            ),
          ),
        ],
      ),
      tileColor: const Color(0xffF3EEEA),
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      tileColor: const Color(0xffF3EEEA),
    );
  }

  Future<void> _changePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
        _uploading = true;
      });

      final controller = ref.read(userProfileLogoControllerProvider);

      try {
        final imageUrl = await controller.uploadLogo(File(pickedImage.path));
        await controller.updateUserProfileLogo(imageUrl);
        setState(() {
          _uploading = false;
        });
      } catch (e) {
        setState(() {
          _uploading = false;
        });
        print('Error uploading image: $e');
      }
    }
  }
}


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/core/shared/custom_button.dart';
// import 'package:targafy/src/home/view/screens/controller/mandatory_Filed_name_controller.dart';
// import 'package:targafy/src/home/view/screens/controller/user_profile_data_controller.dart';
// import 'package:targafy/utils/remote_routes.dart';
// import 'model/user_business_model_drawer.dart';

// class UserProfile extends ConsumerStatefulWidget {
//   const UserProfile({super.key});

//   @override
//   ConsumerState<UserProfile> createState() => _UserProfileState();
// }

// class _UserProfileState extends ConsumerState<UserProfile> {
//   late User _user;
//   XFile? _profileImage;
//   bool _uploading = false;

//   String? _profileImageUrl;
//   final TextEditingController _nameController = TextEditingController();
//   bool _isEditingName = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserAvatar();
//   }

//   Future<void> _fetchUserAvatar() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken');
//     final controller = ref.read(userProfileLogoControllerProvider);
//     try {
//       final avatarUrl = await controller.fetchUserAvatar(token!);
//       setState(() {
//         _profileImageUrl = avatarUrl;
//       });
//     } catch (e) {
//       print('Error fetching user avatar: $e');
//     }
//   }

//   Future<void> _updateProfile() async {
//     try {
//       await ref
//           .read(nameControllerProvider.notifier)
//           .updateName(_nameController.text);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Profile updated successfully')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update profile: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final asyncValue = ref.watch(userProvider);

//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//         centerTitle: true,
//         title: const Text(
//           "User Profile",
//           style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: asyncValue.when(
//         data: (user) {
//           _user = user;
//           _nameController.text =
//               user.name; // Initialize the text controller with the current name
//           return _buildUserProfile();
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stackTrace) => Center(child: Text(error.toString())),
//       ),
//     );
//   }

//   Widget _buildUserProfile() {
//     return SafeArea(
//       child: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           GestureDetector(
//             onTap: _changePicture,
//             child: Center(
//               child: _buildAvatar(),
//             ),
//           ),
//           const SizedBox(height: 20),
//           _buildEditableInfoTile("Name", _nameController, Icons.person, () {
//             setState(() {
//               _isEditingName = true;
//             });
//           }),
//           const SizedBox(height: 10),
//           _buildInfoTile("Email", _user.email, Icons.email),
//           const SizedBox(height: 10),
//           _buildInfoTile(
//               "Phone Number",
//               "${_user.contactNumber['countryCode']} ${_user.contactNumber['number']}",
//               Icons.phone),
//           const SizedBox(height: 20),
//           CustomButton(
//             text: 'Save',
//             function: () {
//               _updateProfile();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAvatar() {
//     return Stack(
//       children: [
//         CircleAvatar(
//           radius: 60,
//           backgroundImage: _profileImage != null
//               ? FileImage(File(_profileImage!.path))
//               : (_profileImageUrl != null
//                       ? NetworkImage(_profileImageUrl!)
//                       : const AssetImage("assets/images/placeholder.png"))
//                   as ImageProvider,
//         ),
//         if (_uploading)
//           const Positioned.fill(
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildEditableInfoTile(String label, TextEditingController controller,
//       IconData icon, VoidCallback onEdit) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(label),
//               IconButton(
//                 icon: Icon(Icons.edit),
//                 onPressed: onEdit,
//               ),
//             ],
//           ),
//           if (_isEditingName)
//             TextField(
//               controller: controller,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: "Enter $label",
//               ),
//             )
//           else
//             Text(controller.text),
//         ],
//       ),
//       tileColor: const Color(0xffF3EEEA),
//     );
//   }

//   Widget _buildInfoTile(String label, String value, IconData icon) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label),
//           Text(
//             value,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//       tileColor: const Color(0xffF3EEEA),
//     );
//   }

//   Future<void> _changePicture() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _profileImage = pickedImage;
//         _uploading = true;
//       });

//       final controller = ref.read(userProfileLogoControllerProvider);

//       try {
//         final imageUrl = await controller.uploadLogo(File(pickedImage.path));
//         await controller.updateUserProfileLogo(imageUrl);
//         setState(() {
//           _uploading = false;
//         });
//       } catch (e) {
//         setState(() {
//           _uploading = false;
//         });
//         print('Error uploading image: $e');
//       }
//     }
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/core/shared/custom_button.dart';
// import 'package:targafy/src/home/view/screens/controller/mandatory_Filed_name_controller.dart';
// import 'package:targafy/src/home/view/screens/controller/user_profile_data_controller.dart';
// import 'package:targafy/utils/remote_routes.dart';
// import 'model/user_business_model_drawer.dart';

// class UserProfile extends ConsumerStatefulWidget {
//   const UserProfile({super.key});

//   @override
//   ConsumerState<UserProfile> createState() => _UserProfileState();
// }

// class _UserProfileState extends ConsumerState<UserProfile> {
//   late User _user;
//   XFile? _profileImage;
//   bool _uploading = false;

//   String? _profileImageUrl;
//   final TextEditingController _nameController = TextEditingController();
//   bool _isEditingName = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserAvatar();
//   }

//   Future<void> _fetchUserAvatar() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken');
//     final controller = ref.read(userProfileLogoControllerProvider);
//     try {
//       final avatarUrl = await controller.fetchUserAvatar(token!);
//       setState(() {
//         _profileImageUrl = avatarUrl;
//       });
//     } catch (e) {
//       print('Error fetching user avatar: $e');
//     }
//   }

//   Future<void> _updateProfile() async {
//     try {
//       await ref
//           .read(nameControllerProvider.notifier)
//           .updateName(_nameController.text);
//       ref.refresh(userProvider);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Profile updated successfully')),
//       );
//       setState(() {
//         _isEditingName = false;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update profile: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final asyncValue = ref.watch(userProvider);

//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//         centerTitle: true,
//         title: const Text(
//           "User Profile",
//           style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: asyncValue.when(
//         data: (user) {
//           _user = user;
//           _nameController.text =
//               user.name; // Initialize the text controller with the current name
//           return _buildUserProfile();
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stackTrace) => Center(child: Text(error.toString())),
//       ),
//     );
//   }

//   Widget _buildUserProfile() {
//     return SafeArea(
//       child: ListView(
//         padding: const EdgeInsets.all(30),
//         children: [
//           GestureDetector(
//             onTap: _changePicture,
//             child: Center(
//               child: _buildAvatar(),
//             ),
//           ),
//           const SizedBox(height: 20),
//           _buildEditableInfoTile("Name", _nameController, Icons.person, () {
//             setState(() {
//               _isEditingName = true;
//             });
//           }),
//           const SizedBox(height: 20),
//           _buildInfoTile("Email", _user.email, Icons.email),
//           const SizedBox(height: 10),
//           _buildInfoTile(
//               "Phone Number",
//               "${_user.contactNumber['countryCode']} ${_user.contactNumber['number']}",
//               Icons.phone),
//           const SizedBox(height: 20),
//           CustomButton(
//             text: 'Save',
//             function: _updateProfile,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAvatar() {
//     return Stack(
//       children: [
//         CircleAvatar(
//           radius: 60,
//           backgroundImage: _profileImage != null
//               ? FileImage(File(_profileImage!.path))
//               : (_profileImageUrl != null
//                       ? NetworkImage(_profileImageUrl!)
//                       : const AssetImage("assets/images/placeholder.png"))
//                   as ImageProvider,
//         ),
//         if (_uploading)
//           const Positioned.fill(
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildEditableInfoTile(String label, TextEditingController controller,
//       IconData icon, VoidCallback onEdit) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(label),
//               IconButton(
//                 icon: Icon(Icons.edit),
//                 onPressed: onEdit,
//               ),
//             ],
//           ),
//           if (_isEditingName)
//             TextField(
//               controller: controller,
//               decoration: InputDecoration(
//                 // border: InputBorder.none,
//                 hintText: "Enter $label",
//               ),
//             )
//           else
//             Text(controller.text),
//         ],
//       ),
//       tileColor: const Color(0xffF3EEEA),
//     );
//   }

//   Widget _buildInfoTile(String label, String value, IconData icon) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label),
//           Text(
//             value,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//       tileColor: const Color(0xffF3EEEA),
//     );
//   }

//   Future<void> _changePicture() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _profileImage = pickedImage;
//         _uploading = true;
//       });

//       final controller = ref.read(userProfileLogoControllerProvider);

//       try {
//         final imageUrl = await controller.uploadLogo(File(pickedImage.path));
//         await controller.updateUserProfileLogo(imageUrl);
//         setState(() {
//           _uploading = false;
//         });
//       } catch (e) {
//         setState(() {
//           _uploading = false;
//         });
//         print('Error uploading image: $e');
//       }
//     }
//   }
// }
