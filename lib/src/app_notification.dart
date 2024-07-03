import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  // initialize notification service
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future firebaseNotificationsInit() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      announcement: true,
      provisional: true,
      criticalAlert: true,
      carPlay: true,
      sound: true,
    );
    var token = await _firebaseMessaging.getToken();
    //debugPrint('Firebase Device Token: $token');
  }

  static Future localnotificationsInit() async {
    // android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo'); //'@mipmap/ic_launcher' or 'logo

    // ios
    DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) {
      //debugPrint('onDidReceiveLocalNotification');
    });

    // initialization settings android and ios.
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: darwinInitializationSettings);
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onBackground,
        onDidReceiveNotificationResponse: onResponse);
  }

  static void onBackground(NotificationResponse details) {
    //debugPrint(details.input);
  }

  static void onResponse(NotificationResponse details) {
    //debugPrint(details.input);
  }

  void onNotificationTap(NotificationResponse response) {
    //debugPrint(response.input);
  }

  static showNotification(
      {required String title,
      required String body,
      required String payload}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
