// widgets/activity_tile.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:targafy/src/activity/ui/model/activity_model.dart';
import 'package:targafy/utils/colors.dart';


class ActivityTile extends StatelessWidget {
  final ActivityModel activity;

  const ActivityTile({Key? key, required this.activity}) : super(key: key);

  String formatDate(DateTime dateTimeFromServer) {
    DateTime localDateTime = dateTimeFromServer.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (localDateTime.day == today.day &&
        localDateTime.month == today.month &&
        localDateTime.year == today.year) {
      return DateFormat.Hm().format(localDateTime);
    } else if (localDateTime.day == yesterday.day &&
        localDateTime.month == yesterday.month &&
        localDateTime.year == yesterday.year) {
      return DateFormat.Hm().format(localDateTime);
    } else {
      return DateFormat.Hm().format(localDateTime);
    }
  }

  Color determineTileColor() {
    if (activity.content.contains("Reassigned") ||
        activity.content.contains("reassigned")) {
      return reassignColor;
    } else if (activity.content.contains("date is changed")) {
      return changeDateColor;
    } else if (activity.content.contains("critical")) {
      return criticalColor;
    } else if (activity.content.contains("title")) {
      return changeTitleColor;
    } else if (activity.content.contains("blocked")) {
      return blockedColor;
    } else if (activity.content.contains("closed")) {
      return closedColor;
    } else {
      return ktertiaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tileColor = determineTileColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      decoration: BoxDecoration(
          color: tileColor, borderRadius: BorderRadius.circular(8)),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity.content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              formatDate(activity.createdDate),
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
