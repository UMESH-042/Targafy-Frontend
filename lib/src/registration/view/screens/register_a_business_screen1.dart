import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/join_business_controller.dart';
import 'package:targafy/business_home_page/models/business_request.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/src/auth/view/Controllers/login.dart';
import 'package:targafy/src/home/view/screens/widgets/Bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:targafy/src/registration/view/screens/register_a_business_screen2.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

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
      final url = Uri.parse('${domain}user/update/fcmToken?fcmToken=$fcmToken');

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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                      CustomTextInputField(
                        numberOfFields: 6,
                        onCodeChanged: (String code) {
                          // Handle validation or checks here if necessary
                        },
                        onSubmit: (String verificationCode) {
                          codeController.text = verificationCode;
                        },
                      ),
                      const SizedBox(height: 5),
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
                    } else if (!isRegisterSelected) {
                      // Handle joining a business with the entered code
                      final code = codeController.text;
                      if (code.length == 6) {
                        final joinBusinessRequest = JoinBusinessRequest(
                          businessCode: code,
                        );
                        try {
                          final success = await ref.read(
                              joinBusinessProvider(joinBusinessRequest).future);

                          //         if (success) {
                          //           ScaffoldMessenger.of(context).showSnackBar(
                          //             const SnackBar(
                          //                 content: Text(
                          //                     'Your request has been sent successfully. You will be notified soon.')),
                          //           );
                          //           Navigator.pushReplacement(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) =>
                          //                       const BottomNavigationAndAppBar()));
                          //         }
                          //       } catch (e) {
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           const SnackBar(
                          //               content: Text('Pls enter correct code')),
                          //         );
                          //       }
                          //     } else {
                          //       // Show an error message if the code is invalid
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         const SnackBar(
                          //             content:
                          //                 Text('Please enter a valid 6-digit code')),
                          //       );
                          //     }
                          //   }
                          // },
                          if (success) {
                            // Show success message in AlertDialog
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Request Sent Successfully'),
                                content: Text(
                                    'Your request has been sent successfully. You will be notified soon.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BottomNavigationAndAppBar()));
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        } catch (e) {
                          // Show error message in AlertDialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Error'),
                              content: Text('Please enter correct code'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        // Show an error message if the code is invalid
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Invalid Code'),
                            content: Text('Please enter a valid 6-digit code'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
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
      ),
    );
  }
}

class CustomTextInputField extends StatefulWidget {
  final int numberOfFields;
  final Function(String) onCodeChanged;
  final Function(String) onSubmit;

  const CustomTextInputField({
    Key? key,
    required this.numberOfFields,
    required this.onCodeChanged,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _CustomTextInputFieldState createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.numberOfFields, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    String code = _controllers.map((e) => e.text.toUpperCase()).join();
    widget.onCodeChanged(code);

    if (value.isNotEmpty && index < widget.numberOfFields - 1) {
      FocusScope.of(context).nextFocus();
    }

    if (code.length == widget.numberOfFields) {
      widget.onSubmit(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.numberOfFields, (index) {
        return SizedBox(
          width: 40.0, // Adjusted field width
          child: TextField(
            controller: _controllers[index],
            maxLength: 1,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.characters,
            onChanged: (value) => _onChanged(value, index),
          ),
        );
      }),
    );
  }
}
