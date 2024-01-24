import 'dart:io';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/loginScreen.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/appStorageModel.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/proposAidePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ParamsAppPage extends StatefulWidget {
  const ParamsAppPage({super.key});

  @override
  State<ParamsAppPage> createState() => _ParamsAppPageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.pageBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "paramètres".tr(),
          style: TextStyle(fontSize: 16, color: AppColors.white),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    appBar: AppBar(
      title: Text(
        "paramètres".tr(),
        style: TextStyle(fontSize: 16, color: AppColors.white),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: AppColors.white),
      ),
    ),
    body: child,
  );
}

class _ParamsAppPageState extends State<ParamsAppPage> {
  int _pageIndex = 0;
  bool _customIconLangue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final dataBloc = context.read<AppCubitStorage>();
    print("dddddddddddddddddddd ${AppCubitStorage().state}");
  }

  // Map<String, dynamic>? get dataLanguage {
  //   return context.read<UserGroupCubit>().state.userGroupDefault;
  // }

  @override
  Widget build(BuildContext context) {
    final dataLanguage = context.read<AppCubitStorage>();

    return BlocBuilder<AppCubitStorage, AppStorageModel>(
        builder: (context, state) {
      return PageScaffold(
        context: context,
        child: Column(
          children: [
            Container(
              child: ExpansionTile(
                childrenPadding: EdgeInsets.all(0),
                shape: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color.fromARGB(12, 0, 0, 0),
                  ),
                ),
                collapsedShape: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color.fromARGB(12, 0, 0, 0),
                  ),
                ),
                title: Container(
                  child: Text(
                    "langue".tr(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackBlue,
                    ),
                  ),
                ),
                trailing: Icon(
                  color: AppColors.blackBlue,
                  size: 12,
                  _customIconLangue
                      ? Icons.keyboard_double_arrow_down
                      : Icons.double_arrow,
                ),
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ParamsAppPage(),
                              ),
                            );
                            setState(() {
                              context.setLocale(
                                Locale("fr", "FR"),
                              );
                            });
                            // AppCubitStorage().updateLanguage("fr");
                            await dataLanguage.updateLanguage('fr');
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 9,
                              bottom: 9,
                              right: 20,
                              left: 20,
                            ),
                            margin: EdgeInsets.only(left: 10, bottom: 10),
                            decoration: AppCubitStorage().state.Language == "fr"
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.colorButton,
                                  )
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.colorButton,
                                    ),
                                  ),
                            child: Text(
                              "${"francais".tr()}",
                              style: AppCubitStorage().state.Language == "fr"
                                  ? TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    )
                                  : TextStyle(
                                      color: AppColors.colorButton,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ParamsAppPage(),
                              ),
                            );
                            setState(() {
                              context.setLocale(
                                Locale("en", "US"),
                              );
                            });
                            await AppCubitStorage().updateLanguage("en");
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 20, right: 20),
                            margin: EdgeInsets.only(left: 10, bottom: 10),
                            decoration: AppCubitStorage().state.Language == "en"
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.colorButton,
                                  )
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.colorButton,
                                    ),
                                  ),
                            child: Text(
                              "anglais".tr(),
                              style: AppCubitStorage().state.Language == "en"
                                  ? TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    )
                                  : TextStyle(
                                      color: AppColors.colorButton,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                onExpansionChanged: (e) {
                  setState(() {
                    // print(e);
                    _customIconLangue = e;
                    print(_customIconLangue);
                  });
                },
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
                padding: EdgeInsets.all(17),
                decoration: BoxDecoration(
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
                            child: Text(
                              "a_propos_et_aide".tr(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.double_arrow,
                        color: AppColors.blackBlue, size: 12),
                  ],
                ),
              ),
            ),

            Container(
              child: ExpansionTile(
                childrenPadding: EdgeInsets.all(0),
                expandedCrossAxisAlignment: CrossAxisAlignment.end,
                expandedAlignment: Alignment.bottomCenter,
                shape: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color.fromARGB(12, 0, 0, 0),
                  ),
                ),
                collapsedShape: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color.fromARGB(12, 0, 0, 0),
                  ),
                ),
                title: Container(
                  child: Text(
                    "déconnexion".tr(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackBlue,
                    ),
                  ),
                ),
                trailing: Icon(
                  color: AppColors.blackBlue,
                  size: 12,
                  _customIconLangue
                      ? Icons.keyboard_double_arrow_down
                      : Icons.double_arrow,
                ),
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Voulez-vous vraiment vous deconnecter?".tr(),
                      style: TextStyle(
                        color: AppColors.blackBlue,
                        fontStyle: FontStyle.italic,
                        fontSize: 12
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 20, right: 20),
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.colorButton,
                            ),
                            child: Text(
                              "${"non".tr()}",
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            print(
                                "success urlcode   ${AppCubitStorage().state.codeAssDefaul}");
                            print(
                                "success token   ${AppCubitStorage().state.tokenUser}");
                            print(
                                "success membre_code   ${AppCubitStorage().state.membreCode}");
                            print(
                                "success tournoi_code   ${AppCubitStorage().state.codeTournois}");
                            print(
                                "membre is_member ${context.read<AuthCubit>().state.detailUser!["isMember"]}");
                            print(
                                "membre configs group ${context.read<UserGroupCubit>().state.ChangeAssData!["user_group"]["configs"]}");

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(0),
                                  content: Container(
                                    padding: EdgeInsets.all(10),
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "etes_vous_sur?".tr(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.blackBlue,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  top: 5,
                                                  bottom: 5,
                                                  right: 20,
                                                  left: 20,
                                                ),
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.colorButton,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  "non".tr(),
                                                  style: TextStyle(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        LoginPage(),
                                                  ),
                                                  (route) => false,
                                                );
                                                HydratedBloc.storage.clear();
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  top: 5,
                                                  bottom: 5,
                                                  right: 20,
                                                  left: 20,
                                                ),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color:
                                                          AppColors.colorButton,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  "oui".tr(),
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.colorButton,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: 17, right: 17),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.colorButton,
                              ),
                            ),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "oui".tr(),
                              style: TextStyle(
                                color: AppColors.colorButton,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onExpansionChanged: (e) {
                  setState(() {
                    // print(e);
                    _customIconLangue = e;
                    print('_customIconLangue');
                  });
                },
              ),
            ),

            // Container(
            //   margin: EdgeInsets.all(15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         child: Text(
            //           "mode_d'affichage".tr(),
            //           style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.w600,
            //             color: AppColors.blackBlue,
            //           ),
            //         ),
            //       ),
            //       Container(
            //         height: 30,
            //         child: CustomSlidingSegmentedControl<int>(
            //           onValueChanged: (index) {
            //             setState(() {
            //               _pageIndex = index;
            //               print(_pageIndex);
            //             });
            //           },
            //           // padding: 10,
            //           // height: 25,
            //           initialValue: _pageIndex,
            //           children: {
            //             0: Row(
            //               children: [
            //                 Text(
            //                   "jour".tr(),
            //                   style: TextStyle(
            //                     color: AppColors.blackBlue,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 12,
            //                   ),
            //                 ),
            //                 Container(
            //                   margin: EdgeInsets.only(left: 3),
            //                   child: Icon(
            //                     Icons.light_mode_outlined,
            //                     size: 15,
            //                     color: AppColors.blackBlue,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             1: Row(
            //               children: [
            //                 Text(
            //                   "nuit".tr(),
            //                   style: TextStyle(
            //                       color: AppColors.blackBlue,
            //                       fontWeight: FontWeight.bold,
            //                       fontSize: 12),
            //                 ),
            //                 Container(
            //                   margin: EdgeInsets.only(left: 3),
            //                   child: Icon(
            //                     Icons.dark_mode_outlined,
            //                     size: 15,
            //                     color: AppColors.blackBlue,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           },
            //           decoration: BoxDecoration(
            //             // border: Border.all(color: Colors.black),
            //             color: Color.fromARGB(27, 36, 36, 36),
            //             borderRadius: BorderRadius.circular(8),
            //           ),
            //           thumbDecoration: BoxDecoration(
            //             // Color.fromARGB(255, 9, 185, 255),
            //             color: Color.fromARGB(255, 255, 255, 255),
            //             borderRadius: BorderRadius.circular(8),
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Color.fromARGB(97, 0, 0, 0),
            //                 blurRadius: 1.0,
            //                 spreadRadius: 0.1,
            //                 // offset: Offset(
            //                 //   0.0,
            //                 //   2.0,
            //                 // ),
            //               ),
            //             ],
            //           ),
            //           duration: Duration(milliseconds: 300),
            //           curve: Curves.ease,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.all(15),
            //   decoration: BoxDecoration(
            //       border: Border(
            //           top: BorderSide(width: 0.5, color: Colors.black12))),
            //   child: Column(
            //     children: [
            //       Container(
            //         // alignment: Alignment.topLeft,
            //         margin: EdgeInsets.only(bottom: 10),
            //         child: Text(
            //           "Notification",
            //           style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.w600,
            //             color: AppColors.blackBlue,
            //           ),
            //         ),
            //       ),
            //       Column(
            //         children: [
            //           Container(
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Container(
            //                   child: Text(
            //                     "son".tr(),
            //                     style: TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w400,
            //                       color: AppColors.blackBlue,
            //                     ),
            //                   ),
            //                 ),
            //                 Column(
            //                   children: [
            //                     Container(
            //                       height: 30,
            //                       child: CustomSlidingSegmentedControl<int>(
            //                         // padding: 10,
            //                         // height: 25,
            //                         initialValue: 0,
            //                         children: {
            //                           0: Row(
            //                             children: [
            //                               Text(
            //                                 'oui'.tr(),
            //                                 style: TextStyle(
            //                                   color: Color.fromARGB(
            //                                       255, 20, 45, 99),
            //                                   fontWeight: FontWeight.bold,
            //                                   fontSize: 12,
            //                                 ),
            //                               ),
            //                               Container(
            //                                 margin: EdgeInsets.only(left: 3),
            //                                 child: Icon(
            //                                   Icons.volume_up_outlined,
            //                                   size: 15,
            //                                   color: Color.fromARGB(
            //                                       255, 20, 45, 99),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           1: Row(
            //                             children: [
            //                               Text(
            //                                 'non'.tr(),
            //                                 style: TextStyle(
            //                                     color: Color.fromARGB(
            //                                         255, 20, 45, 99),
            //                                     fontWeight: FontWeight.bold,
            //                                     fontSize: 12),
            //                               ),
            //                               Container(
            //                                 margin: EdgeInsets.only(left: 3),
            //                                 child: Icon(
            //                                   Icons.volume_mute_outlined,
            //                                   size: 15,
            //                                   color: Color.fromARGB(
            //                                       255, 20, 45, 99),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         },
            //                         decoration: BoxDecoration(
            //                           // border: Border.all(color: Colors.black),
            //                           color: Color.fromARGB(27, 36, 36, 36),
            //                           borderRadius: BorderRadius.circular(8),
            //                         ),
            //                         thumbDecoration: BoxDecoration(
            //                           // Color.fromARGB(255, 9, 185, 255),
            //                           color: Color.fromARGB(255, 255, 255, 255),
            //                           borderRadius: BorderRadius.circular(8),
            //                           boxShadow: [
            //                             BoxShadow(
            //                               color: Color.fromARGB(97, 0, 0, 0),
            //                               blurRadius: 1.0,
            //                               spreadRadius: 0.1,
            //                               // offset: Offset(
            //                               //   0.0,
            //                               //   2.0,
            //                               // ),
            //                             ),
            //                           ],
            //                         ),
            //                         duration: Duration(milliseconds: 300),
            //                         curve: Curves.ease,
            //                         onValueChanged: (index) {
            //                           setState(() {
            //                             _pageIndex = index;
            //                             print(_pageIndex);
            //                           });
            //                         },
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //           Container(
            //             margin: EdgeInsets.only(top: 10),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Container(
            //                   child: Text(
            //                     "Vibration",
            //                     style: TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w400,
            //                       color: AppColors.blackBlue,
            //                     ),
            //                   ),
            //                 ),
            //                 Column(
            //                   children: [
            //                     Container(
            //                       height: 30,
            //                       child: CustomSlidingSegmentedControl<int>(
            //                         // padding: 10,
            //                         // height: 25,
            //                         initialValue: 0,
            //                         children: {
            //                           0: Row(
            //                             children: [
            //                               Text(
            //                                 'oui'.tr(),
            //                                 style: TextStyle(
            //                                   color: Color.fromARGB(
            //                                       255, 20, 45, 99),
            //                                   fontWeight: FontWeight.bold,
            //                                   fontSize: 12,
            //                                 ),
            //                               ),
            //                               Container(
            //                                 margin: EdgeInsets.only(left: 3),
            //                                 child: Icon(
            //                                   Icons.vibration_outlined,
            //                                   size: 15,
            //                                   color: Color.fromARGB(
            //                                       255, 20, 45, 99),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           1: Row(
            //                             children: [
            //                               Text(
            //                                 'non'.tr(),
            //                                 style: TextStyle(
            //                                     color: Color.fromARGB(
            //                                         255, 20, 45, 99),
            //                                     fontWeight: FontWeight.bold,
            //                                     fontSize: 12),
            //                               ),
            //                               Container(
            //                                 margin: EdgeInsets.only(left: 3),
            //                                 child: Icon(
            //                                   Icons.dangerous,
            //                                   size: 15,
            //                                   color: Color.fromARGB(
            //                                       255, 20, 45, 99),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         },
            //                         decoration: BoxDecoration(
            //                           // border: Border.all(color: Colors.black),
            //                           color: Color.fromARGB(27, 36, 36, 36),
            //                           borderRadius: BorderRadius.circular(8),
            //                         ),
            //                         thumbDecoration: BoxDecoration(
            //                           // Color.fromARGB(255, 9, 185, 255),
            //                           color: Color.fromARGB(255, 255, 255, 255),
            //                           borderRadius: BorderRadius.circular(8),
            //                           boxShadow: [
            //                             BoxShadow(
            //                               color: Color.fromARGB(97, 0, 0, 0),
            //                               blurRadius: 1.0,
            //                               spreadRadius: 0.1,
            //                               // offset: Offset(
            //                               //   0.0,
            //                               //   2.0,
            //                               // ),
            //                             ),
            //                           ],
            //                         ),
            //                         duration: Duration(milliseconds: 300),
            //                         curve: Curves.ease,
            //                         onValueChanged: (index) {
            //                           setState(
            //                             () {
            //                               _pageIndex = index;
            //                               print(_pageIndex);
            //                             },
            //                           );
            //                         },
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            // ],
            // ),
            // ],
            // ),
            // ),
            Expanded(
              child: Container(
                // width: MediaQuery.sizeOf(context).width,
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 20),
                // color: Colors.amber,
                child: Text(
                  "Version 1.0.1-beta",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                      color: Color.fromARGB(52, 20, 45, 99),
                      fontSize: 12,
                      fontWeight: FontWeight.w900),
                ),
              ),
            )
          ],
        ),
      );

      // Scaffold(
      //   appBar: AppBar(
      //     title: Text(
      //       "paramètres".tr(),
      //       style: TextStyle(fontSize: 16),
      //     ),
      //     backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
      //     elevation: 0,
      //   ),
      //   body:
      // );
    });
  }
}
