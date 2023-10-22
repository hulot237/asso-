import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/screens/homeScreen.dart';
import 'package:faroty_association_1/screens/settingsScreen.dart';
import 'package:faroty_association_1/screens/HistoriqueScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  final items = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_rounded,
      ),
      label: 'Accueil',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_tree_rounded),
      label: 'Historiques',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_rounded),
      label: 'Profil',
    ),
  ];

  final screens = [
    HomeScreen(),
    HistoriqueScreen(),
    SettingScreen(),
  ];

  Future<void> handleUserGroupDefault() async {
    final userGroupDefault =
        await context.read<UserGroupCubit>().UserGroupDefaultCubit();

    if (userGroupDefault != null) {
      // await AppCubitStorage().updateCodeAssDefaul(
      //     "${context.read<UserGroupCubit>().state.userGroupDefault!["urlcode"]}");
      for (var elt in context
          .read<UserGroupCubit>()
          .state
          .userGroupDefault!["tournois"]) {
        if (elt['is_default'] == 1) {
          print("okkkkkkkkkkkk ${elt["tournois_code"]}");

          // setState(() {

          await AppCubitStorage()
              .updateCodeTournoisDefault("${elt["tournois_code"]}");

          // });

          // AppCubitStorage().updateValeur1WithValA(elt['is_default'], "ournois_cod" );

          print(
            "TournoisCodeDefaultCubitStorage==   ${AppCubitStorage().state.codeTournois}",
          );
        }
      }

      // updateDataTournoisCodeDefaul
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleTournoiDefault() async {
    final detailTournoiCourant = await context
        .read<DetailTournoiCourantCubit>()
        .detailTournoiCourantCubit();

    if (detailTournoiCourant != null) {
      print(
          "objectdddddddddddddddddddddddddddddddddd  ${detailTournoiCourant}");
      print(
          "dddddddddddddddddddddddddddddddddddddddd ${context.read<DetailTournoiCourantCubit>().state.detailtournoiCourant}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllCotisationAss(codeAssociation) async {
    final allCotisationAss = await context
        .read<CotisationCubit>()
        .AllCotisationAssCubit(codeAssociation);

    if (allCotisationAss != null) {
      print("objec~~~~~~~~ttt  ${allCotisationAss}");
      print(
          "éé22222~~~~~~~~  ${context.read<CotisationCubit>().state.allCotisationAss}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllUserGroup() async {
    final AllUserGroup =
        await context.read<UserGroupCubit>().AllUserGroupOfUserCubit();

    if (AllUserGroup != null) {
      print("1");

      // print(context.read<UserGroupCubit>().state.userGroup);
    } else {
      print("AllUserGroup null");
    }
  }

  Future<void> handleDetailUser(userCode) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode);

    if (allCotisationAss != null) {
      print("objec===============ttt  ${allCotisationAss}");
      print(
          "éé22===============222  ${context.read<AuthCubit>().state.detailUser}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllCompteAss(codeAssociation) async {
    final allCotisationAss =
        await context.read<CompteCubit>().AllCompteAssCubit(codeAssociation);

    if (allCotisationAss != null) {
      print("obj}===}}}}ttt  ${allCotisationAss}");
      print(
          "éé22222~===}}}}}}}}}}  ${context.read<CompteCubit>().state.allCompteAss}");
    } else {
      print("userGroupDefault null");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleUserGroupDefault();
    handleTournoiDefault();
    handleAllUserGroup();
    handleAllCotisationAss(AppCubitStorage().state.codeAssDefaul);
    handleDetailUser(Variables().codeMembre);
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      bottomNavigationBar: Container(
        // color: Colors.green,
        height: 51,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 226, 226, 226),
            type: BottomNavigationBarType.shifting,
            selectedIconTheme: IconThemeData(size: 25),
            unselectedIconTheme: IconThemeData(size: 15),
            selectedFontSize: 12,
            unselectedItemColor: Color.fromARGB(255, 20, 45, 99),
            selectedItemColor: Color.fromRGBO(0, 162, 255, 0.815),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: items,
            currentIndex: _pageIndex,
            onTap: (index) {
              handleUserGroupDefault();
              handleTournoiDefault();
              handleAllUserGroup();
              handleAllCotisationAss(AppCubitStorage().state.codeAssDefaul);
              handleDetailUser(Variables().codeMembre);
handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
              setState(() {
                _pageIndex = index;
              });
            },
          ),
        ),
      ),
      body: screens[_pageIndex],
    );
  }
}
