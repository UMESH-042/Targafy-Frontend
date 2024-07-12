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
  // await handleNotification();

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

Future<void> handleNotification() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    enableVibration: true,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: false);

  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launcher_icon', // Make sure this matches your icon name
        ),
      ),
    );
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await handleNotification();
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = await SharedPreferenceService().getAuthToken();
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  final expiryTime = prefs.getInt('expiryTime') ?? 0;
  final isTokenValid = DateTime.now().millisecondsSinceEpoch < expiryTime;
  print(token);

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      showFlutterNotification(message);

      debugPrint("this is alarm in terminated: ${message}");

      // if (message.notification != null) {
      //   final notificationBody = message.notification!.body ?? '';
      //   if (notificationBody.contains("Alarm")) {
      //     Alarmplayer alarmplayer = Alarmplayer();
      //     alarmplayer.Alarm(
      //         url: "assets/notify.mp3",
      //         volume: 1,
      //         looping: true,
      //         callback: () {
      //           print("Alarm done!");
      //         });

      //     Future.delayed(const Duration(seconds: 15), () => alarmplayer.StopAlarm());
      //   }
      // }
    }
  });

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
