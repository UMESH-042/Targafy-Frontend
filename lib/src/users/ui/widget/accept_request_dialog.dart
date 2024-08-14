// ignore_for_file: public_member_api_docs, sort_constructors_first
// user_selection_dialog.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/home/view/screens/controller/Department_controller.dart';
import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';

import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
import 'package:targafy/src/users/ui/model/business_user_list_model.dart';
import 'package:targafy/utils/remote_routes.dart';
import 'package:tuple/tuple.dart';

// class UserSelectionDialog extends ConsumerStatefulWidget {
//   final String userId;
//   final Function userRequestCallback;
//   final String businessId;

//   const UserSelectionDialog({
//     super.key,
//     required this.userId,
//     required this.userRequestCallback,
//     required this.businessId,
//   });

//   @override
//   _UserSelectionDialogState createState() => _UserSelectionDialogState();
// }

// class _UserSelectionDialogState extends ConsumerState<UserSelectionDialog> {
//   List<String> roles = ["MiniAdmin", "User"];
//   BusinessUserModel? selectedUserListItem;
//   String? selectedRole;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref
//           .read(businessUsersProvider.notifier)
//           .fetchBusinessUsers(widget.businessId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final usersListState = ref.watch(businessUsersProvider);
//     final userRequestState = ref.watch(userRequestProvider);

//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               "Select Manager and Role",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Assign To",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: "Poppins",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.06,
//               width: width - 41,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: usersListState.when(
//                 data: (usersList) => DropdownButtonHideUnderline(
//                   child: DropdownButton<BusinessUserModel>(
//                     icon: const Align(
//                       alignment: Alignment.centerRight,
//                       child: Icon(
//                         Icons.keyboard_arrow_down_sharp,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     elevation: 4,
//                     style: const TextStyle(color: Colors.black, fontSize: 14),
//                     value: selectedUserListItem,
//                     onChanged: (BusinessUserModel? newValue) {
//                       setState(() {
//                         selectedUserListItem = newValue;
//                       });
//                     },
//                     items: usersList.map<DropdownMenuItem<BusinessUserModel>>(
//                         (BusinessUserModel user) {
//                       return DropdownMenuItem<BusinessUserModel>(
//                         value: user,
//                         child: Text("  ${user.name}"),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 loading: () => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 error: (error, stackTrace) => Center(
//                   child: Text('Error: $error'),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Select role",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: "Poppins",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.06,
//               width: double.maxFinite - 10,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   icon: const Align(
//                     alignment: Alignment.centerRight,
//                     child: Icon(
//                       Icons.keyboard_arrow_down_sharp,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   elevation: 4,
//                   style: const TextStyle(color: Colors.black, fontSize: 14),
//                   value: selectedRole,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedRole = newValue;
//                     });
//                   },
//                   items: roles.map<DropdownMenuItem<String>>((String s) {
//                     return DropdownMenuItem<String>(
//                       value: s,
//                       child: Text("  $s"),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.02),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text("Close"),
//                 ),
//                 ElevatedButton(
//                   onPressed: userRequestState is AsyncLoading
//                       ? null
//                       : () async {
//                           if (selectedUserListItem != null &&
//                               selectedRole != null) {
//                             await ref
//                                 .read(userRequestProvider.notifier)
//                                 .submitUserRequest(
//                                   widget.businessId,
//                                   widget.userId,
//                                   selectedRole!,
//                                 );
//                             if (userRequestState is AsyncData) {
//                               Navigator.pop(context);
//                             }
//                           } else {
//                             // Show error or validation message
//                           }
//                         },
//                   child: userRequestState is AsyncLoading
//                       ? const CircularProgressIndicator()
//                       : const Text("Submit"),
//                 ),
//               ],
//             ),
//             if (userRequestState is AsyncError)
//               Text(
//                 'Error: ${userRequestState.error}',
//                 style: TextStyle(color: Colors.red),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class UserSelectionDialog extends ConsumerStatefulWidget {
//   final String userId;
//   final Function(bool) userRequestCallback;
//   final String businessId;
//   final String? departmentId;

