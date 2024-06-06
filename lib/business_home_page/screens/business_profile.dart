import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/utils/utils.dart';

class BusinessProfile extends ConsumerStatefulWidget {
  const BusinessProfile({super.key});

  @override
  ConsumerState<BusinessProfile> createState() => _BusinessProfileState();
}

class _BusinessProfileState extends ConsumerState<BusinessProfile> {
  String _name = '';
  String _industryType = '';
  String _city = '';
  String _country = '';
  XFile? profileImage;
  String? imageUrl;
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(businessAndUserProvider);
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final selectedBusiness = selectedBusinessData?['business'] as Business?;
    // final selectedUserType = selectedBusinessData?['userType'] as String?;
    // final selectedBusinessCode = selectedBusinessData?['businessCode'] as String?;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const Text(
          "Business Profile",
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: asyncValue.when(
        data: (data) {
          if (selectedBusiness == null) {
            return const Center(child: Text("No business selected"));
          }
          _name = selectedBusiness.name;
          _industryType = selectedBusiness.industryType;
          _city = selectedBusiness.city;
          _country = selectedBusiness.country;

          return SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Center(
                        child: uploading
                            ? const CircularProgressIndicator()
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: selectedBusiness.logo.isEmpty
                                    ? const AssetImage("assets/images/placeholder.png") as ImageProvider
                                    : NetworkImage(selectedBusiness.logo),
                              ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => _changePicture(selectedBusiness.id),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 216, 196, 180),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Change Picture", style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoTile("Name", _name, Icons.person, context, (val) {
                  setState(() {
                    _name = val;
                  });
                }),
                const SizedBox(height: 10),
                _buildInfoTile("Industry Type", _industryType, Icons.work, context, (val) {
                  setState(() {
                    _industryType = val;
                  });
                }),
                const SizedBox(height: 10),
                _buildInfoTile("City", _city, Icons.location_city, context, (val) {
                  setState(() {
                    _city = val;
                  });
                }),
                const SizedBox(height: 10),
                _buildInfoTile("Country", _country, Icons.location_on_sharp, context, (val) {
                  setState(() {
                    _country = val;
                  });
                }),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon, BuildContext context, ValueChanged<String> onChanged) {
    return ListTile(
      leading: Icon(icon),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          // Logic to handle edit action
        },
      ),
      tileColor: const Color(0xffF3EEEA),
    );
  }

  Future<void> _changePicture(String businessId) async {
    final imagePicker = ImagePicker();
    profileImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (profileImage != null) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Upload'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(File(profileImage!.path), width: 200, height: 200, fit: BoxFit.cover),
              const SizedBox(height: 10),
              const Text('Do you want to upload this image?'),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Upload')),
          ],
        ),
      );

      if (confirmed == true) {
        setState(() {
          uploading = true;
        });
        // imageUrl = await uploadFileAndFolder(File(profileImage!.path), "bprofile");

        if (imageUrl == null || imageUrl!.isEmpty) {
          showSnackBar(context, "Image upload failed", Colors.red);
        } else {
          // Assuming a method to update the business logo in the backend
          bool isUploaded = await updateBusinessLogo(businessId, imageUrl!);
          if (isUploaded) {
            showSnackBar(context, "Logo updated successfully", Colors.green);
          }
        }
        setState(() {
          uploading = false;
        });
      }
    }
  }

  Future<bool> updateBusinessLogo(String businessId, String newLogoUrl) async {
    // Implement your API call to update the business logo here
    // Return true if the update was successful, otherwise false
    return true;
  }
}
