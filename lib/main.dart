import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/business_logic/membres_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/business_logic/association_payements_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_update_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/loginScreen.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/firebase_options.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/homePage.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/push_notification.dart';
import 'package:faroty_association_1/pages/pre_login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

//function to lisen to background changes

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  PushNotifications.init();
  PushNotifications.localNotiInit();

  await EasyLocalization.ensureInitialized();

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarColor: Colors.transparent, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        // systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
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
      ],
      child: ScreenUtilInit(
        designSize: Size(404, 886),
        child: MaterialApp(
          
          theme: ThemeData(
            useMaterial3: false,
            fontFamily: GoogleFonts.roboto().fontFamily,
          ),
          
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          routes: {
            "/": (context) => AppCubitStorage().state.tokenUser == null &&
                    AppCubitStorage().state.codeAssDefaul == null
                ? PreLoginPage()
                : HomePage(),
            "/LoginPage": (context) => LoginPage(),
            "/homepage": (context) => HomePage(),
          },
        ),
      ),
    );
  }
}
