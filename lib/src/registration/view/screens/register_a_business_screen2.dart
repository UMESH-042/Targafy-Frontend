// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/business_home_page/controller/create_business_controller.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/core/shared/components/primary_button.dart';
// import 'package:targafy/src/home/view/screens/widgets/Bottom_navigation_bar.dart';
// import 'package:targafy/utils/remote_routes.dart';

// String domain = AppRemoteRoutes.baseUrl;

// class RegisterABusinessScreen2 extends StatefulWidget {
//   const RegisterABusinessScreen2({super.key});

//   @override
//   State<RegisterABusinessScreen2> createState() =>
//       _RegisterABusinessScreen2State();
// }

// class _RegisterABusinessScreen2State extends State<RegisterABusinessScreen2> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _image;
//   String? _imageName;

//   final TextEditingController _businessNameController = TextEditingController();
//   final TextEditingController _industryTypeController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _countryController = TextEditingController();

//   final CreateBusinessController _createBusinessController =
//       CreateBusinessController();

//   Future<void> _getImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = pickedFile;
//       if (_image != null) {
//         String fileName = _image!.name;
//         _imageName =
//             fileName.length > 10 ? '${fileName.substring(0, 20)}...' : fileName;
//       }
//     });
//   }

//   Future<void> _createBusiness() async {
//     if (_image == null) {
//       // Show error if no image selected
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a logo')),
//       );
//       return;
//     }

//     // Show loading dialog
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircularProgressIndicator(),
//                 SizedBox(width: 20),
//                 Text("Creating Business..."),
//               ],
//             ),
//           ),
//         );
//       },
//     );

//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? bearerToken = prefs.getString('authToken');
//       final logoUrl =
//           await _createBusinessController.uploadLogo(File(_image!.path));
//       _createBusinessController.createBusiness(
//         buisnessName: _businessNameController.text,
//         logo: logoUrl,
//         industryType: _industryTypeController.text,
//         city: _cityController.text,
//         country: _countryController.text,
//         onCompletion: (isSuccess) {
//           Navigator.of(context).pop(); // Dismiss the loading dialog

//           if (isSuccess) {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BottomNavigationAndAppBar(
//                   token: bearerToken,
//                 ),
//               ),
//               (route) => false,
//             );
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Failed to create business')),
//             );
//           }
//         },
//       );
//     } catch (e) {
//       Navigator.of(context).pop(); // Dismiss the loading dialog

