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
    Key? key,
    required this.group,
    required this.onDataAdded,
  }) : super(key: key);

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
          vertical: getScreenheight(context) * 0.02,
        ).copyWith(top: 0),
        padding: EdgeInsets.symmetric(
          horizontal: getScreenWidth(context) * 0.04,
          vertical: getScreenheight(context) * 0.005,
        ).copyWith(right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(group.logo),
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
