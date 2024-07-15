import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/src/users/ui/controller/business_users_controller.dart';
import 'package:targafy/src/users/ui/controller/change_mangager_controller.dart';
import 'package:targafy/src/users/ui/model/business_user_list_model.dart';

class ManagerSelectionDialog extends ConsumerStatefulWidget {
  final String userId;
  final Function(bool) changeManagerCallback;
  final String businessId;

  const ManagerSelectionDialog({
    super.key,
    required this.userId,
    required this.changeManagerCallback,
    required this.businessId,
  });

  @override
  _ManagerSelectionDialogState createState() => _ManagerSelectionDialogState();
}

class _ManagerSelectionDialogState
    extends ConsumerState<ManagerSelectionDialog> {
  BusinessUserModel? selectedUser;
  late String currentUserId;
  @override
  void initState() {
    super.initState();
    currentUserId = widget.userId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(businessUsersProvider.notifier)
          .fetchBusinessUsers(widget.businessId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final usersListState = ref.watch(businessUsersProvider);
    final changeManagerState = ref.watch(changeManagerProvider);

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
              "Select Manager",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
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
                  // Filter out the current user's name from the list
                  List<BusinessUserModel> filteredUsers = usersList
                      .where((user) => user.userId != currentUserId)
                      .toList();

                  return DropdownButtonHideUnderline(
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
                      value: selectedUser,
                      onChanged: (BusinessUserModel? newValue) {
                        setState(() {
                          selectedUser = newValue;
                        });
                      },
                      items: filteredUsers
                          .map<DropdownMenuItem<BusinessUserModel>>(
                              (BusinessUserModel user) {
                        return DropdownMenuItem<BusinessUserModel>(
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
                  child: Text('Error: $error'),
                ),
              ),
            ),
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
                  onPressed: changeManagerState is AsyncLoading
                      ? null
                      : () async {
                          if (selectedUser != null) {
                            try {
                              await ref
                                  .read(changeManagerProvider.notifier)
                                  .changeManager(
                                    widget.businessId,
                                    widget.userId,
                                    selectedUser!.userId,
                                  );
                              Navigator.pop(context);
                              widget.changeManagerCallback(
                                  true); // Notify parent widget
                            } catch (e) {
                              widget.changeManagerCallback(false);
                            }
                          } else {
                            // Show error or validation message
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Error"),
                                content: const Text("Please select a manager."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                  child: changeManagerState is AsyncLoading
                      ? const CircularProgressIndicator()
                      : const Text("Submit"),
                ),
              ],
            ),
            if (changeManagerState is AsyncError)
              Text(
                'Error: ${changeManagerState.error}',
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
