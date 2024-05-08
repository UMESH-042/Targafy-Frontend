import 'package:flutter/material.dart';
import 'package:targafy/core/shared/components/back_button.dart';

class ParameterScreen extends StatefulWidget {
  final String parameterName;
  const ParameterScreen({super.key, required this.parameterName});

  @override
  State<ParameterScreen> createState() => _ParameterScreenState();
}

class _ParameterScreenState extends State<ParameterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomBackButton(
            text: '${widget.parameterName} Parameter',
          ),
        ],
      ),
    );
  }
}
