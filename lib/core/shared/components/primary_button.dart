import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.function,
    required this.text,
  });
  final Function function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getScreenWidth(context),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            surfaceTintColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async{
            await function();
          },
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Sofia Pro',
              fontWeight: FontWeight.w600,
              fontSize: getScreenWidth(context) * 0.035,
              color: Colors.white,
            ),
          )),
    );
  }
}
