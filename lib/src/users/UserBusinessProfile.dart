// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/src/users/ui/controller/user_business_profile_controller.dart';

// class UserBusinessProfilePage extends ConsumerWidget {
//   final String userId;

//   const UserBusinessProfilePage({
//     required this.userId,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userAsyncValue = ref.watch(userProvider(userId));

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Profile'),
//       ),
//       body: userAsyncValue.when(
//         data: (user) => SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ListTile(
//                 title: Text(
//                   'Name: ${user.name}',
//                   style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text('User ID: ${user.userId}'),
//                 trailing: const CircleAvatar(
//                     // Add avatar here if needed
//                     ),
//               ),
//               const Divider(),
//               _buildKeyValuePair("Rating", user.totalRating.toString()),
//               _buildKeyValuePair("Contact Number", user.contactNumber),
//               _buildKeyValuePair("User Type", user.userType),
//               _buildKeyValuePair("Role", user.role),
//               _buildKeyValuePair("Last Seen", user.lastSeen),
//               // Add more fields as needed
//             ],
//           ),
//         ),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stackTrace) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }

//   Widget _buildKeyValuePair(String key, dynamic value) {
//     if (key == "Contact Number") {
//       final countryCode = value["countryCode"] ?? '';
//       final phoneNumber = value["number"] ?? '';
//       final formattedPhoneNumber = '$countryCode $phoneNumber';

