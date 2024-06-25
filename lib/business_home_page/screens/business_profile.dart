// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/src/groups/ui/controller/create_subgroup_controller.dart';
import 'package:targafy/utils/utils.dart';

class BusinessProfile extends ConsumerStatefulWidget {
  final String? token;
  const BusinessProfile({
    this.token,
  });

  @override
  ConsumerState<BusinessProfile> createState() => _BusinessProfileState();
}

class _BusinessProfileState extends ConsumerState<BusinessProfile> {
  String _name = '';
  String _industryType = '';
  String _city = '';
  String _country = '';
  String _imageUrl = '';

  XFile? profileImage;
  String? imageUrl;
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    _fetchBusinessLogo();
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(businessAndUserProvider(widget.token!));
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
                                // backgroundImage: selectedBusiness.logo.isEmpty
                                //     ? const AssetImage(
                                //             "assets/images/placeholder.png")
                                //         as ImageProvider
                                //     : NetworkImage(_imageUrl),
                                backgroundImage: profileImage != null
                                    ? FileImage(File(profileImage!.path))
                                    : (_imageUrl.isEmpty
                                        ? const AssetImage(
                                            "assets/img/targafy.png")
                                        : CachedNetworkImageProvider(
                                            _imageUrl)) as ImageProvider,
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
                            child: Text("Change Picture",
                                style: TextStyle(fontSize: 16)),
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
                _buildInfoTile(
                    "Industry Type", _industryType, Icons.work, context, (val) {
                  setState(() {
                    _industryType = val;
                  });
                }),
                const SizedBox(height: 10),
                _buildInfoTile("City", _city, Icons.location_city, context,
                    (val) {
                  setState(() {
                    _city = val;
                  });
                }),
                const SizedBox(height: 10),
                _buildInfoTile(
                    "Country", _country, Icons.location_on_sharp, context,
                    (val) {
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

  Widget _buildInfoTile(String label, String value, IconData icon,
      BuildContext context, ValueChanged<String> onChanged) {
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

  Future<void> _fetchBusinessLogo() async {
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final selectedBusiness = selectedBusinessData?['business'] as Business?;
    if (selectedBusiness != null) {
      try {
        final logoUrl = await ref
            .read(BusinessLogoControllerProvider)
            .fetchBusinessLogo(selectedBusiness.id);
        setState(() {
          _imageUrl = logoUrl;
        });
      } catch (e) {
        showSnackBar(context, "Failed to fetch business logo", Colors.red);
      }
    }
  }

  Future<void> _changePicture(String businessId) async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Upload'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(File(pickedFile.path),
                  width: 200, height: 200, fit: BoxFit.cover),
              const SizedBox(height: 10),
              const Text('Do you want to upload this image?'),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Upload')),
          ],
        ),
      );

      if (confirmed == true) {
        setState(() {
          uploading = true;
        });
        try {
          final logoUrl = await ref
              .read(BusinessLogoControllerProvider)
              .uploadLogo(File(pickedFile.path));

          await ref
              .read(BusinessLogoControllerProvider)
              .updateBusinessLogo(businessId, logoUrl);

          setState(() {
            _imageUrl = logoUrl;
          });
          print('this is image URL :- $_imageUrl');
          showSnackBar(context, "Logo updated successfully", Colors.green);
        } catch (e) {
          showSnackBar(context, "Image upload failed", Colors.red);
        } finally {
          setState(() {
            uploading = false;
          });
        }
      }
    }
  }
}
