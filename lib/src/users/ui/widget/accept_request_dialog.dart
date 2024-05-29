import 'package:targafy/src/users/ui/model/user_list_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserSelectionDialog extends StatefulWidget {
  final String userId;
  final Function userRequestCallback;

  const UserSelectionDialog(
      {super.key, required this.userId, required this.userRequestCallback});

  @override
  _UserSelectionDialogState createState() => _UserSelectionDialogState();
}

class _UserSelectionDialogState extends State<UserSelectionDialog> {
  List<String> roles = ["MiniAdmin", "User"];

  UserListModel? selectedUserListItem;
  List<UserListModel> usersList = [];

  @override
  void initState() {
    callInit();
    super.initState();
  }

  Future<void> callInit() async {
    // usersList =
    //     await Provider.of<HomeProvider>(context, listen: false).getUsersList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final businessRequestController =
    //     Provider.of<BusinessRequestsProvider>(context, listen: false);
    // final homeController = Provider.of<HomeProvider>(context, listen: false);

    // final createIssueController =
    //     Provider.of<CreateIssueProvider>(context, listen: false);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // if(businessRequestController.userRoleModel?.role == null){
    //   businessRequestController.updateRole("User");
    // }

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
                child: usersList == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : DropdownButtonHideUnderline(
                        child: DropdownButton<UserListModel>(
                          icon: const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.grey,
                            ),
                          ),
                          elevation: 4,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          value: selectedUserListItem,
                          onChanged: (UserListModel? newValue) {
                            if (newValue != null) {
                              // selectedUserListItem = newValue;
                              // debugPrint(
                              //     "Selected user : ${selectedUserListItem?.name ?? "No"}");
                              // businessRequestController
                              //     .updateAssignTo(selectedUserListItem);
                              // setState(() {});
                            }
                          },
                          items: usersList.map<DropdownMenuItem<UserListModel>>(
                            (UserListModel user) {
                              return DropdownMenuItem<UserListModel>(
                                value: user,
                                child: Text("  ${user.name}"),
                              );
                            },
                          ).toList(),
                        ),
                      )),
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
                  // value: businessRequestController.userRoleModel?.role ?? "User",
                  value: "User",
                  onChanged: (p0) {
                    // print("selected value is $p0");
                    // businessRequestController.updateRole(p0);
                    // setState(() {});
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
                    GoRouter.of(context).pop(); // Close the dialog
                  },
                  child: const Text("Close"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // businessRequestController.setUserId(widget.userId);
                    // businessRequestController.acceptRequestPost(
                    //     context, homeController.selectedBusiness, (success) {
                    //   widget.userRequestCallback(true);
                    // });
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}