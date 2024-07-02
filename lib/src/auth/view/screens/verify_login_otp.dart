// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/shared/components/primary_button.dart';
// import 'package:targafy/src/auth/view/Controllers/login.dart';
// import 'package:targafy/src/home/view/screens/Mandatory_filed.dart';
// import 'package:targafy/src/home/view/screens/controller/mandatory_Filed_name_controller.dart';
// import 'package:targafy/src/registration/view/screens/register_a_business_screen1.dart';
// import 'package:targafy/utils/utils.dart';

// class VerifyOTPScreen extends ConsumerStatefulWidget {
//   const VerifyOTPScreen({super.key});

//   @override
//   ConsumerState<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
// }

// class _VerifyOTPScreenState extends ConsumerState<VerifyOTPScreen> {
//   @override
//   void initState() {
//     super.initState();
//     ref.read(nameControllerProvider.notifier).checkFirstTime();
//   }

//   String otp = "";

//   @override
//   Widget build(BuildContext context) {
//     final loginNotifier = ref.read(loginProvider.notifier);
//     final state = ref.watch(nameControllerProvider);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 margin: EdgeInsets.symmetric(
//                     horizontal: getScreenWidth(context) * 0.04,
//                     vertical: getScreenheight(context) * 0.04),
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
//               style: TextStyle(
//                   fontFamily: 'Sofia Pro',
//                   fontWeight: FontWeight.w400,
//                   fontSize: getScreenWidth(context) * 0.04,
//                   color: tertiaryColor),
//             ),
//             SizedBox(height: getScreenheight(context) * 0.05),
//             OtpTextField(
//               autoFocus: true,
//               cursorColor: Colors.black,
//               fieldWidth: getScreenWidth(context) * 0.12,
//               borderRadius: BorderRadius.circular(12),
//               textStyle: const TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.black),
//               showCursor: false,
//               borderWidth: 2,
//               numberOfFields: 4,
//               borderColor: primaryColor,
//               showFieldAsBox: true,
//               onSubmit: (String code) {
//                 setState(() {
//                   otp = code;
//                 });
//               },
//               disabledBorderColor: primaryColor,
//               enabledBorderColor: primaryColor,
//             ),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.symmetric(
//                   horizontal: getScreenWidth(context) * 0.05),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: getScreenheight(context) * 0.02),
//                   SizedBox(height: getScreenheight(context) * 0.05),
//                   PrimaryButton(
//                     function: () async {
//                       loginNotifier.updateOtpCode(otp);
//                       final success =
//                           await loginNotifier.verifyLoginOtp(context);
//                       if (success) {
//                         // // Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterABusinessScreen1()));
//                         // Navigator.pushReplacement(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) => MandatoryFieldPage()));

//                         if (state.isFirstTime) {
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const MandatoryFieldPage(),
//                             ),
//                             (route) => false,
//                           );
//                         } else {
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   const RegisterABusinessScreen1(),
//                             ),
//                             (route) => false,
//                           );
//                         }
//                       } else {
//                         showSnackBar(context, 'Invalid OTP. Please try again.',
//                             Colors.red);
//                       }
//                     },
//                     text: 'Verify OTP',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/shared/components/primary_button.dart';
// import 'package:targafy/src/auth/view/Controllers/login.dart';
// import 'package:targafy/src/home/view/screens/Mandatory_filed.dart';
// import 'package:targafy/src/home/view/screens/controller/mandatory_Filed_name_controller.dart';
// import 'package:targafy/src/registration/view/screens/register_a_business_screen1.dart';
// import 'package:targafy/utils/utils.dart';

// class VerifyOTPScreen extends ConsumerStatefulWidget {
//   const VerifyOTPScreen({super.key});

//   @override
//   ConsumerState<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
// }

// class _VerifyOTPScreenState extends ConsumerState<VerifyOTPScreen> {
//   String otp = "";

