// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';

// class ParameterScreen extends ConsumerStatefulWidget {
//   final String parameterName;
//   const ParameterScreen({super.key, required this.parameterName});

//   @override
//   ConsumerState<ParameterScreen> createState() => _ParameterScreenState();
// }

// class _ParameterScreenState extends ConsumerState<ParameterScreen> {
//   final List<String> _selectedUserIds = [];
//   final List<String> _selectedUsersNames = [];
//   String? _selectedUserId;

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

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomBackButton(
//                 text: '${widget.parameterName} Parameter',
//               ),
//               const SizedBox(height: 20),
//               asyncUsers.when(
//                 data: (users) {
//                   if (users.isEmpty) {
//                     return const Text('No users available');
//                   }
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       DropdownButton<String>(
//                         value: _selectedUserId,
//                         hint: const Text('Select User'),
//                         isExpanded: true,
//                         icon: const Icon(Icons.arrow_drop_down),
//                         iconSize: 24,
//                         elevation: 16,
//                         style: const TextStyle(color: Colors.deepPurple),
//                         items: users.map((user) {
//                           return DropdownMenuItem<String>(
//                             value: user.userId,
//                             child: Text(user.name),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             if (value != null &&
//                                 !_selectedUserIds.contains(value)) {
//                               _selectedUserId = value;
//                               _selectedUserIds.add(value);
//                               _selectedUsersNames.add(users
//                                   .firstWhere((user) => user.userId == value)
//                                   .name);
//                             }
//                           });
//                           print(_selectedUserIds);
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       _buildChips(),
//                     ],
//                   );
//                 },
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 error: (error, stackTrace) =>
//                     Text('Failed to load users: $error'),
//               ),
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
// import 'package:targafy/src/parameters/view/controller/add_new_user_Parameter_controller.dart';
// import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/src/parameters/view/widgets/CustomParameterField.dart';

// class ParameterScreen extends ConsumerStatefulWidget {
//   final String parameterName;
//   const ParameterScreen({super.key, required this.parameterName});

//   @override
//   ConsumerState<ParameterScreen> createState() => _ParameterScreenState();
// }

// class _ParameterScreenState extends ConsumerState<ParameterScreen> {
//   final List<String> _selectedUserIds = [];
//   final List<String> _selectedUsersNames = [];
//   String? _selectedUserId;

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

//   void _submitUsers() {
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;

//     if (businessId != null && _selectedUserIds.isNotEmpty) {
//       ref.read(addUserToParameterProvider.notifier).addUserToParameter(
//             businessId,
//             widget.parameterName,
//             _selectedUserIds,
//           );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final asyncUsers = ref.watch(businessUsersProvider);
//     final addUserState = ref.watch(addUserToParameterProvider);

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomBackButton(
//                 text: '${widget.parameterName} Parameter',
//               ),
//               const SizedBox(height: 20),
//               asyncUsers.when(
//                 data: (users) {
//                   if (users.isEmpty) {
//                     return const Text('No users available');
//                   }
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       DropdownButton<String>(
//                         value: _selectedUserId,
//                         hint: const Text('Select User'),
//                         isExpanded: true,
//                         icon: const Icon(Icons.arrow_drop_down),
//                         iconSize: 24,
//                         elevation: 16,
//                         style: const TextStyle(color: Colors.deepPurple),
//                         items: users.map((user) {
//                           return DropdownMenuItem<String>(
//                             value: user.userId,
//                             child: Text(user.name),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             if (value != null &&
//                                 !_selectedUserIds.contains(value)) {
//                               _selectedUserId = value;
//                               _selectedUserIds.add(value);
//                               _selectedUsersNames.add(users
//                                   .firstWhere((user) => user.userId == value)
//                                   .name);
//                             }
//                           });
//                           print(_selectedUserIds);
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       _buildChips(),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: _submitUsers,
//                         child: const Text('Submit'),
//                       ),
//                       addUserState.when(
//                         data: (_) => const Text('Users added successfully!'),
//                         loading: () => const CircularProgressIndicator(),
//                         error: (error, stackTrace) => Text('Error: $error'),
//                       ),
//                     ],
//                   );
//                 },
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 error: (error, stackTrace) =>
//                     Text('Failed to load users: $error'),
//               ),
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
// import 'package:targafy/src/parameters/view/controller/add_new_user_Parameter_controller.dart';
// import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/src/parameters/view/widgets/CustomParameterField.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:targafy/src/parameters/view/model/user_target_model.dart';
// import 'package:targafy/utils/remote_routes.dart';
// import 'package:targafy/widgets/submit_button.dart';

// // Define the domain for API requests
// String domain = AppRemoteRoutes.baseUrl;

// // User Notifier to fetch assigned users
// class UserNotifier extends StateNotifier<AsyncValue<List<User>>> {
//   UserNotifier() : super(const AsyncValue.loading());

//   Future<void> fetchUsers(String paramName, String businessId) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('authToken');
//       final response = await http.get(
//         Uri.parse('${domain}params/get-assign-user/$paramName/$businessId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body)['data'] as List;
//         state =
//             AsyncValue.data(data.map((user) => User.fromJson(user)).toList());
//       } else {
//         state = AsyncValue.error('Failed to load users', StackTrace.current);
//       }
//     } catch (e) {
//       state = AsyncValue.error(e, StackTrace.current);
//     }
//   }
// }

// // Provider for the UserNotifier
// final assignedUsersProvider =
//     StateNotifierProvider<UserNotifier, AsyncValue<List<User>>>((ref) {
//   return UserNotifier();
// });

// class ParameterScreen extends ConsumerStatefulWidget {
//   final String parameterName;
//   final String paramId;
//   const ParameterScreen({required this.paramId, required this.parameterName});

//   @override
//   ConsumerState<ParameterScreen> createState() => _ParameterScreenState();
// }

// class _ParameterScreenState extends ConsumerState<ParameterScreen> {
//   final List<String> _selectedUserIds = [];
//   final List<String> _selectedUsersNames = [];
//   String? _selectedUserId;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch the businessId from the current selected business
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     if (businessId != null) {
//       ref.read(businessUsersProvider.notifier).fetchBusinessUsers(businessId);
//       ref
//           .read(assignedUsersProvider.notifier)
//           .fetchUsers(widget.parameterName, businessId);
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

//   void _submitUsers() {
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;

//     if (businessId != null && _selectedUserIds.isNotEmpty) {
//       ref.read(addUserToParameterProvider.notifier).addUserToParameter(
//             businessId,
//             widget.parameterName,
//             _selectedUserIds,
//             widget.paramId,
//           );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final asyncUsers = ref.watch(businessUsersProvider);
//     final asyncAssignedUsers = ref.watch(assignedUsersProvider);
//     final addUserState = ref.watch(addUserToParameterProvider);

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomBackButton(
//                 text: '${widget.parameterName} Parameter',
//               ),
//               const SizedBox(height: 20),
//               asyncUsers.when(
//                 data: (users) {
//                   return asyncAssignedUsers.when(
//                     data: (assignedUsers) {
//                       // Filter out assigned users from available users
//                       final filteredUsers = users.where((user) {
//                         return !assignedUsers.any((assignedUser) =>
//                             assignedUser.userId == user.userId);
//                       }).toList();

//                       if (filteredUsers.isEmpty) {
//                         return const Text('No users available');
//                       }

//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           DropdownButton<String>(
//                             value: _selectedUserId,
//                             hint: const Text('Select User'),
//                             isExpanded: true,
//                             icon: const Icon(Icons.arrow_drop_down),
//                             iconSize: 24,
//                             elevation: 16,
//                             style: const TextStyle(color: Colors.deepPurple),
//                             items: filteredUsers.map((user) {
//                               return DropdownMenuItem<String>(
//                                 value: user.userId,
//                                 child: Text(user.name),
//                               );
//                             }).toList(),
//                             onChanged: (value) {
//                               setState(() {
//                                 if (value != null &&
//                                     !_selectedUserIds.contains(value)) {
//                                   _selectedUserId = value;
//                                   _selectedUserIds.add(value);
//                                   _selectedUsersNames.add(filteredUsers
//                                       .firstWhere(
//                                           (user) => user.userId == value)
//                                       .name);
//                                 }
//                               });
//                               print(_selectedUserIds);
//                             },
//                           ),
//                           const SizedBox(height: 20),
//                           _buildChips(),
//                           const SizedBox(height: 20),
//                           SubmitButton(
//                             onPressed: _submitUsers,
//                           ),
//                           addUserState.when(
//                             data: (_) => const Text(''),
//                             loading: () => const CircularProgressIndicator(),
//                             error: (error, stackTrace) => Text('Error: $error'),
//                           ),
//                         ],
//                       );
//                     },
//                     loading: () =>
//                         const Center(child: CircularProgressIndicator()),
//                     error: (error, stackTrace) =>
//                         Text('Failed to load assigned users: $error'),
//                   );
//                 },
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 error: (error, stackTrace) =>
//                     Text('Failed to load users: $error'),
//               ),
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
// import 'package:targafy/src/parameters/view/controller/add_new_user_Parameter_controller.dart';
// import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:targafy/src/parameters/view/model/user_target_model.dart';
// import 'package:targafy/utils/remote_routes.dart';
// import 'package:targafy/widgets/submit_button.dart';

// // Define the domain for API requests
// String domain = AppRemoteRoutes.baseUrl;

// // User Notifier to fetch assigned users
// class UserNotifier extends StateNotifier<AsyncValue<List<User>>> {
//   UserNotifier() : super(const AsyncValue.loading());

//   Future<void> fetchUsers(String paramName, String businessId) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('authToken');
//       final response = await http.get(
//         Uri.parse('${domain}params/get-assign-user/$paramName/$businessId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body)['data'] as List;
//         state =
//             AsyncValue.data(data.map((user) => User.fromJson(user)).toList());
//       } else {
//         state = AsyncValue.error('Failed to load users', StackTrace.current);
//       }
//     } catch (e) {
//       state = AsyncValue.error(e, StackTrace.current);
//     }
//   }
// }

// // Provider for the UserNotifier
// final assignedUsersProvider =
//     StateNotifierProvider<UserNotifier, AsyncValue<List<User>>>((ref) {
//   return UserNotifier();
// });

// class ParameterScreen extends ConsumerStatefulWidget {
//   final String parameterName;
//   final String paramId;
//   const ParameterScreen({required this.paramId, required this.parameterName});

//   @override
//   ConsumerState<ParameterScreen> createState() => _ParameterScreenState();
// }

// class _ParameterScreenState extends ConsumerState<ParameterScreen> {
//   final List<String> _selectedUserIds = [];
//   final List<String> _selectedUsersNames = [];
//   String? _selectedUserId;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch the businessId from the current selected business
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     if (businessId != null) {
//       ref.read(businessUsersProvider.notifier).fetchBusinessUsers(businessId);
//       ref
//           .read(assignedUsersProvider.notifier)
//           .fetchUsers(widget.parameterName, businessId);
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

//   Future<void> _submitUsers() async {
//     final selectedBusinessData = ref.read(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;

//     if (businessId != null && _selectedUserIds.isNotEmpty) {
//       await ref.read(addUserToParameterProvider.notifier).addUserToParameter(
//             businessId,
//             widget.parameterName,
//             _selectedUserIds,
//             widget.paramId,
//           );
//       _showSuccessDialog();
//     }
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Success'),
//           content: const Text('User added successfully!'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(true); // Close the dialog
//                 Navigator.of(context).pop(true); // Navigate back
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final asyncUsers = ref.watch(businessUsersProvider);
//     final asyncAssignedUsers = ref.watch(assignedUsersProvider);
//     final addUserState = ref.watch(addUserToParameterProvider);

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomBackButton(
//                 text: 'Assign User for ${widget.parameterName}',
//               ),
//               const SizedBox(height: 20),
//               asyncUsers.when(
//                 data: (users) {
//                   return asyncAssignedUsers.when(
//                     data: (assignedUsers) {
//                       // Filter out assigned users from available users
//                       final filteredUsers = users.where((user) {
//                         return !assignedUsers.any((assignedUser) =>
//                             assignedUser.userId == user.userId);
//                       }).toList();

//                       if (filteredUsers.isEmpty) {
//                         return const Text('No users available');
//                       }

//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           DropdownButton<String>(
//                             value: _selectedUserId,
//                             hint: const Text('Select User'),
//                             isExpanded: true,
//                             icon: const Icon(Icons.arrow_drop_down),
//                             iconSize: 24,
//                             elevation: 16,
//                             style: const TextStyle(color: Colors.deepPurple),
//                             items: filteredUsers.map((user) {
//                               return DropdownMenuItem<String>(
//                                 value: user.userId,
//                                 child: Text(user.name),
//                               );
//                             }).toList(),
//                             onChanged: (value) {
//                               setState(() {
//                                 if (value != null &&
//                                     !_selectedUserIds.contains(value)) {
//                                   _selectedUserId = value;
//                                   _selectedUserIds.add(value);
//                                   _selectedUsersNames.add(filteredUsers
//                                       .firstWhere(
//                                           (user) => user.userId == value)
//                                       .name);
//                                 }
//                               });
//                               print(_selectedUserIds);
//                             },
//                           ),
//                           const SizedBox(height: 20),
//                           _buildChips(),
//                           const SizedBox(height: 20),
//                           SubmitButton(
//                             onPressed: _submitUsers,
//                           ),
//                           addUserState.when(
//                             data: (_) => const Text(''),
//                             loading: () => const CircularProgressIndicator(),
//                             error: (error, stackTrace) => Text('Error: $error'),
//                           ),
//                         ],
//                       );
//                     },
//                     loading: () =>
//                         const Center(child: CircularProgressIndicator()),
//                     error: (error, stackTrace) =>
//                         Text('Failed to load assigned users: $error'),
//                   );
//                 },
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 error: (error, stackTrace) =>
//                     Text('Failed to load users: $error'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/shared/components/back_button.dart';
import 'package:targafy/src/parameters/view/controller/add_new_user_Parameter_controller.dart';
import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:targafy/src/parameters/view/model/user_target_model.dart';
import 'package:targafy/utils/remote_routes.dart';
import 'package:targafy/widgets/sort_dropdown_list.dart';
import 'package:targafy/widgets/submit_button.dart';

// Define the domain for API requests
String domain = AppRemoteRoutes.baseUrl;

// User Notifier to fetch assigned users
class UserNotifier extends StateNotifier<AsyncValue<List<User>>> {
  UserNotifier() : super(const AsyncValue.loading());

  Future<void> fetchUsers(String paramName, String businessId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.get(
        Uri.parse('${domain}params/get-assign-user/$paramName/$businessId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        state =
            AsyncValue.data(data.map((user) => User.fromJson(user)).toList());
      } else {
        state = AsyncValue.error('Failed to load users', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Provider for the UserNotifier
final assignedUsersProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<List<User>>>((ref) {
  return UserNotifier();
});

class ParameterScreen extends ConsumerStatefulWidget {
  final String parameterName;
  final String paramId;
  const ParameterScreen({required this.paramId, required this.parameterName});

  @override
  ConsumerState<ParameterScreen> createState() => _ParameterScreenState();
}

class _ParameterScreenState extends ConsumerState<ParameterScreen> {
  final List<String> _selectedUserIds = [];
  final List<String> _selectedUsersNames = [];
  String? _selectedUserId;
  bool _isAllSelected = false;

  @override
  void initState() {
    super.initState();
    // Fetch the businessId from the current selected business
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    if (businessId != null) {
      ref.read(businessUsersProvider.notifier).fetchBusinessUsers(businessId);
      ref
          .read(assignedUsersProvider.notifier)
          .fetchUsers(widget.parameterName, businessId);
    }
  }

  Widget _buildChips() {
    if (_isAllSelected) {
      return InputChip(
        label: const Text("All Selected"),
        onDeleted: () {
          setState(() {
            _isAllSelected = false;
            _selectedUserIds.clear();
            _selectedUsersNames.clear();
          });
        },
      );
    }

    if (_selectedUsersNames.isEmpty) {
      return const SizedBox
          .shrink(); // Return an empty widget if there are no selected users
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

  Future<void> _submitUsers() async {
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;

    if (businessId != null && _selectedUserIds.isNotEmpty) {
      await ref.read(addUserToParameterProvider.notifier).addUserToParameter(
            businessId,
            widget.parameterName,
            _selectedUserIds,
            widget.paramId,
          );
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('User added successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Close the dialog
                Navigator.of(context).pop(true); // Navigate back
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncUsers = ref.watch(businessUsersProvider);
    final asyncAssignedUsers = ref.watch(assignedUsersProvider);
    final addUserState = ref.watch(addUserToParameterProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(
              text: 'Assign User for ${widget.parameterName}',
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      asyncUsers.when(
                        data: (users) {
                          return asyncAssignedUsers.when(
                            data: (assignedUsers) {
                              // Filter out assigned users from available users
                              final filteredUsers = users.where((user) {
                                return !assignedUsers.any((assignedUser) =>
                                    assignedUser.userId == user.userId);
                              }).toList();
                              final sortedUserList =
                                  sortList(filteredUsers, (user) => user.name);
                              if (sortedUserList.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No users available to assign',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                );
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: DropdownButton<String>(
                                      value: _selectedUserId,
                                      hint: const Text('Select User'),
                                      isExpanded: true,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(color: primaryColor),
                                      underline: SizedBox.shrink(),
                                      items: [
                                        const DropdownMenuItem<String>(
                                          value: 'all',
                                          child: Text('Select All'),
                                        ),
                                        ...sortedUserList.map((user) {
                                          return DropdownMenuItem<String>(
                                            value: user.userId,
                                            child: Text(user.name),
                                          );
                                        }).toList(),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          if (value == 'all') {
                                            _isAllSelected = true;
                                            _selectedUserId = null;
                                            _selectedUserIds.clear();
                                            _selectedUsersNames.clear();
                                            _selectedUserIds.addAll(
                                                sortedUserList
                                                    .map((user) => user.userId)
                                                    .toList());
                                            _selectedUsersNames.addAll(
                                                sortedUserList
                                                    .map((user) => user.name)
                                                    .toList());
                                          } else if (value != null &&
                                              !_selectedUserIds
                                                  .contains(value)) {
                                            _isAllSelected = false;
                                            _selectedUserId = value;
                                            _selectedUserIds.add(value);
                                            _selectedUsersNames.add(
                                                sortedUserList
                                                    .firstWhere((user) =>
                                                        user.userId == value)
                                                    .name);
                                          }
                                        });
                                        print(_selectedUserIds);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  _buildChips(),
                                  const SizedBox(height: 20),
                                  SubmitButton(
                                    onPressed: _submitUsers,
                                  ),
                                  addUserState.when(
                                    data: (_) => const Text(''),
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    error: (error, stackTrace) =>
                                        Text('Error: $error'),
                                  ),
                                ],
                              );
                            },
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (error, stackTrace) =>
                                Text('Failed to load assigned users: $error'),
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) =>
                            Text('Failed to load users: $error'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
