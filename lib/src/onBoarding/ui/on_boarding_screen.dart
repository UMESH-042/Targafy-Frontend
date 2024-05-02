// ignore_for_file: use_build_context_synchronously

import 'package:targafy/core/shared/nav_bar.dart';
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

  void _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasSeenOnboarding', true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavigationScreen()));
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
              });
            },
            controller: _controller,
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  Row(
                    
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _completeOnboarding,
                          child: const SizedBox(
                            width: 216,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Skip',
                                ),
                                Icon(
                                  Icons.arrow_right,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
