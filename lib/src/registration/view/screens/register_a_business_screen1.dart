import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/src/auth/view/Controllers/login.dart';
import 'package:targafy/src/home/view/screens/widgets/Bottom_navigation_bar.dart';
import 'package:targafy/src/registration/view/screens/register_a_business_screen2.dart';

class RegisterABusinessScreen1 extends ConsumerStatefulWidget {
  const RegisterABusinessScreen1({super.key});

  @override
  ConsumerState<RegisterABusinessScreen1> createState() =>
      _RegisterABusinessScreen1State();
}

class _RegisterABusinessScreen1State
    extends ConsumerState<RegisterABusinessScreen1> {
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
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
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
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.05).copyWith(top: getScreenheight(context) * 0.05),
            //   child: PrimaryButton(
            //       function: () {
            //         Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterABusinessScreen2()));

            //       },
            //       text: 'Proceed'),
            // )
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: getScreenWidth(context) * 0.05,
              ).copyWith(
                top: getScreenheight(context) * 0.05,
              ),
              child: PrimaryButton(
                function: () async {
                  // Call the function to check business existence
                  final exists = await loginNotifier.checkBusinessExists();

                  if (exists) {
                    // Business already exists
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Business already exists')),
                    );
                    Navigator.push(
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
                },
                text: 'Proceed',
              ),
            )
          ],
        ),
      ),
    );
  }
}