//   const UserSelectionDialog({
//     required this.userId,
//     required this.userRequestCallback,
//     required this.businessId,
//     required this.departmentId,
//   });

//   @override
//   _UserSelectionDialogState createState() => _UserSelectionDialogState();
// }

// class _UserSelectionDialogState extends ConsumerState<UserSelectionDialog> {
//   List<String> roles = ["MiniAdmin", "User"];
//   BusinessUserModel? selectedUserListItem;
//   String? selectedRole;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref
//           .read(businessUsersProvider.notifier)
//           .fetchBusinessUsers(widget.businessId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final usersListState = ref.watch(businessUsersProvider);
//     final userRequestState = ref.watch(userRequestProvider);

//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               "Select Manager and Role",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Select role",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: "Poppins",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.06,
//               width: double.maxFinite - 10,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   icon: const Align(
//                     alignment: Alignment.centerRight,
//                     child: Icon(
//                       Icons.keyboard_arrow_down_sharp,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   elevation: 4,
//                   style: const TextStyle(color: Colors.black, fontSize: 14),
//                   value: selectedRole,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedRole = newValue;
//                     });
//                   },
//                   items: roles.map<DropdownMenuItem<String>>((String s) {
//                     return DropdownMenuItem<String>(
//                       value: s,
//                       child: Text("  $s"),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.02),
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Assign To",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: "Poppins",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.06,
//               width: width - 41,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: usersListState.when(
//                 data: (usersList) => DropdownButtonHideUnderline(
//                   child: DropdownButton<BusinessUserModel>(
//                     icon: const Align(
//                       alignment: Alignment.centerRight,
//                       child: Icon(
//                         Icons.keyboard_arrow_down_sharp,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     elevation: 4,
//                     style: const TextStyle(color: Colors.black, fontSize: 14),
//                     value: selectedUserListItem,
//                     onChanged: (BusinessUserModel? newValue) {
//                       setState(() {
//                         selectedUserListItem = newValue;
//                       });
//                     },
//                     items: usersList.map<DropdownMenuItem<BusinessUserModel>>(
//                         (BusinessUserModel user) {
//                       return DropdownMenuItem<BusinessUserModel>(
//                         value: user,
//                         child: Text("  ${user.name}"),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 loading: () => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 error: (error, stackTrace) => Center(
//                   child: Text('Error: $error'),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text("Close"),
//                 ),
//                 ElevatedButton(
//                   onPressed: userRequestState is AsyncLoading
//                       ? null
//                       : () async {
//                           if (selectedUserListItem != null &&
//                               selectedRole != null) {
//                             try {
//                               await ref
//                                   .read(userRequestProvider.notifier)
//                                   .submitUserRequest(
//                                     widget.businessId,
//                                     widget.userId,
//                                     selectedRole!,
//                                     selectedUserListItem!.userId,
//                                   );
//                               Navigator.pop(context);
//                               widget.userRequestCallback(
//                                   true); // Notify parent widget
//                             } catch (e) {
//                               widget.userRequestCallback(false);
//                             }
//                           } else {
//                             // Show error or validation message
//                             showDialog(
//                               context: context,
//                               builder: (context) => AlertDialog(
//                                 title: const Text("Error"),
//                                 content: const Text(
//                                     "Please select a user and role."),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: const Text("OK"),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }
//                         },
//                   child: userRequestState is AsyncLoading
//                       ? const CircularProgressIndicator()
//                       : const Text("Submit"),
//                 ),
//               ],
//             ),
//             if (userRequestState is AsyncError)
//               Text(
//                 'Error: ${userRequestState.error}',
//                 style: const TextStyle(color: Colors.red),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class UserSelectionDialog extends ConsumerStatefulWidget {
//   final String userId;
//   final Function(bool) userRequestCallback;
//   final String businessId;
//   final String? departmentId;

//   const UserSelectionDialog({
//     required this.userId,
//     required this.userRequestCallback,
//     required this.businessId,
//     required this.departmentId,
//   });

//   @override
//   _UserSelectionDialogState createState() => _UserSelectionDialogState();
// }

