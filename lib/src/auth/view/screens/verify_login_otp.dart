// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/shared/components/primary_button.dart';
// import 'package:targafy/src/registration/view/screens/register_a_business_screen1.dart';

// class VerifyOTPScreen extends StatefulWidget {
//   const VerifyOTPScreen({super.key});

//   @override
//   State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
// }

// class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.04, vertical: getScreenheight(context) * 0.04),
//                 alignment: Alignment.centerLeft,
//                 child: Image.asset('assets/img/back.png'),
//               ),
//             ),
//             Container(
//               alignment: Alignment.center,
//               child: Image.asset('assets/img/verify_screen.png'),
//             ),
//             Text(
//               'OTP Verification',
//               style: TextStyle(
//                 fontFamily: 'Sofia Pro',
//                 fontWeight: FontWeight.w700,
//                 fontSize: getScreenWidth(context) * 0.06,
//               ),
//             ),
//             Text(
//               'Manage Your Business Easily With Us',
//               style: TextStyle(fontFamily: 'Sofia Pro', fontWeight: FontWeight.w400, fontSize: getScreenWidth(context) * 0.04, color: tertiaryColor),
//             ),
//             SizedBox(height: getScreenheight(context) * 0.05),
//             OtpTextField(
//               autoFocus: true,
//               cursorColor: Colors.black,
//               fieldWidth: getScreenWidth(context) * 0.12,
//               borderRadius: BorderRadius.circular(12),
//               textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//               showCursor: false,
//               borderWidth: 2,
//               numberOfFields: 4,
//               borderColor: primaryColor,
//               showFieldAsBox: true,
//               onSubmit: (String code) {},
//               disabledBorderColor: primaryColor,
//               enabledBorderColor: primaryColor,
//             ),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.05),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [SizedBox(height: getScreenheight(context) * 0.02), SizedBox(height: getScreenheight(context) * 0.05), PrimaryButton(function: () {
//                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterABusinessScreen1()));
//                 }, text: 'Verify OTP')],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/src/auth/view/Controllers/login.dart';
import 'package:targafy/utils/utils.dart';
import 'package:targafy/src/registration/view/screens/register_a_business_screen1.dart';

class VerifyOTPScreen extends ConsumerStatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  ConsumerState<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends ConsumerState<VerifyOTPScreen> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    final loginNotifier = ref.read(loginProvider.notifier);

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
              alignment: Alignment.center,
              child: Image.asset('assets/img/verify_screen.png'),
            ),
            Text(
              'OTP Verification',
              style: TextStyle(
                fontFamily: 'Sofia Pro',
                fontWeight: FontWeight.w700,
                fontSize: getScreenWidth(context) * 0.06,
              ),
            ),
            Text(
              'Manage Your Business Easily With Us',
              style: TextStyle(fontFamily: 'Sofia Pro', fontWeight: FontWeight.w400, fontSize: getScreenWidth(context) * 0.04, color: tertiaryColor),
            ),
            SizedBox(height: getScreenheight(context) * 0.05),
            OtpTextField(
              autoFocus: true,
              cursorColor: Colors.black,
              fieldWidth: getScreenWidth(context) * 0.12,
              borderRadius: BorderRadius.circular(12),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              showCursor: false,
              borderWidth: 2,
              numberOfFields: 4,
              borderColor: primaryColor,
              showFieldAsBox: true,
              onSubmit: (String code) {
                setState(() {
                  otp = code;
                });
              },
              disabledBorderColor: primaryColor,
              enabledBorderColor: primaryColor,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getScreenheight(context) * 0.02),
                  SizedBox(height: getScreenheight(context) * 0.05),
                  PrimaryButton(
                    function: () async {
                      loginNotifier.updateOtpCode(otp);
                      final success = await loginNotifier.verifyLoginOtp(context);
                      if (success) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterABusinessScreen1()));
                      } else {
                        showSnackBar(context, 'Invalid OTP. Please try again.', Colors.red);
                      }
                    },
                    text: 'Verify OTP',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
