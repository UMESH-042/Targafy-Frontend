
// // user_selection_dialog.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
// import 'package:targafy/src/users/ui/model/business_user_list_model.dart';

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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
import 'package:targafy/src/users/ui/model/business_user_list_model.dart';

class UserSelectionDialog extends ConsumerStatefulWidget {
  final String userId;
  final Function(bool) userRequestCallback;
  final String businessId;

  const UserSelectionDialog({
    Key? key,
    required this.userId,
    required this.userRequestCallback,
    required this.businessId,
  }) : super(key: key);

  @override
  _UserSelectionDialogState createState() => _UserSelectionDialogState();
}

class _UserSelectionDialogState extends ConsumerState<UserSelectionDialog> {
  List<String> roles = ["MiniAdmin", "User"];
  BusinessUserModel? selectedUserListItem;
  String? selectedRole;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(businessUsersProvider.notifier).fetchBusinessUsers(widget.businessId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final usersListState = ref.watch(businessUsersProvider);
    final userRequestState = ref.watch(userRequestProvider);

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
            const Text(
              "Select Manager and Role",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
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
                data: (usersList) => DropdownButtonHideUnderline(
                  child: DropdownButton<BusinessUserModel>(
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
                    onChanged: (BusinessUserModel? newValue) {
                      setState(() {
                        selectedUserListItem = newValue;
                      });
                    },
                    items: usersList.map<DropdownMenuItem<BusinessUserModel>>(
                        (BusinessUserModel user) {
                      return DropdownMenuItem<BusinessUserModel>(
                        value: user,
                        child: Text("  ${user.name}"),
                      );
                    }).toList(),
                  ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                SizedBox(width: 5),
                Text(
                  "Select role",
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
                              await ref
                                  .read(userRequestProvider.notifier)
                                  .submitUserRequest(
                                    widget.businessId,
                                    widget.userId,
                                    selectedRole!,
                                  );
                              Navigator.pop(context);
                              widget.userRequestCallback(true); // Notify parent widget
                            } catch (e) {
                              widget.userRequestCallback(false);
                            }
                          } else {
                            // Show error or validation message
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Error"),
                                content: Text("Please select a user and role."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                  child: userRequestState is AsyncLoading
                      ? const CircularProgressIndicator()
                      : const Text("Submit"),
                ),
              ],
            ),
            if (userRequestState is AsyncError)
              Text(
                'Error: ${userRequestState.error}',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}