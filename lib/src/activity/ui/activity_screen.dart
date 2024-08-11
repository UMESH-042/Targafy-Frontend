import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/core/notification/controller/reset_notification_controller.dart';
import 'package:targafy/src/activity/ui/controller/Activity_controller.dart';
import 'package:targafy/src/activity/ui/model/activity_model.dart';
import 'package:targafy/src/activity/ui/widgets/activity_tile.dart';
import 'package:targafy/utils/colors.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.read(resetNotificationCounterProvider('activity'));
    });

    if (businessId == null) {
      return const Scaffold(
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

    final activityList = ref.watch(activityListProvider(businessId));
    return Scaffold(
      body: activityList.when(
        data: (activities) {
          if (activities.isEmpty) {
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

          // Sort activities by createdDate in descending order
          activities.sort((a, b) => b.createdDate.compareTo(a.createdDate));

          Map<DateTime, List<ActivityModel>> groupedActivities =
              _groupActivitiesByDate(activities);

          return ListView.builder(
            itemCount: groupedActivities.length,
            itemBuilder: (context, index) {
              DateTime date = groupedActivities.keys.elementAt(index);
              List<ActivityModel> activities = groupedActivities[date]!;

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
                  ...activities.map((activity) {
                    return GestureDetector(
                      onTap: () {
                        // Handle activity tap here
                      },
                      child: ActivityTile(activity: activity),
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

  Map<DateTime, List<ActivityModel>> _groupActivitiesByDate(
      List<ActivityModel> activities) {
    Map<DateTime, List<ActivityModel>> groupedActivities = {};

    for (ActivityModel activity in activities) {
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
    DateTime localDateTime = dateTimeFromServer.toLocal();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (localDateTime.day == today.day &&
        localDateTime.month == today.month &&
        localDateTime.year == today.year) {
      return "Today";
    } else if (localDateTime.day == yesterday.day &&
        localDateTime.month == yesterday.month &&
        localDateTime.year == yesterday.year) {
      return 'Yesterday';
    } else {
      return DateFormat('dd/MM/yy').format(localDateTime);
    }
  }
}
