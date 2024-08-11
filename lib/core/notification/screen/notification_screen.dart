// // // notification_page.dart
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:gap/gap.dart';
// // import 'package:intl/intl.dart';
// // import 'package:lottie/lottie.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:targafy/business_home_page/controller/business_controller.dart';
// // import 'package:targafy/core/notification/controller/notification_controller.dart';
// // import 'package:targafy/core/notification/model/notification_model.dart';
// // import 'package:targafy/utils/colors.dart';

// // import '../../../business_home_page/models/fetch_business_data_mode.dart';

// // final notificationProvider = FutureProvider.autoDispose
// //     .family<List<NotificationModel>, NotificationRequestParams>(
// //         (ref, params) async {
// //   final notificationService = ref.read(notificationServiceProvider);
// //   final prefs = await SharedPreferences.getInstance();
// //   final token = prefs.getString('authToken') ?? params.token;

// //   return await notificationService.fetchNotifications(params.businessId, token);
// // });

// // class NotificationPage extends ConsumerWidget {
// //   final String? token;
// //   NotificationPage({this.token});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final selectedBusinessData = ref.watch(currentBusinessProvider);
// //     final selectedBusiness = selectedBusinessData?['business'] as Business?;
// //     final businessId = selectedBusiness?.id;

// //     if (token == null || businessId == null) {
// //       return Scaffold(
// //         appBar: AppBar(title: Text('Notifications')),
// //         body: Center(child: Text('Token or Business ID not available')),
// //       );
// //     }

// //     final notificationsAsyncValue = ref.watch(notificationProvider(
// //       NotificationRequestParams(businessId: businessId!, token: token!),
// //     ));

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Notifications'),
// //       ),
// //       body: notificationsAsyncValue.when(
// //         data: (notifications) {
// //           if (notifications.isEmpty) {
// //             return Center(
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Lottie.asset('assets/animations/empty_list.json',
// //                       height: 200, width: 200),
// //                   Text(
// //                     "No notifications found",
// //                     style: TextStyle(
// //                       color: Colors.grey[500],
// //                       fontSize: 14,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           }

// //           Map<DateTime, List<NotificationModel>> groupedNotifications =
// //               _groupNotificationsByDate(notifications);

// //           return ListView.builder(
// //             itemCount: groupedNotifications.length,
// //             itemBuilder: (context, index) {
// //               DateTime date = groupedNotifications.keys.elementAt(index);
// //               List<NotificationModel> notifications =
// //                   groupedNotifications[date]!;

// //               return Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const Gap(5),
// //                   Center(
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                         color: ksecondaryColor,
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 8.0, vertical: 2.0),
// //                       child: Text(
// //                         _formatDate(date),
// //                         style: const TextStyle(
// //                           fontWeight: FontWeight.w600,
// //                           fontSize: 14,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   const Gap(5),
// //                   ...notifications.map((notification) {
// //                     return NotificationTile(notification: notification);
// //                   }).toList(),
// //                 ],
// //               );
// //             },
// //           );
// //         },
// //         loading: () => const Center(child: CircularProgressIndicator()),
// //         error: (error, stack) => Center(child: Text('Error: $error')),
// //       ),
// //     );
// //   }

// //   Map<DateTime, List<NotificationModel>> _groupNotificationsByDate(
// //       List<NotificationModel> notifications) {
// //     Map<DateTime, List<NotificationModel>> groupedNotifications = {};

// //     for (NotificationModel notification in notifications) {
// //       DateTime date = DateTime(notification.createdDate.year,
// //           notification.createdDate.month, notification.createdDate.day);

// //       if (!groupedNotifications.containsKey(date)) {
// //         groupedNotifications[date] = [];
// //       }
// //       groupedNotifications[date]!.add(notification);
// //     }

// //     return groupedNotifications;
// //   }

// //   String _formatDate(DateTime dateTimeFromServer) {
// //     DateTime localDateTime = dateTimeFromServer.toLocal();
// //     final now = DateTime.now();
// //     final today = DateTime(now.year, now.month, now.day);
// //     final yesterday = DateTime(now.year, now.month, now.day - 1);

// //     if (localDateTime.day == today.day &&
// //         localDateTime.month == today.month &&
// //         localDateTime.year == today.year) {
// //       return "Today";
// //     } else if (localDateTime.day == yesterday.day &&
// //         localDateTime.month == yesterday.month &&
// //         localDateTime.year == yesterday.year) {
// //       return 'Yesterday';
// //     } else {
// //       return DateFormat('dd/MM/yy').format(localDateTime);
// //     }
// //   }
// // }

// // class NotificationTile extends StatelessWidget {
// //   final NotificationModel notification;

// //   const NotificationTile({Key? key, required this.notification})
// //       : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return ListTile(
// //       title: Text(notification.content),
// //       subtitle: Text(DateFormat('hh:mm a').format(notification.createdDate)),
// //       onTap: () {
// //         // Handle notification tap here
// //       },
// //     );
// //   }
// // }

