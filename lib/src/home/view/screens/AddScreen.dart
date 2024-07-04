// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/src/home/view/screens/controller/mandatory_Filed_name_controller.dart';
// import 'package:targafy/utils/remote_routes.dart';
// import 'package:targafy/widgets/submit_button.dart';

// String domain = AppRemoteRoutes.baseUrl;

// // Provider for fetching parameters
// final parametersProvider = FutureProvider<List<String>>((ref) async {
//   final authToken = await SharedPreferenceService().getAuthToken();
//   final selectedBusinessData = ref.watch(currentBusinessProvider);
//   final businessId = selectedBusinessData?['business']?.id;

//   final response = await http.get(
//     Uri.parse('${domain}data/get-target-users/$businessId'),
//     headers: {
//       'Authorization': 'Bearer $authToken',
//     },
//   );

//   if (response.statusCode == 200) {
//     final data = json.decode(response.body) as Map<String, dynamic>;
//     return List<String>.from(data['data']);
//   } else {
//     throw Exception('Failed to fetch parameters');
//   }
// });

// final addDataForParameterProvider =
//     FutureProvider.autoDispose.family<void, Map<String, dynamic>>(
//   (ref, requestData) async {
//     final authToken = await SharedPreferenceService().getAuthToken();
//     final businessId = requestData['businessId'] as String;
//     final parameterName = requestData['parameterName'] as String;
//     final todayData = requestData['todayData'] as String;
//     final comment = requestData['comment'] as String;

//     final response = await http.post(
//       Uri.parse('${domain}data/add-data/$businessId/$parameterName'),
//       headers: {
//         'Authorization': 'Bearer $authToken',
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'todaysdata': todayData,
//         'comment': comment,
//       }),
//     );

//     if (response.statusCode != 201) {
//       throw Exception('Failed to add data for parameter: $parameterName');
//     }
//   },
// );

// class Addscreen extends ConsumerStatefulWidget {
//   const Addscreen({super.key});

//   @override
//   _AddscreenState createState() => _AddscreenState();
// }

// class _AddscreenState extends ConsumerState<Addscreen> {
//   String? selectedParameter;
//   final TextEditingController todayDataController = TextEditingController();
//   final TextEditingController commentController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final parametersAsyncValue = ref.watch(parametersProvider);
//     final selectedBusinessData = ref.watch(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;

//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Add Data'),
//       // ),
//       body: businessId == null
//           ? Center(
//               child: Text(
//                 'Please select a business',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//             )
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: parametersAsyncValue.when(
//                 data: (parameters) {
//                   if (parameters.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Lottie.asset('assets/animations/empty_list.json',
//                               height: 200, width: 200),
//                           const Text(
//                             "Nothing to Add",
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const Text(
//                         'Add Data',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 20),
//                       DropdownButtonFormField<String>(
//                         hint: const Text('Select Parameter'),
//                         // value: selectedParameter ??
//                         //     (parameters.isNotEmpty ? parameters[0] : null),
//                         value: selectedParameter,
//                         onChanged: (value) {
//                           setState(() {
//                             selectedParameter = value;
//                           });
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Select Parameter',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                         ),
//                         items: parameters
//                             .map<DropdownMenuItem<String>>((String parameter) {
//                           return DropdownMenuItem<String>(
//                             value: parameter,
//                             child: Text(parameter),
//                           );
//                         }).toList(),
//                       ),
//                       const SizedBox(height: 20),
//                       TextField(
//                         controller: todayDataController,
//                         decoration: InputDecoration(
//                           labelText: 'Today\'s Data',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                         ),
//                         keyboardType: TextInputType.number,
//                       ),
//                       const SizedBox(height: 20),
//                       TextField(
//                         controller: commentController,
//                         decoration: InputDecoration(
//                           labelText: 'Comment',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       SubmitButton(
//                         onPressed: () {
//                           if (selectedParameter != null && businessId != null) {
//                             final todayData = todayDataController.text;
//                             final comment = commentController.text;
//                             ref
//                                 .read(addDataForParameterProvider({
//                               'businessId': businessId,
//                               'parameterName': selectedParameter!,
//                               'todayData': todayData,
//                               'comment': comment,
//                             }).future)
//                                 .then((_) {
//                               // Data added successfully
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text('Data added successfully')),
//                               );
//                               // Clear the input fields
//                               todayDataController.clear();
//                               commentController.clear();
//                               setState(() {
//                                 selectedParameter = null;
//                               });
//                             }).catchError((error) {
//                               // Handle error
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text('Failed to add data')),
//                               );
//                             });
//                           }
//                         },
//                       ),
//                     ],
//                   );
//                 },
//                 loading: () {
//                   return const Center(child: CircularProgressIndicator());
//                 },
//                 error: (error, stack) {
//                   return Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Lottie.asset('assets/animations/empty_list.json',
//                             height: 200, width: 200),
//                         const Text(
//                           "Nothing to Add",
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }

