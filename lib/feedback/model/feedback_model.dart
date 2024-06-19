// feedback_model.dart

import 'package:flutter/foundation.dart';

class FeedbackModel {
  final String id;
  final String userId;
  final String businessId;
  final String givenTo;
  final double rating;
  final String message;
  final GivenBy givenBy;
  final DateTime createdDate;

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.businessId,
    required this.givenTo,
    required this.rating,
    required this.message,
    required this.givenBy,
    required this.createdDate,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['_id'],
      userId: json['userId'],
      businessId: json['businessId'],
      givenTo: json['givenTo'],
      rating: json['rating'],
      message: json['message'],
      givenBy: GivenBy.fromJson(json['givenBy']),
      createdDate: DateTime.parse(json['createdDate']),
    );
  }
}

class GivenBy {
  final String name;
  final String id;

  GivenBy({required this.name, required this.id});

  factory GivenBy.fromJson(Map<String, dynamic> json) {
    return GivenBy(
      name: json['name'],
      id: json['id'],
    );
  }
}