//       return Container(
//         margin: const EdgeInsets.symmetric(vertical: 5),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 5,
//               child: Text(
//                 key,
//                 style: const TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//             Expanded(
//               flex: 5,
//               child: Text(
//                 formattedPhoneNumber,
//                 style: const TextStyle(fontSize: 16, color: Colors.black),
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       return Container(
//         margin: const EdgeInsets.symmetric(vertical: 5),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 5,
//               child: Text(
//                 key,
//                 style: const TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//             Expanded(
//               flex: 5,
//               child: Text(
//                 value.toString(),
//                 style: const TextStyle(fontSize: 16, color: Colors.black),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/src/users/ui/controller/user_business_profile_controller.dart';

// class UserBusinessProfilePage extends ConsumerWidget {
//   final String userId;

//   const UserBusinessProfilePage({
//     required this.userId,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userAsyncValue = ref.watch(userProvider(userId));

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Profile'),
//       ),
//       body: userAsyncValue.when(
//         data: (user) => SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ListTile(
//                 title: Text(
//                   'Name: ${user.name}',
//                   style: const TextStyle(
//                       fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text('User ID: ${user.userId}'),
//                 trailing: const CircleAvatar(
//                     // Add avatar here if needed
//                     ),
//               ),
//               const Divider(),
//               _buildKeyValuePair("Rating", user.totalRating.toString()),
//               _buildKeyValuePair("Contact Number", user.contactNumber),
//               // _buildKeyValuePair("User Type", user.userType),
//               _buildKeyValuePair("Role", user.role),
//               _buildKeyValuePair("Last Seen", user.lastSeen),
//               // Add more fields as needed
//             ],
//           ),
//         ),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stackTrace) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }

//   Widget _buildKeyValuePair(String key, dynamic value) {
//     if (key == "Contact Number") {
//       final countryCode = value["countryCode"] ?? '';
//       final phoneNumber = value["number"] ?? '';
//       final formattedPhoneNumber = '$countryCode $phoneNumber';

//       return Container(
//         margin: const EdgeInsets.symmetric(vertical: 5),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 5,
//               child: Text(
//                 key,
//                 style: const TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//             Expanded(
//               flex: 5,
//               child: Text(
//                 formattedPhoneNumber,
//                 style: const TextStyle(fontSize: 16, color: Colors.black),
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       return Container(
//         margin: const EdgeInsets.symmetric(vertical: 5),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 5,
//               child: Text(
//                 key,
//                 style: const TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//             Expanded(
//               flex: 5,
//               child: Text(
//                 value.toString(),
//                 style: const TextStyle(fontSize: 16, color: Colors.black),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/src/parameters/view/controller/get_target_controller.dart';
import 'package:targafy/src/parameters/view/widgets/TargetCard.dart';
import 'package:targafy/src/parameters/view/widgets/small_button.dart';
import 'package:targafy/src/users/ui/controller/user_business_profile_controller.dart';
import 'package:targafy/src/services/shared_preference_service.dart';
import 'package:targafy/utils/remote_routes.dart';
import 'package:targafy/src/parameters/view/model/target_data_model.dart';

String domain = AppRemoteRoutes.baseUrl;

class UserBusinessProfilePage extends ConsumerStatefulWidget {
  final String userId;

  const UserBusinessProfilePage({
    required this.userId,
    super.key,
  });

  @override
  _UserBusinessProfilePageState createState() =>
      _UserBusinessProfilePageState();
}

class _UserBusinessProfilePageState
    extends ConsumerState<UserBusinessProfilePage> {
  List<String> parameterList = [];
  bool isLoading = true;
  String? errorMessage;
  Map<String, List<TargetData>> userParameterTargetData = {};
  bool _showTargets = false;

  @override
  void initState() {
    super.initState();
    _fetchParameters();
  }

  Future<void> _fetchParameters() async {
    try {
      final authToken = await SharedPreferenceService().getAuthToken();
      final selectedBusinessData = ref.read(currentBusinessProvider);
      final businessId = selectedBusinessData?['business']?.id;

      final response = await http.get(
        Uri.parse('${domain}data/get-target-users/$businessId'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        setState(() {
          parameterList = List<String>.from(data['data']['paramNames']);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch parameters');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  Future<void> _fetchTargetsForParameters(
      String userId, String businessId) async {
    final controller = ref.read(targetDataControllerProvider.notifier);

    for (String parameter in parameterList) {
      try {
        final List<TargetData> targets = await controller.fetchThreeMonthsData(
            userId, businessId, parameter);
        userParameterTargetData[parameter] = targets;
      } catch (e) {
        print('Failed to fetch data for parameter $parameter: $e');
        userParameterTargetData[parameter] = []; // Handle empty case or error
      }
    }
    setState(() {}); // Trigger rebuild after fetching all data
  }

  @override
  Widget build(BuildContext context) {
    final selectedBusinessData = ref.read(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;

    return Consumer(builder: (context, watch, child) {
      final userAsyncValue = ref.watch(userProvider(widget.userId));

      return Scaffold(
        appBar: AppBar(
          title: const Text('User Profile'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userAsyncValue.when(
                data: (user) => Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Name: ${user.name}',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('User ID: ${user.userId}'),
                      trailing: const CircleAvatar(
                          // Add avatar here if needed
                          ),
                    ),
                    const Divider(),
                    _buildKeyValuePair("Rating", user.totalRating.toString()),
                    _buildKeyValuePair("Contact Number", user.contactNumber),
                    // _buildKeyValuePair("User Type", user.userType),
                    _buildKeyValuePair("Role", user.role),
                    _buildKeyValuePair("Last Seen", user.lastSeen),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text('Error: $error')),
              ),
              const SizedBox(height: 20),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (errorMessage != null)
                Center(child: Text('Error: $errorMessage'))
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CustomSmallButton(
                        onPressed: () {
                          setState(() {
                            _showTargets =
                                true; // Show targets when button pressed
                          });
                          _fetchTargetsForParameters(widget.userId, businessId);
                        },
                        title: 'Get Target',
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_showTargets) ...[
                      Center(
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _showTargets = false;
                            });
                          },
                        ),
                      ),
                    ],
                    if (_showTargets) ...[
                      const SizedBox(height: 10),
                      _buildTargetCards(businessId, widget.userId),
                    ],
                  ],
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTargetCards(String businessId, String userId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: userParameterTargetData.entries.map((entry) {
        final parameterName = entry.key;
        final targets = entry.value;
        return TargetCard(
          userId: userId,
          parameterName: parameterName,
          targets: targets,
          businessId: businessId,
        );
      }).toList(),
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
