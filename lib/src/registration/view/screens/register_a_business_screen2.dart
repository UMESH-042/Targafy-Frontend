// import 'package:flutter/material.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/shared/components/primary_button.dart';
// import 'package:targafy/src/home/view/screens/home_screen.dart';

// class RegisterABusinessScreen2 extends StatefulWidget {
//   const RegisterABusinessScreen2({super.key});

//   @override
//   State<RegisterABusinessScreen2> createState() => _RegisterABusinessScreen2State();
// }

// class _RegisterABusinessScreen2State extends State<RegisterABusinessScreen2> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.04, vertical: getScreenheight(context) * 0.04),
//                     alignment: Alignment.centerLeft,
//                     child: Image.asset('assets/img/back.png'),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: getScreenheight(context) * 0.01),
//                   child: Text('Register a business', style: TextStyle(fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.05, fontWeight: FontWeight.w500, color: secondaryColor)),
//                 )
//               ],
//             ),
//             Container(
//               padding: EdgeInsets.all(getScreenWidth(context) * 0.05),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: getScreenWidth(context) * 0.1,
//                     child: TextField(
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.only(top: getScreenWidth(context) * 0.0, left: getScreenWidth(context) * 0.02),
//                         hintText: 'Enter your email address',
//                         hintStyle: TextStyle(color: const Color(0xff787878), fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.035),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: getScreenheight(context) * 0.025),
//                   SizedBox(
//                     height: getScreenWidth(context) * 0.1,
//                     child: TextField(
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.only(top: getScreenWidth(context) * 0.0, left: getScreenWidth(context) * 0.02),
//                         hintText: 'Enter your name',
//                         hintStyle: TextStyle(color: const Color(0xff787878), fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.035),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: getScreenheight(context) * 0.025),
//                   SizedBox(
//                     height: getScreenWidth(context) * 0.1,
//                     child: TextField(
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.only(top: getScreenWidth(context) * 0.0, left: getScreenWidth(context) * 0.02),
//                         hintText: 'Enter your business name',
//                         hintStyle: TextStyle(color: const Color(0xff787878), fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.035),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: getScreenheight(context) * 0.025),
//                   SizedBox(
//                     height: getScreenWidth(context) * 0.1,
//                     child: TextField(
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.only(top: getScreenWidth(context) * 0.0, left: getScreenWidth(context) * 0.02),
//                         hintText: 'Import your logo',
//                         hintStyle: TextStyle(color: const Color(0xff787878), fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.035),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: getScreenheight(context) * 0.025),
//                   SizedBox(
//                     height: getScreenWidth(context) * 0.1,
//                     child: TextField(
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.only(top: getScreenWidth(context) * 0.0, left: getScreenWidth(context) * 0.02),
//                         hintText: 'Enter parameters to monitor',
//                         hintStyle: TextStyle(color: const Color(0xff787878), fontFamily: 'Sofia Pro', fontSize: getScreenWidth(context) * 0.035),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: primaryColor, width: 2),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: getScreenheight(context) * 0.38),
//                   PrimaryButton(
//                       function: () {
//                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
//                       },
//                       text: 'Continue')
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/src/home/view/screens/home_screen.dart';
import 'package:targafy/src/home/view/screens/widgets/Bottom_navigation_bar.dart';

class RegisterABusinessScreen2 extends StatefulWidget {
  const RegisterABusinessScreen2({super.key});

  @override
  State<RegisterABusinessScreen2> createState() =>
      _RegisterABusinessScreen2State();
}

class _RegisterABusinessScreen2State extends State<RegisterABusinessScreen2> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

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
                    margin: EdgeInsets.symmetric(
                        horizontal: getScreenWidth(context) * 0.04,
                        vertical: getScreenheight(context) * 0.04),
                    alignment: Alignment.centerLeft,
                    child: Image.asset('assets/img/back.png'),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: getScreenheight(context) * 0.01),
                  child: Text('Register a business',
                      style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontSize: getScreenWidth(context) * 0.05,
                          fontWeight: FontWeight.w500,
                          color: secondaryColor)),
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
                        contentPadding: EdgeInsets.only(
                            top: getScreenWidth(context) * 0.0,
                            left: getScreenWidth(context) * 0.02),
                        hintText: 'Enter your email address',
                        hintStyle: TextStyle(
                            color: const Color(0xff787878),
                            fontFamily: 'Sofia Pro',
                            fontSize: getScreenWidth(context) * 0.035),
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
                        labelText: 'Email', // Label added
                        labelStyle:
                            TextStyle(color: primaryColor), // Label text color
                        // suffixIcon: Icon(Icons.email, color: primaryColor), // Icon at the end
                      ),
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.025),
                  // Similar modifications for other text fields
                  // TextField for 'Enter your name'
                  SizedBox(
                    height: getScreenWidth(context) * 0.1,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: getScreenWidth(context) * 0.0,
                            left: getScreenWidth(context) * 0.02),
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                            color: const Color(0xff787878),
                            fontFamily: 'Sofia Pro',
                            fontSize: getScreenWidth(context) * 0.035),
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
                        labelText: 'Name',
                        labelStyle: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.025),
                  // TextField for 'Enter your business name'
                  SizedBox(
                    height: getScreenWidth(context) * 0.1,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: getScreenWidth(context) * 0.0,
                            left: getScreenWidth(context) * 0.02),
                        hintText: 'Enter your business name',
                        hintStyle: TextStyle(
                            color: const Color(0xff787878),
                            fontFamily: 'Sofia Pro',
                            fontSize: getScreenWidth(context) * 0.035),
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
                        labelText: 'Business Name',
                        labelStyle: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.025),
                  // TextField for 'Import your logo'
                  SizedBox(
                    height: getScreenWidth(context) * 0.1,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: getScreenWidth(context) * 0.0,
                                left: getScreenWidth(context) * 0.02),
                            hintText: 'Import your logo',
                            hintStyle: TextStyle(
                                color: const Color(0xff787878),
                                fontFamily: 'Sofia Pro',
                                fontSize: getScreenWidth(context) * 0.035),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2),
                            ),
                            labelText: 'Logo',
                            labelStyle: TextStyle(color: primaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: _getImage,
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(primaryColor),
                              minimumSize: WidgetStateProperty.all<Size>(Size(
                                  getScreenheight(context) * 0.04 * 2,
                                  getScreenheight(
                                      context))), // Adjust size here
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          horizontal:
                                              8)), // Adjust padding here
                            ),
                            child: const Text('Import',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.025),
                  // TextField for 'Enter parameters to monitor'

                  SizedBox(
                    height: getScreenWidth(context) * 0.1,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: getScreenWidth(context) * 0.0,
                            left: getScreenWidth(context) * 0.02),
                        hintText: 'Enter parameters to monitor',
                        hintStyle: TextStyle(
                            color: const Color(0xff787878),
                            fontFamily: 'Sofia Pro',
                            fontSize: getScreenWidth(context) * 0.035),
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
                        labelText: 'Parameters to Monitor',
                        labelStyle: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.38),
                  PrimaryButton(
                      function: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavigationAndAppBar()),
                            (route) => false);
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
