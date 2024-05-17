import 'package:image_picker/image_picker.dart';

import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/submit_button.dart';
import 'package:flutter/material.dart';

class CreateBusinessPage extends StatefulWidget {
  const CreateBusinessPage({super.key});

  @override
  _CreateBusinessPageState createState() => _CreateBusinessPageState();
}

class _CreateBusinessPageState extends State<CreateBusinessPage> {
  XFile? profileImage;
  String? imageUrl;

  // Future<void> changePicture(
  //     ImageSource src, CreateBusinessProvider controller) async {
  //   profileImage = await captureImage(src);
  //   debugPrint("reaching here");
  //   if (profileImage != null) {
  //     imageUrl = await uploadFileToStorage("business_logo", profileImage);
  //     if (imageUrl == null || imageUrl!.isEmpty) {
  //       showSnackBar(context, "Image upload failed", Colors.red);
  //     } else {
  //       debugPrint("image url$imageUrl");
  //       controller.updateBusinessLogo(imageUrl ?? "");
  //       setState(() {});
  //     }
  //   }
  // }

  // Future<void> showDialogBox(CreateBusinessProvider controller) async {
  //   AwesomeDialog(
  //     context: context,
  //     dialogType: DialogType.info,
  //     animType: AnimType.rightSlide,
  //     title: 'choose to pick image',
  //     desc: 'how you want to pick image!',
  //     btnOkText: "Gallery",
  //     btnCancelText: "Camera",
  //     btnCancelOnPress: () => changePicture(ImageSource.camera, controller),
  //     btnOkOnPress: () => changePicture(ImageSource.gallery, controller),
  //   ).show();
  // }

  @override
  Widget build(BuildContext context) {
    // final homeController = Provider.of<HomeProvider>(context, listen: false);
    final nameController = TextEditingController();
    final industryTypeController = TextEditingController();
    final cityController = TextEditingController();
    final countryController = TextEditingController();

    // final createBusinessController =
    // Provider.of<CreateBusinessProvider>(context, listen: false);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * .19),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.02, horizontal: width * .04),
          child: const Row(
            children: [
              CustomBackButton(),
              SizedBox(width: 20),
              Text(
                "Create Business",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
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
                  backgroundImage: NetworkImage(imageUrl != null
                      ? imageUrl!
                      : "https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  // await showDialogBox(createBusinessController);
                },
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
              CustomTextField(
                controller: nameController,
                onChanged: (p0) => {},
                labelText: "Name*",
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                controller: industryTypeController,
                onChanged: (p0) => {},
                labelText: "Industry type",
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                controller: cityController,
                onChanged: (p0) => {},
                labelText: "City",
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                controller: countryController,
                onChanged: (p0) =>{},
                labelText: "Country",
              ),
              SizedBox(height: height * 0.02),
              SubmitButton(
                onPressed: () {
                  // createBusinessController
                  //     .updateAdminUserName(homeController.userModel!.name);
                  // createBusinessController.createBusiness(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