//       print('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

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
//                     margin: EdgeInsets.symmetric(
//                         horizontal: getScreenWidth(context) * 0.04,
//                         vertical: getScreenheight(context) * 0.04),
//                     alignment: Alignment.centerLeft,
//                     child: Image.asset('assets/img/back.png'),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.only(top: getScreenheight(context) * 0.01),
//                   child: Text('Register a business',
//                       style: TextStyle(
//                           fontFamily: 'Sofia Pro',
//                           fontSize: getScreenWidth(context) * 0.05,
//                           fontWeight: FontWeight.w500,
//                           color: secondaryColor)),
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
//                       textCapitalization: TextCapitalization.sentences,
//                       controller: _businessNameController,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.only(
//                             top: getScreenWidth(context) * 0.0,
//                             left: getScreenWidth(context) * 0.02),
//                         hintText: 'Enter your business name',
//                         hintStyle: TextStyle(
//                             color: const Color(0xff787878),
//                             fontFamily: 'Sofia Pro',
//                             fontSize: getScreenWidth(context) * 0.035),
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
//                         labelText: 'Business Name',
//                         labelStyle: TextStyle(color: primaryColor),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: getScreenheight(context) * 0.025),
//                   // TextField for 'Enter Industry type'
//                   SizedBox(
//                     height: getScreenWidth(context) * 0.1,
//                     child: TextField(
//                       textCapitalization: TextCapitalization.sentences,
//                       controller: _industryTypeController,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.only(
//                             top: getScreenWidth(context) * 0.0,
//                             left: getScreenWidth(context) * 0.02),
//                         hintText: 'Enter Industry type',
//                         hintStyle: TextStyle(
//                             color: const Color(0xff787878),
//                             fontFamily: 'Sofia Pro',
//                             fontSize: getScreenWidth(context) * 0.035),
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
//                         labelText: 'Industry Type',
//                         labelStyle: TextStyle(color: primaryColor),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: getScreenheight(context) * 0.025),
//                   // TextField for 'Enter your city'
//                   SizedBox(
//                     height: getScreenWidth(context) * 0.1,
//                     child: TextField(
//                       textCapitalization: TextCapitalization.sentences,
//                       controller: _cityController,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.only(
//                             top: getScreenWidth(context) * 0.0,
//                             left: getScreenWidth(context) * 0.02),
//                         hintText: 'Enter your city',
//                         hintStyle: TextStyle(
//                             color: const Color(0xff787878),
//                             fontFamily: 'Sofia Pro',
//                             fontSize: getScreenWidth(context) * 0.035),
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
//                         labelText: 'City',
//                         labelStyle: TextStyle(color: primaryColor),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: getScreenheight(context) * 0.025),
//                   // TextField for 'Import your logo'
//                   SizedBox(
//                     height: getScreenWidth(context) * 0.1,
//                     child: Stack(
//                       alignment: Alignment.topRight,
//                       children: [
//                         TextField(
//                           textCapitalization: TextCapitalization.sentences,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.only(
//                                 top: getScreenWidth(context) * 0.0,
//                                 left: getScreenWidth(context) * 0.02),
//                             hintText: _imageName ?? 'Import your logo',
//                             hintStyle: TextStyle(
//                                 color: const Color(0xff787878),
//                                 fontFamily: 'Sofia Pro',
//                                 fontSize: getScreenWidth(context) * 0.035),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide:
//                                   BorderSide(color: primaryColor, width: 2),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide:
//                                   BorderSide(color: primaryColor, width: 2),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide:
//                                   BorderSide(color: primaryColor, width: 2),
//                             ),
//                             labelText: 'Logo',
//                             labelStyle: TextStyle(color: primaryColor),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ElevatedButton(
//                             onPressed: _getImage,
//                             style: ButtonStyle(
//                               backgroundColor:
//                                   WidgetStateProperty.all<Color>(primaryColor),
//                               minimumSize: WidgetStateProperty.all<Size>(Size(
//                                   getScreenheight(context) * 0.04 * 2,
//                                   getScreenheight(
//                                       context))), // Adjust size here
//                               padding:
//                                   WidgetStateProperty.all<EdgeInsetsGeometry>(
//                                       const EdgeInsets.symmetric(
//                                           horizontal:
//                                               8)), // Adjust padding here
//                             ),
//                             child: const Text('Import',
//                                 style: TextStyle(color: Colors.white)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: getScreenheight(context) * 0.025),
//                   // TextField for 'Enter parameters to monitor'
//                   SizedBox(
//                     height: getScreenWidth(context) * 0.1,
//                     child: TextField(
//                       textCapitalization: TextCapitalization.sentences,
//                       controller: _countryController,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.only(
//                             top: getScreenWidth(context) * 0.0,
//                             left: getScreenWidth(context) * 0.02),
//                         hintText: 'Enter your Country',
//                         hintStyle: TextStyle(
//                             color: const Color(0xff787878),
//                             fontFamily: 'Sofia Pro',
//                             fontSize: getScreenWidth(context) * 0.035),
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
//                         labelText: 'Country',
//                         labelStyle: TextStyle(color: primaryColor),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: getScreenheight(context) * 0.38),
//                   PrimaryButton(function: _createBusiness, text: 'Continue')
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/create_business_controller.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/shared/components/primary_button.dart';
import 'package:targafy/src/home/view/screens/widgets/Bottom_navigation_bar.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

class RegisterABusinessScreen2 extends StatefulWidget {
  const RegisterABusinessScreen2({super.key});

  @override
  State<RegisterABusinessScreen2> createState() =>
      _RegisterABusinessScreen2State();
}