// class _UserSelectionDialogState extends ConsumerState<UserSelectionDialog> {
//   List<String> roles = ["MiniAdmin", "User"];
//   BusinessUserModel? selectedUserListItem;
//   String? selectedRole;
//   Department? selectedDepartment;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref
//           .read(businessUsersProvider.notifier)
//           .fetchBusinessUsers(widget.businessId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final usersListState = ref.watch(businessUsersProvider);
//     final userRequestState = ref.watch(userRequestProvider);
//     final departmentState = ref.watch(departmentProvider(widget.businessId));

//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               "Select Manager and Role",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Select role",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: "Poppins",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.06,
//               width: double.maxFinite - 10,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   icon: const Align(
//                     alignment: Alignment.centerRight,
//                     child: Icon(
//                       Icons.keyboard_arrow_down_sharp,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   elevation: 4,
//                   style: const TextStyle(color: Colors.black, fontSize: 14),
//                   value: selectedRole,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedRole = newValue;
//                     });
//                   },
//                   items: roles.map<DropdownMenuItem<String>>((String s) {
//                     return DropdownMenuItem<String>(
//                       value: s,
//                       child: Text("  $s"),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.02),
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Select Department",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: "Poppins",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.06,
//               width: double.maxFinite - 10,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: departmentState.when(
//                 data: (departments) => DropdownButtonHideUnderline(
//                   child: DropdownButton<Department>(
//                     icon: const Align(
//                       alignment: Alignment.centerRight,
//                       child: Icon(
//                         Icons.keyboard_arrow_down_sharp,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     elevation: 4,
//                     style: const TextStyle(color: Colors.black, fontSize: 14),
//                     value: selectedDepartment,
//                     onChanged: (Department? newValue) {
//                       setState(() {
//                         selectedDepartment = newValue;
//                       });
//                     },
//                     items: departments.map<DropdownMenuItem<Department>>(
//                         (Department department) {
//                       return DropdownMenuItem<Department>(
//                         value: department,
//                         child: Text("  ${department.name}"),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 loading: () => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 error: (error, stackTrace) => Center(
//                   child: Text('Error: $error'),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.02),
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Assign To",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: "Poppins",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.06,
//               width: width - 41,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: usersListState.when(
//                 data: (usersList) => DropdownButtonHideUnderline(
//                   child: DropdownButton<BusinessUserModel>(
//                     icon: const Align(
//                       alignment: Alignment.centerRight,
//                       child: Icon(
//                         Icons.keyboard_arrow_down_sharp,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     elevation: 4,
//                     style: const TextStyle(color: Colors.black, fontSize: 14),
//                     value: selectedUserListItem,
//                     onChanged: (BusinessUserModel? newValue) {
//                       setState(() {
//                         selectedUserListItem = newValue;
//                       });
//                     },
//                     items: usersList.map<DropdownMenuItem<BusinessUserModel>>(
//                         (BusinessUserModel user) {
//                       return DropdownMenuItem<BusinessUserModel>(
//                         value: user,
//                         child: Text("  ${user.name}"),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 loading: () => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 error: (error, stackTrace) => Center(
//                   child: Text('Error: $error'),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text("Close"),
//                 ),
//                 ElevatedButton(
//                   onPressed: userRequestState is AsyncLoading
//                       ? null
//                       : () async {
//                           if (selectedUserListItem != null &&
//                               selectedRole != null &&
//                               selectedDepartment != null) {
//                             try {
//                               await ref
//                                   .read(userRequestProvider.notifier)
//                                   .submitUserRequest(
//                                     widget.businessId,
//                                     widget.userId,
//                                     selectedRole!,
//                                     selectedUserListItem!.userId,
//                                   );
//                               Navigator.pop(context);
//                               widget.userRequestCallback(
//                                   true); // Notify parent widget
//                             } catch (e) {
//                               widget.userRequestCallback(false);
//                             }
//                           } else {
//                             // Show error or validation message
//                             showDialog(
//                               context: context,
//                               builder: (context) => AlertDialog(
//                                 title: const Text("Error"),
//                                 content: const Text(
//                                     "Please select a role, department, and user."),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: const Text("OK"),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }
//                         },
//                   child: userRequestState is AsyncLoading
//                       ? const CircularProgressIndicator()
//                       : const Text("Submit"),
//                 ),
//               ],
//             ),
//             if (userRequestState is AsyncError)
//               Text(
//                 'Error: ${userRequestState.error}',
//                 style: const TextStyle(color: Colors.red),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:http/http.dart' as http;

