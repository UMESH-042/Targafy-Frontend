import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/src/home/view/screens/controller/mandatory_Filed_name_controller.dart';
import 'package:targafy/src/registration/view/screens/register_a_business_screen1.dart';
import 'package:targafy/utils/colors.dart';
import 'package:targafy/utils/utils.dart';
import 'package:targafy/widgets/submit_button.dart';

class MandatoryFieldPage extends ConsumerStatefulWidget {
  const MandatoryFieldPage({super.key});

  @override
  ConsumerState<MandatoryFieldPage> createState() => _MandatoryFieldPageState();
}

class _MandatoryFieldPageState extends ConsumerState<MandatoryFieldPage> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final state = ref.watch(nameControllerProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * .19),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.03, horizontal: width * .04),
          child: const Row(
            children: [
              SizedBox(width: 10),
              Text(
                "Mandatory Field",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 22), // Increased font size
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Enter your name',
                      labelStyle: TextStyle(color: primaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SubmitButton(
                    onPressed: () async {
                      if (nameController.text.isEmpty ||
                          nameController.text == "Guest") {
                        showSnackBar(
                            context, "Enter Correct Name!!", invalidColor);
                        return;
                      }

                      try {
                        await ref
                            .read(nameControllerProvider.notifier)
                            .updateName(nameController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegisterABusinessScreen1()));
                      } catch (e) {
                        showSnackBar(
                            context, "Failed to update name", invalidColor);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
