// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:targafy/main.dart';

// class MessagingSocketService {
//   static late IO.Socket socket;
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static void init() {
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   static void initSocket(String userId, BuildContext context) {
//     print('This is the Userid :- $userId');
//     // Accept BuildContext as parameter
//     socket = IO.io(
//       'http://13.234.163.59/home/notifications',
//       <String, dynamic>{
//         'transports': ['websocket'],
//         'autoConnect': false,
//       },
//     );

//     socket.connect();
//     socket.onConnect((_) {
//       debugPrint('connected');
//       print('connected');
//       socket.emit("user-joined", userId);
//       print('user-joined event emitted with userId: $userId');
//     });

//     socket.on('new-notification', (data) async {
//       print('notifiMessage Socket  $data');
//       String title = 'Targafy';
//       String body = data['content'];
//       // RemoteMessage message = createRemoteMessageFromData(data);
//       _showNotification(title, body);
//       print('displayed notification');
//     });

//     socket.on('new-notification-add-business', (data) async {
//       print('notifiMessage Socket  $data');
//       String title = 'Targafy';
//       String body = data['content'];
//       // RemoteMessage message = createRemoteMessageFromData(data);
//       _showNotification(title, body);
//       print('displayed notification');
//     });

//     socket.on('activity-notification', (data) async {
//       print('notifiMessage Socket  $data');
//       String title = 'Targafy';
//       String body = data['content'];
//       print('Notification for activity :- $body');
//       _showNotification(title, body);
//     });

//     socket.on('join-business-notification', (data) async {
//       print('notifiMessage Socket  $data');
//       String title = 'Targafy';
//       String body = data['content'];
//       print('Notification for Join business :- $body');
//       _showNotification(title, body);
//     });

//     socket.on('receive-message', (data) {
//       print("###This data is received : $data");
//       debugPrint("###This data is received : $data");
//     });

//     socket.onConnectError((error) {
//       print('Connect error: $error');
//       debugPrint('Connect error: $error');
//     });

//     socket.onError((error) {
//       print('Error: $error');
//       debugPrint('Error: $error');
//     });

//     socket.onDisconnect((_) {
//       print('Socket disconnected');
//       debugPrint('Socket disconnected');
//     });
//   }

//   static Future<void> _showNotification(String title, String body) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//     );
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'item x',
//     );
//   }

//   static void disconnect() {
//     if (socket.connected) {
//       socket.disconnect();
//       print('Socket disconnected');
//       debugPrint('Socket disconnected');
//     }
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:targafy/main.dart';

class MessagingSocketService {
  static late IO.Socket socket;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void init() {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void initSocket(String userId, BuildContext context) {
    print('This is the Userid :- $userId');
    // Accept BuildContext as parameter
    socket = IO.io(
      'http://13.234.163.59/home/notifications',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();
    socket.onConnect((_) {
      debugPrint('connected');
      print('connected');
      socket.emit("user-joined", userId);
      print('user-joined event emitted with userId: $userId');
    });

    socket.on('new-notification', (data) async {
      _handleNotification('new-notification', data);
    });

    socket.on('new-notification-add-business', (data) async {
      _handleNotification('new-notification-add-business', data);
    });

    socket.on('activity-notification', (data) async {
      _handleNotification('activity-notification', data);
    });

    socket.on('join-business-notification', (data) async {
      _handleNotification('join-business-notification', data);
    });

    socket.on('receive-message', (data) {
      print("###This data is received : $data");
      debugPrint("###This data is received : $data");
    });

    socket.onConnectError((error) {
      print('Connect error: $error');
      debugPrint('Connect error: $error');
    });

    socket.onError((error) {
      print('Error: $error');
      debugPrint('Error: $error');
    });

    socket.onDisconnect((_) {
      print('Socket disconnected');
      debugPrint('Socket disconnected');
    });
  }

  static void _handleNotification(String eventName, dynamic data) async {
    print('Notification Event [$eventName] Data: $data');
    String title = 'Targafy';
    String body = data['content'];
    _showNotification(title, body);
    print('Displayed notification for event: $eventName');
  }

  static Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  static void disconnect() {
    if (socket.connected) {
      socket.disconnect();
      print('Socket disconnected');
      debugPrint('Socket disconnected');
    }
  }
}

class lastseenSocketService {
  static late IO.Socket socket;

  static void initSocket(
      String userId, String businessId, BuildContext context) {
    print('This is the Userid :- $userId');

    final username = "${userId}_${businessId}";
    print('This is username $username');
    // Accept BuildContext as parameter
    socket = IO.io(
      'http://13.234.163.59/business/activity',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();
    socket.onConnect((_) {
      debugPrint('connected');
      print('connected');
      socket.emit("business-user-joined", username);
      print(
          'business-user-joined event emitted with userId: $userId and businessId : $businessId');
    });

    // socket.on('receive-message', (data) {
    //   print("###This data is received : $data");
    //   debugPrint("###This data is received : $data");
    // });

    socket.onConnectError((error) {
      print('Connect error: $error');
      debugPrint('Connect error: $error');
    });

    socket.onError((error) {
      print('Error: $error');
      debugPrint('Error: $error');
    });

    socket.onDisconnect((_) {
      print('Socket disconnected');
      debugPrint('Socket disconnected');
    });
  }

  static void disconnectSocket() {
    if (socket.connected) {
      socket.disconnect();
      print('Socket disconnected manually');
      debugPrint('Socket disconnected manually');
    }
  }
}
