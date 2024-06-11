// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/shared/components/primary_button.dart';
// import 'package:targafy/src/auth/view/Controllers/login.dart';
// import 'package:targafy/src/home/view/screens/widgets/Bottom_navigation_bar.dart';
// import 'package:http/http.dart' as http;
// import 'package:targafy/src/registration/view/screens/register_a_business_screen2.dart';

// class RegisterABusinessScreen1 extends ConsumerStatefulWidget {
//   const RegisterABusinessScreen1({super.key});

//   @override
//   ConsumerState<RegisterABusinessScreen1> createState() =>
//       _RegisterABusinessScreen1State();
// }

// class _RegisterABusinessScreen1State
//     extends ConsumerState<RegisterABusinessScreen1> {
//   @override
//   void initState() {
//     super.initState();
//     _getToken();
//   }

//   Future<void> _getToken() async {
//     try {
//       // Fetch the FCM token
//       String? fcmToken = await FirebaseMessaging.instance.getToken();
//       print('FCM Token: $fcmToken');

//       // Retrieve the bearer token from shared preferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? bearerToken = prefs.getString('authToken');

//       // Ensure both tokens are available
//       if (fcmToken != null && bearerToken != null) {
//         // Make a POST request to your server
//         await _sendTokenToServer(fcmToken, bearerToken);
//       } else {
//         print('Failed to retrieve FCM token or bearer token.');
//       }
//     } catch (e) {
//       print('Error fetching token: $e');
//     }
//   }

//   Future<void> _sendTokenToServer(String fcmToken, String bearerToken) async {
//     try {
//       // Define the URL of your server endpoint
//       final url = Uri.parse(
//           'http://13.234.163.59:5000/api/v1/user/update/fcmToken?fcmToken=$fcmToken');

//       // Make the POST request
//       final response = await http.patch(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $bearerToken',
//         },
//       );

//       // Check the response status
//       if (response.statusCode == 200) {
//         print('Token sent successfully.');
//       } else {
//         print('Failed to send token: ${response.statusCode} ${response.body}');
//       }
//     } catch (e) {
//       print('Error sending token to server: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loginState = ref.watch(loginProvider);
//     final loginNotifier = ref.read(loginProvider.notifier);
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: getScreenheight(context) * 0.2,
//             ),

//             Container(
//               margin: EdgeInsets.all(getScreenWidth(context) * 0.05),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(18),
//                 color: Colors.white,
//                 border: Border.all(color: primaryColor, width: 2),
//               ),
//               width: getScreenWidth(context),
//               height: getScreenheight(context) * 0.23,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Checkbox(
//                         value: true,
//                         onChanged: (_) {},
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         checkColor: Colors.white,
//                         activeColor: primaryColor,
//                       ),
//                       Text(
//                         'Register a Business',
//                         style: TextStyle(
//                           fontFamily: 'Sofia Pro',
//                           fontWeight: FontWeight.w400,
//                           fontSize: getScreenWidth(context) * 0.04,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: getScreenWidth(context) * 0.04),
//                     child: Container(
//                       alignment: Alignment.centerLeft,
//                       width: getScreenWidth(context) * 0.72,
//                       child: Text(
//                         'This option is for the business owners who wants to register their business. Registering will generate a special code which can be shared with employees.',
//                         style: TextStyle(
//                           fontFamily: 'Sofia Pro',
//                           fontWeight: FontWeight.w400,
//                           fontSize: getScreenWidth(context) * 0.038,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(getScreenWidth(context) * 0.05),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(18),
//                 color: Colors.white,
//                 border: Border.all(color: primaryColor, width: 2),
//               ),
//               width: getScreenWidth(context),
//               height: getScreenheight(context) * 0.23,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Checkbox(
//                         value: false,
//                         onChanged: (_) {},
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         checkColor: Colors.white,
//                         activeColor: primaryColor,
//                       ),
//                       Text(
//                         'Join a Business',
//                         style: TextStyle(
//                           fontFamily: 'Sofia Pro',
//                           fontWeight: FontWeight.w400,
//                           fontSize: getScreenWidth(context) * 0.04,
//                         ),
//                       ),
//                     ],
//                   ),
//                   OtpTextField(
//                     autoFocus: false,
//                     cursorColor: Colors.black,
//                     fieldWidth: getScreenWidth(context) * 0.08,
//                     fieldHeight: getScreenheight(context) * 0.045,
//                     borderRadius: BorderRadius.circular(12),
//                     textStyle: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                     showCursor: false,
//                     borderWidth: 1,
//                     numberOfFields: 4,
//                     borderColor: primaryColor,
//                     showFieldAsBox: true,
//                     onSubmit: (String code) {},
//                     disabledBorderColor: primaryColor,
//                     enabledBorderColor: primaryColor,
//                   ),
//                   const SizedBox(height: 5),
//                   Container(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Enter the business code',
//                       style: TextStyle(
//                           fontFamily: 'Sofia Pro',
//                           fontWeight: FontWeight.w300,
//                           fontSize: getScreenWidth(context) * 0.028,
//                           color: tertiaryColor),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: getScreenWidth(context) * 0.04),
//                     child: Container(
//                       alignment: Alignment.centerLeft,
//                       width: getScreenWidth(context) * 0.75,
//                       child: Text(
//                         'This option is for the employees who want to join a particular business. For joining a business you should have a special code.',
//                         style: TextStyle(
//                           fontFamily: 'Sofia Pro',
//                           fontWeight: FontWeight.w400,
//                           fontSize: getScreenWidth(context) * 0.038,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Container(
//             //   margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.05).copyWith(top: getScreenheight(context) * 0.05),
//             //   child: PrimaryButton(
//             //       function: () {
//             //         Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterABusinessScreen2()));

