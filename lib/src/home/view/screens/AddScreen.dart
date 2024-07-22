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
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/src/home/view/screens/controller/mandatory_Filed_name_controller.dart';
import 'package:targafy/utils/remote_routes.dart';
import 'package:targafy/widgets/custom_dropdown_field.dart';
import 'package:targafy/widgets/custom_text_field.dart';
import 'package:targafy/widgets/sort_dropdown_list.dart';
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
//     print(response.body);

//     if (response.statusCode == 400) {
//       throw Exception('You have already added the data for today');
//     } else if (response.statusCode != 201) {
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
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Scaffold(
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
//                   final sortedParameters =
//                       sortList(parameters, (parameter) => parameter);
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
//                       SizedBox(height: height * 0.03),
//                       CustomDropdownField(
//                         labelText: 'Select Parameter',
//                         value: selectedParameter,
//                         onChanged: (value) {
//                           setState(() {
//                             selectedParameter = value;
//                           });
//                         },
//                         items: sortedParameters
//                             .map<DropdownMenuItem<String>>((String parameter) {
//                           return DropdownMenuItem<String>(
//                             value: parameter,
//                             child: Text(parameter),
//                           );
//                         }).toList(),
//                       ),
//                       SizedBox(height: height * 0.03),
//                       CustomInputField(
//                         labelText: 'Today\'s Data',
//                         controller: todayDataController,
//                         keyboardType: TextInputType.number,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please add data for given Selected Parameter';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: height * 0.03),
//                       CustomInputField(
//                         labelText: 'Comment',
//                         controller: commentController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please add comments';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: height * 0.05),
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
//                             }).catchError((e) {
//                               // print(error);
//                               // // Handle error
//                               // ScaffoldMessenger.of(context).showSnackBar(
//                               //   const SnackBar(
//                               //       content: Text('Failed to add data')),
//                               // );
//                               if (e.toString().contains(
//                                   'You have already added the data for today')) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content: Text(
//                                           'You have already added the data for today')),
//                                 );
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text('Failed to add data')),
//                                 );
//                               }
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
// }

// final addDataForParametersProvider =
//     FutureProvider.autoDispose.family<void, Map<String, dynamic>>(
//   (ref, requestData) async {
//     final authToken = await SharedPreferenceService().getAuthToken();
//     final businessId = requestData['businessId'] as String;
//     final date = requestData['date'] as String;
//     final userData = requestData['userData'] as List<Map<String, String>>;
//     print(userData);
//     print(date);
//     final response = await http.post(
//       Uri.parse('${domain}data/add-test-data/$businessId'),
//       headers: {
//         'Authorization': 'Bearer $authToken',
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'userData': userData,
//         'date': date,
//       }),
//     );
//     print(response.body);
//     if (response.statusCode != 201) {
//       throw Exception('Failed to add data for parameters');
//     }
//   },
// );

// class Addscreen extends ConsumerStatefulWidget {
//   const Addscreen({super.key});

//   @override
//   _AddscreenState createState() => _AddscreenState();
// }

// class _AddscreenState extends ConsumerState<Addscreen> {
//   final Map<String, TextEditingController> dataControllers = {};
//   final Map<String, TextEditingController> commentControllers = {};
//   String? selectedDate;

//   @override
//   void dispose() {
//     dataControllers.forEach((_, controller) => controller.dispose());
//     commentControllers.forEach((_, controller) => controller.dispose());
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final parametersAsyncValue = ref.watch(parametersProvider);
//     final selectedBusinessData = ref.watch(currentBusinessProvider);
//     final businessId = selectedBusinessData?['business']?.id;
//     double height = MediaQuery.of(context).size.height;

//     return Scaffold(
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

//                   final sortedParameters =
//                       sortList(parameters, (parameter) => parameter);

//                   for (var parameter in sortedParameters) {
//                     dataControllers.putIfAbsent(
//                         parameter, () => TextEditingController());
//                     commentControllers.putIfAbsent(
//                         parameter, () => TextEditingController());
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
//                       SizedBox(height: height * 0.03),
//                       ElevatedButton(
//                         onPressed: () async {
//                           final DateTime? pickedDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2101),
//                           );

