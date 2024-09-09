import 'dart:async';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/business_logic/help_center_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/business_logic/membres_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/business_logic/association_payements_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/business_logic/sanction_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_update_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/network/localisation_phone/business_logic/localisation_phone_cubit.dart';
import 'package:faroty_association_1/network/session_activity/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:uni_links/uni_links.dart';

import 'package:faroty_association_1/pages/contact_us_page.dart';
import 'package:faroty_association_1/pages/proposAidePage.dart';
import 'package:faroty_association_1/pages/splash_screen.dart';
import 'package:faroty_association_1/pages/home_centrale_screen.dart';
import 'package:faroty_association_1/pages/updatePage.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/push_notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling background message: ${message.messageId}");
  PushNotifications.handleNotificationNavigation(
    message.data['source_name'],
    message.data['source_code'],
    message.data['tournois_code'],
    message.data['urlcode'],
  );
}

Future<void> _initUniLinks() async {
  try {
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      _handleLink(initialLink);
    }

    linkStream.listen((String? link) {
      if (link != null) {
        _handleLink(link);
      }
    });
  } catch (e) {
    print('Failed to handle link: $e');
  }
}

void _handleLink(String link) {
  // Process deep links if necessary
  print('Received deep link: $link');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );

  await Firebase.initializeApp();
  await _initUniLinks();
  await EasyLocalization.ensureInitialized();

  PushNotifications.init();

  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  PushNotifications.initialize(flutterLocalNotificationsPlugin);

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print("Got a message in foreground");
  //   final String? messageId = message.messageId;
  //   final String? notificationTitle = message.notification?.title;
  //   final String? notificationBody = message.notification?.body;
  //   final Map<String, dynamic> data = message.data;

  //   print("Message ID: $messageId");
  //   print("Notification Title: $notificationTitle");
  //   print("Notification Body: $notificationBody");
  //   print("Data: ${data.toString()}");
  // });

  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        Locale("en", "US"),
        Locale("fr", "FR"),
      ],
      saveLocale: true,
      path: "assets/languages",
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserGroupCubit()),
        BlocProvider(create: (context) => DetailTournoiCourantCubit()),
        BlocProvider(create: (context) => SeanceCubit()),
        BlocProvider(create: (context) => AppCubitStorage()),
        BlocProvider(create: (context) => CotisationCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => CompteCubit()),
        BlocProvider(create: (context) => TontineCubit()),
        BlocProvider(create: (context) => CotisationDetailCubit()),
        BlocProvider(create: (context) => PayementCubit()),
        BlocProvider(create: (context) => AuthUpdateCubit()),
        BlocProvider(create: (context) => DetailContributionCubit()),
        BlocProvider(create: (context) => RecentEventCubit()),
        BlocProvider(create: (context) => MembreCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => PretEpargneCubit()),
        BlocProvider(create: (context) => SessionCubit()),
        BlocProvider(create: (context) => SanctionCubit()),
        BlocProvider(create: (context) => LocalisationPhoneCubit()),
        BlocProvider(create: (context) => HelpCenterCubit()),
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: false,
            highlightColor: Colors.green.withOpacity(0.5),
            splashColor: Colors.blue.withOpacity(0.5),
            fontFamily: GoogleFonts.roboto().fontFamily,
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          routes: {
            "/": (context) => SplashScreen(),
            "/homepage": (context) => HomeCentraleScreen(),
            "/updatePage": (context) => UpdatePage(),
            "/contact": (context) => ContactUsPage(),
            "/ProposAidePage": (context) => ProposAidePage(),
          },
        ),
      ),
    );
  }
}
