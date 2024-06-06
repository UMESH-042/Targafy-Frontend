
import 'package:flutter/material.dart';

class CustomFieldParameter extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? dropdownValue;
  final List<DropdownMenuItem<String>>? dropdownItems;
  final ValueChanged<String?>? onChanged;

  const CustomFieldParameter({
    super.key,
    this.controller,
    required this.label,
    this.dropdownValue,
    this.dropdownItems,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0, // Fixed height for consistency
      child: dropdownItems != null
          ? DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
              value: dropdownValue,
              items: dropdownItems,
              onChanged: onChanged,
            )
          : TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
            ),
    );
  }
}

