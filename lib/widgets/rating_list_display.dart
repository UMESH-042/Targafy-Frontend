// String domain = AppRemoteRoutes.baseUrl;

// final userProvider = FutureProvider.autoDispose
//     .family<UserProfileBusinessModel, String>((ref, userId) async {
//   final selectedBusinessData = ref.watch(currentBusinessProvider);
//   final selectedBusiness = selectedBusinessData?['business'] as Business?;
//   final businessId = selectedBusiness?.id;
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('authToken');
//   final url = '${domain}business/user/$businessId/$userId';

//   final response = await http.get(
//     Uri.parse(url),
//     headers: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     },
//   );

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> responseData = json.decode(response.body);
//     final userData = responseData['data']['user'];
//     return UserProfileBusinessModel.fromJson(userData);
//   } else {
//     throw Exception('Failed to load user details');
//   }
// });

// class RatingListTile extends ConsumerStatefulWidget {
//   final bool isFeedback;
//   final FeedbackModel feedback;

//   const RatingListTile({
//     Key? key,
//     required this.feedback,
//     this.isFeedback = false,
//   }) : super(key: key);

//   @override
//   ConsumerState<RatingListTile> createState() => _RatingListTileState();
// }

// class _RatingListTileState extends ConsumerState<RatingListTile> {
//   @override
//   Widget build(BuildContext context) {
//     final userAsyncValue = ref.watch(userProvider(widget.feedback.userId));

//     String formattedDate =
//         "${widget.feedback.createdDate.day}/${widget.feedback.createdDate.month}/${widget.feedback.createdDate.year}";

//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.grey[200], // Background color
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           userAsyncValue.when(
//             data: (user) => Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     InkWell(
//                       onTap: (widget.isFeedback &&
//                               widget.feedback.givenBy.name.isNotEmpty)
//                           ? () {
//                               // Navigator.of(context).push(
//                               //   MaterialPageRoute(
//                               //     builder: (context) => UserProfilePage(
//                               //       userId: feedback.userId,
//                               //       businessId: feedback.businessId,
//                               //     ),
//                               //   ),
//                               // );
//                             }
//                           : () {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text("No Feedback Found"),
//                                   backgroundColor: lightblue,
//                                 ),
//                               );
//                             },
//                       child: (widget.isFeedback &&
//                               widget.feedback.givenTo.isNotEmpty)
//                           ? Text(
//                               "${widget.feedback.givenTo} (${user.totalRating.toStringAsFixed(2)} ⭐️)",
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: kprimaryColor,
//                                   fontSize: 18),
//                             )
//                           : Text(
//                               "Rating: ${widget.feedback.rating}",
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                     ),
//                     Container(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         formattedDate,
//                         style: const TextStyle(fontSize: 12),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const PlainText(
//                       name: "Given By: ",
//                       fontWeight: FontWeight.w500,
//                       color: kprimaryColor,
//                     ),
//                     PlainText(name: widget.feedback.givenBy.name, fontsize: 14),
//                   ],
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: PlainText(
//                         name: "Feedback - ${widget.feedback.message}",
//                         fontsize: 14,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 24),
//                       child: Text("${widget.feedback.rating} ⭐️",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 22,
//                           )),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//             loading: () => const Center(child: CircularProgressIndicator()),
//             error: (error, stackTrace) => Center(child: Text('Error: $error')),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/business_home_page/models/fetch_business_data_mode.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/feedback/model/feedback_model.dart';
import 'package:targafy/utils/colors.dart';
import 'package:targafy/widgets/plain_text.dart';
import 'package:targafy/src/users/ui/model/user_Business_Profile_model.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/utils/remote_routes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final userStreamProvider = StreamProvider.autoDispose
    .family<UserProfileBusinessModel, String>((ref, userId) {
  final selectedBusinessData = ref.watch(currentBusinessProvider);
  final selectedBusiness = selectedBusinessData?['business'] as Business?;
  final businessId = selectedBusiness?.id;

  // Create a Stream that periodically fetches user data
  return Stream.periodic(Duration(seconds: 0), (_) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final url = '${domain}business/user/$businessId/$userId';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final userData = responseData['data']['user'];
      return UserProfileBusinessModel.fromJson(userData);
    } else {
      throw Exception('Failed to load user details');
    }
  }).asyncMap((event) async => await event); // Convert periodic to async
});

class RatingListTile extends ConsumerStatefulWidget {
  final bool isFeedback;
  final FeedbackModel feedback;

  const RatingListTile({
    Key? key,
    required this.feedback,
    this.isFeedback = false,
  }) : super(key: key);

  @override
  ConsumerState<RatingListTile> createState() => _RatingListTileState();
}

class _RatingListTileState extends ConsumerState<RatingListTile> {
  @override
  Widget build(BuildContext context) {
    final userStreamAsyncValue =
        ref.watch(userStreamProvider(widget.feedback.userId));

    String formattedDate =
        "${widget.feedback.createdDate.day}/${widget.feedback.createdDate.month}/${widget.feedback.createdDate.year}";

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200], // Background color
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userStreamAsyncValue.when(
            data: (user) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (widget.isFeedback &&
                              widget.feedback.givenBy.name.isNotEmpty)
                          ? () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => UserProfilePage(
                              //       userId: feedback.userId,
                              //       businessId: feedback.businessId,
                              //     ),
                              //   ),
                              // );
                            }
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("No Feedback Found"),
                                  backgroundColor: lightblue,
                                ),
                              );
                            },
                      child: (widget.isFeedback &&
                              widget.feedback.givenTo.isNotEmpty)
                          ? Text(
                              "${widget.feedback.givenTo} (${user.totalRating.toStringAsFixed(2)} ⭐️)",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kprimaryColor,
                                  fontSize: 18),
                            )
                          : Text(
                              "Rating: ${widget.feedback.rating}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const PlainText(
                      name: "Given By: ",
                      fontWeight: FontWeight.w500,
                      color: kprimaryColor,
                    ),
                    PlainText(name: widget.feedback.givenBy.name, fontsize: 14),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PlainText(
                        name: "Feedback - ${widget.feedback.message}",
                        fontsize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text("${widget.feedback.rating} ⭐️",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          )),
                    )
                  ],
                ),
              ],
            ),
            loading: () => const SizedBox.shrink(),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }
}
