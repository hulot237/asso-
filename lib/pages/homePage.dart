import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/screens/homeScreen.dart';
import 'package:faroty_association_1/screens/settingsScreen.dart';
import 'package:faroty_association_1/screens/HistoriqueScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Widget PageScaffold({
  required BuildContext context,
  required List<Widget> child,
  required List<BottomNavigationBarItem> itemListAndroid,
  required List<BottomNavigationBarItem> itemListIos,
  required Widget childBottomNavBar,
  required int indexPage,
}) {
  if (Platform.isIOS) {
    return CupertinoTabScaffold(
      backgroundColor: AppColors.pageBackground,
      tabBar: CupertinoTabBar(
        items: itemListIos,
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return child[index];
          },
        );
      },
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    bottomNavigationBar: childBottomNavBar,
    body: child[indexPage],
  );
}

class _HomePageState extends State<HomePage> {
  Future<void> handleTournoiDefault() async {
    final detailTournoiCourant = await context
        .read<DetailTournoiCourantCubit>()
        .detailTournoiCourantCubit();

    if (detailTournoiCourant != null) {
      print("handleTournoiDefault");
    } else {
      print("handleTournoiDefault null");
    }
  }

  int _pageIndex = 0;
  final screens = [
    HomeScreen(),
    HistoriqueScreen(),
    SettingScreen(),
  ];

  final itemListAndroid = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_rounded,
      ),
      label: 'Accueil'.tr(),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.article_rounded),
      label: 'Historiques'.tr(),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_2_rounded),
      label: 'Profil'.tr(),
    ),
  ];

  final itemListIos = [
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.house_fill,
        // home_rounded,
      ),
      label: 'Accueil',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.table_fill),
      // account_tree_rounded),
      label: 'Historiques',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.circle_grid_hex_fill),
      label: 'Profil',
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      context: context,
      indexPage: _pageIndex,
      child: screens,
      itemListIos: itemListIos,
      itemListAndroid: itemListAndroid,
      childBottomNavBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 226, 226, 226),
          type: BottomNavigationBarType.shifting,
          selectedIconTheme: IconThemeData(size: 25),
          unselectedIconTheme: IconThemeData(size: 15),
          selectedFontSize: 12,
          unselectedItemColor: AppColors.blackBlue,
          selectedItemColor: Color.fromRGBO(0, 162, 255, 0.815),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: itemListAndroid,
          currentIndex: _pageIndex,
          onTap: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
