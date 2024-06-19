// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:go_router/go_router.dart';

// class RateUserDialog extends StatefulWidget {
//   final String userId;
//   final String businessId;
//   final bool isFeedback;
//   final Function rateUserCallback;

//   const RateUserDialog({
//     Key? key,
//     required this.userId,
//     required this.businessId,
//     this.isFeedback = false,
//     required this.rateUserCallback,
//   }) : super(key: key);

//   @override
//   _RateUserDialogState createState() => _RateUserDialogState();
// }

// class _RateUserDialogState extends State<RateUserDialog> {
//   late TextEditingController _messageController;
//   double _rating = 0;
//   bool _switchValue = false;
//   @override
//   void initState() {
//     super.initState();
//     _messageController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               "Rate User",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Center(
//               child: RatingBar.builder(
//                 initialRating: _rating,
//                 minRating: 1,
//                 direction: Axis.horizontal,
//                 allowHalfRating: true,
//                 itemCount: 5,
//                 itemSize: 40,
//                 itemBuilder: (context, _) => const Icon(
//                   Icons.star,
//                   color: Colors.amber,
//                 ),
//                 onRatingUpdate: (rating) {
//                   setState(() {
//                     _rating = rating;
//                   });
//                 },
//               ),
//             ),
//             if(_rating<3)
//             Row(
//               children: [
//                 const Text(
//                   "Anonymous",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Switch(
//                   value: _switchValue,
//                   onChanged: (value) {
//                     setState(() {
//                       _switchValue = value;
//                     });
//                   },
//                   activeColor: Colors.blue, // Color when switch is on
//                   inactiveThumbColor:
//                       Colors.grey, // Color of the switch when off
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               textCapitalization:
//                   TextCapitalization.sentences, // or TextCapitalization.words
//               keyboardType: TextInputType.text,
//               controller: _messageController,
//               decoration: const InputDecoration(
//                 labelText: "Message",
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//                   child: const Text("Cancel"),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     // businessController.rateUserRequest(
//                     //     context,
//                     //     widget.businessId,
//                     //     widget.userId,
//                     //     _messageController.text,
//                     //     _rating,
//                     //     widget.isFeedback,
//                     //     _switchValue, (success) {
//                     //   if (success) {
//                     //     print("succeess 2.....");
//                     //     widget.rateUserCallback(true);
//                     //   }
//                     // });
//                     // _messageController.text = "";

//                     // _submitRating(); // Perform rating submission
//                   },
//                   child: const Text("Submit"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _submitRating() {
//     // GoRouter.of(context).pop(); // Close the dialog after submission
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/feedback/controller/feedback_controller.dart';

class RateUserDialog extends ConsumerStatefulWidget {
  final String userId;
  final String userName;
  final String businessId;
  final bool isFeedback;
  final Function(bool)? rateUserCallback;

  const RateUserDialog({
    Key? key,
    required this.userId,
    required this.userName,
    required this.businessId,
    this.isFeedback = false,
    this.rateUserCallback,
  }) : super(key: key);

  @override
  _RateUserDialogState createState() => _RateUserDialogState();
}

class _RateUserDialogState extends ConsumerState<RateUserDialog> {
  late TextEditingController _messageController;
  double _rating = 0.0;
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final apiService = ref.read(apiProvider); // Access the ApiService
    print('this is the userName ${widget.userName}');

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Rate User",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
            ),
            if (_rating < 3)
              Row(
                children: [
                  const Text(
                    "Anonymous",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Switch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                    activeColor: Colors.blue,
                    inactiveThumbColor: Colors.grey,
                  ),
                ],
              ),
            const SizedBox(height: 16),
            TextField(
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text,
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: "Message",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    final success = await apiService.submitFeedback(
                        businessId: widget.businessId,
                        userId: widget.userId,
                        rating: _rating,
                        message: _messageController.text,
                        isAnonymous: _switchValue,
                        userName: widget.userName);

                    if (success) {
                      widget.rateUserCallback?.call(true);
                      Navigator.of(context).pop();
                    } else {
                      // Handle error
                      // Optionally show an error message
                    }
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
