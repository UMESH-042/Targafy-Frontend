import 'package:flutter/material.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/utils/texts.dart';

class CustomBackButton extends StatelessWidget {
  final String? text;
  const CustomBackButton({
    super.key,
    this.text,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                    horizontal: getScreenWidth(context) * 0.04,
                    vertical: getScreenheight(context) * 0.04)
                .copyWith(bottom: 0),
            alignment: Alignment.centerLeft,
            child: Image.asset('assets/img/back.png'),
          ),
        ),
        if (text != null)
          Padding(
            padding: EdgeInsets.only(top: getScreenheight(context) * 0.04),
            child: CustomText(
              text: text!,
              fontSize: getScreenWidth(context) * 0.055,
              fontWeight: FontWeight.w400,
            ),
          ),
      ],
    );
  }
}
