// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/business_home_page/controller/create_business_controller.dart';
// import 'package:targafy/core/shared/components/back_button.dart';
// import 'package:targafy/widgets/custom_text_field.dart';
// import 'package:targafy/widgets/submit_button.dart';

// import '../../core/shared/custom_text_field.dart';
// import '../../widgets/custom_back_button.dart';

// final createBusinessControllerProvider =
//     Provider((ref) => CreateBusinessController());

// class CreateBusinessPage extends ConsumerStatefulWidget {
//   final String? token;
//   const CreateBusinessPage({
//     this.token,
//   });

//   @override
//   _CreateBusinessPageState createState() => _CreateBusinessPageState();
// }

// class _CreateBusinessPageState extends ConsumerState<CreateBusinessPage> {
//   final nameController = TextEditingController();
//   final industryTypeController = TextEditingController();
//   final cityController = TextEditingController();
//   final countryController = TextEditingController();
//   String? _selectedImagePath;
//   bool _uploading = false;

//   @override
//   void dispose() {
//     nameController.dispose();
//     industryTypeController.dispose();
//     cityController.dispose();
//     countryController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImagePath = pickedFile.path;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final createBusinessController =
//         ref.watch(createBusinessControllerProvider);

//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(height * .1),
//         child: const Row(
//           children: [
//             const CustomBackButton(
//               text: 'Create Business',
//             ),
//             // CustomBackButton(),
//             // SizedBox(width: 20),
//             // Text(
//             //   "Create Business",
//             //   style: TextStyle(
//             //       color: Colors.black,
//             //       fontFamily: "Poppins",
//             //       fontWeight: FontWeight.bold,
//             //       fontSize: 18),
//             // ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 15, right: 15),
//           child: Column(
//             children: [
//               Center(
//                 child: CircleAvatar(
//                   radius: width * 0.2,
//                   backgroundImage: _selectedImagePath != null
//                       ? FileImage(File(_selectedImagePath!))
//                       : const NetworkImage(
//                               'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80')
//                           as ImageProvider,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 216, 196, 180),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       "Change Picture",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: height * 0.05),
//               CustomInputField(
//                 controller: nameController,
//                 labelText: "Name",
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter Name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: height * 0.02),
//               CustomInputField(
//                 controller: industryTypeController,
//                 labelText: "Industry type",
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter Industry Type';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: height * 0.02),
//               CustomInputField(
//                 controller: cityController,
//                 labelText: "City",
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter City';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: height * 0.02),
//               CustomInputField(
//                 controller: countryController,
//                 labelText: "Country",
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter Country';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: height * 0.05),
//               SubmitButton(
//                 onPressed: () async {
//                   if (_selectedImagePath == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Please select an image')),
//                     );
//                     return;
//                   }

//                   setState(() {
//                     _uploading = true;
//                   });

//                   try {
//                     final logoUrl = await createBusinessController
//                         .uploadLogo(File(_selectedImagePath!));
//                     await createBusinessController.createBusiness(
//                       buisnessName: nameController.text,
//                       logo: logoUrl,
//                       industryType: industryTypeController.text,
//                       city: cityController.text,
//                       country: countryController.text,
//                       onCompletion: (bool isSuccess) {
//                         if (isSuccess) {
//                           ref.refresh(businessAndUserProvider(widget
//                               .token!)); // Example of refreshing data using Riverpod
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text('Business created successfully')),
//                           );
//                           Navigator.pop(context);
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text('Failed to create business')),
//                           );
//                         }
//                       },
//                     );
//                   } catch (e) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Error: $e')),
//                     );
//                   } finally {
//                     setState(() {
//                       _uploading = false;
//                     });
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/controller/create_business_controller.dart';
import 'package:targafy/core/shared/components/back_button.dart';
import 'package:targafy/widgets/custom_text_field.dart';
import 'package:targafy/widgets/submit_button.dart';

import '../../core/shared/custom_text_field.dart';
import '../../widgets/custom_back_button.dart';

final createBusinessControllerProvider =
    Provider((ref) => CreateBusinessController());

class CreateBusinessPage extends ConsumerStatefulWidget {
  final String? token;
  const CreateBusinessPage({
    this.token,
  });

  @override
  _CreateBusinessPageState createState() => _CreateBusinessPageState();
}

class _CreateBusinessPageState extends ConsumerState<CreateBusinessPage> {
  final nameController = TextEditingController();
  final industryTypeController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  String? _selectedImagePath;
  bool _uploading = false;

  @override
  void dispose() {
    nameController.dispose();
    industryTypeController.dispose();
    cityController.dispose();
    countryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
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

  File compressedFile = File(imageFile.path)..writeAsBytesSync(compressedBytes);

  return compressedFile;
}


  @override
  Widget build(BuildContext context) {
    final createBusinessController =
        ref.watch(createBusinessControllerProvider);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * .1),
        child: const Row(
          children: [
            CustomBackButton(
              text: 'Create Business',
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: width * 0.2,
                  backgroundImage: _selectedImagePath != null
                      ? FileImage(File(_selectedImagePath!))
                      : const NetworkImage(
                              'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80')
                          as ImageProvider,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 216, 196, 180),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Change Picture",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
              CustomInputField(
                controller: nameController,
                labelText: "Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: height * 0.02),
              CustomInputField(
                controller: industryTypeController,
                labelText: "Industry type",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Industry Type';
                  }
                  return null;
                },
              ),
              SizedBox(height: height * 0.02),
              CustomInputField(
                controller: cityController,
                labelText: "City",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter City';
                  }
                  return null;
                },
              ),
              SizedBox(height: height * 0.02),
              CustomInputField(
                controller: countryController,
                labelText: "Country",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Country';
                  }
                  return null;
                },
              ),
              SizedBox(height: height * 0.05),
              SubmitButton(
                onPressed: () async {
                  setState(() {
                    _uploading = true;
                  });

                  try {
                    String logoUrl = "";
                    if (_selectedImagePath != null) {
                      logoUrl = await createBusinessController
                          .uploadLogo(File(_selectedImagePath!));
                    }

                    await createBusinessController.createBusiness(
                      buisnessName: nameController.text,
                      logo: logoUrl,
                      industryType: industryTypeController.text,
                      city: cityController.text,
                      country: countryController.text,
                      onCompletion: (bool isSuccess) {
                        if (isSuccess) {
                          ref.refresh(businessAndUserProvider(widget
                              .token!)); // Example of refreshing data using Riverpod
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Business created successfully')),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Failed to create business')),
                          );
                        }
                      },
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  } finally {
                    setState(() {
                      _uploading = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
