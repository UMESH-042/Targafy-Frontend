import 'package:flutter/material.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/utils/texts.dart';
import 'package:targafy/src/groups/ui/group_details_page.dart';
import 'package:targafy/src/groups/ui/model/group_data_moderl.dart';

class GroupTile extends StatelessWidget {
  final GroupDataModel group;
  final VoidCallback onDataAdded;

  const GroupTile({
    super.key, // Corrected super.key to Key? key
    required this.group,
    required this.onDataAdded,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupDetailsPage(group: group),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: primaryColor, width: 2),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: getScreenWidth(context) * 0.06,
          vertical: getScreenheight(context) *
              0.02, // Corrected getScreenheight to getScreenHeight
        ).copyWith(top: 0),
        padding: EdgeInsets.symmetric(
          horizontal: getScreenWidth(context) * 0.04,
          vertical: getScreenheight(context) *
              0.005, // Corrected getScreenheight to getScreenHeight
        ).copyWith(right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   backgroundImage: group.logo.isNotEmpty
                //       ? NetworkImage(group.logo) // Use group.logo if not empty
                //       : const NetworkImage(
                //           'https://randomuser.me/api/portraits/lego/2.jpg'), // Use a default/random image URL here
                // ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/lego/2.jpg'), // Use a default/random image URL here
                ),
                SizedBox(width: getScreenWidth(context) * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: group.headGroupName,
                      fontSize: getScreenWidth(context) * 0.04,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    CustomText(
                      text: "Members: ${group.userAddedLength}",
                      fontSize: getScreenWidth(context) * 0.03,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.chevron_right,
                    color: primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class SubGroupTile extends StatelessWidget {
//   final SubGroupDataModel group;
//   final VoidCallback onDataAdded;

//   const SubGroupTile({
//     super.key, // Corrected super.key to Key? key
//     required this.group,
//     required this.onDataAdded,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SubGroupDetailsPage(group: group),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: primaryColor, width: 2),
//         ),
//         margin: EdgeInsets.symmetric(
//           horizontal: getScreenWidth(context) * 0.06,
//           vertical: getScreenheight(context) *
//               0.02, // Corrected getScreenheight to getScreenHeight
//         ).copyWith(top: 0),
//         padding: EdgeInsets.symmetric(
//           horizontal: getScreenWidth(context) * 0.04,
//           vertical: getScreenheight(context) *
//               0.005, // Corrected getScreenheight to getScreenHeight
//         ).copyWith(right: 0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 // CircleAvatar(
//                 //   backgroundImage: group.logo.isNotEmpty
//                 //       ? NetworkImage(group.logo) // Use group.logo if not empty
//                 //       : const NetworkImage(
//                 //           'https://randomuser.me/api/portraits/lego/2.jpg'), // Use a default/random image URL here
//                 // ),
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       'https://randomuser.me/api/portraits/lego/2.jpg'), // Use a default/random image URL here
//                 ),
//                 SizedBox(width: getScreenWidth(context) * 0.04),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: group.groupName,
//                       fontSize: getScreenWidth(context) * 0.04,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black,
//                     ),
//                     CustomText(
//                       text: "Members: ${group.userAddedLength}",
//                       fontSize: getScreenWidth(context) * 0.03,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {},
//                   child: Icon(
//                     Icons.chevron_right,
//                     color: primaryColor,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


class SubGroupTile extends StatelessWidget {
  final SubGroupDataModel group;
  final VoidCallback onDataAdded;

  const SubGroupTile({
    super.key, // Corrected super.key to Key? key
    required this.group,
    required this.onDataAdded,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubGroupDetailsPage(group: group),
          ),
        );

        // Check if the result indicates the data should be refreshed
        if (result == true) {
          onDataAdded();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: primaryColor, width: 2),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: getScreenWidth(context) * 0.06,
          vertical: getScreenheight(context) * 0.02, // Corrected getScreenheight to getScreenHeight
        ).copyWith(top: 0),
        padding: EdgeInsets.symmetric(
          horizontal: getScreenWidth(context) * 0.04,
          vertical: getScreenheight(context) * 0.005, // Corrected getScreenheight to getScreenHeight
        ).copyWith(right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://randomuser.me/api/portraits/lego/2.jpg'), // Use a default/random image URL here
                ),
                SizedBox(width: getScreenWidth(context) * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: group.groupName,
                      fontSize: getScreenWidth(context) * 0.04,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    CustomText(
                      text: "Members: ${group.userAddedLength}",
                      fontSize: getScreenWidth(context) * 0.03,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.chevron_right,
                    color: primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
