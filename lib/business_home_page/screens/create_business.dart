import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:targafy/business_home_page/controller/create_business_controller.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/submit_button.dart';

final createBusinessControllerProvider =
    Provider((ref) => CreateBusinessController());

class CreateBusinessPage extends ConsumerStatefulWidget {
  const CreateBusinessPage({Key? key}) : super(key: key);

  @override
  _CreateBusinessPageState createState() => _CreateBusinessPageState();
}

class _CreateBusinessPageState extends ConsumerState<CreateBusinessPage> {
  final nameController = TextEditingController();
  final industryTypeController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  String? _selectedImagePath;

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

  @override
  Widget build(BuildContext context) {
    final createBusinessController =
        ref.watch(createBusinessControllerProvider);

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
                onChanged: (p0) => {},
                labelText: "Country",
              ),
              SizedBox(height: height * 0.02),
              SubmitButton(
                onPressed: () {
                  createBusinessController.createBusiness(
                    buisnessName: nameController.text,
                    logo: _selectedImagePath ??
                        '', // Pass the logo URL here if you have it
                    industryType: industryTypeController.text,
                    city: cityController.text,
                    country: countryController.text,
                    parameters: "Sales, Revenue, Items Sold, Margins",
                  );
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Submitted Successfully')),
                    );
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
