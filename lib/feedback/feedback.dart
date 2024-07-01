// feedback_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:remixicon/remixicon.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart'; // Adjust imports as per your project structure
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart'; // Adjust imports as per your project structure
import 'package:targafy/core/constants/colors.dart'; // Adjust imports as per your project structure
import 'package:targafy/feedback/controller/feedback_list_controller.dart';
import 'package:targafy/src/users/ui/controller/business_users_controller.dart'; // Adjust imports as per your project structure
import 'package:targafy/widgets/rate_user_dialog.dart'; // Adjust imports as per your project structure
import 'package:targafy/widgets/rating_list_display.dart';
import 'package:targafy/widgets/sort_dropdown_list.dart'; // Adjust imports as per your project structure

class FeedbackScreen extends ConsumerStatefulWidget {
  final String? token;
  const FeedbackScreen({this.token});
  @override
  ConsumerState<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
  String? selectedUserListItem;
  String? selectedUserName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final selectedBusiness = selectedBusinessData?['business'] as Business?;
    final businessId = selectedBusiness?.id;

    final asyncValue = ref.watch(businessAndUserProvider(widget.token!));

    // Extracting userName from asyncValue
    final User user = asyncValue.asData!.value?['user'] as User;
    final username = user.name;

    print(username);

    final usersStream =
        ref.watch(businessUsersStreamProvider(businessId ?? ''));

    final feedbackStream =
        ref.watch(feedbackProvider); // Listen to feedback provider

    return Scaffold(
      body: businessId == null
          ? Center(
              child: Text(
                'Please select a business',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            )
          : usersStream.when(
              data: (usersList) {
                final sortedUsers = sortList(usersList, (user) => user.name);

                return Column(
                  children: [
                    const Gap(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              style: BorderStyle.solid,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: sortedUsers.isEmpty
                              ? const Center(
                                  child: Text("No users available"),
                                )
                              : DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: selectedUserListItem == null
                                        ? const Text(
                                            "  Select user to give feedback",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )
                                        : null,
                                    icon: const Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    elevation: 4,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    value: selectedUserListItem,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedUserListItem = newValue;
                                        selectedUserName = sortedUsers
                                            .firstWhere((user) =>
                                                user.userId == newValue)
                                            .name;
                                      });
                                    },
                                    items: sortedUsers
                                        .map<DropdownMenuItem<String>>((user) {
                                      return DropdownMenuItem<String>(
                                        value: user.userId,
                                        child: Text("  ${user.name}"),
                                      );
                                    }).toList(),
                                  ),
                                ),
                        ),
                        const Gap(5),
                        GestureDetector(
                          onTap: () {
                            if (selectedUserListItem == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Please select user to give feedback"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            showDialog(
                              context: context,
                              builder: (context) {
                                return RateUserDialog(
                                  userId: selectedUserListItem!,
                                  userName: username ?? '',
                                  businessId:
                                      businessId, // Dummy ID for UI purpose
                                  rateUserCallback: (success) {
                                    if (success) {
                                      setState(() {
                                        selectedUserListItem = null;
                                        selectedUserName = null;
                                      });
                                    }
                                  },
                                );
                              },
                            );
                          },
                          child: Icon(
                            Remix.arrow_right_circle_fill,
                            color: selectedUserListItem == null
                                ? Colors.grey.shade400
                                : primaryColor,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: feedbackStream.when(
                        data: (feedbackList) {
                          if (feedbackList.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Lottie.asset(
                                    'assets/animations/empty_list.json',
                                    height: 200,
                                    width: 200,
                                  ),
                                  Text(
                                    "No feedback is found!",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: feedbackList.length,
                              itemBuilder: (context, index) {
                                final feedback = feedbackList[index];
                                // return ListTile(
                                //   title: Text(feedback.message),
                                //   subtitle: Text(
                                //       'Rating: ${feedback.rating}, By: ${feedback.givenBy.name}'),
                                //   trailing: Text(
                                //     feedback.createdDate.toString(),
                                //     style: TextStyle(
                                //       fontSize: 12,
                                //       color: Colors.grey,
                                //     ),
                                //   ),
                                // );

                                return RatingListTile(
                                  feedback: feedback,
                                  isFeedback:
                                      true, // Assuming this is for feedback display
                                );
                              },
                            );
                          }
                        },
                        loading: () => Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, stackTrace) => Center(
                          child: Text('Error: $error'),
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Error: $error')),
            ),
    );
  }
}
