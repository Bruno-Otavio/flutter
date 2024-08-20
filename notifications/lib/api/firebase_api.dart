import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseNotification = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // Request permission from user
    await _firebaseNotification.requestPermission();

    // fetch the FCM token for this device
    final fCMToken = await _firebaseNotification.getToken();

    // print the token (normally you would send this to your server)
    print('Token: $fCMToken');
  }

  void handleMessage(RemoteMessage? message) {
    
  }
} 