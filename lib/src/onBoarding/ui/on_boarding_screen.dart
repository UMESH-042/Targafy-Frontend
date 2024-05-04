// ignore_for_file: use_build_context_synchronously

import 'package:dots_indicator/dots_indicator.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/src/auth/view/screens/send_otp_screen.dart';
import 'package:targafy/src/onBoarding/ui/intro_page2.dart';
import 'package:targafy/src/onBoarding/ui/intro_page3.dart';
import 'package:targafy/src/onBoarding/ui/intro_page1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  bool onLastPage = false;
  int currentIndex = 0;

  void _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasSeenOnboarding', true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
                currentIndex = index;
              });
            },
            controller: _controller,
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Positioned(
              left: getScreenWidth(context) * 0.42,
              bottom: getScreenheight(context) * 0.46,
              child: DotsIndicator(
                decorator: DotsDecorator(
                  activeColor: primaryColor,
                ),
                dotsCount: 3,
                position: currentIndex,
              )),
          Positioned(
              left: getScreenWidth(context) * 0.07,
              bottom: getScreenWidth(context) * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () {
                      _completeOnboarding();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: getScreenWidth(context) * 0.14,
                        vertical: getScreenWidth(context) * 0.015,
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.w500,
                          color: secondaryColor,
                          fontSize: getScreenWidth(context) * 0.04,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: getScreenWidth(context) * 0.12),
                  GestureDetector(
                    onTap: () {
                      if (onLastPage) {
                        _completeOnboarding();
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: getScreenWidth(context) * 0.14,
                        vertical: getScreenWidth(context) * 0.015,
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: getScreenWidth(context) * 0.04,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