// String domain = AppRemoteRoutes.baseUrl;

// final businessUsersProvider =
//     FutureProvider.family<List<BusinessUserModel2>, String>(
//   (ref, businessId) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('authToken');

//     if (token == null) {
//       throw Exception('Authorization token not found');
//     }

//     final response = await http.get(
//       Uri.parse(
//           '${domain}business/get-all-subordinate-businessusers/$businessId'),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to load users');
//     }

//     final data = json.decode(response.body);
//     return (data['data']['users'] as List)
//         .map((user) => BusinessUserModel2.fromJson(user))
//         .toList();
//   },
// );

// class UserSelectionDialog extends ConsumerStatefulWidget {
//   final String userId;
//   final Function(bool) userRequestCallback;
//   final String businessId;

//   const UserSelectionDialog({
//     required this.userId,
//     required this.userRequestCallback,
//     required this.businessId,
//   });

//   @override
//   _UserSelectionDialogState createState() => _UserSelectionDialogState();
// }

// class _UserSelectionDialogState extends ConsumerState<UserSelectionDialog> {
//   List<String> roles = ["MiniAdmin", "User"];
//   BusinessUserModel2? selectedUserListItem;
//   String? selectedRole;
//   List<String> selectedParameterIds = [];

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref
//           .read(parameterNotifierProvider.notifier)
//           .fetchParameters(widget.businessId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final usersListState = ref.watch(businessUsersProvider(widget.businessId));
//     final userRequestState = ref.watch(userRequestProvider);
//     final parametersState = ref.watch(parameterNotifierProvider);

//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 16),
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Select Role",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: "Poppins",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.06,
//               width: double.maxFinite - 10,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   icon: const Align(
//                     alignment: Alignment.centerRight,
//                     child: Icon(
//                       Icons.keyboard_arrow_down_sharp,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   elevation: 4,
//                   style: const TextStyle(color: Colors.black, fontSize: 14),
//                   value: selectedRole,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedRole = newValue;
//                     });
//                   },
//                   items: roles.map<DropdownMenuItem<String>>((String s) {
//                     return DropdownMenuItem<String>(
//                       value: s,
//                       child: Text("  $s"),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.02),
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Assign To",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: "Poppins",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.06,
//               width: width - 41,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: usersListState.when(
//                 data: (usersList) => DropdownButtonHideUnderline(
//                   child: DropdownButton<BusinessUserModel2>(
//                     icon: const Align(
//                       alignment: Alignment.centerRight,
//                       child: Icon(
//                         Icons.keyboard_arrow_down_sharp,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     elevation: 4,
//                     style: const TextStyle(color: Colors.black, fontSize: 14),
//                     value: selectedUserListItem,
//                     onChanged: (BusinessUserModel2? newValue) {
//                       setState(() {
//                         selectedUserListItem = newValue;
//                       });
//                     },
//                     items: usersList.map<DropdownMenuItem<BusinessUserModel2>>(
//                         (BusinessUserModel2 user) {
//                       return DropdownMenuItem<BusinessUserModel2>(
//                         value: user,
//                         child: Text("  ${user.name}"),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 loading: () => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 error: (error, stackTrace) => Center(
//                   child: Text('No Users'),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             // const Row(
//             //   children: [
//             //     SizedBox(width: 5),
//             //     Text(
//             //       "Select Parameter List",
//             //       style: TextStyle(
//             //           color: Colors.black,
//             //           fontFamily: "Poppins",
//             //           fontSize: 14,
//             //           fontWeight: FontWeight.w600),
//             //     ),
//             //   ],
//             // ),

