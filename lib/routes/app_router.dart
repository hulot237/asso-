// ignore: depend_on_referenced_packages
import 'package:auto_route/auto_route.dart';
import 'package:faroty_association_1/pages/home_centrale_screen.dart';
import 'package:faroty_association_1/pages/paiement_screen.dart';
import 'package:faroty_association_1/pages/pre_login_screen.dart';
import 'package:faroty_association_1/pages/splash_screen.dart';
import 'package:faroty_association_1/pages/subscribe_form_screen.dart';
import 'package:faroty_association_1/screens/historique_screen.dart';
import 'package:faroty_association_1/screens/home_screen.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    // AutoRoute(page: SplashRoute.page, initial: true),
    // AutoRoute(page: PreLoginRoute.page, ),
    // AutoRoute(page: HomeRoute.page),
    // AutoRoute(page: HomeCentraleRoute.page),
    // AutoRoute(page: SubscribeFormRoute.page)
    // AutoRoute(page: ),
  ];
}