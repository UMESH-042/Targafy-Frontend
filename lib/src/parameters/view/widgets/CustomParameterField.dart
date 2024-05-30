
import 'package:flutter/material.dart';

class CustomFieldParameter extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? dropdownValue;
  final List<DropdownMenuItem<String>>? dropdownItems;
  final ValueChanged<String?>? onChanged;

  const CustomFieldParameter({
    Key? key,
    this.controller,
    required this.label,
    this.dropdownValue,
    this.dropdownItems,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0, // Fixed height for consistency
      child: dropdownItems != null
          ? DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
              value: dropdownValue,
              items: dropdownItems,
              onChanged: onChanged,
            )
          : TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
            ),
    );
  }
}


class CustomMultiSelectUserField extends StatelessWidget {
  final List<String>? selectedUsers;
  final List<String>? allUsers;
  final ValueChanged<List<String>> onChanged;

  const CustomMultiSelectUserField({
    Key? key,
    required this.selectedUsers,
    required this.allUsers,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Select User',
          border: OutlineInputBorder(),
        ),
        value: selectedUsers != null && selectedUsers!.isNotEmpty ? selectedUsers![0] : null,
        items: allUsers != null
            ? allUsers!.map((user) {
                return DropdownMenuItem<String>(
                  value: user,
                  child: Text(user),
                );
              }).toList()
            : null,
        onChanged: (selectedItem) {
          if (selectedItem != null) {
            final List<String> updatedUsers = List.from(selectedUsers ?? []);
            if (updatedUsers.contains(selectedItem)) {
              updatedUsers.remove(selectedItem);
            } else {
              updatedUsers.add(selectedItem);
            }
            onChanged(updatedUsers);
          }
        },
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
      ),
    );
  }
}