//   @override
//   void initState() {
//     super.initState();
//     ref.read(nameControllerProvider.notifier).checkFirstTime();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loginNotifier = ref.read(loginProvider.notifier);
//     final state = ref.watch(nameControllerProvider);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 margin: EdgeInsets.symmetric(
//                     horizontal: getScreenWidth(context) * 0.04,
//                     vertical: getScreenheight(context) * 0.04),
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
//               style: TextStyle(
//                   fontFamily: 'Sofia Pro',
//                   fontWeight: FontWeight.w400,
//                   fontSize: getScreenWidth(context) * 0.04,
//                   color: tertiaryColor),
//             ),
//             SizedBox(height: getScreenheight(context) * 0.05),
//             OtpTextField(
//               autoFocus: true,
//               cursorColor: Colors.black,
//               fieldWidth: getScreenWidth(context) * 0.12,
//               borderRadius: BorderRadius.circular(12),
//               textStyle: const TextStyle(
//                   fontWeight: FontWeight.bold, color: Colors.black),
//               showCursor: false,
//               borderWidth: 2,
//               numberOfFields: 4,
//               borderColor: primaryColor,
//               showFieldAsBox: true,
//               onSubmit: (String code) {
//                 setState(() {
//                   otp = code;
//                 });
//               },
//               disabledBorderColor: primaryColor,
//               enabledBorderColor: primaryColor,
//             ),
//             SizedBox(height: getScreenheight(context) * 0.02),
//             RichText(
//               text: TextSpan(
//                 text: "Don't receive OTP? ",
//                 style: TextStyle(
//                   fontFamily: 'Sofia Pro',
//                   fontWeight: FontWeight.w400,
//                   fontSize: getScreenWidth(context) * 0.04,
//                   color: Colors.black,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: 'Resend',
//                     style: TextStyle(
//                       color: primaryColor,
//                       decoration: TextDecoration.underline,
//                     ),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () {
//                         // Resend OTP logic here
//                         loginNotifier.login(context);
//                       },
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.symmetric(
//                   horizontal: getScreenWidth(context) * 0.05),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: getScreenheight(context) * 0.05),
//                   PrimaryButton(
//                     function: () async {
//                       loginNotifier.updateOtpCode(otp);
//                       final success =
//                           await loginNotifier.verifyLoginOtp(context);
//                       if (success) {
//                         if (state.isFirstTime) {
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const MandatoryFieldPage(),
//                             ),
//                             (route) => false,
//                           );
//                         } else {
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   const RegisterABusinessScreen1(),
//                             ),
//                             (route) => false,
//                           );
//                         }
//                       } else {
//                         showSnackBar(context, 'Invalid OTP. Please try again.',
//                             Colors.red);
//                       }
//                     },
//                     text: 'Verify OTP',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/src/auth/view/Controllers/login.dart';
import 'package:targafy/src/home/view/screens/Mandatory_filed.dart';
import 'package:targafy/src/home/view/screens/controller/mandatory_Filed_name_controller.dart';
import 'package:targafy/src/home/view/screens/widgets/Bottom_navigation_bar.dart';
import 'package:targafy/utils/utils.dart';

class VerifyOTPScreen extends ConsumerStatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  ConsumerState<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends ConsumerState<VerifyOTPScreen> {
  String otp = "";
  late Timer _timer;
  int _start = 30; // Initial countdown time in seconds

  @override
  void initState() {
    super.initState();
    ref.read(nameControllerProvider.notifier).checkFirstTime();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _resendOtp() {
    // Reset timer and resend OTP logic
    setState(() {
      _start = 30;
    });
    _startTimer();
    ref.read(loginProvider.notifier).login(context);
  }

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
                margin: EdgeInsets.symmetric(
                    horizontal: getScreenWidth(context) * 0.04,
                    vertical: getScreenheight(context) * 0.04),
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
              style: TextStyle(
                  fontFamily: 'Sofia Pro',
                  fontWeight: FontWeight.w400,
                  fontSize: getScreenWidth(context) * 0.04,
                  color: tertiaryColor),
            ),
            SizedBox(height: getScreenheight(context) * 0.05),
            OtpTextField(
              autoFocus: true,
              cursorColor: Colors.black,
              fieldWidth: getScreenWidth(context) * 0.12,
              borderRadius: BorderRadius.circular(12),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
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
            SizedBox(height: getScreenheight(context) * 0.02),
            RichText(
              text: TextSpan(
                text: _start > 0
                    ? "Don't receive OTP? Resend in $_start seconds"
                    : "Don't receive OTP? ",
                style: TextStyle(
                  fontFamily: 'Sofia Pro',
                  fontWeight: FontWeight.w400,
                  fontSize: getScreenWidth(context) * 0.04,
                  color: Colors.black,
                ),
                children: _start > 0
                    ? []
                    : [
                        TextSpan(
                          text: 'Resend',
                          style: TextStyle(
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _resendOtp,
                        ),
                      ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                  horizontal: getScreenWidth(context) * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getScreenheight(context) * 0.05),
                  PrimaryButton(
                    function: () async {
                      loginNotifier.updateOtpCode(otp);
                      final success =
                          await loginNotifier.verifyLoginOtp(context);
                      if (success) {
                        final exists =
                            await loginNotifier.checkBusinessExists();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String? bearerToken = prefs.getString('authToken');
                        if (exists) {
                          // Business already exists
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Business already exists')),
                          );
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           const BottomNavigationAndAppBar()),
                          // );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigationAndAppBar(
                                token: bearerToken,
                              ),
                            ),
                            (route) => false,
                          );
                        } else {
                          // Navigate to the next screen if business does not exist
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           const RegisterABusinessScreen2()),
                          // );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MandatoryFieldPage(),
                            ),
                            (route) => false,
                          );
                        }

                        // if (state.isFirstTime) {
                        //   Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const MandatoryFieldPage(),
                        //     ),
                        //     (route) => false,
                        //   );
                        // } else {
                        //   Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           const RegisterABusinessScreen1(),
                        //     ),
                        //     (route) => false,
                        //   );
                        // }
                      } else {
                        showSnackBar(context, 'Invalid OTP. Please try again.',
                            Colors.red);
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