//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Select Parameter List",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: "Poppins",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.2,
//               width: width - 41,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: MultiSelectDialogField<String>(
//                   items: parametersState
//                       .map((parameter) =>
//                           MultiSelectItem<String>(parameter.id, parameter.name))
//                       .toList(),
//                   listType: MultiSelectListType.CHIP,
//                   onConfirm: (values) {
//                     setState(() {
//                       selectedParameterIds = values;
//                     });
//                   },
//                   chipDisplay: MultiSelectChipDisplay(
//                     onTap: (value) {
//                       setState(() {
//                         selectedParameterIds.remove(value);
//                       });
//                     },
//                   ),
//                   buttonText: Text(
//                     "Select Parameters",
//                     style: TextStyle(color: Colors.grey[700], fontSize: 14),
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.01),
//             // Implement your parameter list dropdown here similar to the roles and users
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text("Close"),
//                 ),
//                 ElevatedButton(
//                   onPressed: userRequestState is AsyncLoading
//                       ? null
//                       : () async {
//                           if (selectedUserListItem != null &&
//                               selectedRole != null) {
//                             try {
//                               await ref
//                                   .read(userRequestProvider.notifier)
//                                   .submitUserRequest(
//                                       widget.businessId,
//                                       widget.userId,
//                                       selectedRole!,
//                                       selectedUserListItem!.userId,
//                                       selectedParameterIds);
//                               Navigator.pop(context);
//                               widget.userRequestCallback(
//                                   true); // Notify parent widget
//                             } catch (e) {
//                               widget.userRequestCallback(false);
//                             }
//                           } else {
//                             showDialog(
//                               context: context,
//                               builder: (context) => AlertDialog(
//                                 title: const Text("Error"),
//                                 content: const Text(
//                                     "Please select a role and user."),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: const Text("OK"),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }
//                         },
//                   child: const Text("Submit"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:http/http.dart' as http;

String domain = AppRemoteRoutes.baseUrl;

final businessUsersProvider =
    FutureProvider.family<List<BusinessUserModel2>, String>(
  (ref, businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Authorization token not found');
    }

    final response = await http.get(
      Uri.parse(
          '${domain}business/get-all-subordinate-businessusers/$businessId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load users');
    }

    final data = json.decode(response.body);
    return (data['data']['users'] as List)
        .map((user) => BusinessUserModel2.fromJson(user))
        .toList();
  },
);

class UserSelectionDialog extends ConsumerStatefulWidget {
  final String userId;
  final Function(bool) userRequestCallback;
  final String businessId;

  const UserSelectionDialog({
    required this.userId,
    required this.userRequestCallback,
    required this.businessId,
  });

  @override
  _UserSelectionDialogState createState() => _UserSelectionDialogState();
}

