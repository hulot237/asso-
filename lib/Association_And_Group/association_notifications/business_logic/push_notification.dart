import 'dart:convert';

import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_cubit.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;

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
    print("token: ${token}");
  }


  Future _firebaseBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
    }
  }

  final _androidChanel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notifications",
    description: "This channel is used for important notification",
    importance: Importance.defaultImportance,
  );

  final _localNotification = FlutterLocalNotificationsPlugin();


  Future<void> getTokenNotification() async {
    String? token = await FirebaseMessaging.instance.getAPNSToken();

    await FirebaseMessaging.instance.getToken().then((value) async {
      await saveToken(value!);
      
      return null;
    });
  }

  saveToken(String token) async {
    await AppCubitStorage().updatetokenNotification(token);
  }

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);

    // await _localNotification.initialize(
    //   settings,
    //   onSel
    // );
  }


  // // initalize local notifications
  // static Future localNotiInit() async {
  //   // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   final DarwinInitializationSettings initializationSettingsDarwin =
  //       DarwinInitializationSettings(
  //     onDidReceiveLocalNotification: (id, title, body, payload) => null,
  //   );
  //   final LinuxInitializationSettings initializationSettingsLinux =
  //       LinuxInitializationSettings(defaultActionName: 'Open notification');
  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(
  //           android: initializationSettingsAndroid,
  //           iOS: initializationSettingsDarwin,
  //           linux: initializationSettingsLinux);
  //   _flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onDidReceiveNotificationResponse: onNotificationTap,
  //       onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  // }
}
