// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/core/constants/colors.dart';
// import 'package:targafy/core/constants/dimensions.dart';
// import 'package:targafy/src/home/view/screens/widgets/CustomCharts.dart';
// import 'package:targafy/src/home/view/screens/widgets/DataTable.dart';
// import 'package:targafy/src/home/view/screens/widgets/GraphicalStatistics.dart';
// import 'package:targafy/src/home/view/screens/widgets/PieChart.dart';
// import 'package:targafy/src/home/view/widgets/selectable_chart.dart';
// import 'package:targafy/src/home/view/widgets/selectable_parameter.dart';
// import 'package:http/http.dart' as http;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
// Future<void> _getToken() async {
//   try {
//     // Fetch the FCM token
//     String? fcmToken = await FirebaseMessaging.instance.getToken();
//     print('FCM Token: $fcmToken');

//     // Retrieve the bearer token from shared preferences
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? bearerToken = prefs.getString('authToken');

//     // Ensure both tokens are available
//     if (fcmToken != null && bearerToken != null) {
//       // Make a POST request to your server
//       await _sendTokenToServer(fcmToken, bearerToken);
//     } else {
//       print('Failed to retrieve FCM token or bearer token.');
//     }
//   } catch (e) {
//     print('Error fetching token: $e');
//   }
// }

// Future<void> _sendTokenToServer(String fcmToken, String bearerToken) async {
//   try {
//     // Define the URL of your server endpoint
//     final url = Uri.parse(
//         'http://13.234.163.59:5000/api/v1/user/update/fcmToken?fcmToken=$fcmToken');

//     // Make the POST request
//     final response = await http.patch(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $bearerToken',
//       },
//     );

//     // Check the response status
//     if (response.statusCode == 200) {
//       print('Token sent successfully.');
//     } else {
//       print('Failed to send token: ${response.statusCode} ${response.body}');
//     }
//   } catch (e) {
//     print('Error sending token to server: $e');
//   }
// }

//   final int _selectedIndex = 0;
// List<String> images = [
//   'assets/img/line_chart.png',
//   'assets/img/table.png',
//   'assets/img/chat.png',
//   'assets/img/pie.png',
//   'assets/img/lines.png'
// ];
//   List<String> parameters = [
//     'Sales',
//     'Revenue',
//     'Items Sold',
//     'Margins',
//     'Secondary Sales'
//   ];

//   List<List<List<dynamic>>> actualData = [
//     // Actual data for Sales
//     [
//       ['Jan', 35],
//       ['Feb', 28],
//       ['Mar', 34],
//       ['Apr', 32],
//       ['May', 40],
//     ],
//     // Actual data for Revenue
//     [
//       ['Jan', 1000],
//       ['Feb', 1200],
//       ['Mar', 1050],
//       ['Apr', 1300],
//       ['May', 1100],
//     ],
//     // Actual data for Items Sold
//     [
//       ['Jan', 500],
//       ['Feb', 550],
//       ['Mar', 480],
//       ['Apr', 600],
//       ['May', 520],
//     ],
//     // Actual data for Margins
//     [
//       ['Jan', 20],
//       ['Feb', 22],
//       ['Mar', 18],
//       ['Apr', 24],
//       ['May', 21],
//     ],
//     // Actual data for Secondary Sales
//     [
//       ['Jan', 200],
//       ['Feb', 180],
//       ['Mar', 220],
//       ['Apr', 210],
//       ['May', 190],
//     ],
//   ];

