import 'package:flutter/material.dart';

class CustomSubBackButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomSubBackButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.04)
                .copyWith(bottom: 0),
            alignment: Alignment.centerLeft,
            child: Image.asset('assets/img/back.png'),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.055,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
