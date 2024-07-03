// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:targafy/src/auth/view/screens/login_screen.dart';
// import 'package:targafy/src/onBoarding/ui/on_boarding_screen.dart';
// import 'package:targafy/src/services/shared_preference_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final token = await SharedPreferenceService().getAuthToken();
//   bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
//   runApp(ProviderScope(child: MyApp(hasSeenOnboarding: hasSeenOnboarding)));
// }

// class MyApp extends StatelessWidget {
//   final bool hasSeenOnboarding;
//   const MyApp({required this.hasSeenOnboarding, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       // home: const OnBoardingScreen(),
// home: !hasSeenOnboarding
//     ? const OnBoardingScreen()
//     : const LoginScreen(),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:targafy/src/auth/view/screens/login_screen.dart';
import 'package:targafy/src/home/view/screens/widgets/Bottom_navigation_bar.dart';
import 'package:targafy/src/onBoarding/ui/on_boarding_screen.dart';
import 'package:targafy/src/services/shared_preference_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final token = await SharedPreferenceService().getAuthToken();
//   bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
//   final expiryTime = prefs.getInt('expiryTime') ?? 0;
//   final isTokenValid = DateTime.now().millisecondsSinceEpoch < expiryTime;
//   print(token);
//   runApp(ProviderScope(
//       child: MyApp(
//     token: token,
//     hasSeenOnboarding: hasSeenOnboarding,
//     isTokenValid: isTokenValid,
//   )));

//   // runApp(ResettableProviderScope(
//   //     child: MyApp(
//   //   hasSeenOnboarding: hasSeenOnboarding,
//   //   isTokenValid: isTokenValid,
//   // )));
// }

// class MyApp extends StatelessWidget {
//   final bool hasSeenOnboarding;
//   final bool isTokenValid;
//   final String? token;

//   const MyApp({
//     Key? key,
//     required this.hasSeenOnboarding,
//     required this.isTokenValid,
//     this.token,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: !hasSeenOnboarding
//           ? const OnBoardingScreen()
//           : isTokenValid
//               ? BottomNavigationAndAppBar(
//                   token: token,
//                 )
//               : const LoginScreen(),
//       // home: !hasSeenOnboarding ? const OnBoardingScreen() : const LoginScreen(),
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:targafy/src/auth/view/screens/login_screen.dart';
import 'package:targafy/src/home/view/screens/widgets/Bottom_navigation_bar.dart';
import 'package:targafy/src/onBoarding/ui/on_boarding_screen.dart';
import 'package:targafy/src/services/shared_preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = await SharedPreferenceService().getAuthToken();
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  final expiryTime = prefs.getInt('expiryTime') ?? 0;
  final isTokenValid = DateTime.now().millisecondsSinceEpoch < expiryTime;
  print(token);
  runApp(ProviderScope(
      child: MyApp(
    token: token,
    hasSeenOnboarding: hasSeenOnboarding,
    isTokenValid: isTokenValid,
  )));
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;
  final bool isTokenValid;
  final String? token;

  const MyApp({
    Key? key,
    required this.hasSeenOnboarding,
    required this.isTokenValid,
    this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('This is the token in main page:- $token');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: !hasSeenOnboarding
          ? const OnBoardingScreen()
          : (token == null || !isTokenValid)
              ? const LoginScreen()
              : BottomNavigationAndAppBar(
                  token: token,
                ),
    );
  }
}

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) async {
    try {
      print("In Notification method");
      // int id = DateTime.now().microsecondsSinceEpoch ~/1000000;
      // Random random = new Random();
      // int id = random.nextInt(1000);
      int id = 1;
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "channelId",
        "my chanel",
        importance: Importance.max,
        priority: Priority.high,
      ));
      print("my id is ${id.toString()}");
      await _flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print('Error>>>$e');
    }
  }
}
