import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/loginScreen.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/firebase_options.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/network/localisation_phone/business_logic/localisation_phone_cubit.dart';
import 'package:faroty_association_1/network/session_activity/session_cubit.dart';
import 'package:faroty_association_1/pages/splash_screen.dart';
import 'package:faroty_association_1/pages/subscribe_form_screen.dart';
import 'package:faroty_association_1/pages/home_centrale_screen.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/push_notification.dart';
import 'package:faroty_association_1/pages/pre_login_screen.dart';
import 'package:faroty_association_1/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uni_links/uni_links.dart';

//function to lisen to background changes

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print(
      "onBackground: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}");
}

Future<void> _initUniLinks() async {
     print('Failed to handle link');
  try {
    // Pour les liens ouverts lorsqu'une application est lancée en premier
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      _handleLink(initialLink);
    }

    // Pour les liens ouverts lorsque l'application est déjà en cours d'exécution
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
  // Gérer le lien profond ici
  print('Received deep link: $link');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        statusBarBrightness: Brightness.dark),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

   await _initUniLinks();

  PushNotifications.init();
  // PushNotifications.localNotiInit();

  await EasyLocalization.ensureInitialized();

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    print("payloadData $payloadData");
  });

  try {
    final RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    await PushNotifications.initialize(flutterLocalNotificationsPlugin);

    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }

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
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserGroupCubit(),
        ),
        BlocProvider(
          create: (context) => DetailTournoiCourantCubit(),
        ),
        BlocProvider(
          create: (context) => SeanceCubit(),
        ),
        BlocProvider(
          create: (context) => AppCubitStorage(),
        ),
        BlocProvider(
          create: (context) => CotisationCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => CompteCubit(),
        ),
        BlocProvider(
          create: (context) => TontineCubit(),
        ),
        BlocProvider(
          create: (context) => CotisationDetailCubit(),
        ),
        BlocProvider(
          create: (context) => PayementCubit(),
        ),
        BlocProvider(
          create: (context) => AuthUpdateCubit(),
        ),
        BlocProvider(
          create: (context) => DetailContributionCubit(),
        ),
        BlocProvider(
          create: (context) => RecentEventCubit(),
        ),
        BlocProvider(
          create: (context) => MembreCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(),
        ),
        BlocProvider(
          create: (context) => PretEpargneCubit(),
        ),
        BlocProvider(
          create: (context) => SessionCubit(),
        ),
        BlocProvider(
          create: (context) => SanctionCubit(),
        ),
        BlocProvider(
          create: (context) => LocalisationPhoneCubit(),
        ),
        BlocProvider(
          create: (context) => HelpCenterCubit(),
        )
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        child: MaterialApp
            // .router
            (
          theme: ThemeData(
            useMaterial3: false,
            highlightColor: AppColors.greenAssociation.withOpacity(0.5),
            splashColor: AppColors.bleuLight.withOpacity(0.5),
            fontFamily: GoogleFonts.roboto().fontFamily,
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,

          // routerConfig: _appRouter.config(
          //   rebuildStackOnDeepLink: true,
          //   deepLinkBuilder: (deepLink) {
          //     final uri = deepLink.uri;
          //     if (uri.path.contains('/subscribe')) {
          //       String? urlcode = uri.queryParameters['urlcode'];
          //       return DeepLink([SubscribeFormRoute(urlcodeAss: '$urlcode')]);
          //       // path('${uri.path}?firstName=$firstName&lastName=$lastName&email=$email&mobile=$mobile');
          //     }
          //     return DeepLink.defaultPath;
          //   },
          // ),

          routes: {
            "/": (context) => SplashScreen(),
            // AppCubitStorage().state.tokenUser == null &&
            //         AppCubitStorage().state.codeAssDefaul == null
            //     ? PreLoginScreen()
            //     : HomeCentraleScreen(),

            // : true? UpdatePage() : HomePage(),
            // "/LoginPage": (context) => LoginPage(),
            "/homepage": (context) => HomeCentraleScreen(),
            // "/": (context) => SubscribeForm(urlcodeAss: 'llle',),
          },
        ),
      ),
    );
  }
}
