import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/business_logic/association_payements_cubit.dart';
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
import 'package:faroty_association_1/pages/push_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';





//function to lisen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async{
  if (message.notification != null) {
    print("Some notifications received");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  PushNotifications.init();
  
  //Listen to background notifications 
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await EasyLocalization.ensureInitialized();

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
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => AppCubitStorage().state.userNameKey == null &&
                  AppCubitStorage().state.passwordKey == null &&
                  AppCubitStorage().state.codeAssDefaul == null
              ? LoginPage()
              : HomePage(),
          // "/": (context) => LoginPage(),
          "/homepage": (context) => HomePage(),
        },
      ),
    );
  }
}