//   List<List<List<dynamic>>> predictedData = [
//     // Predicted data for Sales
//     [
//       ['Jan', 15],
//       ['Feb', 20],
//       ['Mar', 35],
//       ['Apr', 40],
//       ['May', 50],
//     ],
//     // Predicted data for Revenue
//     [
//       ['Jan', 1100],
//       ['Feb', 1000],
//       ['Mar', 1150],
//       ['Apr', 1050],
//       ['May', 1200],
//     ],
//     // Predicted data for Items Sold
//     [
//       ['Jan', 600],
//       ['Feb', 650],
//       ['Mar', 580],
//       ['Apr', 700],
//       ['May', 620],
//     ],
//     // Predicted data for Margins
//     [
//       ['Jan', 22],
//       ['Feb', 20],
//       ['Mar', 24],
//       ['Apr', 26],
//       ['May', 23],
//     ],
//     // Predicted data for Secondary Sales
//     [
//       ['Jan', 190],
//       ['Feb', 200],
//       ['Mar', 180],
//       ['Apr', 210],
//       ['May', 195],
//     ],
//   ];

// late List<bool> selectedStates;
//   late List<bool> selectedParameters;
//   String selectedParameter = '';

//   @override
//   void initState() {
//     super.initState();
//     selectedStates = List<bool>.filled(images.length, false);
//     selectedParameters = List<bool>.filled(parameters.length, false);
//     _getToken();
//   }

//   void handleTapForCharts(int index) {
//     setState(() {
//       for (int i = 0; i < selectedStates.length; i++) {
//         if (i != index) {
//           selectedStates[i] = false;
//         }
//       }
//       selectedStates[index] = !selectedStates[index];
//     });
//   }

