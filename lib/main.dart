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
import 'package:flutter/foundation.dart';
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

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // await handleNotification();
  print("Handling a background message: ${message.toMap()}");
  // Handle the message
  // if (message.notification != null) {
  //   if (message.notification!.body!.contains("Alarm")) {
  //     Alarmplayer alarmplayer = Alarmplayer();
  //     alarmplayer.Alarm(
  //         url: "assets/notify.mp3", // Path of sound file.
  //         volume: 1, // optional, set the volume, default 1.
  //         looping: true, // optional, if you want to loop you're alarm or not
  //         callback: () // this is the callback, it's getting executed if you're alarm
  //             =>
  //             {
  //               print("i'm done!")
  //             } // is done playing. Note if you're alarm is on loop you're callback won't be executed
  //         );

  //     Future.delayed(const Duration(seconds: 15), () => alarmplayer.StopAlarm());
  //   }
  print('Notification Title: ${message.notification!.title}');
  print('Notification Body: ${message.notification!.body}');
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
    alert: true,
    badge: true,
    sound: false,
  );

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //   print('Got a message whilst in the foreground!');
  //   print('Message Firebase data: ${message.data}');

  //   if (message.notification != null) {
  //     print('Notification Title: ${message.notification!.title}');
  //     print("Notification MessageId:${message.messageId}");
  //     print("Notification Message Category:${message.category}");
  //     print("Notification Message CollapseKey:${message.collapseKey}");
  //     print("Notification Message From:${message.from}");
  //     print("Notification Message ThreadId:${message.threadId}");
  //     print('Notification Body: ${message.notification!.body}');
  //     print('Notification Data: ${message.data}');
  //     print('Notification Data: ${message.data['issueId']}');
  //     print('Notification Data: ${message.data['businessId']}');
  //   }
  // });
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
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = await SharedPreferenceService().getAuthToken();
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  final expiryTime = prefs.getInt('expiryTime') ?? 0;
  final isTokenValid = DateTime.now().millisecondsSinceEpoch < expiryTime;
  print(token);
  if (!kIsWeb) {
    await handleNotification();
  }
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
