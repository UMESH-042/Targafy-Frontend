import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/src/home/view/home_screen.dart';

class RegisterABusinessScreen2 extends StatefulWidget {
  const RegisterABusinessScreen2({super.key});

  @override
  State<RegisterABusinessScreen2> createState() => _RegisterABusinessScreen2State();
}

class _RegisterABusinessScreen2State extends State<RegisterABusinessScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.04, vertical: getScreenheight(context) * 0.04),
                    alignment: Alignment.centerLeft,
                    child: Image.asset('assets/img/back.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: getScreenheight(context) * 0.01),
                  child: Text('Register a business', style: TextStyle(fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.05, fontWeight: FontWeight.w500, color: secondaryColor)),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(getScreenWidth(context) * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: getScreenWidth(context) * 0.1,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: getScreenWidth(context) * 0.0, left: getScreenWidth(context) * 0.02),
                        hintText: 'Enter your email address',
                        hintStyle: TextStyle(color: const Color(0xff787878), fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.035),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.025),
                  SizedBox(
                    height: getScreenWidth(context) * 0.1,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: getScreenWidth(context) * 0.0, left: getScreenWidth(context) * 0.02),
                        hintText: 'Enter yourname',
                        hintStyle: TextStyle(color: const Color(0xff787878), fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.035),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.025),
                  SizedBox(
                    height: getScreenWidth(context) * 0.1,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: getScreenWidth(context) * 0.0, left: getScreenWidth(context) * 0.02),
                        hintText: 'Enter your business name',
                        hintStyle: TextStyle(color: const Color(0xff787878), fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.035),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.025),
                  SizedBox(
                    height: getScreenWidth(context) * 0.1,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: getScreenWidth(context) * 0.0, left: getScreenWidth(context) * 0.02),
                        hintText: 'Import your logo',
                        hintStyle: TextStyle(color: const Color(0xff787878), fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.035),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.025),
                  SizedBox(
                    height: getScreenWidth(context) * 0.1,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: getScreenWidth(context) * 0.0, left: getScreenWidth(context) * 0.02),
                        hintText: 'Enter parameters to monitor',
                        hintStyle: TextStyle(color: const Color(0xff787878), fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.035),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.38),
                  PrimaryButton(
                      function: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                      },
                      text: 'Continue')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
