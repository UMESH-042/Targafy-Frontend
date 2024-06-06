// models/activity_model.dart
class ActivityModel {
  final String id;
  final String content;
  final String activityCategory;
  final DateTime createdDate;

  ActivityModel({
    required this.id,
    required this.content,
    required this.activityCategory,
    required this.createdDate,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['_id'],
      content: json['content'],
      activityCategory: json['activityCategory'],
      createdDate: DateTime.parse(json['createdDate']),
    );
  }
}
