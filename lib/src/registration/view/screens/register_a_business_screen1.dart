import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/src/registration/view/screens/register_a_business_screen2.dart';

class RegisterABusinessScreen1 extends StatefulWidget {
  const RegisterABusinessScreen1({super.key});

  @override
  State<RegisterABusinessScreen1> createState() => _RegisterABusinessScreen1State();
}

class _RegisterABusinessScreen1State extends State<RegisterABusinessScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            Container(
              margin: EdgeInsets.all(getScreenWidth(context) * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                border: Border.all(color: primaryColor, width: 2),
              ),
              width: getScreenWidth(context),
              height: getScreenheight(context) * 0.23,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (_) {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        checkColor: Colors.white,
                        activeColor: primaryColor,
                      ),
                      Text(
                        'Register a Business',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.w400,
                          fontSize: getScreenWidth(context) * 0.04,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.04),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: getScreenWidth(context) * 0.72,
                      child: Text(
                        'This option is for the business owners who wants to register their business. Registering will generate a special code which can be shared with employees.',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.w400,
                          fontSize: getScreenWidth(context) * 0.038,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(getScreenWidth(context) * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                border: Border.all(color: primaryColor, width: 2),
              ),
              width: getScreenWidth(context),
              height: getScreenheight(context) * 0.23,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (_) {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        checkColor: Colors.white,
                        activeColor: primaryColor,
                      ),
                      Text(
                        'Join a Business',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.w400,
                          fontSize: getScreenWidth(context) * 0.04,
                        ),
                      ),
                    ],
                  ),
                  OtpTextField(
                    autoFocus: true,
                    cursorColor: Colors.black,
                    fieldWidth: getScreenWidth(context) * 0.08,
                    fieldHeight: getScreenheight(context) * 0.045,
                    borderRadius: BorderRadius.circular(12),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    showCursor: false,
                    borderWidth: 1,
                    numberOfFields: 4,
                    borderColor: primaryColor,
                    showFieldAsBox: true,
                    onSubmit: (String code) {},
                    disabledBorderColor: primaryColor,
                    enabledBorderColor: primaryColor,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Enter the business code',
                      style: TextStyle(fontFamily: 'Sofia Pro', fontWeight: FontWeight.w300, fontSize: getScreenWidth(context) * 0.028, color: tertiaryColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.04),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: getScreenWidth(context) * 0.75,
                      child: Text(
                        'This option is for the employees who want to join a particular business. For joining a business you should have a special code.',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.w400,
                          fontSize: getScreenWidth(context) * 0.038,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.05).copyWith(top: getScreenheight(context) * 0.05),
              child: PrimaryButton(
                  function: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterABusinessScreen2()));
                  },
                  text: 'Proceed'),
            )
          ],
        ),
      ),
    );
  }
}