//             //       },
//             //       text: 'Proceed'),
//             // )
//             Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: getScreenWidth(context) * 0.05,
//               ).copyWith(
//                 top: getScreenheight(context) * 0.05,
//               ),
//               child: PrimaryButton(
//                 function: () async {
//                   // Call the function to check business existence
//                   final exists = await loginNotifier.checkBusinessExists();

//                   if (exists) {
//                     // Business already exists
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Business already exists')),
//                     );
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               const BottomNavigationAndAppBar()),
//                     );
//                   } else {
//                     // Navigate to the next screen if business does not exist
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               const RegisterABusinessScreen2()),
//                     );
//                   }
//                 },
//                 text: 'Proceed',
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/src/auth/view/Controllers/login.dart';
import 'package:targafy/src/home/view/screens/widgets/Bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:targafy/src/registration/view/screens/register_a_business_screen2.dart';

class RegisterABusinessScreen1 extends ConsumerStatefulWidget {
  const RegisterABusinessScreen1({super.key});

  @override
  ConsumerState<RegisterABusinessScreen1> createState() =>
      _RegisterABusinessScreen1State();
}

class _RegisterABusinessScreen1State
    extends ConsumerState<RegisterABusinessScreen1> {
  bool isRegisterSelected = true;
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    try {
      // Fetch the FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print('FCM Token: $fcmToken');

      // Retrieve the bearer token from shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? bearerToken = prefs.getString('authToken');

      // Ensure both tokens are available
      if (fcmToken != null && bearerToken != null) {
        // Make a POST request to your server
        await _sendTokenToServer(fcmToken, bearerToken);
      } else {
        print('Failed to retrieve FCM token or bearer token.');
      }
    } catch (e) {
      print('Error fetching token: $e');
    }
  }

  Future<void> _sendTokenToServer(String fcmToken, String bearerToken) async {
    try {
      // Define the URL of your server endpoint
      final url = Uri.parse(
          'http://13.234.163.59:5000/api/v1/user/update/fcmToken?fcmToken=$fcmToken');

      // Make the POST request
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        print('Token sent successfully.');
      } else {
        print('Failed to send token: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error sending token to server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getScreenheight(context) * 0.2,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isRegisterSelected = true;
                });
              },
              child: Container(
                margin: EdgeInsets.all(getScreenWidth(context) * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  border: Border.all(
                      color: isRegisterSelected ? primaryColor : Colors.grey,
                      width: 2),
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
                          value: isRegisterSelected,
                          onChanged: (value) {
                            setState(() {
                              isRegisterSelected = value!;
                            });
                          },
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
                      padding: EdgeInsets.symmetric(
                          horizontal: getScreenWidth(context) * 0.04),
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
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isRegisterSelected = false;
                });
              },
              child: Container(
                margin: EdgeInsets.all(getScreenWidth(context) * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  border: Border.all(
                      color: !isRegisterSelected ? primaryColor : Colors.grey,
                      width: 2),
                ),
                width: getScreenWidth(context),
                height: getScreenheight(context) * 0.28,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: !isRegisterSelected,
                          onChanged: (value) {
                            setState(() {
                              isRegisterSelected = !value!;
                            });
                          },
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
                    const SizedBox(height: 5),
                    OtpTextField(
                      numberOfFields: 6,
                      fieldWidth: 30.0, // Adjusted field width
                      fieldHeight: 40.0, // Adjusted field height
                      borderColor: primaryColor,
                      showFieldAsBox: true,
                      onCodeChanged: (String code) {
                        // Handle validation or checks here if necessary
                      },
                      onSubmit: (String verificationCode) {
                        codeController.text = verificationCode;
                      }, // end onSubmit
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Enter the business code',
                        style: TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontWeight: FontWeight.w300,
                            fontSize: getScreenWidth(context) * 0.028,
                            color: tertiaryColor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getScreenWidth(context) * 0.04),
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
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: getScreenWidth(context) * 0.05,
              ).copyWith(
                top: getScreenheight(context) * 0.05,
              ),
              child: PrimaryButton(
                function: () async {
                  if (isRegisterSelected) {
                    // Call the function to check business existence
                    final exists = await loginNotifier.checkBusinessExists();

                    if (exists) {
                      // Business already exists
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Business already exists')),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BottomNavigationAndAppBar()),
                      );
                    } else {
                      // Navigate to the next screen if business does not exist
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RegisterABusinessScreen2()),
                      );
                    }
                  } else {
                    // Handle joining a business with the entered code
                    final code = codeController.text;
                    if (code.length == 6) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationAndAppBar()));
                    } else {
                      // Show an error message if the code is invalid
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please enter a valid 6-digit code')),
                      );
                    }
                  }
                },
                text: 'Proceed',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