//                           if (pickedDate != null) {
//                             setState(() {
//                               selectedDate =
//                                   "${pickedDate.toLocal()}".split(' ')[0];
//                             });
//                           }
//                         },
//                         child: Text(
//                           selectedDate == null
//                               ? 'Select Date'
//                               : 'Date: $selectedDate',
//                         ),
//                       ),
//                       SizedBox(height: height * 0.03),
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: sortedParameters.length,
//                           itemBuilder: (context, index) {
//                             final parameter = sortedParameters[index];
//                             return Card(
//                               elevation: 4.0,
//                               margin: const EdgeInsets.symmetric(vertical: 8.0),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: Text(
//                                             parameter,
//                                             style: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: CustomInputField(
//                                             labelText: 'Enter Data',
//                                             controller:
//                                                 dataControllers[parameter]!,
//                                             keyboardType: TextInputType.number,
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty) {
//                                                 return 'Please enter data';
//                                               }
//                                               return null;
//                                             },
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 10),
//                                     CustomInputField(
//                                       labelText: 'Comment',
//                                       controller:
//                                           commentControllers[parameter]!,
//                                       validator: (value) {
//                                         if (value == null || value.isEmpty) {
//                                           return 'Please enter a comment';
//                                         }
//                                         return null;
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       SizedBox(height: height * 0.05),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: SubmitButton(
//                           onPressed: () {
//                             if (selectedDate != null && businessId != null) {
//                               final userData =
//                                   sortedParameters.map((parameter) {
//                                 return {
//                                   'paramName': parameter,
//                                   'todaysdata':
//                                       dataControllers[parameter]!.text,
//                                   'comment':
//                                       commentControllers[parameter]!.text,
//                                 };
//                               }).toList();
//                               print(userData);
//                               print(selectedDate);
//                               ref
//                                   .read(addDataForParametersProvider({
//                                 'businessId': businessId,
//                                 'date': selectedDate!,
//                                 'userData': userData,
//                               }).future)
//                                   .then((_) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text('Data added successfully')),
//                                 );

//                                 for (var controller in dataControllers.values) {
//                                   controller.clear();
//                                 }
//                                 for (var controller
//                                     in commentControllers.values) {
//                                   controller.clear();
//                                 }
//                                 setState(() {
//                                   selectedDate = null;
//                                 });
//                               }).catchError((error) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text('Failed to add data')),
//                                 );
//                               });
//                             }
//                           },
//                         ),
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
// }

// Add your providers and services here

final addDataForParametersProvider =
    FutureProvider.autoDispose.family<void, Map<String, dynamic>>(
  (ref, requestData) async {
    final authToken = await SharedPreferenceService().getAuthToken();
    final businessId = requestData['businessId'] as String;
    final date = requestData['date'] as String;
    final userData = requestData['userData'] as List<Map<String, String>>;
    print(userData);
    print(date);
    final response = await http.post(
      Uri.parse('${domain}data/add-test-data/$businessId'),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'userData': userData,
        'date': date,
      }),
    );
    print(response.body);
    if (response.statusCode != 201) {
      throw Exception('Failed to add data for parameters');
    }
  },
);

class Addscreen extends ConsumerStatefulWidget {
  const Addscreen({super.key});

  @override
  _AddscreenState createState() => _AddscreenState();
}

class _AddscreenState extends ConsumerState<Addscreen> {
  final Map<String, TextEditingController> dataControllers = {};
  final Map<String, TextEditingController> commentControllers = {};
  String? selectedDate;
  
  @override
  void initState() {
    super.initState();
    selectedDate = "${DateTime.now().toLocal()}".split(' ')[0];
  }

  @override
  void dispose() {
    dataControllers.forEach((_, controller) => controller.dispose());
    commentControllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parametersAsyncValue = ref.watch(parametersProvider);
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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

                  final sortedParameters =
                      sortList(parameters, (parameter) => parameter);

                  for (var parameter in sortedParameters) {
                    dataControllers.putIfAbsent(
                        parameter, () => TextEditingController());
                    commentControllers.putIfAbsent(
                        parameter, () => TextEditingController());
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Add Data',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: height * 0.03),
                      Container(
                        width: width * 0.5,
                        child: ElevatedButton(
                          onPressed: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                selectedDate =
                                    "${pickedDate.toLocal()}".split(' ')[0];
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor),
                          child: Text(
                            selectedDate == null
                                ? 'Select Date'
                                : 'Date: $selectedDate',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Expanded(
                        child: ListView.builder(
                          itemCount: sortedParameters.length,
                          itemBuilder: (context, index) {
                            final parameter = sortedParameters[index];
                            return Card(
                              elevation: 4.0,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            parameter,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomInputField(
                                            labelText: 'Enter Data',
                                            controller:
                                                dataControllers[parameter]!,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    CustomInputField(
                                      labelText: 'Comment',
                                      controller:
                                          commentControllers[parameter]!,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SubmitButton(
                          onPressed: () {
                            if (selectedDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please select a date before submitting'),
                                ),
                              );
                              return;
                            }

                            if (selectedDate != null && businessId != null) {
                              final userData = sortedParameters
                                  .where((parameter) =>
                                      dataControllers[parameter]!
                                          .text
                                          .isNotEmpty)
                                  .map((parameter) {
                                return {
                                  'paramName': parameter,
                                  'todaysdata':
                                      dataControllers[parameter]!.text,
                                  'comment':
                                      commentControllers[parameter]!.text,
                                };
                              }).toList();

                              if (userData.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please enter data for at least one parameter'),
                                  ),
                                );
                                return;
                              }

                              ref
                                  .read(addDataForParametersProvider({
                                'businessId': businessId,
                                'date': selectedDate!,
                                'userData': userData,
                              }).future)
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Data added successfully')),
                                );

                                for (var controller in dataControllers.values) {
                                  controller.clear();
                                }
                                for (var controller
                                    in commentControllers.values) {
                                  controller.clear();
                                }
                                setState(() {
                                  selectedDate = null;
                                });
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Failed to add data')),
                                );
                              });
                            }
                          },
                        ),
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
