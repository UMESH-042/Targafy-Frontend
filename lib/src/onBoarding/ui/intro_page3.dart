import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:targafy/core/constants/dimensions.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          left: getScreenWidth(context) * 0.18,
          top: getScreenheight(context) * 0.13,
          child: SvgPicture.asset(
            'assets/svgs/vector3.svg',
          ),
        ),
        Positioned(
          left: getScreenWidth(context) * 0.04,
          top: getScreenheight(context) * 0.16,
          child: Image.asset(
            'assets/img/image3.png',
          ),
        ),
        Positioned(
          left: getScreenWidth(context) * 0.165,
          top: getScreenheight(context) * 0.53,
          child: Text(
            'For employees',
            style: TextStyle(
              fontSize: getScreenWidth(context) * 0.1,
              fontWeight: FontWeight.w600,
              fontFamily: 'Sofia Pro',
            ),
          ),
        ),
        Positioned(
          left: getScreenWidth(context) * 0.26,
          top: getScreenheight(context) * 0.6,
          child: SizedBox(
            width: getScreenWidth(context) * 0.5,
            child: Text(
              'Make your business easy with our service',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getScreenWidth(context) * 0.04,
                fontWeight: FontWeight.w500,
                fontFamily: 'Sofia Pro',
              ),
            ),
          ),
        ),
        Positioned(
          left: getScreenWidth(context) * 0.05,
          top: getScreenheight(context) * 0.68,
          child: SizedBox(
            width: getScreenWidth(context) * 0.9,
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getScreenWidth(context) * 0.028,
                fontWeight: FontWeight.w300,
                fontFamily: 'Sofia Pro',
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
