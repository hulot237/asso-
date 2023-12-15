import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  Future _firebaseBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      print("Some notifications received");
    }
  }

  final _androidChanel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notifications",
    description: "This channel is used for important notification",
    importance: Importance.defaultImportance,
  );

  final _localNotification = FlutterLocalNotificationsPlugin();

  //request notification permission
  Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    //get the device fcm token
    final token = await _firebaseMessaging.getToken();
    print("device token for FireBase: $token");

    //Listen to background notifications
// FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
      (message) {
        final notification = message.notification;

        if (notification == null) return;

        _localNotification.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                _androidChanel.id,
                _androidChanel.name,
                channelDescription: _androidChanel.description,
                icon: "@drawable/ic_launcher",
              ),
            ),
            payload: jsonEncode(message.toMap()));
      },
    );
  }

  Future initLocalNotification() async{
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);
  
  // await _localNotification.initialize(
  //   settings,
  //   onSel
  // );
  }
}
