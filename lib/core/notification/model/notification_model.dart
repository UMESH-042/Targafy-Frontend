import 'package:flutter/foundation.dart';

class NotificationModel {
  final String id;
  final String userId;
  final String content;
  final String notificationCategory;
  final DateTime createdDate;
  final String businessName;
  final String businessId;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.content,
    required this.notificationCategory,
    required this.createdDate,
    required this.businessName,
    required this.businessId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      userId: json['userId'],
      content: json['content'],
      notificationCategory: json['notificationCategory'],
      createdDate: DateTime.parse(json['createdDate']),
      businessName: json['businessName'],
      businessId: json['businessId'],
    );
  }
}