// class NotificationPage extends ConsumerWidget {
//   const NotificationPage({
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedBusinessData = ref.watch(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;

//     if (businessId == null) {
//       return const Scaffold(
//         body: Center(
//           child: Text(
//             "Business not selected",
//             style: TextStyle(
//               color: Colors.red,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       );
//     }

//     final NotificationList = ref.watch(NotificationListProvider(businessId));
//     return Scaffold(
//       body: NotificationList.when(
//         data: (notification) {
//           if (notification.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Lottie.asset('assets/animations/empty_list.json',
//                       height: 200, width: 200),
//                   Text(
//                     "No activities found",
//                     style: TextStyle(
//                       color: Colors.grey[500],
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }

//           Map<DateTime, List<NotificationModel>> groupedActivities =
//               _groupActivitiesByDate(notification);

//           return ListView.builder(
//             itemCount: groupedActivities.length,
//             itemBuilder: (context, index) {
//               DateTime date = groupedActivities.keys.elementAt(index);
//               List<NotificationModel> activities = groupedActivities[date]!;

//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Gap(5),
//                   Center(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: ksecondaryColor,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8.0, vertical: 2.0),
//                       child: Text(
//                         _formatDate(date),
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Gap(5),
//                   ...activities.map((notification) {
//                     return GestureDetector(
//                       onTap: () {
//                         // Handle activity tap here
//                       },
//                       child: NotificationTile(
//                         notification: notification,
//                       ),
//                     );
//                   }),
//                 ],
//               );
//             },
//           );
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stack) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }

//   Map<DateTime, List<NotificationModel>> _groupActivitiesByDate(
//       List<NotificationModel> activities) {
//     Map<DateTime, List<NotificationModel>> groupedActivities = {};

//     for (NotificationModel activity in activities) {
//       DateTime date = DateTime(activity.createdDate.year,
//           activity.createdDate.month, activity.createdDate.day);

//       if (!groupedActivities.containsKey(date)) {
//         groupedActivities[date] = [];
//       }
//       groupedActivities[date]!.add(activity);
//     }

//     return groupedActivities;
//   }

//   String _formatDate(DateTime dateTimeFromServer) {
//     DateTime localDateTime = dateTimeFromServer.toLocal();
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yesterday = DateTime(now.year, now.month, now.day - 1);

//     if (localDateTime.day == today.day &&
//         localDateTime.month == today.month &&
//         localDateTime.year == today.year) {
//       return "Today";
//     } else if (localDateTime.day == yesterday.day &&
//         localDateTime.month == yesterday.month &&
//         localDateTime.year == yesterday.year) {
//       return 'Yesterday';
//     } else {
//       return DateFormat('dd/MM/yy').format(localDateTime);
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/core/notification/controller/notification_controller.dart';
import 'package:targafy/core/notification/controller/reset_notification_controller.dart';
import 'package:targafy/core/notification/model/notification_model.dart';
import 'package:targafy/core/notification/screen/notification_tile.dart';
import 'package:targafy/utils/colors.dart';

class NotificationPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;

    // Call the reset notification counter function when the widget initializes
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.read(
          resetNotificationCounterProvider('notification')); // Trigger API call
    });

    if (businessId == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Please select a business",
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    final NotificationList = ref.watch(NotificationListProvider(businessId));
    return Scaffold(
      body: NotificationList.when(
        data: (notification) {
          if (notification.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset('assets/animations/empty_list.json',
                      height: 200, width: 200),
                  Text(
                    "No activities found",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }

          // Sort notifications by createdDate in descending order
          notification.sort((a, b) => b.createdDate.compareTo(a.createdDate));

          Map<DateTime, List<NotificationModel>> groupedActivities =
              _groupActivitiesByDate(notification);

          return ListView.builder(
            itemCount: groupedActivities.length,
            itemBuilder: (context, index) {
              DateTime date = groupedActivities.keys.elementAt(index);
              List<NotificationModel> activities = groupedActivities[date]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(5),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: ksecondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        _formatDate(date),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const Gap(5),
                  ...activities.map((notification) {
                    return GestureDetector(
                      onTap: () {
                        // Handle activity tap here
                      },
                      child: NotificationTile(
                        notification: notification,
                      ),
                    );
                  }),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Map<DateTime, List<NotificationModel>> _groupActivitiesByDate(
      List<NotificationModel> activities) {
    Map<DateTime, List<NotificationModel>> groupedActivities = {};

    for (NotificationModel activity in activities) {
      DateTime date = DateTime(activity.createdDate.year,
          activity.createdDate.month, activity.createdDate.day);

      if (!groupedActivities.containsKey(date)) {
        groupedActivities[date] = [];
      }
      groupedActivities[date]!.add(activity);
    }

    return groupedActivities;
  }

  String _formatDate(DateTime dateTimeFromServer) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (dateTimeFromServer.day == today.day &&
        dateTimeFromServer.month == today.month &&
        dateTimeFromServer.year == today.year) {
      return "Today";
    } else if (dateTimeFromServer.day == yesterday.day &&
        dateTimeFromServer.month == yesterday.month &&
        dateTimeFromServer.year == yesterday.year) {
      return 'Yesterday';
    } else {
      return DateFormat('dd/MM/yy').format(dateTimeFromServer);
    }
  }
}
