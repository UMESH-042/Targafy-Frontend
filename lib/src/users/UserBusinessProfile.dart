import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/src/users/ui/controller/user_business_profile_controller.dart';

class UserBusinessProfilePage extends ConsumerWidget {
  final String userId;

  const UserBusinessProfilePage({
    required this.userId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: userAsyncValue.when(
        data: (user) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Name: ${user.name}',
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('User ID: ${user.userId}'),
                trailing: const CircleAvatar(
                    // Add avatar here if needed
                    ),
              ),
              const Divider(),
              _buildKeyValuePair("Rating", user.totalRating.toString()),
              _buildKeyValuePair("Contact Number", user.contactNumber),
              _buildKeyValuePair("User Type", user.userType),
              _buildKeyValuePair("Role", user.role),
              _buildKeyValuePair("Last Seen", user.lastSeen),
              // Add more fields as needed
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildKeyValuePair(String key, dynamic value) {
    if (key == "Contact Number") {
      final countryCode = value["countryCode"] ?? '';
      final phoneNumber = value["number"] ?? '';
      final formattedPhoneNumber = '$countryCode $phoneNumber';

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                key,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                formattedPhoneNumber,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                key,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value.toString(),
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      );
    }
  }
}
