import 'dart:io';

import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/pages/FicheMembrePage.dart';
import 'package:faroty_association_1/pages/paramsAppPage.dart';
import 'package:faroty_association_1/pages/profilPersonnelPage.dart';
import 'package:faroty_association_1/pages/proposAidePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // bool _customIconHelp = false;

  Map<String, dynamic>? get currentInfoAssociationCourant {
    return context.read<UserGroupCubit>().state.userGroupDefault;
  }


  @override
  Widget build(BuildContext context) {
    //  Map<String, dynamic>? currentInfoAssociationCourant = context.read<UserGroupCubit>().state.userGroupDefault;
    setState(() {
      print(
          "zzzzzzzzzzzzzzzzzzzzzzzededededeecec ${currentInfoAssociationCourant!["tournois"]}");
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Profil",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
        elevation: 0,
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
                      style:
                          TextStyle(fontSize: 7, fontWeight: FontWeight.w700),
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
                margin: EdgeInsets.only(top: 20, bottom: 10),
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
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(50)
                          // ),
                          width: 90,
                          height: 90,
                          child: Image.network(
                            "https://img.freepik.com/photos-gratuite/confiant-entrepreneur-regardant-camera-bras-croises-souriant_1098-18840.jpg?size=626&ext=jpg&ga=GA1.1.852592464.1694512378&semt=ais",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                            child: Text(
                              "KENGNE DJOUSSE Hulot",
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
                              "Matricule: MT2122",
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
              // padding: EdgeInsets.only(top: 50, bottom: 50),
              // color: Colors.grey,
              // height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(
                top: 20,
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
                        top: 10,
                        left: 10,
                        right: 10,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        // color: Colors.black12,
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: Color.fromARGB(12, 0, 0, 0)),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.phone_android_outlined,
                                      color: Colors.blue),
                                  margin: EdgeInsets.only(right: 10),
                                ),
                                Text(
                                  "Votre compte",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_right,
                              color: Color.fromARGB(255, 20, 45, 99), size: 12),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // context.read<ServiceCubit>().state.currentService!.id;
                      Modal().showBottomSheetListTournoi(
                        context,
                        currentInfoAssociationCourant!["tournois"],
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 10,
                        right: 10,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        // color: Colors.black12,
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: Color.fromARGB(12, 0, 0, 0)),
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
                                  "Tournoi",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (var item
                              in currentInfoAssociationCourant!["tournois"])
                            if (item["is_default"] == 1)
                              Text(
                                'Tournoi #${item["reference"]}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromARGB(125, 20, 45, 99),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          Icon(Icons.arrow_right,
                              color: Color.fromARGB(255, 20, 45, 99), size: 12),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // context.read<ServiceCubit>().state.currentService!.id;
                      Modal().showBottomSheetListAss(context,
                          context.read<UserGroupCubit>().state.userGroup);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 10,
                        right: 10,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        // color: Colors.black12,
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: Color.fromARGB(12, 0, 0, 0)),
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
                                  "Groupe et Association",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${currentInfoAssociationCourant!["matricule"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(125, 20, 45, 99),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(Icons.arrow_right,
                              color: Color.fromARGB(255, 20, 45, 99), size: 12),
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
                        top: 20,
                        left: 10,
                        right: 10,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        // color: Colors.black12,
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: Color.fromARGB(12, 0, 0, 0)),
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
                                  "Paramètres",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_right,
                              color: Color.fromARGB(255, 20, 45, 99), size: 12),
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
                        top: 20,
                        left: 10,
                        right: 10,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        // color: Colors.black12,
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: Color.fromARGB(12, 0, 0, 0)),
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
                                  "A propos et aide",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_right,
                              color: Color.fromARGB(255, 20, 45, 99), size: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  // color: Colors.lightBlue,
                  ),
            ),
            GestureDetector(
              
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(45, 255, 82, 82),
                  ),
                  width: MediaQuery.of(context).size.width / 2.7,
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        // color: Color.fromARGB(185, 255, 214, 64),
                        child: Icon(Icons.logout_rounded, color: Colors.red),
                      ),
                      Container(
                        // color: Colors.greenAccent,
                        child: Text(
                          "Déconnexion",
                          style: TextStyle(
                            fontSize: 12,
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
    );
  }
}
