import 'package:flutter/material.dart';
import 'package:targafy/core/shared/components/back_button.dart';
import 'package:targafy/core/shared/custom_textform_field.dart';

class AddParameter extends StatefulWidget {
  const AddParameter({super.key});

  @override
  State<AddParameter> createState() => _AddParameterState();
}

class _AddParameterState extends State<AddParameter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const CustomBackButton(
          text: 'Add Parameter',
        ),
        CustomTextField(controller: TextEditingController(), label: 'Enter Parameter Name'),
        CustomTextField(controller: TextEditingController(), label: 'Select users'),
        CustomTextField(controller: TextEditingController(), label: 'Select charts'),
        CustomTextField(controller: TextEditingController(), label: 'Enter Description', height: 0.5),
      ],
    ));
  }
}