class _RegisterABusinessScreen2State extends State<RegisterABusinessScreen2> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _imageName;

  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _industryTypeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final CreateBusinessController _createBusinessController =
      CreateBusinessController();

  // Future<void> _getImage() async {
  //   final XFile? pickedFile =
  //       await _picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = pickedFile;
  //     if (_image != null) {
  //       String fileName = _image!.name;
  //       _imageName =
  //           fileName.length > 10 ? '${fileName.substring(0, 20)}...' : fileName;
  //     }
  //   });
  // }
  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File compressedFile = await compressImage(File(pickedFile.path));
      setState(() {
        _image = XFile(compressedFile.path);
        String fileName = _image!.name;
        _imageName =
            fileName.length > 10 ? '${fileName.substring(0, 10)}...' : fileName;
      });
    }
  }

  Future<File> compressImage(File imageFile) async {
    // Define the target file size in bytes (100 KB in this example)
    int targetSize = 100 * 1024;

    Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
      imageFile.path,
      minWidth: 800,
      minHeight: 600,
      quality: 85,
    );

    if (compressedBytes!.lengthInBytes > targetSize) {
      compressedBytes = await FlutterImageCompress.compressWithList(
        compressedBytes,
        minWidth: 800,
        minHeight: 600,
        quality: 70,
      );
    }

    File compressedFile = File(imageFile.path)
      ..writeAsBytesSync(compressedBytes);

    return compressedFile;
  }

  Future<void> _createBusiness() async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Creating Business..."),
              ],
            ),
          ),
        );
      },
    );

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? bearerToken = prefs.getString('authToken');
      String logoUrl = '';

      if (_image != null) {
        logoUrl =
            await _createBusinessController.uploadLogo(File(_image!.path));
      }

      _createBusinessController.createBusiness(
        buisnessName: _businessNameController.text,
        logo: logoUrl,
        industryType: _industryTypeController.text,
        city: _cityController.text,
        country: _countryController.text,
        onCompletion: (isSuccess) {
          Navigator.of(context).pop(); // Dismiss the loading dialog

          if (isSuccess) {
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to create business')),
            );
          }
        },
      );
    } catch (e) {
      Navigator.of(context).pop(); // Dismiss the loading dialog

      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
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
                      textCapitalization: TextCapitalization.sentences,
                      controller: _businessNameController,
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
                  // TextField for 'Enter Industry type'
                  SizedBox(
                    height: getScreenWidth(context) * 0.1,
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _industryTypeController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: getScreenWidth(context) * 0.0,
                            left: getScreenWidth(context) * 0.02),
                        hintText: 'Enter Industry type',
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
                        labelText: 'Industry Type',
                        labelStyle: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.025),
                  // TextField for 'Enter your city'
                  SizedBox(
                    height: getScreenWidth(context) * 0.1,
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _cityController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: getScreenWidth(context) * 0.0,
                            left: getScreenWidth(context) * 0.02),
                        hintText: 'Enter your city',
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
                        labelText: 'City',
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
                          textCapitalization: TextCapitalization.sentences,
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
                            labelText: 'Import your logo',
                            labelStyle: TextStyle(color: primaryColor),
                          ),
                          enabled: false,
                          controller: TextEditingController(text: _imageName),
                        ),
                        Positioned(
                          right: getScreenWidth(context) * 0.01,
                          top: getScreenWidth(context) * 0.015,
                          child: IconButton(
                            icon: Icon(
                              Icons.upload_rounded,
                              color: primaryColor,
                            ),
                            onPressed: _getImage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.025),
                  // TextField for 'Enter your country'
                  SizedBox(
                    height: getScreenWidth(context) * 0.1,
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _countryController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: getScreenWidth(context) * 0.0,
                            left: getScreenWidth(context) * 0.02),
                        hintText: 'Enter your country',
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
                        labelText: 'Country',
                        labelStyle: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: getScreenheight(context) * 0.025),
                  // Register Button
                  SizedBox(height: getScreenheight(context) * 0.38),
                  PrimaryButton(function: _createBusiness, text: 'Continue')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
