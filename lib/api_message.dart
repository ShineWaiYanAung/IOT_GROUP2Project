import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseAPI {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    try {
      await _firebaseMessaging.requestPermission();
      final fCMToken = await _firebaseMessaging.getToken();
      print("Token: $fCMToken");

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message received: ${message.notification?.title}');
        // Handle foreground message with custom sound
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Message clicked: ${message.notification?.title}');
        // Handle notification click
      });

    } catch (e) {
      print("Error initializing notifications: $e");
    }
  }
}
