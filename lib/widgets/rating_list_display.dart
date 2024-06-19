import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/feedback/model/feedback_model.dart';
import 'package:targafy/utils/colors.dart';
import 'package:targafy/widgets/plain_text.dart';

// class RatingListTile extends StatelessWidget {
//   final bool isFeedback;
//   final FeedbackModel feedback;

//   const RatingListTile({
//     Key? key,
//     required this.feedback,
//     this.isFeedback = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String formattedDate =
//         "${feedback.createdDate.day}/${feedback.createdDate.month}/${feedback.createdDate.year}";

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
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: (isFeedback &&
//                         feedback.givenBy.name
//                             .isNotEmpty) // Assuming GivenBy has a name property
//                     ? () {
//                         // Navigator.of(context).push(
//                         //   MaterialPageRoute(
//                         //     builder: (context) => UserProfilePage(
//                         //       userId: feedback.userId,
//                         //       businessId: feedback.businessId,
//                         //     ),
//                         //   ),
//                         // );
//                       }
//                     : () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text("No Feedback Found"),
//                             backgroundColor: lightblue,
//                           ),
//                         );
//                       },
//                 child: (isFeedback && feedback.givenTo.isNotEmpty)
//                     ? Text(
//                         "${feedback.givenTo} (${feedback.rating} ⭐️)",
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: kprimaryColor,
//                             fontSize: 18),
//                       )
//                     : Text(
//                         "Rating: ${feedback.rating}",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//               ),
//               Container(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   formattedDate,
//                   style: const TextStyle(fontSize: 12),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               const PlainText(
//                 name: "Given By: ",
//                 fontWeight: FontWeight.w500,
//                 color: kprimaryColor,
//               ),
//               PlainText(name: feedback.givenBy.name, fontsize: 14),
//             ],
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: PlainText(
//                   name: "Feedback - ${feedback.message}",
//                   fontsize: 14,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 24),
//                 child: Text("${feedback.rating} ⭐️",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22,
//                     )),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class RatingListTile extends StatelessWidget {
  final bool isFeedback;
  final FeedbackModel feedback;

  const RatingListTile({
    Key? key,
    required this.feedback,
    this.isFeedback = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        "${feedback.createdDate.day}/${feedback.createdDate.month}/${feedback.createdDate.year}";

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (isFeedback &&
                        feedback.givenBy.name
                            .isNotEmpty) // Assuming GivenBy has a name property
                    ? () {
                        // Handle navigation to user profile
                      }
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("No Feedback Found"),
                            backgroundColor: Colors.lightBlue,
                          ),
                        );
                      },
                child: (isFeedback && feedback.givenTo.isNotEmpty)
                    ? Text(
                        "${feedback.givenTo} (${feedback.rating as double} ⭐️)",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      )
                    : Text(
                        "Rating: ${feedback.rating as double}",
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
              const Text(
                "Given By: ",
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
              ),
              Text(feedback.givenBy.name, style: const TextStyle(fontSize: 14)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Feedback - ${feedback.message}",
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  "${feedback.rating as double} ⭐️",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
