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
//     print('This is the token in main page:- $token');
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: !hasSeenOnboarding
//           ? const OnBoardingScreen()
//           : (token == null || !isTokenValid)
//               ? const LoginScreen()
//               : BottomNavigationAndAppBar(
//                   token: token,
//                 ),
//     );
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:targafy/utils/notificationservices.dart';
import 'package:targafy/utils/socketsServices.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:targafy/src/auth/view/screens/login_screen.dart';
import 'package:targafy/src/home/view/screens/widgets/Bottom_navigation_bar.dart';
import 'package:targafy/src/onBoarding/ui/on_boarding_screen.dart';
import 'package:targafy/src/services/shared_preference_service.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: firebaseOptions);
//   print("Handling a background message: ${message.messageId}");
// }

late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: firebaseOptions,
  );

  print("this is alarm in background : ${message.toMap()}");

  // if (message.notification != null) {
  //   final notificationBody = message.notification!.body ?? '';
  //   if (notificationBody.contains("Alarm")) {
  //     // Handle alarm here
  //     Alarmplayer alarmplayer = Alarmplayer();
  //     alarmplayer.Alarm(
  //         url: "assets/notify.mp3", // Path of sound file.
  //         volume: 1, // optional, set the volume, default 1.
  //         looping: true, // optional, if you want to loop your alarm or not
  //         callback: () {
  //           print("Alarm done!");
  //         });

  //     // Delayed stop after 15 seconds (adjust as needed)
  //     Future.delayed(const Duration(seconds: 2), () => alarmplayer.StopAlarm());
  //   }

  //   print('Notification Title: ${message.notification!.title}');
  //   print('Notification Body: $notificationBody');
  // }
}

RemoteMessage createRemoteMessageFromData(Map<String, dynamic> data) {
  return RemoteMessage(
    notification: RemoteNotification(
      title: 'Targafy',
      body: data['content'],
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: firebaseOptions);

  MessagingSocketService.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = await SharedPreferenceService().getAuthToken();
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  final isTokenValid = true;
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
