// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CommentBubble extends StatelessWidget {
//   final String profileImage;
//   final String message;
//   final String sender;
//   final DateTime timestamp;

//   const CommentBubble({
//     required this.profileImage,
//     required this.message,
//     required this.sender,
//     required this.timestamp,
//   });

//   @override
//   Widget build(BuildContext context) {
//     bool isMe = sender == 'my_user_id'; // Change this to your logic for checking the sender

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (!isMe) // Show profile picture for the other user
//             CircleAvatar(
//               backgroundImage: NetworkImage(profileImage),
//               radius: 20,
//             ),
//           SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment:
//                   isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   sender,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: isMe ? Colors.blue : Colors.black,
//                   ),
//                 ),
//                 Material(
//                   borderRadius: BorderRadius.circular(10.0),
//                   color: isMe ? Colors.lightBlueAccent : Colors.grey[300],
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10.0, horizontal: 20.0),
//                     child: Text(
//                       message,
//                       style: TextStyle(
//                         color: isMe ? Colors.white : Colors.black,
//                         fontSize: 15.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   DateFormat('h:mm a').format(timestamp),
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (isMe) // Show profile picture for the current user
//             SizedBox(width: 8),
//           if (isMe)
//             CircleAvatar(
//               backgroundImage: NetworkImage(profileImage),
//               radius: 20,
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentBubble extends StatelessWidget {
  final String profileImage;
  final String message;
  final String sender;
  final DateTime timestamp;
  final DateTime dateAdded; // New field for the date when the comment was added

  const CommentBubble({
    required this.profileImage,
    required this.message,
    required this.sender,
    required this.timestamp,
    required this.dateAdded, // Initialize the new field
  });

  @override
  Widget build(BuildContext context) {
    bool isMe = sender ==
        'my_user_id'; // Change this to your logic for checking the sender

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              DateFormat('MMMM d, yyyy').format(dateAdded),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe) // Show profile picture for the other user
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImage),
                  radius: 20,
                ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      sender,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe ? Colors.blue : Colors.black,
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: isMe ? Colors.lightBlueAccent : Colors.grey[300],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          message,
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      DateFormat('h:mm a').format(timestamp),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              if (isMe) // Show profile picture for the current user
                SizedBox(width: 8),
              if (isMe)
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImage),
                  radius: 20,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