//   void handleTapForParameters(int index) {
//     setState(() {
//       for (int i = 0; i < selectedParameters.length; i++) {
//         if (i != index) {
//           selectedParameters[i] = false;
//         }
//       }
//       selectedParameters[index] = !selectedParameters[index];
//       if (selectedParameters[index]) {
//         selectedParameter = parameters[index];
//       } else {
//         selectedParameter = '';
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
// Container(
//   height: getScreenheight(context) * 0.04,
//   margin: EdgeInsets.symmetric(
//           horizontal: getScreenWidth(context) * 0.035)
//       .copyWith(top: getScreenheight(context) * 0.03),
//   child: ListView.builder(
//     scrollDirection: Axis.horizontal,
//     itemCount: images.length,
//     itemBuilder: (context, index) {
//       return SelectableChartWidget(
//         imagePath: images[index],
//         isSelected: selectedStates[index],
//         onTap: () => handleTapForCharts(index),
//       );
//     },
//   ),
// ),
// Container(
//   height: getScreenheight(context) * 0.04,
//   margin: EdgeInsets.symmetric(
//           horizontal: getScreenWidth(context) * 0.035)
//       .copyWith(top: getScreenheight(context) * 0.01),
//   child: ListView.builder(
//     scrollDirection: Axis.horizontal,
//     itemCount: parameters.length,
//     itemBuilder: (context, index) {
//       return SelectableParameterWidget(
//         text: parameters[index],
//         isSelected: selectedParameters[index],
//         onTap: () => handleTapForParameters(index),
//       );
//     },
//   ),
//             ),
//             SizedBox(
//               height: getScreenheight(context) * 0.04,
//             ),
//             if (selectedStates[0] && parameters.isNotEmpty)
//               for (int i = 0; i < parameters.length; i++)
//                 if (selectedParameters[i])
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: CustomChart(
//                       parameter: parameters[i],
//                       actualData: actualData[i],
//                       predictedData: predictedData[i],
//                     ),
//                   ),
//             if (selectedStates[0] &&
//                 !selectedParameters.any((element) => element))
// const Padding(
//   padding: EdgeInsets.all(8.0),
//   child: CustomChart(
//     parameter: '',
//     actualData: [],
//     predictedData: [],
//   ),
// ),
//             Container(
//               margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 border: Border.all(color: primaryColor), // Border color
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.all(8), // Add padding here
//                       child: Text(
//                         'Why the target is not Completed?',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ),
//                   Icon(Icons.arrow_forward_sharp, color: primaryColor),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: getScreenheight(context) * 0.04,
//             ),
//             if (selectedStates[0] && parameters.isNotEmpty)
//               for (int i = 0; i < parameters.length; i++)
//                 if (selectedParameters[i])
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Graphicalstatistics(
//                       parameter: parameters[i],
//                       actualData: actualData[i],
//                       predictedData: predictedData[i],
//                     ),
//                   ),
//             if (selectedStates[0] &&
//                 !selectedParameters.any((element) => element))
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Graphicalstatistics(
//                   parameter: '',
//                   actualData: [],
//                   predictedData: [],
//                 ),
//               ),
//           ],
//         ),
//       )
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/business_controller.dart';
// import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';
// import 'package:targafy/src/parameters/view/model/parameter_model.dart'; // Import your parameter model

// final selectedBusinessData = Provider<Map<String, dynamic>?>((ref) {
//   return ref.watch(currentBusinessProvider);
// });

// final parameterListProvider =
//     FutureProvider.autoDispose<List<Parameter>>((ref) async {
//   final selectedBusinessData = ref.watch(currentBusinessProvider);
//   final businessId = selectedBusinessData?['business']?.id;

//   if (businessId != null) {
//     final notifier = ref.read(parameterNotifierProvider.notifier);
//     await notifier.fetchParameters(businessId);
//     return ref.watch(parameterNotifierProvider);
//   } else {
//     return <Parameter>[];
//   }
// });

// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final parameterListAsync = ref.watch(parameterListProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Parameter List'),
//       ),
//       body: parameterListAsync.when(
//         data: (parameterList) {
//           return ListView.builder(
//             itemCount: parameterList.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(parameterList[index].name),
//                 // Add more details or actions if needed
//               );
//             },
//           );
//         },
//         loading: () => Center(child: CircularProgressIndicator()),
//         error: (error, stackTrace) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/business_home_page/controller/business_controller.dart';
import 'package:targafy/src/home/view/screens/controller/actual_predicted_data_controller.dart';
import 'package:targafy/src/home/view/screens/widgets/CustomCharts.dart';
import 'package:targafy/src/home/view/screens/widgets/DataTable.dart';
import 'package:targafy/src/home/view/screens/widgets/PieChart.dart';
import 'package:targafy/src/home/view/widgets/selectable_chart.dart';
import 'package:targafy/src/home/view/widgets/selectable_parameter.dart';
import 'package:targafy/src/parameters/view/controller/add_parameter_controller.dart';
import 'package:targafy/src/parameters/view/model/parameter_model.dart';

final selectedBusinessData = Provider<Map<String, dynamic>?>((ref) {
  return ref.watch(currentBusinessProvider);
});

final parameterListProvider =
    FutureProvider.autoDispose<List<Parameter>>((ref) async {
  final selectedBusinessData = ref.watch(currentBusinessProvider);
  final businessId = selectedBusinessData?['business']?.id;

  if (businessId != null) {
    final notifier = ref.read(parameterNotifierProvider.notifier);
    await notifier.fetchParameters(businessId);
    return ref.watch(parameterNotifierProvider);
  } else {
    return <Parameter>[];
  }
});

final dataAddedControllerProvider =
    Provider<DataAddedController>((ref) => DataAddedController());

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> _getToken() async {
    try {
      // Fetch the FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print('FCM Token: $fcmToken');

      // Retrieve the bearer token from shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? bearerToken = prefs.getString('authToken');

      // Ensure both tokens are available
      if (fcmToken != null && bearerToken != null) {
        // Make a POST request to your server
        await _sendTokenToServer(fcmToken, bearerToken);
      } else {
        print('Failed to retrieve FCM token or bearer token.');
      }
    } catch (e) {
      print('Error fetching token: $e');
    }
  }

  Future<void> _sendTokenToServer(String fcmToken, String bearerToken) async {
    try {
      // Define the URL of your server endpoint
      final url = Uri.parse(
          'http://13.234.163.59:5000/api/v1/user/update/fcmToken?fcmToken=$fcmToken');

      // Make the POST request
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        print('Token sent successfully.');
      } else {
        print('Failed to send token: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error sending token to server: $e');
    }
  }

  static const List<String> images = [
    'assets/img/line_chart.png',
    'assets/img/table.png',
    'assets/img/chat.png',
    'assets/img/pie.png',
    'assets/img/lines.png'
  ];

  late List<bool> selectedStates;
  late String selectedParameter; // Store the selected parameter name here

  @override
  void initState() {
    super.initState();
    selectedStates = List<bool>.filled(images.length, false);
    selectedParameter = ''; // Initialize selected parameter to empty string
    _getToken();
  }

  void handleTapForCharts(int index) {
    setState(() {
      for (int i = 0; i < selectedStates.length; i++) {
        if (i != index) {
          selectedStates[i] = false;
        }
      }
      selectedStates[index] = !selectedStates[index];
    });
  }

  void _handleTapForParameters(String parameterName) {
    setState(() {
      selectedParameter =
          selectedParameter == parameterName ? '' : parameterName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final parameterListAsync = ref.watch(parameterListProvider);
    final dataAddedController = ref.read(dataAddedControllerProvider);
    final selectedBusinessData = ref.watch(currentBusinessProvider);
    final businessId = selectedBusinessData?['business']?.id;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.035,
            ).copyWith(
              top: MediaQuery.of(context).size.height * 0.03,
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return SelectableChartWidget(
                  imagePath: images[index],
                  isSelected: selectedStates[index],
                  onTap: () => handleTapForCharts(index),
                );
              },
            ),
          ),
          parameterListAsync.when(
            data: (parameterList) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.04,
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.035,
                ).copyWith(
                  top: MediaQuery.of(context).size.height * 0.01,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: parameterList.length,
                  itemBuilder: (context, index) {
                    final parameterName = parameterList[index].name;
                    return SelectableParameterWidget(
                      text: parameterName,
                      isSelected: parameterName == selectedParameter,
                      onTap: () => _handleTapForParameters(parameterName),
                    );
                  },
                ),
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          ),
          if (selectedStates.isNotEmpty &&
              selectedStates[0] &&
              selectedParameter.isEmpty)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomChart(
                parameter: '',
                actualData: [],
                predictedData: [],
              ),
            ),
          if (selectedStates.isNotEmpty &&
              selectedStates[0] &&
              selectedParameter.isNotEmpty)
            FutureBuilder(
              future: dataAddedController.fetchDataAdded(
                  businessId, selectedParameter),
              builder: (context,
                  AsyncSnapshot<Map<String, List<List<dynamic>>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final data = snapshot.data!;
                  print(data);
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomChart(
                      parameter: selectedParameter,
                      actualData: data['userEntries'] ?? [],
                      predictedData: data['dailyTarget'] ?? [],
                    ),
                  );
                }
              },
            ),
          if (selectedStates.isNotEmpty &&
              selectedStates[3] &&
              selectedParameter.isNotEmpty)
            FutureBuilder(
              future: dataAddedController.fetchDataAdded(
                  businessId, selectedParameter),
              builder: (context,
                  AsyncSnapshot<Map<String, List<List<dynamic>>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final data = snapshot.data!;
                  print(data);
                  return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: PiechartGraph(
                        parameter: selectedParameter,
                        actualData: data['userEntries'] ?? [],
                      ));
                }
              },
            ),
          if (selectedStates.isNotEmpty &&
              selectedStates[1] &&
              selectedParameter.isNotEmpty)
            FutureBuilder(
              future: dataAddedController.fetchDataAdded(
                  businessId, selectedParameter),
              builder: (context,
                  AsyncSnapshot<Map<String, List<List<dynamic>>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final data = snapshot.data!;
                  print(data);
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DataTableWidget(
                        parameter: selectedParameter,
                        actualData: data['userEntries'] ?? [],
                        predictedData: data['dailyTarget'] ?? []),
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}
