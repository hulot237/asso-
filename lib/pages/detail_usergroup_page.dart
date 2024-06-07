// import 'dart:ffi';
import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/business_logic/membres_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/presentation/screens/members_Ass_Page.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/checkInternetConnectionPage.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailUsergroupPage extends StatefulWidget {
  const DetailUsergroupPage({super.key});

  @override
  State<DetailUsergroupPage> createState() => _DetailUsergroupPageState();
}

class _DetailUsergroupPageState extends State<DetailUsergroupPage> {
  List<dynamic>? get currentInfoAllAssociation {
    return context.read<UserGroupCubit>().state.userGroup;
  }

  @override
  Widget build(BuildContext context) {
    final DetailAss = context.read<UserGroupCubit>().state.changeAssData;
    return BlocBuilder<UserGroupCubit, UserGroupState>(
      builder: (userGroupContext, userGroupState) {
        if (userGroupState.isLoading == true &&
            userGroupState.changeAssData == null)
          return Container(
              child: EasyLoader(
            backgroundColor: Color.fromARGB(0, 255, 255, 255),
            iconSize: 50.r,
            iconColor: AppColors.blackBlueAccent1,
            image: AssetImage(
              "assets/images/AssoplusFinal.png",
            ),
          ));
        final currentInfoAllTournoiAssCourant =
            userGroupContext.read<UserGroupCubit>().state.changeAssData;
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (authContext, authState) {
            if (authState.detailUser == null && authState.isLoading == true)
              return Container(
                  child: EasyLoader(
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                iconSize: 50.r,
                iconColor: AppColors.blackBlueAccent1,
                image: AssetImage(
                  "assets/images/AssoplusFinal.png",
                ),
              ));
            final currentDetailUser =
                authContext.read<AuthCubit>().state.detailUser;

            return (authState.errorLoadDetailAuth == true ||
                    userGroupState.errorLoadDetailChangeAss == true)
                ? checkInternetConnectionPage(
                    backToHome: true,
                    functionToCall: () {},
                  )
                : Material(
                    color: Colors.transparent,
                    child: Scaffold(
                      backgroundColor: AppColors.pageBackground,
                      appBar: AppBar(
                        title: Text(
                          "${DetailAss!.user_group!.name} (${DetailAss!.user_group!.matricule})",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: AppColors.backgroundAppBAr,
                        elevation: 0,
                        leading: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: BackButtonWidget(
                                  colorIcon: AppColors.white,
                                ),
                              ),
                        // actions: [
                        //   Stack(
                        //     alignment: Alignment.center,
                        //     children: [
                        //       GestureDetector(
                        //         onTap: () {
                        //           Modal().showBottomSheetListAss(
                        //             context,
                        //             context
                        //                 .read<UserGroupCubit>()
                        //                 .state
                        //                 .userGroup,
                        //           );
                        //         },
                        //         child: Container(
                        //           margin: EdgeInsets.only(
                        //             right: 10.h,
                        //           ),
                        //           decoration: BoxDecoration(
                        //             border: Border.all(
                        //               color: Color.fromARGB(
                        //                 255,
                        //                 255,
                        //                 26,
                        //                 9,
                        //               ),
                        //             ),
                        //             borderRadius: BorderRadius.circular(
                        //               50.r,
                        //             ),
                        //           ),
                        //           padding: EdgeInsets.all(1.r),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(50.r),
                        //             child: Container(
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(50.r),
                        //               ),
                        //               height: 20.w,
                        //               width: 20.w,
                        //               child: Image.network(
                        //                 // "zz",
                        //                 "${Variables.LienAIP}${DetailAss!.user_group!.profile_photo == null ? "" : DetailAss.user_group!.profile_photo}",
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Positioned(
                        //         right: 10.w,
                        //         top: 18.h,
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //             color: Color.fromARGB(255, 255, 26, 9),
                        //             borderRadius: BorderRadius.circular(
                        //               50.r,
                        //             ),
                        //           ),
                        //           width: 5.w,
                        //           height: 5.w,
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ],
                      ),
                      body: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 10.h,
                                      left: 10.w,
                                      right: 10.w,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            updateTrackingData(
                                                "detailGroup.tournoi",
                                                "${DateTime.now()}", {});
                                            // context.read<ServiceCubit>().state.currentService!.id;
                                            Modal().showBottomSheetListTournoi(
                                                context,
                                                currentInfoAllTournoiAssCourant
                                                    .user_group!.tournois!,
                                                false);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10.h),
                                            padding: EdgeInsets.only(
                                              top: 20.h,
                                              left: 15.w,
                                              right: 15.w,
                                              bottom: 20.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              // color: Colors.black12,
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1.r,
                                                    color: Color.fromARGB(
                                                        12, 0, 0, 0)),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        child: Icon(
                                                          Icons
                                                              .ads_click_outlined,
                                                          color: Colors.red,
                                                          size: 20.sp,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                          right: 10.w,
                                                        ),
                                                      ),
                                                      Text(
                                                        "tournoi".tr(),
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: AppColors
                                                              .blackBlue,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                for (var item
                                                    in currentInfoAllTournoiAssCourant!
                                                        .user_group!.tournois!)
                                                  if (item.tournois_code ==
                                                      AppCubitStorage()
                                                          .state
                                                          .codeTournois)
                                                    Text(
                                                      'Tournoi #${item.matricule}',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Color.fromARGB(
                                                            125, 20, 45, 99),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                // Icon(Icons.arrow_right,
                                                //     color: AppColors.blackBlue,
                                                //     size: 14.sp),
                                              ],
                                            ),
                                          ),
                                        ),

                                        // GestureDetector(
                                        //   onTap: () {
                                        //     Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             DetailUsergroupPage(),
                                        //       ),
                                        //     );
                                        //   },
                                        //   child: Container(
                                        //     padding: EdgeInsets.only(
                                        //       top: 15.h,
                                        //       left: 10.w,
                                        //       right: 10.w,
                                        //       bottom: 15.h,
                                        //     ),
                                        //     decoration: BoxDecoration(
                                        //       // color: Colors.black12,
                                        //       border: Border(
                                        //         bottom: BorderSide(
                                        //             width: 1.r,
                                        //             color: Color.fromARGB(
                                        //                 12, 0, 0, 0)),
                                        //       ),
                                        //     ),
                                        //     child: Row(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.center,
                                        //       children: [
                                        //         Expanded(
                                        //           child: Row(
                                        //             children: [
                                        //               Container(
                                        //                 width: 16.w,
                                        //                 child: Image.asset(
                                        //                   "assets/images/Groupe_ou_Asso.png",
                                        //                   // scale: ,
                                        //                 ),
                                        //                 margin: EdgeInsets.only(
                                        //                     right: 10.w),
                                        //               ),
                                        //               Text(
                                        //                 "${"Votre groupe".tr()} ASSO+"
                                        //                     .tr(),
                                        //                 style: TextStyle(
                                        //                   fontSize: 15.sp,
                                        //                   color:
                                        //                       AppColors.blackBlue,
                                        //                   fontWeight:
                                        //                       FontWeight.w500,
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //         Text(
                                        //           "${context.read<UserGroupCubit>().state.changeAssData!.user_group!.matricule == null ? "" : context.read<UserGroupCubit>().state.changeAssData!.user_group!.matricule}",
                                        //           style: TextStyle(
                                        //             fontSize: 10.sp,
                                        //             color: Color.fromARGB(
                                        //               125,
                                        //               20,
                                        //               45,
                                        //               99,
                                        //             ),
                                        //             fontWeight: FontWeight.w500,
                                        //           ),
                                        //         ),
                                        //         Icon(
                                        //           Icons.arrow_right,
                                        //           color: AppColors.blackBlue,
                                        //           size: 12.sp,
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        GestureDetector(
                                          onTap: () {
                                            updateTrackingData(
                                                "detailGroup.members",
                                                "${DateTime.now()}", {});
                                            context
                                                .read<MembreCubit>()
                                                .showMembersAss(
                                                    AppCubitStorage()
                                                        .state
                                                        .codeAssDefaul);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MembersAssPage(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10.h),
                                            padding: EdgeInsets.only(
                                              top: 20.h,
                                              left: 15.w,
                                              right: 15.w,
                                              bottom: 20.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              // color: Colors.black12,
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1.r,
                                                    color: Color.fromARGB(
                                                        12, 0, 0, 0)),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        child: Icon(
                                                          Icons.groups,
                                                          color: AppColors
                                                              .blackBlue,
                                                          size: 20.sp,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            right: 10.w),
                                                      ),
                                                      Text(
                                                        "Membres".tr(),
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: AppColors
                                                              .blackBlue,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Icon(
                                                //   Icons.arrow_right,
                                                //   color: AppColors.blackBlue,
                                                //   size: 14.sp,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: () {
                                            updateTrackingData(
                                                "detailGroup.btnSwitch",
                                                "${DateTime.now()}", {});
                                            // context.read<cubi>().state.currentService!.id;
                                            Modal().showBottomSheetListAss(
                                              context,
                                              currentInfoAllAssociation,
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10.h),
                                            padding: EdgeInsets.only(
                                              top: 20.h,
                                              left: 15.w,
                                              right: 15.w,
                                              bottom: 20.h,
                                            ),
                                            decoration: BoxDecoration(
                                              // color: Colors.black12,
                                              color: AppColors.white,
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1.r,
                                                    color: Color.fromARGB(
                                                        12, 0, 0, 0)),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 22.w,
                                                        child: Image.asset(
                                                          "assets/images/Groupe_ou_Asso.png",
                                                          // scale: ,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            right: 10.w),
                                                      ),
                                                      Text(
                                                        "Changer d'association"
                                                            .tr(),
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: AppColors
                                                              .blackBlue,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  "${context.read<UserGroupCubit>().state.changeAssData!.user_group!.matricule == null ? "" : context.read<UserGroupCubit>().state.changeAssData!.user_group!.matricule}",
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Color.fromARGB(
                                                      125,
                                                      20,
                                                      45,
                                                      99,
                                                    ),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                // Icon(
                                                //   Icons.arrow_right,
                                                //   color: AppColors.blackBlue,
                                                //   size: 14.sp,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: () async {
                                            updateTrackingData(
                                                "detailGroup.btnAddAsso",
                                                "${DateTime.now()}", {});
                                            // print("${dataForCookies}");
                                            // print("objectobjectobjectobjectobject${context.read<AuthCubit>().state.dataCookies}");
                                            await launchUrlString(
                                              "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://business.faroty.com/groups&app_mode=mobile",
                                              mode: LaunchMode.platformDefault,
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10.h),
                                            padding: EdgeInsets.only(
                                              top: 20.h,
                                              left: 10.w,
                                              right: 15.w,
                                              bottom: 20.h,
                                            ),
                                            decoration: BoxDecoration(
                                              // color: Colors.black12,
                                              color: AppColors.white,
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1.r,
                                                    color: Color.fromARGB(
                                                        12, 0, 0, 0)),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 30.w,
                                                        child: Image.asset(
                                                          "assets/images/AssoplusFinal.png",
                                                          // scale: ,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                          right: 10.w,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Créer un nouveau groupe"
                                                            .tr(),
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: AppColors
                                                              .blackBlue,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Icon(
                                                //   Icons.arrow_right,
                                                //   color: AppColors.blackBlue,
                                                //   size: 14.sp,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (!context
                                            .read<AuthCubit>()
                                            .state
                                            .detailUser!["isMember"])
                                          GestureDetector(
                                            onTap: () {
                                              updateTrackingData(
                                                  "detailGroup.inviteMember",
                                                  "${DateTime.now()}", {});
                                              Modal().showShareLinkPage(
                                                  context,
                                                  context
                                                      .read<UserGroupCubit>()
                                                      .state
                                                      .changeAssData!
                                                      .user_group!
                                                      .name
                                                  // "${Variables.LienAIP}${currentDetailUser!["photo_profil"]}",
                                                  // "Photo de profil".tr(),
                                                  );
                                              // _pickImage();
                                              // _cropImage();
                                              // Modal().showBottomShreetEditProfilPhoto(
                                              //     context, "key", _pickImage());
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(top: 10.h),
                                              padding: EdgeInsets.only(
                                                top: 20.h,
                                                left: 10.w,
                                                right: 15.w,
                                                bottom: 20.h,
                                              ),
                                              decoration: BoxDecoration(
                                                // color: Colors.black12,
                                                color: AppColors.white,
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 1.r,
                                                      color: Color.fromARGB(
                                                          12, 0, 0, 0)),
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 20.w,
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/shareIcon.svg",
                                                            // fit: BoxFit.scaleDown,
                                                            color: AppColors
                                                                .blackBlue,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10.w,
                                                                  left: 5.w),
                                                        ),
                                                        Text(
                                                          "Lien d'invitation"
                                                              .tr(),
                                                          style: TextStyle(
                                                            fontSize: 18.sp,
                                                            color: AppColors
                                                                .blackBlue,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Icon(
                                                  //   Icons.arrow_right,
                                                  //   color: AppColors.blackBlue,
                                                  //   size: 14.sp,
                                                  // ),
                                                ],
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
                          if (!context
                              .read<AuthCubit>()
                              .state
                              .detailUser!["isMember"])
                            InkWell(
                              onTap: () async {
                                updateTrackingData("detailGroup.btnAdminister",
                                    "${DateTime.now()}", {});
                                await launchUrlString(
                                  "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com&app_mode=mobile",
                                  mode: LaunchMode.platformDefault,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(360.r),
                                  border: Border.all(
                                    width: 1.w,
                                    color: AppColors.colorButton,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(75, 150, 191, 53),
                                      spreadRadius: 0.1,
                                      blurRadius: 2,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.only(
                                  top: 7.h,
                                  left: 8.w,
                                  right: 8.w,
                                ),
                                // width: MediaQuery.of(context).size.width /
                                //     1.4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 40.w,
                                      child: Image.asset(
                                        "assets/images/Groupe_ou_Asso.png",
                                        // scale: 4,
                                      ),
                                    ),
                                    Text(
                                      "Administrer le groupe".tr(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackBlue,
                                        fontSize: 20.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 100.h,
                          )
                        ],
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}
