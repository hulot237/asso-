import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/loginScreen.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/FicheMembrePage.dart';
import 'package:faroty_association_1/pages/homePage.dart';
import 'package:faroty_association_1/pages/paramsAppPage.dart';
import 'package:faroty_association_1/pages/profilPersonnelPage.dart';
import 'package:faroty_association_1/pages/proposAidePage.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/presentation/screens/retraitPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // bool _customIconHelp = false;

  List<dynamic>? get currentInfoAllAssociation {
    return context.read<UserGroupCubit>().state.userGroup;
  }

  // Map<String, dynamic>? get currentInfoAllTournoiAssCourant {
  //   return context.read<UserGroupCubit>().state.ChangeAssData;
  // }

  Future<void> handleChangeTournoi(codeTournoi) async {
    final allCotisationAss = await context
        .read<DetailTournoiCourantCubit>()
        .changeTournoiCubit(codeTournoi, AppCubitStorage().state.codeAssDefaul);

    if (allCotisationAss != null) {
      print("objec~~~~~~~~ttt  ${allCotisationAss}");
      print(
          "éé22222~~~~~~~~  ${context.read<DetailTournoiCourantCubit>().state.changeTournoi}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleDetailUser(userCode) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode);

    if (allCotisationAss != null) {
      print("handleDetailUser");
    } else {
      print("handleDetailUser null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserGroupCubit, UserGroupState>(
        builder: (userGroupContext, userGroupState) {
      if (userGroupState.isLoading == null ||
          userGroupState.isLoading == true ||
          userGroupState.ChangeAssData == null)
        return Container(
          color: Colors.white,
          width: 10,
          height: 10,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      final currentInfoAllTournoiAssCourant =
          userGroupContext.read<UserGroupCubit>().state.ChangeAssData;
      return BlocBuilder<AuthCubit, AuthState>(
          builder: (authContext, authState) {
        if (authState.isLoading == null || authState.isLoading == true)
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        final currentDetailUser =
            authContext.read<AuthCubit>().state.detailUser;
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(),
              ),
              (route) => false,
            );
            return false;
          },
          child: Scaffold(
            backgroundColor: Color(0xFFEFEFEF),
            appBar: AppBar(
              title: Text(
                "profil".tr(),
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(),
                    ),
                    (route) => false,
                  );
                },
                child: Icon(Icons.arrow_back),
              ),
              actions: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 25, top: 15),
                        child: Icon(Icons.notifications_active_outlined),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          alignment: Alignment.center,
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            color: Colors.red,
                          ),
                          child: Text(
                            "100",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
              // leading: Icon(Icons.arrow_back),
            ),
            body: Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilPersonnelPage(),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 162, 255, 0.815),
                                borderRadius: BorderRadius.circular(100)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                width: 90,
                                height: 90,
                                child: Image.network(
                                  "${Variables.LienAIP}${currentDetailUser!["photo_profil"] == null ? "" : currentDetailUser!["photo_profil"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 5),
                                  child: Text(
                                    "${currentDetailUser["first_name"] == null ? "" : currentDetailUser["first_name"]} ${currentDetailUser["last_name"] == null ? "" : currentDetailUser["last_name"]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromARGB(255, 20, 45, 99),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFEFEFEF),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "${"matricule".tr()}: ${currentDetailUser["matricule"]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(96, 20, 45, 99),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccountPage(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 10,
                              right: 10,
                              bottom: 15,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(12, 0, 0, 0)),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Icon(
                                            Icons.phone_android_outlined,
                                            color: Colors.blue),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      Text(
                                        "votre_compte".tr(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 20, 45, 99),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_right,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    size: 12),
                              ],
                            ),
                          ),
                        ),
                        if (currentDetailUser["is_withdrawal_approvers"] == 1)
                          GestureDetector(
                            onTap: () {
                              handleDetailUser(
                                  AppCubitStorage().state.membreCode);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RetraitPage()));
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 15,
                                left: 10,
                                right: 10,
                                bottom: 15,
                              ),
                              decoration: BoxDecoration(
                                // color: Colors.black12,
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(12, 0, 0, 0)),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Icon(
                                            Icons
                                                .account_balance_wallet_outlined,
                                            color: Colors.black,
                                          ),
                                          margin: EdgeInsets.only(right: 10),
                                        ),
                                        Text(
                                          "retrait_en_attente".tr(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Color.fromARGB(255, 20, 45, 99),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.arrow_right,
                                      color: Color.fromARGB(255, 20, 45, 99),
                                      size: 12),
                                ],
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            // context.read<ServiceCubit>().state.currentService!.id;
                            Modal().showBottomSheetListTournoi(
                              context,
                              currentInfoAllTournoiAssCourant!["user_group"]
                                  ["tournois"],
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 10,
                              right: 10,
                              bottom: 15,
                            ),
                            decoration: BoxDecoration(
                              // color: Colors.black12,
                              border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(12, 0, 0, 0)),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Icon(Icons.ads_click_outlined,
                                            color: Colors.red),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      Text(
                                        "tournoi".tr(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 20, 45, 99),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                for (var item
                                    in currentInfoAllTournoiAssCourant![
                                        "user_group"]["tournois"])
                                  if (item["tournois_code"] ==
                                      AppCubitStorage().state.codeTournois)
                                    Text(
                                      'Tournoi #${item["matricule"]}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color.fromARGB(125, 20, 45, 99),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                Icon(Icons.arrow_right,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    size: 12),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // context.read<ServiceCubit>().state.currentService!.id;
                            Modal().showBottomSheetListAss(
                              context,
                              currentInfoAllAssociation,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 10,
                              right: 10,
                              bottom: 15,
                            ),
                            decoration: BoxDecoration(
                              // color: Colors.black12,
                              border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(12, 0, 0, 0)),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/images/Groupe_ou_Asso.png",
                                          scale: 14,
                                        ),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      Text(
                                        "groupe_et_association".tr(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 20, 45, 99),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${context.read<UserGroupCubit>().state.ChangeAssData!["user_group"]["matricule"] == null ? "" : context.read<UserGroupCubit>().state.ChangeAssData!["user_group"]["matricule"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromARGB(125, 20, 45, 99),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(Icons.arrow_right,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    size: 12),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ParamsAppPage(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 10,
                              right: 10,
                              bottom: 15,
                            ),
                            decoration: BoxDecoration(
                              // color: Colors.black12,
                              border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(12, 0, 0, 0)),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.settings_outlined,
                                          color: Colors.brown,
                                        ),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      Text(
                                        "paramètres".tr(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 20, 45, 99),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_right,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    size: 12),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProposAidePage(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 10,
                              right: 10,
                              bottom: 15,
                            ),
                            decoration: BoxDecoration(
                              // color: Colors.black12,
                              border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(12, 0, 0, 0)),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.support_agent_outlined,
                                          color: Colors.orange,
                                        ),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      Text(
                                        "a_propos_et_aide".tr(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 20, 45, 99),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_right,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    size: 12),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Share.share("Le lien de l'application");
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 10,
                              right: 10,
                              bottom: 15,
                            ),
                            decoration: BoxDecoration(
                              // color: Colors.black12,
                              border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(12, 0, 0, 0)),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.share_outlined,
                                          color: Colors.black,
                                        ),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      Text(
                                        "partager_l'application".tr(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 20, 45, 99),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_right,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    size: 12),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        // color: Colors.lightBlue,
                        ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print(
                          "success urlcode   ${AppCubitStorage().state.codeAssDefaul}");
                      print(
                          "success token   ${AppCubitStorage().state.tokenUser}");
                      print(
                          "success membre_code   ${AppCubitStorage().state.membreCode}");
                      print(
                          "success tournoi_code   ${AppCubitStorage().state.codeTournois}");
                      print("membre is_member ${currentDetailUser["isMember"]}");
                      print("membre configs group ${context.read<UserGroupCubit>().state.ChangeAssData!["user_group"]["configs"]}");

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("etes_vous_sur?".tr()),
                            titleTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 20, 45, 99),
                                fontSize: 20),
                            actionsOverflowButtonSpacing: 20,
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    right: 20,
                                    left: 20,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 162, 255, 0.815),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "non".tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginPage(),
                                    ),
                                    (route) => false,
                                  );
                                  HydratedBloc.storage.clear();
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    right: 20,
                                    left: 20,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color:
                                            Color.fromRGBO(0, 162, 255, 0.815),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "oui".tr(),
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 162, 255, 0.815),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            // content: Text("Saved successfully"),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(45, 255, 82, 82),
                        ),
                        width: MediaQuery.of(context).size.width / 3,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              // color: Color.fromARGB(185, 255, 214, 64),
                              child: Icon(
                                Icons.logout_rounded,
                                color: Colors.red,
                                size: 15,
                              ),
                            ),
                            Container(
                              // color: Colors.greenAccent,
                              child: Text(
                                "déconnexion".tr(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
