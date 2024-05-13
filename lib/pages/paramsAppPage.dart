import 'dart:io';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/loginScreen.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_repository.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/appStorageModel.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/pre_login_screen.dart';
import 'package:faroty_association_1/pages/proposAidePage.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: BackButtonWidget(colorIcon: AppColors.white)
        ),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    appBar: AppBar(
      title: Text(
        "paramètres".tr(),
        style: TextStyle(fontSize: 16.sp, color: AppColors.white,fontWeight: FontWeight.bold,),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: BackButtonWidget(colorIcon: AppColors.white)
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
    print("dddddddddddddddddddd ${AppCubitStorage().state.codeTournois}");
  }

  // Map<String, dynamic>? get dataLanguage {
  //   return context.read<UserGroupCubit>().state.userGroupDefault;
  // }

  @override
  Widget build(BuildContext context) {
    final dataLanguage = context.read<AppCubitStorage>();

    return BlocBuilder<AppCubitStorage, AppStorageModel>(
        builder: (context, state) {
      return Material(
        type: MaterialType.transparency,
        child: PageScaffold(
          context: context,
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              children: [
                Container(
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.all(0),
                    shape: Border(
                      bottom: BorderSide(
                        width: 1.r,
                        color: Color.fromARGB(12, 0, 0, 0),
                      ),
                    ),
                    collapsedShape: Border(
                      bottom: BorderSide(
                        width: 1.r,
                        color: Color.fromARGB(12, 0, 0, 0),
                      ),
                    ),
                    title: Container(
                      child: Text(
                        "langue".tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackBlue,
                        ),
                      ),
                    ),
                    trailing: Icon(
                      color: AppColors.blackBlue,
                      size: 12.sp,
                      _customIconLangue
                          ? Icons.keyboard_double_arrow_down
                          : Icons.double_arrow,
                    ),
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                updateTrackingData("parameter.language","${DateTime.now()}", {});
                                // Navigator.pop(context);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ParamsAppPage(),
                                //   ),
                                // );
                                // setState(() {
                                await context.setLocale(
                                  Locale("fr", "FR"),
                                );
                                await UserGroupRepository().ChangerLang(
                                    AppCubitStorage().state.codeAssDefaul,
                                    "fr");
                                // });
                                print(context.locale.toString());
                                // AppCubitStorage().updateLanguage("fr");
                                await dataLanguage.updateLanguage('fr');
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 9.h,
                                  bottom: 9.h,
                                  right: 20.w,
                                  left: 20.w,
                                ),
                                margin:
                                    EdgeInsets.only(left: 10.w, bottom: 10.h),
                                decoration: context.locale.toString() == "fr_FR"
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
                                  style: context.locale.toString() == "fr_FR"
                                      ? TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                        )
                                      : TextStyle(
                                          color: AppColors.colorButton,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                        ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                
                                // Navigator.pop(context);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ParamsAppPage(),
                                //   ),
                                // );
                                // setState(() {
                                await context.setLocale(
                                  Locale("en", "US"),
                                );
                                await UserGroupRepository().ChangerLang(
                                    AppCubitStorage().state.codeAssDefaul,
                                    "en");

                                // });
                                print(context.locale.toString());

                                await AppCubitStorage().updateLanguage("en");
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 10.h,
                                  left: 20.w,
                                  right: 20.w,
                                ),
                                margin:
                                    EdgeInsets.only(left: 10.w, bottom: 10.h),
                                decoration: context.locale.toString() == "en_US"
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
                                  style: context.locale.toString() == "en_US"
                                      ? TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                        )
                                      : TextStyle(
                                          color: AppColors.colorButton,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
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
                      });
                    },
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    updateTrackingData("parameter.aboutHelp","${DateTime.now()}", {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProposAidePage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(17.r),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 1.r, color: Color.fromARGB(12, 0, 0, 0)),
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
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.double_arrow,
                          color: AppColors.blackBlue,
                          size: 12.sp,
                        ),
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
                        width: 1.r,
                        color: Color.fromARGB(12, 0, 0, 0),
                      ),
                    ),
                    collapsedShape: Border(
                      bottom: BorderSide(
                        width: 1.r,
                        color: Color.fromARGB(12, 0, 0, 0),
                      ),
                    ),
                    title: Container(
                      child: Text(
                        "déconnexion".tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackBlue,
                        ),
                      ),
                    ),
                    trailing: Icon(
                      color: AppColors.blackBlue,
                      size: 12.sp,
                      _customIconLangue
                          ? Icons.keyboard_double_arrow_down
                          : Icons.double_arrow,
                    ),
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          "Voulez-vous vraiment vous deconnecter?".tr(),
                          style: TextStyle(
                            color: AppColors.blackBlue,
                            fontStyle: FontStyle.italic,
                            fontSize: 12.sp,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: 20.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 10.h,
                                  left: 20.w,
                                  right: 20.w,
                                ),
                                margin: EdgeInsets.only(right: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.colorButton,
                                ),
                                child: Text(
                                  "${"non".tr()}",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                updateTrackingData("parameter.logOut","${DateTime.now()}", {});
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.all(0),
                                      content: Container(
                                        padding: EdgeInsets.all(10),
                                        height: 150.h,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                  fontSize: 18.sp,
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
                                                      top: 5.h,
                                                      bottom: 5.h,
                                                      right: 20.w,
                                                      left: 20.w,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .colorButton,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Text(
                                                      "non".tr(),
                                                      style: TextStyle(
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            PreLoginScreen(),
                                                      ),
                                                      (route) => false,
                                                    );
                                                    HydratedBloc.storage
                                                        .clear();
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                      top: 5.h,
                                                      bottom: 5.h,
                                                      right: 20.w,
                                                      left: 20.w,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 1.r,
                                                          color: AppColors
                                                              .colorButton,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Text(
                                                      "oui".tr(),
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .colorButton,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16.sp,
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
                                    top: 8.h,
                                    bottom: 8.h,
                                    left: 17.w,
                                    right: 17.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.colorButton,
                                  ),
                                ),
                                margin:
                                    EdgeInsets.only(top: 10.h, bottom: 10.h),
                                child: Text(
                                  "oui".tr(),
                                  style: TextStyle(
                                    color: AppColors.colorButton,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    onExpansionChanged: (e) async {

                      setState(() {
                        // print(e);
                        _customIconLangue = e;
                        print(
                            "Code notification: ${AppCubitStorage().state.tokenNotification}");
                        print(
                            "Code token: ${AppCubitStorage().state.tokenUser}");
                        print(
                            "Code ass: ${AppCubitStorage().state.codeAssDefaul}");
                        print(
                            "Code tournoi: ${AppCubitStorage().state.codeTournois}");
                        print(
                            "Code usernamekey: ${AppCubitStorage().state.userNameKey}");
                        print(
                            "Code passswordkey: ${AppCubitStorage().state.passwordKey}");
                            print(
                            "Code id session: ${AppCubitStorage().state.xSessionId}");
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
              margin: EdgeInsets.only(bottom: 5.h),
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "By",
                        style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: 40.r,
                        child: Image.asset("assets/images/FAroty_gris.png"),
                      ),
                      Text(
                        "Version ${Variables.version}",
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
                )
              ],
            ),
          ),
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
