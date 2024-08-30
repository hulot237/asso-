// import 'package:faroty_association_1/localStorage/localCubit.dart';
// import 'package:faroty_association_1/main.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class PushNotifications {
//   static final _firebaseMessaging = FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     final token = await _firebaseMessaging.getToken();
//     print("device token: $token");
//     AppCubitStorage().updatetokenNotification(token!);
//   }

//   static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize = AndroidInitializationSettings('notification_icon');
//     var iOSInitialize = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );
//     var initializationSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse payload) async {
//         try {
//           final String? urlcode = payload.payload;
//           print(".............................onDidReceiveNotificationResponse.............................");
//           handleNotificationNavigation("update");
//         } catch (e) {
//           print("Error: ${e.toString()}");
//         }
//       },
//     );

//     await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print(".............................onMessage.............................");
//       print("onMessage: ${message.notification?.title}/${message.notification?.body}/${message.notification}");
//       PushNotifications.showNotification(message, flutterLocalNotificationsPlugin);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print(".............................onMessageOpenedApp.............................");
//       print("onMessageOpenedApp: ${message.notification?.title}/${message.notification?.body}/${message.data}");
//       // final String? urlcode = message.data['urlcode'];
//           handleNotificationNavigation("contact");
//     });

//   }

//   static Future<void> showNotification(RemoteMessage msg, FlutterLocalNotificationsPlugin fln) async {
//     BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//       msg.notification!.body!,
//       htmlFormatBigText: true,
//       contentTitle: msg.notification!.title!,
//       htmlFormatContent: true,
//     );
//     AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       "channel_id_1",
//       "ASSO+",
//       importance: Importance.high,
//       styleInformation: bigTextStyleInformation,
//       priority: Priority.high,
//       playSound: true,
//     );
//     NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: DarwinNotificationDetails(),
//     );
//     await fln.show(
//       0,
//       msg.notification!.title!,
//       msg.notification!.body!,
//       platformChannelSpecifics,
//     );
//   }

//   static void handleNotificationNavigation(String? urlcode) {
//       print("_handleNotificationNavigation");

//     if (urlcode != null) {
//       print("_handleNotificationNavigation1");
//       if (urlcode == 'update') {
//         navigatorKey.currentState?.pushNamed('/updatePage');
//       } else if (urlcode == 'contact') {
//         navigatorKey.currentState?.pushNamed('/contact');
//       } else {
//         navigatorKey.currentState?.pushNamed('/');
//       }
//     } else {
//       print("_handleNotificationNavigation2");

//       navigatorKey.currentState?.pushNamed('/');
//     }
//   }
// }

import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/main.dart';
import 'package:faroty_association_1/pages/contact_us_page.dart';
import 'package:faroty_association_1/pages/home_centrale_screen.dart';
import 'package:faroty_association_1/pages/splash_redirect_notif_screen.dart';
import 'package:faroty_association_1/pages/updatePage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final token = await _firebaseMessaging.getToken();
    print("device token: $token");
    AppCubitStorage().updatetokenNotification(token!);
  }

  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = AndroidInitializationSettings('notification_icon');
    var iOSInitialize = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse payload) async {
        try {
          final String? urlcode = payload.payload;
          print(
              ".............................onDidReceiveNotificationResponse.............................");
          handleNotificationNavigation(null, null);
        } catch (e) {
          print("Error: ${e.toString()}");
        }
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
          "onMessage: ${message.notification?.title}/${message.notification?.body}/${message.data['source_name']} ${message.data['source_code']}");
      PushNotifications.showNotification(
          message, flutterLocalNotificationsPlugin);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          ".............................onMessageOpenedApp.............................");
      print(
          "onMessageOpenedApp: ${message.notification?.title}/${message.notification?.body}/${message.data['source_name']}");
      handleNotificationNavigation(message.data['source_name'], message.data['source_code']);
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

  static void handleNotificationNavigation(String? dataSource, String? codeElt) {
    print("_handleNotificationNavigation");

    if (dataSource != null) {
      print("_handleNotificationNavigation1");
      Widget page;
      switch (dataSource) {
        case 'ass_cotisations':
          page = SplashRedirectNotifScreen(dataSource: dataSource, codeElt: codeElt!,);
          break;
        case 'ass_tontine_contributions':
          page = SplashRedirectNotifScreen(dataSource: dataSource, codeElt: codeElt!,);
          break;
        default:
          page =
              HomeCentraleScreen(); // Remplacez par la page d'accueil ou une autre page par défaut
      }

      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => page),
      );
    } else {
      print("_handleNotificationNavigation2");
      navigatorKey.currentState?.push(
        MaterialPageRoute(
            builder: (context) =>
                HomeCentraleScreen()), // Remplacez par la page d'accueil ou une autre page par défaut
      );
    }
  }
}