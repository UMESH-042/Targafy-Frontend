// widgets/activity_tile.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:targafy/core/notification/model/notification_model.dart';
import 'package:targafy/src/activity/ui/model/activity_model.dart';
import 'package:targafy/utils/colors.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const NotificationTile({super.key, required this.notification});

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
    if (notification.content.contains("Reassigned") ||
        notification.content.contains("reassigned")) {
      return reassignColor;
    } else if (notification.content.contains("date is changed")) {
      return changeDateColor;
    } else if (notification.content.contains("critical")) {
      return criticalColor;
    } else if (notification.content.contains("title")) {
      return changeTitleColor;
    } else if (notification.content.contains("blocked")) {
      return blockedColor;
    } else if (notification.content.contains("closed")) {
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
            notification.content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              formatDate(notification.createdDate),
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}