class _UserSelectionDialogState extends ConsumerState<UserSelectionDialog> {
  List<String> roles = ["MiniAdmin", "User"];
  BusinessUserModel2? selectedUserListItem;
  String? selectedRole;
  List<String> selectedParameterIds = [];
  String? dummyAdminId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(parameterNotifierProvider.notifier)
          .fetchParameters(widget.businessId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final usersListState = ref.watch(businessUsersProvider(widget.businessId));
    final userRequestState = ref.watch(userRequestProvider);
    final parametersState = ref.watch(parameterNotifierProvider);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Row(
              children: [
                SizedBox(width: 5),
                Text(
                  "Select Role",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Container(
              height: height * 0.06,
              width: double.maxFinite - 10,
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Colors.grey,
                    ),
                  ),
                  elevation: 4,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  value: selectedRole,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue;
                    });
                  },
                  items: roles.map<DropdownMenuItem<String>>((String s) {
                    return DropdownMenuItem<String>(
                      value: s,
                      child: Text("  $s"),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            const Row(
              children: [
                SizedBox(width: 5),
                Text(
                  "Assign To",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Container(
              height: height * 0.06,
              width: width - 41,
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: usersListState.when(
                data: (usersList) {
                  // Find the DummyAdmin user and store its ID
                  dummyAdminId = usersList
                      .firstWhere((user) => user.name == 'DummyAdmin',
                          orElse: () => BusinessUserModel2(
                              userId: '',
                              name: '',
                              role: '',
                              userType: '',
                              lastSeen: '',
                              unseenMessagesCount: 0))
                      .userId;
                  // Filter out the DummyAdmin from the list for display
                  final filteredUsersList = usersList
                      .where((user) => user.name != 'DummyAdmin')
                      .toList();

                  return DropdownButtonHideUnderline(
                    child: DropdownButton<BusinessUserModel2>(
                      icon: const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.grey,
                        ),
                      ),
                      elevation: 4,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      value: selectedUserListItem,
                      onChanged: (BusinessUserModel2? newValue) {
                        setState(() {
                          selectedUserListItem = newValue;
                        });
                      },
                      items: filteredUsersList
                          .map<DropdownMenuItem<BusinessUserModel2>>(
                              (BusinessUserModel2 user) {
                        return DropdownMenuItem<BusinessUserModel2>(
                          value: user,
                          child: Text("  ${user.name}"),
                        );
                      }).toList(),
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Text('No Users'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                SizedBox(width: 5),
                Text(
                  "Select Parameter List",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Container(
              height: height * 0.2,
              width: width - 41,
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: MultiSelectDialogField<String>(
                  items: parametersState
                      .map((parameter) =>
                          MultiSelectItem<String>(parameter.id, parameter.name))
                      .toList(),
                  listType: MultiSelectListType.CHIP,
                  onConfirm: (values) {
                    setState(() {
                      selectedParameterIds = values;
                    });
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (value) {
                      setState(() {
                        selectedParameterIds.remove(value);
                      });
                    },
                  ),
                  buttonText: Text(
                    "Select Parameters",
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                ),
                ElevatedButton(
                  onPressed: userRequestState is AsyncLoading
                      ? null
                      : () async {
                          if (selectedUserListItem != null &&
                              selectedRole != null) {
                            try {
                              // Use DummyAdmin ID if an Admin is selected
                              final userIdToSubmit =
                                  selectedUserListItem!.role == 'Admin'
                                      ? dummyAdminId ??
                                          selectedUserListItem!.userId
                                      : selectedUserListItem!.userId;

                              await ref
                                  .read(userRequestProvider.notifier)
                                  .submitUserRequest(
                                      widget.businessId,
                                      widget.userId,
                                      selectedRole!,
                                      userIdToSubmit,
                                      selectedParameterIds);
                              Navigator.pop(context);
                              widget.userRequestCallback(
                                  true); // Notify the parent widget of success
                            } catch (e) {
                              print('Failed to submit user request: $e');
                            }
                          }
                        },
                  child: userRequestState is AsyncLoading
                      ? const CircularProgressIndicator()
                      : const Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




// class UserSelectionDialog extends ConsumerStatefulWidget {
//   final String userId;
//   final Function(bool) userRequestCallback;
//   final String businessId;

//   const UserSelectionDialog({
//     Key? key,
//     required this.userId,
//     required this.userRequestCallback,
//     required this.businessId,
//   }) : super(key: key);

//   @override
//   _UserSelectionDialogState createState() => _UserSelectionDialogState();
// }

// class _UserSelectionDialogState extends ConsumerState<UserSelectionDialog> {
//   List<String> roles = ["MiniAdmin", "User"];
//   BusinessUserModel? selectedUserListItem;
//   String? selectedRole;
//   String? selectedOfficeId;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref
//           .read(businessUsersProvider.notifier)
//           .fetchBusinessUsers(widget.businessId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final usersListState = ref.watch(businessUsersProvider);
//     final userRequestState = ref.watch(userRequestProvider);
//     final officesState = ref.watch(officesProvider(widget.businessId));

//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               "Select Manager and Role",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Assign To",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: "Poppins",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.06,
//               width: width - 41,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: usersListState.when(
//                 data: (usersList) => DropdownButtonHideUnderline(
//                   child: DropdownButton<BusinessUserModel>(
//                     icon: const Align(
//                       alignment: Alignment.centerRight,
//                       child: Icon(
//                         Icons.keyboard_arrow_down_sharp,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     elevation: 4,
//                     style: const TextStyle(color: Colors.black, fontSize: 14),
//                     value: selectedUserListItem,
//                     onChanged: (BusinessUserModel? newValue) {
//                       setState(() {
//                         selectedUserListItem = newValue;
//                       });
//                     },
//                     items: usersList.map<DropdownMenuItem<BusinessUserModel>>(
//                         (BusinessUserModel user) {
//                       return DropdownMenuItem<BusinessUserModel>(
//                         value: user,
//                         child: Text("  ${user.name}"),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 loading: () => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 error: (error, stackTrace) => Center(
//                   child: Text('Error: $error'),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Select role",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: "Poppins",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.06,
//               width: double.maxFinite - 10,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   icon: const Align(
//                     alignment: Alignment.centerRight,
//                     child: Icon(
//                       Icons.keyboard_arrow_down_sharp,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   elevation: 4,
//                   style: const TextStyle(color: Colors.black, fontSize: 14),
//                   value: selectedRole,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedRole = newValue;
//                     });
//                   },
//                   items: roles.map<DropdownMenuItem<String>>((String s) {
//                     return DropdownMenuItem<String>(
//                       value: s,
//                       child: Text("  $s"),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.02),
//             const Row(
//               children: [
//                 SizedBox(width: 5),
//                 Text(
//                   "Select Office",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontFamily: "Poppins",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Container(
//               height: height * 0.06,
//               width: width - 41,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   style: BorderStyle.solid,
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: officesState.when(
//                 data: (offices) => DropdownButtonHideUnderline(
//                   child: DropdownButton<Map<String, dynamic>>(
//                     icon: const Align(
//                       alignment: Alignment.centerRight,
//                       child: Icon(
//                         Icons.keyboard_arrow_down_sharp,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     elevation: 4,
//                     style: const TextStyle(color: Colors.black, fontSize: 14),
//                     // value: selectedOfficeId != null
//                     //     ? offices.firstWhere(
//                     //         (element) =>
//                     //             element['officeId'] == selectedOfficeId,
//                     //         orElse: () =>,
//                     //       )
//                     //     : null,
//                     value: selectedOfficeId != null
//                         ? offices.firstWhere(
//                             (element) =>
//                                 element['officeId'] == selectedOfficeId,
//                           )
//                         : null,
//                     onChanged: (Map<String, dynamic>? newValue) {
//                       setState(() {
//                         selectedOfficeId = newValue!['officeId'];
//                       });
//                     },
//                     items: offices
//                         .map<DropdownMenuItem<Map<String, dynamic>>>((office) {
//                       return DropdownMenuItem<Map<String, dynamic>>(
//                         value: office,
//                         child: Text("  ${office['name']}"),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 loading: () => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 error: (error, stackTrace) => Center(
//                   child: Text('Error: $error'),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.02),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text("Close"),
//                 ),
//                 ElevatedButton(
//                   onPressed: userRequestState is AsyncLoading
//                       ? null
//                       : () async {
//                           if (selectedUserListItem != null &&
//                               selectedRole != null &&
//                               selectedOfficeId != null) {
//                             try {
//                               await ref
//                                   .read(userRequestProvider.notifier)
//                                   .submitUserRequest(
//                                     widget.businessId,
//                                     widget.userId,
//                                     selectedRole!,
//                                     selectedUserListItem!.userId,
//                                     selectedOfficeId,
//                                   );
//                               Navigator.pop(context);
//                               widget.userRequestCallback(
//                                   true); // Notify parent widget
//                             } catch (e) {
//                               widget.userRequestCallback(false);
//                             }
//                           } else {
//                             // Show error or validation message
//                             showDialog(
//                               context: context,
//                               builder: (context) => AlertDialog(
//                                 title: const Text("Error"),
//                                 content: const Text(
//                                     "Please select a user, role, and office."),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: const Text("OK"),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }
//                         },
//                   child: userRequestState is AsyncLoading
//                       ? const CircularProgressIndicator()
//                       : const Text("Submit"),
//                 ),
//               ],
//             ),
//             if (userRequestState is AsyncError)
//               Text(
//                 'Error: ${userRequestState.error}',
//                 style: const TextStyle(color: Colors.red),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
