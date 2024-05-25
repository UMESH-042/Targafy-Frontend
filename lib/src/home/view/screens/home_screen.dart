// ignore_for_file: avoid_print, unused_field

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/core/constants/colors.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/src/home/view/screens/widgets/CustomCharts.dart';
import 'package:targafy/src/home/view/screens/widgets/GraphicalStatistics.dart';
import 'package:targafy/src/home/view/widgets/selectable_chart.dart';
import 'package:targafy/src/home/view/widgets/selectable_parameter.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  final int _selectedIndex = 0;
  List<String> images = [
    'assets/img/line_chart.png',
    'assets/img/table.png',
    'assets/img/chat.png',
    'assets/img/pie.png',
    'assets/img/lines.png'
  ];
  List<String> parameters = [
    'Sales',
    'Revenue',
    'Items Sold',
    'Margins',
    'Secondary Sales'
  ];

  List<List<List<dynamic>>> actualData = [
    // Actual data for Sales
    [
      ['Jan', 35],
      ['Feb', 28],
      ['Mar', 34],
      ['Apr', 32],
      ['May', 40],
    ],
    // Actual data for Revenue
    [
      ['Jan', 1000],
      ['Feb', 1200],
      ['Mar', 1050],
      ['Apr', 1300],
      ['May', 1100],
    ],
    // Actual data for Items Sold
    [
      ['Jan', 500],
      ['Feb', 550],
      ['Mar', 480],
      ['Apr', 600],
      ['May', 520],
    ],
    // Actual data for Margins
    [
      ['Jan', 20],
      ['Feb', 22],
      ['Mar', 18],
      ['Apr', 24],
      ['May', 21],
    ],
    // Actual data for Secondary Sales
    [
      ['Jan', 200],
      ['Feb', 180],
      ['Mar', 220],
      ['Apr', 210],
      ['May', 190],
    ],
  ];

  List<List<List<dynamic>>> predictedData = [
    // Predicted data for Sales
    [
      ['Jan', 15],
      ['Feb', 20],
      ['Mar', 35],
      ['Apr', 40],
      ['May', 50],
    ],
    // Predicted data for Revenue
    [
      ['Jan', 1100],
      ['Feb', 1000],
      ['Mar', 1150],
      ['Apr', 1050],
      ['May', 1200],
    ],
    // Predicted data for Items Sold
    [
      ['Jan', 600],
      ['Feb', 650],
      ['Mar', 580],
      ['Apr', 700],
      ['May', 620],
    ],
    // Predicted data for Margins
    [
      ['Jan', 22],
      ['Feb', 20],
      ['Mar', 24],
      ['Apr', 26],
      ['May', 23],
    ],
    // Predicted data for Secondary Sales
    [
      ['Jan', 190],
      ['Feb', 200],
      ['Mar', 180],
      ['Apr', 210],
      ['May', 195],
    ],
  ];
  late List<bool> selectedStates;
  late List<bool> selectedParameters;
  String selectedParameter = '';

  @override
  void initState() {
    super.initState();
    selectedStates = List<bool>.filled(images.length, false);
    selectedParameters = List<bool>.filled(parameters.length, false);
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

  void handleTapForParameters(int index) {
    setState(() {
      for (int i = 0; i < selectedParameters.length; i++) {
        if (i != index) {
          selectedParameters[i] = false;
        }
      }
      selectedParameters[index] = !selectedParameters[index];
      if (selectedParameters[index]) {
        selectedParameter = parameters[index];
      } else {
        selectedParameter = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: getScreenheight(context) * 0.04,
            margin: EdgeInsets.symmetric(
                    horizontal: getScreenWidth(context) * 0.035)
                .copyWith(top: getScreenheight(context) * 0.03),
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
          Container(
            height: getScreenheight(context) * 0.04,
            margin: EdgeInsets.symmetric(
                    horizontal: getScreenWidth(context) * 0.035)
                .copyWith(top: getScreenheight(context) * 0.01),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: parameters.length,
              itemBuilder: (context, index) {
                return SelectableParameterWidget(
                  text: parameters[index],
                  isSelected: selectedParameters[index],
                  onTap: () => handleTapForParameters(index),
                );
              },
            ),
          ),
          SizedBox(
            height: getScreenheight(context) * 0.04,
          ),
          if (selectedStates[0] && parameters.isNotEmpty)
            for (int i = 0; i < parameters.length; i++)
              if (selectedParameters[i])
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomChart(
                    parameter: parameters[i],
                    actualData: actualData[i],
                    predictedData: predictedData[i],
                  ),
                ),
          if (selectedStates[0] &&
              !selectedParameters.any((element) => element))
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomChart(
                parameter: '',
                actualData: [],
                predictedData: [],
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor), // Border color
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8), // Add padding here
                    child: Text(
                      'Why the target is not Completed?',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_sharp, color: primaryColor),
              ],
            ),
          ),
          SizedBox(
            height: getScreenheight(context) * 0.04,
          ),
          if (selectedStates[0] && parameters.isNotEmpty)
            for (int i = 0; i < parameters.length; i++)
              if (selectedParameters[i])
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Graphicalstatistics(
                    parameter: parameters[i],
                    actualData: actualData[i],
                    predictedData: predictedData[i],
                  ),
                ),
          if (selectedStates[0] &&
              !selectedParameters.any((element) => element))
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Graphicalstatistics(
                parameter: '',
                actualData: [],
                predictedData: [],
              ),
            ),
        ],
      ),
    ));
  }
}
