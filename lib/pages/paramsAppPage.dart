import 'dart:io';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/loginScreen.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/business_logic/tontine_perso_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/business_logic/tontine_perso_state.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/presentation/screen/identite_screen.dart';
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
import 'package:faroty_association_1/widget/widget_check_code.dart';
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
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackButtonWidget(colorIcon: AppColors.white)),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    appBar: AppBar(
      title: Text(
        "paramètres".tr(),
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: BackButtonWidget(colorIcon: AppColors.white)),
    ),
    body: child,
  );
}

class _ParamsAppPageState extends State<ParamsAppPage> {
  int _pageIndex = 0;
  bool _customIconLangue = false;
  bool _isSwitched = AppCubitStorage().state.maskSold;

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
                BlocBuilder<TontinePersoCubit, TontinePersoState>(
                  builder: (context, state) {
                    final cubit = context.read<TontinePersoCubit>();
                    final isNoSubmit = cubit.isNoSubmit;
                    return AppCubitStorage().state.isNoSubmit
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.w, right: 10.w, top: 20.h),
                                child: Text(
                                  "Tontine perso".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackBlue,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 15.w, right: 10.w),
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Row(
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text(
                                            'Modifier votre PIN',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.blackBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        print('Premier élément tapé');
                                      },
                                    ),
                                    Divider(
                                      height: 1,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Row(
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text(
                                            'Afficher votre identité',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.blackBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () async {
                                        final isCodeValid =
                                            await showCodeDialog(context);
                                        if (isCodeValid['isValid'])
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  IdentiteScreen(),
                                            ),
                                          );
                                        print('Premier élément tapé');
                                      },
                                    ),
                                    Divider(
                                      height: 1,
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Row(
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Expanded(
                                            child: Text(
                                              'Toujours masquer votre solde',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.blackBlue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Transform.scale(
                                        scale: .6.r,
                                        child: CupertinoSwitch(
                                          activeColor:
                                              AppColors.greenAssociation,
                                          value: _isSwitched,
                                          onChanged: (bool value) async {
                                            final isCodeValid =
                                                await showCodeDialog(context);
                                            if (isCodeValid['isValid']) {
                                              setState(() {
                                                _isSwitched = value;
                                              });
                                              await AppCubitStorage()
                                                  .updateMaskSold(_isSwitched);
                                              print(
                                                  'Switch toggled to: $_isSwitched');
                                            }
                                          },
                                        ),
                                      ),
                                      onTap: () async {
                                        print('Premier élément tapé');
                                        final isCodeValid =
                                            await showCodeDialog(context);
                                        if (isCodeValid['isValid']) {
                                          setState(() {
                                            _isSwitched =
                                                _isSwitched ? false : true;
                                          });
                                          await AppCubitStorage()
                                              .updateMaskSold(_isSwitched);
                                        }
                                      },
                                    ),
                                    Divider(
                                      height: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 25.h, bottom: 15.h),
                      child: Text(
                        "General".toUpperCase(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackBlue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 15.w,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "langue".tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackBlue,
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      updateTrackingData("parameter.language",
                                          "${DateTime.now()}", {});
                                      await context.setLocale(
                                        Locale("fr", "FR"),
                                      );
                                      await UserGroupRepository().ChangerLang(
                                          AppCubitStorage().state.codeAssDefaul,
                                          "fr");
                                      print(context.locale.toString());
                                      await dataLanguage.updateLanguage('fr');
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: 5.h,
                                        bottom: 5.h,
                                        right: 20.w,
                                        left: 20.w,
                                      ),
                                      margin: EdgeInsets.only(
                                          left: 10.w, bottom: 10.h),
                                      decoration: context.locale.toString() ==
                                              "fr_FR"
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              color: AppColors.colorButton,
                                            )
                                          : BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              border: Border.all(
                                                color: AppColors.colorButton,
                                              ),
                                            ),
                                      child: Text(
                                        "${"francais".tr()}",
                                        style: context.locale.toString() ==
                                                "fr_FR"
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
                                      await context.setLocale(
                                        Locale("en", "US"),
                                      );
                                      await UserGroupRepository().ChangerLang(
                                          AppCubitStorage().state.codeAssDefaul,
                                          "en");

                                      print(context.locale.toString());

                                      await AppCubitStorage()
                                          .updateLanguage("en");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: 5.h,
                                        bottom: 5.h,
                                        left: 20.w,
                                        right: 20.w,
                                      ),
                                      margin: EdgeInsets.only(
                                          left: 10.w, bottom: 10.h),
                                      decoration: context.locale.toString() ==
                                              "en_US"
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              color: AppColors.colorButton,
                                            )
                                          : BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              border: Border.all(
                                                color: AppColors.colorButton,
                                              ),
                                            ),
                                      child: Text(
                                        "anglais".tr(),
                                        style: context.locale.toString() ==
                                                "en_US"
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
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Divider(
                            height: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              updateTrackingData("parameter.aboutHelp",
                                  "${DateTime.now()}", {});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProposAidePage(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 15.h,
                                bottom: 15.h,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.r,
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Container(
                //   child: ExpansionTile(
                //     childrenPadding: EdgeInsets.all(0),
                //     expandedCrossAxisAlignment: CrossAxisAlignment.end,
                //     expandedAlignment: Alignment.bottomCenter,
                //     shape: Border(
                //       bottom: BorderSide(
                //         width: 1.r,
                //         color: Color.fromARGB(12, 0, 0, 0),
                //       ),
                //     ),
                //     collapsedShape: Border(
                //       bottom: BorderSide(
                //         width: 1.r,
                //         color: Color.fromARGB(12, 0, 0, 0),
                //       ),
                //     ),
                //     title: Container(
                //       child: Text(
                //         "déconnexion".tr(),
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w600,
                //           color: AppColors.blackBlue,
                //         ),
                //       ),
                //     ),
                //     trailing: Icon(
                //       color: AppColors.blackBlue,
                //       size: 12.sp,
                //       _customIconLangue
                //           ? Icons.keyboard_double_arrow_down
                //           : Icons.double_arrow,
                //     ),
                //     children: [
                //       Container(
                //         padding: EdgeInsets.only(left: 20.w),
                //         child: Text(
                //           "Voulez-vous vraiment vous deconnecter ?".tr(),
                //           style: TextStyle(
                //             color: AppColors.blackBlue,
                //             fontStyle: FontStyle.italic,
                //             fontSize: 12.sp,
                //           ),
                //         ),
                //         alignment: Alignment.centerLeft,
                //       ),
                //       Container(
                //         padding: EdgeInsets.only(
                //           right: 20.w,
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             GestureDetector(
                //               onTap: () async {
                //                 Navigator.pop(context);
                //               },
                //               child: Container(
                //                 padding: EdgeInsets.only(
                //                   top: 10.h,
                //                   bottom: 10.h,
                //                   left: 20.w,
                //                   right: 20.w,
                //                 ),
                //                 margin: EdgeInsets.only(right: 10.w),
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(8),
                //                   color: AppColors.colorButton,
                //                 ),
                //                 child: Text(
                //                   "${"non".tr()}",
                //                   style: TextStyle(
                //                     color: AppColors.white,
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 12.sp,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             GestureDetector(
                //               onTap: () async {
                //                 updateTrackingData("parameter.logOut",
                //                     "${DateTime.now()}", {});
                //                 showDialog(
                //                   context: context,
                //                   builder: (BuildContext context) {
                //                     return AlertDialog(
                //                       contentPadding: EdgeInsets.all(0),
                //                       content: Container(
                //                         padding: EdgeInsets.all(10),
                //                         height: 150.h,
                //                         width:
                //                             MediaQuery.of(context).size.width,
                //                         decoration: BoxDecoration(
                //                           color: AppColors.white,
                //                           borderRadius:
                //                               BorderRadius.circular(10),
                //                         ),
                //                         child: Column(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Container(
                //                               alignment: Alignment.topLeft,
                //                               child: Text(
                //                                 "etes_vous_sur?".tr(),
                //                                 style: TextStyle(
                //                                   fontSize: 18.sp,
                //                                   color: AppColors.blackBlue,
                //                                 ),
                //                               ),
                //                             ),
                //                             Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.end,
                //                               children: [
                //                                 GestureDetector(
                //                                   onTap: () {
                //                                     Navigator.pop(context);
                //                                   },
                //                                   child: Container(
                //                                     padding: EdgeInsets.only(
                //                                       top: 5.h,
                //                                       bottom: 5.h,
                //                                       right: 20.w,
                //                                       left: 20.w,
                //                                     ),
                //                                     decoration: BoxDecoration(
                //                                         color: AppColors
                //                                             .colorButton,
                //                                         borderRadius:
                //                                             BorderRadius
                //                                                 .circular(10)),
                //                                     child: Text(
                //                                       "non".tr(),
                //                                       style: TextStyle(
                //                                         color: AppColors.white,
                //                                         fontWeight:
                //                                             FontWeight.w600,
                //                                         fontSize: 16.sp,
                //                                       ),
                //                                     ),
                //                                   ),
                //                                 ),
                //                                 SizedBox(
                //                                   width: 5.w,
                //                                 ),
                //                                 GestureDetector(
                //                                   onTap: () {
                //                                     Navigator.of(context)
                //                                         .pushAndRemoveUntil(
                //                                       MaterialPageRoute(
                //                                         builder: (BuildContext
                //                                                 context) =>
                //                                             PreLoginScreen(),
                //                                       ),
                //                                       (route) => false,
                //                                     );
                //                                     HydratedBloc.storage
                //                                         .clear();
                //                                   },
                //                                   child: Container(
                //                                     padding: EdgeInsets.only(
                //                                       top: 5.h,
                //                                       bottom: 5.h,
                //                                       right: 20.w,
                //                                       left: 20.w,
                //                                     ),
                //                                     decoration: BoxDecoration(
                //                                         border: Border.all(
                //                                           width: 1.r,
                //                                           color: AppColors
                //                                               .colorButton,
                //                                         ),
                //                                         borderRadius:
                //                                             BorderRadius
                //                                                 .circular(10)),
                //                                     child: Text(
                //                                       "oui".tr(),
                //                                       style: TextStyle(
                //                                         color: AppColors
                //                                             .colorButton,
                //                                         fontWeight:
                //                                             FontWeight.w600,
                //                                         fontSize: 16.sp,
                //                                       ),
                //                                     ),
                //                                   ),
                //                                 ),
                //                               ],
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                     );
                //                   },
                //                 );
                //               },
                //               child: Container(
                //                 padding: EdgeInsets.only(
                //                     top: 8.h,
                //                     bottom: 8.h,
                //                     left: 17.w,
                //                     right: 17.w),
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(8),
                //                   border: Border.all(
                //                     color: AppColors.colorButton,
                //                   ),
                //                 ),
                //                 margin:
                //                     EdgeInsets.only(top: 10.h, bottom: 10.h),
                //                 child: Text(
                //                   "oui".tr(),
                //                   style: TextStyle(
                //                     color: AppColors.colorButton,
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 12.sp,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //     onExpansionChanged: (e) async {
                //       setState(() {
                //         // print(e);
                //         _customIconLangue = e;
                //         print(
                //             "Code notification: ${AppCubitStorage().state.tokenNotification}");
                //         print(
                //             "Code token: ${AppCubitStorage().state.tokenUser}");
                //         print(
                //             "Code ass: ${AppCubitStorage().state.codeAssDefaul}");
                //         print(
                //             "Code tournoi: ${AppCubitStorage().state.codeTournois}");
                //         print(
                //             "Code usernamekey: ${AppCubitStorage().state.userNameKey}");
                //         print(
                //             "Code passswordkey: ${AppCubitStorage().state.passwordKey}");
                //         print(
                //             "Code id session: ${AppCubitStorage().state.xSessionId}");
                //         print(
                //             "Code tournoiHist: ${AppCubitStorage().state.codeTournoisHist}");
                //       });
                //     },
                //   ),
                // ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.h),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            print(
                                "Code notification: ${AppCubitStorage().state.tokenNotification}");
                            print(
                                "Code isNoSubmit: ${AppCubitStorage().state.isNoSubmit}");
                            print(
                                "Code passWordTontinePerso: ${AppCubitStorage().state.passWordTontinePerso}");
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
                            print(
                                "Code tournoiHist: ${AppCubitStorage().state.codeTournoisHist}");
                            updateTrackingData(
                                "parameter.logOut", "${DateTime.now()}", {});
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(0),
                                  content: Container(
                                    padding: EdgeInsets.all(10.r),
                                    height: 150.h,
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
                                            "Voulez-vous vraiment vous deconnecter ?"
                                                .tr(),
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
                                                HydratedBloc.storage.clear();
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
                                left: 15.w, right: 15.w, top: 3.h, bottom: 3.h),
                            margin: EdgeInsets.only(bottom: 35.h),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border.all(
                                  color: AppColors.red,
                                ),
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Text(
                              "déconnexion".tr(),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.red,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40.r,
                                  child: Image.asset(
                                      "assets/images/FAroty_gris.png"),
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