//   Future<String> _getAuthToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('authToken') ?? '';
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/src/home/view/screens/controller/mandatory_Filed_name_controller.dart';
import 'package:targafy/utils/remote_routes.dart';
import 'package:targafy/widgets/submit_button.dart';

String domain = AppRemoteRoutes.baseUrl;

final parametersProvider = FutureProvider<List<String>>((ref) async {
  final authToken = await SharedPreferenceService().getAuthToken();
  final selectedBusinessData = ref.watch(currentBusinessProvider);
  final businessId = selectedBusinessData?['business']?.id;

  final response = await http.get(
    Uri.parse('${domain}data/get-target-users/$businessId'),
    headers: {
      'Authorization': 'Bearer $authToken',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;
    return List<String>.from(data['data']['paramNames']);
  } else {
    throw Exception('Failed to fetch parameters');
  }
});

final addDataForParameterProvider =
    FutureProvider.autoDispose.family<void, Map<String, dynamic>>(
  (ref, requestData) async {
    final authToken = await SharedPreferenceService().getAuthToken();
    final businessId = requestData['businessId'] as String;
    final parameterName = requestData['parameterName'] as String;
    final todayData = requestData['todayData'] as String;
    final comment = requestData['comment'] as String;

    final response = await http.post(
      Uri.parse('${domain}data/add-data/$businessId/$parameterName'),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'todaysdata': todayData,
        'comment': comment,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add data for parameter: $parameterName');
    }
  },
);

class Addscreen extends ConsumerStatefulWidget {
  const Addscreen({super.key});

  @override
  _AddscreenState createState() => _AddscreenState();
}

class _AddscreenState extends ConsumerState<Addscreen> {
  String? selectedParameter;
  final TextEditingController todayDataController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final parametersAsyncValue = ref.watch(parametersProvider);
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;

    return Scaffold(
      body: businessId == null
          ? Center(
              child: Text(
                'Please select a business',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: parametersAsyncValue.when(
                data: (parameters) {
                  if (parameters.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset('assets/animations/empty_list.json',
                              height: 200, width: 200),
                          const Text(
                            "Nothing to Add",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Add Data',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        hint: const Text('Select Parameter'),
                        value: selectedParameter,
                        onChanged: (value) {
                          setState(() {
                            selectedParameter = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Select Parameter',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        items: parameters
                            .map<DropdownMenuItem<String>>((String parameter) {
                          return DropdownMenuItem<String>(
                            value: parameter,
                            child: Text(parameter),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: todayDataController,
                        decoration: InputDecoration(
                          labelText: 'Today\'s Data',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          labelText: 'Comment',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SubmitButton(
                        onPressed: () {
                          if (selectedParameter != null && businessId != null) {
                            final todayData = todayDataController.text;
                            final comment = commentController.text;
                            ref
                                .read(addDataForParameterProvider({
                              'businessId': businessId,
                              'parameterName': selectedParameter!,
                              'todayData': todayData,
                              'comment': comment,
                            }).future)
                                .then((_) {
                              // Data added successfully
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Data added successfully')),
                              );
                              // Clear the input fields
                              todayDataController.clear();
                              commentController.clear();
                              setState(() {
                                selectedParameter = null;
                              });
                            }).catchError((error) {
                              // Handle error
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Failed to add data')),
                              );
                            });
                          }
                        },
                      ),
                    ],
                  );
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, stack) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset('assets/animations/empty_list.json',
                            height: 200, width: 200),
                        const Text(
                          "Nothing to Add",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
