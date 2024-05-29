import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/core/shared/custom_textform_field.dart';
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
    // ref.read(nameControllerProvider.notifier).checkFirstTime();
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

    if (!state.isFirstTime) {
      // Navigate to the next screen if not first time
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        // Navigator.pushReplacementNamed(context, '/nextScreen');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const RegisterABusinessScreen1()));
      });
    }

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             TextFormField(controller: nameController,autofocus: true),
              const SizedBox(height: 20),
              SubmitButton(
                onPressed: () async {
                
                  if (nameController.text.isEmpty ||
                      nameController.text == "Guest") {
                    showSnackBar(context, "Enter Correct Name!!", invalidColor);
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
            ],
          ),
        ),
      ),
    );
  }
}
