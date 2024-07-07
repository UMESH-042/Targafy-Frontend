import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final commentsDataControllerProvider =
    Provider<CommentsDataController>((ref) => CommentsDataController());

class CommentsDataController {
  Future<CommentsDataModel> fetchCommentsData(
      String businessId, String parameterName, String month) async {
    final String url =
        '${domain}data/get-param-comments/$businessId/$parameterName/$month';
    final authToken = await _getAuthToken(); // Get the auth token
    print('This is business Id :- $businessId');
    print('This is parameterName :- $parameterName');
    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $authToken'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('data')) {
          final Map<String, dynamic> data = responseData['data'];
          return CommentsDataModel.fromJson(data);
        }
      }
    } catch (e) {
      print('Error fetching comments data: $e');
    }
    return CommentsDataModel.empty();
  }
}

// Function to get the auth token
Future<String> _getAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken') ?? '';
}

class CommentsDataModel {
  final List<CommentEntry> comments;

  CommentsDataModel({required this.comments});

  factory CommentsDataModel.fromJson(Map<String, dynamic> data) {
    return CommentsDataModel(
      comments: (data['comments'] as List<dynamic>)
          .map((e) => CommentEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory CommentsDataModel.empty() {
    return CommentsDataModel(comments: []);
  }
}

class CommentEntry {
  final String date;
  final List<CommentDetail> comments;

  CommentEntry({required this.date, required this.comments});

  factory CommentEntry.fromJson(Map<String, dynamic> json) {
    return CommentEntry(
      date: json['date'],
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CommentDetail {
  final String todaysComment;
  final String addedBy;
  final String date;

  CommentDetail(
      {required this.todaysComment, required this.addedBy, required this.date});

  factory CommentDetail.fromJson(Map<String, dynamic> json) {
    return CommentDetail(
      todaysComment: json['todaysComment'],
      addedBy: json['addedBy'],
      date: json['date'],
    );
  }
}
