import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/utils/remote_routes.dart';

String domain = AppRemoteRoutes.baseUrl;

final commentsDataProvider =
    StateNotifierProvider<CommentsDataController, AsyncValue<List<Comment>>>(
        (ref) {
  return CommentsDataController();
});

class CommentsDataController extends StateNotifier<AsyncValue<List<Comment>>> {
  CommentsDataController() : super(const AsyncLoading());

  Future<void> fetchComments(
      String businessId, String userId, String parameter, String month) async {
    final String url =
        '${domain}data/get-level-comments/$businessId/$userId/$parameter/$month';
    final authToken = await _getAuthToken();
    print('This is business Id :- $businessId');
    print('This is userId :- $userId');
    print('This is Parameter :- $parameter');
    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $authToken'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('data')) {
          final List<dynamic> commentsData = responseData['data']['comments'];
          List<Comment> comments = commentsData
              .map((commentData) => Comment.fromJson(commentData))
              .toList();
          state = AsyncValue.data(comments);
          return;
        }
      }
    } catch (e) {
      print('Error fetching comments: $e');
    }
    state = AsyncValue.data([]);
  }

  Future<void> fetchGroupComments(
      String businessId, String userId, String parameter, String month) async {
    final String url =
        '${domain}groups/get-group-comments/$businessId/$parameter/$month/$userId';
    final authToken = await _getAuthToken();
    print('This is business Id :- $businessId');
    print('This is userId :- $userId');
    print('This is Parameter :- $parameter');
    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $authToken'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('data')) {
          final List<dynamic> commentsData = responseData['data']['comments'];
          List<Comment> comments = commentsData
              .map((commentData) => Comment.fromJson(commentData))
              .toList();
          state = AsyncValue.data(comments);
          return;
        }
      }
    } catch (e) {
      print('Error fetching comments: $e');
    }
    state = AsyncValue.data([]);
  }
}

// Function to get the auth token
Future<String> _getAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken') ?? '';
}

class Comment {
  final String date;
  final List<TodaysComment> comments;

  Comment({
    required this.date,
    required this.comments,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      date: json['date'] ?? '',
      comments: List<TodaysComment>.from((json['comments'] ?? [])
          .map((comment) => TodaysComment.fromJson(comment))),
    );
  }
}

class TodaysComment {
  final String todaysComment;
  final String addedBy;
  final String date;
  final String time;

  TodaysComment({
    required this.todaysComment,
    required this.addedBy,
    required this.date,
    required this.time,
  });

  factory TodaysComment.fromJson(Map<String, dynamic> json) {
    return TodaysComment(
      todaysComment: json['todaysComment'] ?? '',
      addedBy: json['addedBy'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
    );
  }
}
