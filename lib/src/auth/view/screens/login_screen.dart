// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/shared/components/primary_button.dart';
// import 'package:targafy/src/auth/view/Controllers/login.dart';
// import 'package:targafy/src/auth/view/screens/verify_login_otp.dart';
// // import 'package:targafy/utils/routes/app_route_constants.dart';
// import 'package:targafy/utils/utils.dart';
// import 'package:url_launcher/url_launcher.dart';
// // import 'package:go_router/go_router.dart';

// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   bool _isTermsAndConditionsAgreed = false;

//   @override
//   Widget build(BuildContext context) {
//     final loginState = ref.watch(loginProvider);
//     final loginNotifier = ref.read(loginProvider.notifier);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: getScreenheight(context) * 0.15),
//             Container(
//               alignment: Alignment.center,
//               child: Image.asset('assets/img/targafy.png'),
//             ),
//             SizedBox(height: getScreenheight(context) * 0.08),
//             Text(
//               'Login',
//               style: TextStyle(
//                 fontFamily: 'Sofia Pro',
//                 fontWeight: FontWeight.w700,
//                 fontSize: getScreenWidth(context) * 0.06,
//               ),
//             ),
//             SizedBox(height: getScreenheight(context) * 0.05),
//             Container(
//               alignment: Alignment.centerLeft,
//               margin: EdgeInsets.symmetric(
//                   horizontal: getScreenWidth(context) * 0.05),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Contact Number',
//                     style: TextStyle(
//                       fontFamily: 'Sofia Pro',
//                       fontWeight: FontWeight.w600,
//                       fontSize: getScreenWidth(context) * 0.04,
//                     ),
//                   ),
//                   SizedBox(height: getScreenheight(context) * 0.02),
//                   IntlPhoneField(
//                     initialValue: loginState.number,
//                     decoration: InputDecoration(
//                       labelText: 'Phone Number',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(color: primaryColor, width: 2),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(color: primaryColor, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(color: primaryColor, width: 2),
//                       ),
//                     ),
//                     initialCountryCode: 'IN',
//                     onChanged: (phone) {
//                       loginNotifier.updateNumber(phone.number);
//                     },
//                     onCountryChanged: (country) {
//                       loginNotifier.updateCountryCode('+${country.dialCode}');
//                     },
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(width: getScreenWidth(context) * 0.05),
//                       Checkbox(
//                         value: _isTermsAndConditionsAgreed,
//                         onChanged: (bool? value) {
//                           setState(() {
//                             _isTermsAndConditionsAgreed = value ?? false;
//                           });
//                         },
//                       ),
//                       SizedBox(width: getScreenWidth(context) * 0.02),
//                       // Flexible(
//                       //   child: Text(
//                       //     'I agree to the Terms and Conditions and Privacy Policy',
//                       //     style: TextStyle(
//                       //       fontFamily: 'Sofia Pro',
//                       //       fontWeight: FontWeight.w500,
//                       //       fontSize: getScreenWidth(context) * 0.03,
//                       //     ),
//                       //   ),
//                       // )
//                       RichText(
//                         text: TextSpan(
//                           text: 'I agree to the ',
//                           style: TextStyle(
//                             fontFamily: 'Sofia Pro',
//                             fontWeight: FontWeight.w500,
//                             fontSize: getScreenWidth(context) * 0.03,
//                             color: Colors.black, // Adjust color as needed
//                           ),
//                           children: [
//                             TextSpan(
//                               text: 'Terms and Conditions \nand Privacy Policy',
//                               style: TextStyle(
//                                 decoration: TextDecoration.underline,
//                                 color: Colors.blue, // Adjust color as needed
//                               ),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   // Navigate to your URL
//                                   launch('https://ophiz.com/targafy');
//                                 },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: getScreenheight(context) * 0.05),
//                   PrimaryButton(
//                     function: () async {
//                       if (_isTermsAndConditionsAgreed) {
//                         final success = await loginNotifier.login(context);
//                         if (success) {
//                           // GoRouter.of(context).pushNamed(MyAppRouteConstants.verifyRouteName);
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const VerifyOTPScreen()));
//                         }
//                       } else {
//                         showSnackBar(
//                           context,
//                           'You must agree to the terms and conditions.',
//                           Colors.red,
//                         );
//                       }
//                     },
//                     text: 'Send OTP',
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/src/auth/view/Controllers/login.dart';
import 'package:targafy/src/auth/view/screens/verify_login_otp.dart';
import 'package:targafy/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isTermsAndConditionsAgreed = false;

  Future<bool> _onWillPop() async {
    // Always return false to prevent back navigation
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                margin: EdgeInsets.symmetric(
                    horizontal: getScreenWidth(context) * 0.05),
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
                    IntlPhoneField(
                      initialValue: loginState.number,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
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
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        loginNotifier.updateNumber(phone.number);
                      },
                      onCountryChanged: (country) {
                        loginNotifier.updateCountryCode('+${country.dialCode}');
                      },
                    ),
                    Row(
                      children: [
                        SizedBox(width: getScreenWidth(context) * 0.05),
                        Checkbox(
                          value: _isTermsAndConditionsAgreed,
                          onChanged: (bool? value) {
                            setState(() {
                              _isTermsAndConditionsAgreed = value ?? false;
                            });
                          },
                        ),
                        SizedBox(width: getScreenWidth(context) * 0.02),
                        RichText(
                          text: TextSpan(
                            text: 'I agree to the ',
                            style: TextStyle(
                              fontFamily: 'Sofia Pro',
                              fontWeight: FontWeight.w500,
                              fontSize: getScreenWidth(context) * 0.03,
                              color: Colors.black, // Adjust color as needed
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms and Conditions \nand Privacy Policy',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue, // Adjust color as needed
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch('https://ophiz.com/targafy');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getScreenheight(context) * 0.05),
                    PrimaryButton(
                      function: () async {
                        if (_isTermsAndConditionsAgreed) {
                          final success = await loginNotifier.login(context);
                          if (success) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VerifyOTPScreen(),
                              ),
                            );
                          }
                        } else {
                          showSnackBar(
                            context,
                            'You must agree to the terms and conditions.',
                            Colors.red,
                          );
                        }
                      },
                      text: 'Send OTP',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
