import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define a model for the notification counters
class NotificationCounters {
  final int acceptCounter;
  final int activityCounter;
  final int notificationCounter;
  final int totalNotification;

  NotificationCounters({
     this.acceptCounter=0,
     this.activityCounter=0,
    this.notificationCounter=0,
     this.totalNotification=0,
  });

  factory NotificationCounters.fromJson(Map<String, dynamic> json) {
    return NotificationCounters(
      acceptCounter: json['acceptCounter'],
      activityCounter: json['activityCounter'],
      notificationCounter: json['notificationCounter'],
      totalNotification: json['totalNotification'],
    );
  }
}

// Define a state notifier to manage the notification counters state
class NotificationCountersNotifier
    extends StateNotifier<AsyncValue<NotificationCounters>> {
  NotificationCountersNotifier() : super(const AsyncLoading());
  

  Future<void> fetchNotificationCounters(
      String token, String businessId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://13.234.163.59/api/v1/notification/get-notification-counters/$businessId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        final counters = NotificationCounters.fromJson(data);
        state = AsyncValue.data(counters);
      } else {
        state = AsyncValue.error(
            'Failed to fetch notification counters', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Function to fetch notification counters for a list of business IDs
  // Future<void> fetchTotalNotificationsForBusinesses(String token, List<String> businessIds) async {
  //   try {
  //     for (final businessId in businessIds) {
  //       final response = await http.get(
  //         Uri.parse('http://13.234.163.59/api/v1/notification/get-notification-counters/$businessId'),
  //         headers: {'Authorization': 'Bearer $token'},
  //       );

  //       if (response.statusCode == 200) {
  //         final data = json.decode(response.body)['data'];
  //         final counters = NotificationCounters.fromJson(data);
  //         // You can update state here as per your requirement
  //       } else {
  //         // Handle error if needed
  //       }
  //     }
  //   } catch (e) {
  //     // Handle error if needed
  //   }
  // }
}

// Define a provider for the notification counters state notifier
final notificationCountersProvider = StateNotifierProvider<
    NotificationCountersNotifier, AsyncValue<NotificationCounters>>(
  (ref) => NotificationCountersNotifier(),
);
