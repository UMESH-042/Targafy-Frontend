import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/src/auth/view/screens/verify_otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getScreenheight(context) * 0.15),
            Container(
              alignment: Alignment.center,
              child: Image.asset('assets/img/targafy.png'),
            ),
            SizedBox(height: getScreenheight(context) * 0.08),
            Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Sofia Pro',
                fontWeight: FontWeight.w700,
                fontSize: getScreenWidth(context) * 0.06,
              ),
            ),
            SizedBox(height: getScreenheight(context) * 0.05),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Number',
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontWeight: FontWeight.w600,
                      fontSize: getScreenWidth(context) * 0.04,
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: getScreenWidth(context) * 0.125,
                        height: getScreenWidth(context) * 0.1,
                      ),
                      SizedBox(width: getScreenWidth(context) * 0.05),
                      Expanded(
                          child: SizedBox(
                        height: getScreenWidth(context) * 0.1,
                        child: TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: getScreenWidth(context) * 0.05, left: getScreenWidth(context) * 0.02),
                            hintText: 'Enter contact number',
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
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: getScreenWidth(context) * 0.05),
                      Checkbox(value: false, onChanged: (_) {}),
                      SizedBox(width: getScreenWidth(context) * 0.02),
                      SizedBox(
                        width: getScreenWidth(context) * 0.7,
                        child: Text(
                          'I agree to the Terms and Conditions and Privacy Policy',
                          style: TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontWeight: FontWeight.w500,
                            fontSize: getScreenWidth(context) * 0.03,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: getScreenheight(context) * 0.05),
                  PrimaryButton(function: () async{
                    // Map<String, dynamic> response = await AuthRepo.login(countryCode: '+91', phone: '9134548705');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const VerifyOTPScreen()));
                  }, text: 'Send OTP')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
