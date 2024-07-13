import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessagingSocketService {
  static late IO.Socket socket;

  static void initSocket(String userId, BuildContext context) {
    print('This is the Userid :- $userId');
    // Accept BuildContext as parameter
    socket = IO.io(
      'http://13.234.163.59:3000/home/notifications',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();
    

    socket.onConnect((_) {
      debugPrint('connected');
      print('connected');
      // socket.emit("user-joined", userId);
      // print('user-joined event emitted with userId: $userId');
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

  static void disconnect() {
    if (socket.connected) {
      socket.disconnect();
      print('Socket disconnected');
      debugPrint('Socket disconnected');
    }
  }
}
