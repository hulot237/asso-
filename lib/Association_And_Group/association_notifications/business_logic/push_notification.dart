import 'dart:convert';

import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_cubit.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // get the device fcm token
    final token = await _firebaseMessaging.getToken();
    print("device token: $token");
    AppCubitStorage().updatetokenNotification(token!);
  }

  static Future<void> initialize(
      FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin) async {
    var androidInitialize = AndroidInitializationSettings('notification_icon');
    var iOSInitialize = DarwinInitializationSettings(
        // requestAlertPermission: true,
        // requestBadgePermission: true,
        // requestSoundPermission: true,
        // onDidReceiveLocalNotification:
        //     (int id, String? title, String? body, String? payload) async {},
        );
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    // // get the device fcm token
    // final token = await _firebaseMessaging.getToken();
    // print("device token: $token");
    // AppCubitStorage().updatetokenNotification(token!);

    _flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: (payload) async {
        try {

          print("onDidReceiveNotificationResponse ${payload.payload}");
          if (payload != null) {
          } else {}
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
        return;
      },
    );

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          ".............................onMessage.............................");
      print(
          "onMessage: ${message.notification?.title}/${message.notification?.body}/${message.notification}");

      PushNotifications.showNotification(
          message, _flutterLocalNotificationsPlugin);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          ".............................onMessageOpenedApp.............................");
      print(
          "onMessageOpenedApp: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}");
    });
  }

  static Future<void> showNotification(
      RemoteMessage msg, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      msg.notification!.body!,
      htmlFormatBigText: true,
      contentTitle: msg.notification!.title!,
      htmlFormatContent: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "channel_id_1",
      "ASSO+",
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );
    await fln.show(
      0,
      msg.notification!.title!,
      msg.notification!.body!,
      platformChannelSpecifics,
    );
  }
}
