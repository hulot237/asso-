import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/presentation/screens/help_center_screen.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/presentation/screens/notification_page.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_webview/administration_webview.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/FicheMembrePage.dart';
import 'package:faroty_association_1/pages/checkInternetConnectionPage.dart';
import 'package:faroty_association_1/pages/detail_usergroup_page.dart';
import 'package:faroty_association_1/pages/home_centrale_screen.dart';
import 'package:faroty_association_1/pages/paramsAppPage.dart';
import 'package:faroty_association_1/pages/profilPersonnelPage.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/presentation/screens/retraitPage.dart';
import 'package:faroty_association_1/pages/updatePage.dart';
import 'package:faroty_association_1/routes/app_router.dart';
import 'package:faroty_association_1/widget/add_asso_button_widget.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with WidgetsBindingObserver {
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
    } else {
      print("userGroupDefault null");
    }
  }

  Future countNotifications() async {
    final countNotificationsVar =
        await context.read<NotificationCubit>().countNotification();

    print("cdddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcrrrr");
  }

  Future<void> getNotification() async {
    await context.read<NotificationCubit>().getNotification(
        AppCubitStorage().state.tokenUser,
        AppCubitStorage().state.codeAssDefaul);
  }

  Future<void> handleDetailUser(userCode, codeTournoi) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode, codeTournoi);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    countNotifications();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      countNotifications();
      print("RETOUR");
    }
  }

  @override
  Widget build(BuildContext context) {
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
        final DetailAss = context.read<UserGroupCubit>().state.changeAssData;

        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => HomeCentraleScreen(),
              ),
              (route) => false,
            );
            return true;
          },
          child: (authState.errorLoadDetailAuth == true ||
                  userGroupState.errorLoadDetailChangeAss == true)
              ? checkInternetConnectionPage(
                  backToHome: true,
                  functionToCall: () {},
                )
              : !context.read<AuthCubit>().state.detailUser!["is_app_updated"]
                  ? UpdatePage()
                  : Scaffold(
                      backgroundColor: AppColors.pageBackground,
                      appBar: AppBar(
                        centerTitle: false,
                        title: Text(
                          "Profil".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: AppColors.backgroundAppBAr,
                        elevation: 0,
                        leading: Platform.isAndroid
                            ? InkWell(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeCentraleScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: BackButtonWidget(
                                  colorIcon: AppColors.white,
                                ),
                              )
                            : Container(),
                        actions: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10.w),
                                height: 30.h,
                                width: 30.h,
                                child: AddAssoWidget(
                                  screenSource: "profile.btnAddAsso",
                                ),
                              ),
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      updateTrackingData("profile.btnSwitch",
                                          "${DateTime.now()}", {});
                                      Modal().showBottomSheetListAss(
                                        context,
                                        context
                                            .read<UserGroupCubit>()
                                            .state
                                            .userGroup,
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: 10.h,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color.fromARGB(
                                            255,
                                            255,
                                            26,
                                            9,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          50.r,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(1.r),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.r),
                                          ),
                                          height: 30.h,
                                          width: 30.h,
                                          child: Image.network(
                                            // "zz",
                                            "${Variables.LienAIP}${DetailAss!.user_group!.profile_photo == null ? "" : DetailAss.user_group!.profile_photo}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10.w,
                                    top: 2.h,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 255, 26, 9),
                                        borderRadius: BorderRadius.circular(
                                          50.r,
                                        ),
                                      ),
                                      width: 7.w,
                                      height: 7.w,
                                    ),
                                  )
                                ],
                              ),
                              // if (!context
                              //     .read<AuthCubit>()
                              //     .state
                              //     .detailUser!["isMember"])
                              //   GestureDetector(
                              //     onTap: () async {
                              //       updateTrackingData("profile.btnAdminister",
                              //           "${DateTime.now()}", {});
                              //       launchWeb(
                              //         "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com&app_mode=mobile",
                              //       );
                              //     },
                              //     child: Container(
                              //       margin: EdgeInsets.only(
                              //         right: 10.h,
                              //       ),
                              //       padding: EdgeInsets.all(
                              //         1.r,
                              //       ),
                              //       decoration: BoxDecoration(
                              //         border: Border.all(
                              //           width: 1.r,
                              //           color: AppColors.blackBlue,
                              //         ),
                              //         color: AppColors.blackBlueAccent2,
                              //         borderRadius: BorderRadius.circular(
                              //           50.r,
                              //         ),
                              //       ),
                              //       height: 30.h,
                              //       width: 30.h,
                              //       child: Image.asset(
                              //         "assets/images/Groupe_ou_Asso.png",
                              //         scale: 4,
                              //       ),
                              //     ),
                              //   ),

                              GestureDetector(
                                onTap: () {
                                  updateTrackingData("profile.btnNotification",
                                      "${DateTime.now()}", {});
                                  context
                                      .read<NotificationCubit>()
                                      .getNotification(
                                          AppCubitStorage().state.tokenUser,
                                          AppCubitStorage()
                                              .state
                                              .codeAssDefaul);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NotificationPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: 25.w,
                                        ),
                                        child: Icon(
                                          Icons.notifications_active_outlined,
                                          color: AppColors.white,
                                          size: 30.h,
                                        ),
                                      ),
                                      BlocBuilder<NotificationCubit,
                                          NotificationState>(
                                        builder: (NotificationContext,
                                            NotificationState) {
                                          if (NotificationState
                                                      .isLoadingNomberNotif ==
                                                  true &&
                                              NotificationState.nomberNotif ==
                                                  null)
                                            return Positioned(
                                              top: 8.h,
                                              left: 8.w,
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 15.w,
                                                height: 15.w,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 0.1,
                                                  color: AppColors.green,
                                                ),
                                              ),
                                            );
                                          final currentNotifications = context
                                              .read<NotificationCubit>()
                                              .state
                                              .nomberNotif;

                                          if (currentNotifications! > 0) {
                                            return Positioned(
                                              top: 0.r,
                                              left: 12.r,
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 18.h,
                                                height: 18.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            360),
                                                    color: Colors.red,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .backgroundAppBAr)),
                                                child: Text(
                                                  "${currentNotifications}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 7.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          return Container();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                        // leading: Icon(Icons.arrow_back),
                      ),
                      body: SingleChildScrollView(
                        child: Container(
                          // decoration: BoxDecoration(
                          //   image: DecorationImage(
                          //         opacity: .2,
                          //         image: AssetImage("assets/images/BG2.png", ),
                          //         fit: BoxFit.cover,
                          //       ),
                          // ),
                          child: Column(
                            children: [
                              // color: AppColors.white,
                              //     borderRadius: BorderRadius.circular(
                              //       10.r,
                              //     ),
                              Container(
                                decoration: BoxDecoration(
                                  // image: DecorationImage(
                                  //   opacity: .2,
                                  //   image: AssetImage("assets/images/BG2.png", ),
                                  //   fit: BoxFit.cover,
                                  // ),
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                    10.r,
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                  top: 10.h,
                                ),
                                margin: EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 10.h,
                                  left: 10.w,
                                  right: 10.w,
                                ),
                                child: Column(
                                  children: [
                                    Material(
                                      color: AppColors.white,
                                      child: InkWell(
                                        onTap: () {
                                          updateTrackingData(
                                              "profile.profilePerson",
                                              "${DateTime.now()}", {});
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfilPersonnelPage(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          //height: 20,

                                          width:
                                              MediaQuery.of(context).size.width,

                                          child: Column(
                                            children: [
                                              Container(
                                                // padding: EdgeInsets.all(3.r),
                                                decoration: BoxDecoration(
                                                    // color:
                                                    //     AppColors.colorButton,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Container(
                                                    width: 80.w,
                                                    height: 80.w,
                                                    child: Image.network(
                                                      "${Variables.LienAIP}${currentDetailUser!["photo_profil"] == null ? "" : currentDetailUser!["photo_profil"]}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 5.w,
                                                    right: 5.w,
                                                    top: 10.h,
                                                    bottom: 10.h),
                                                child: Text(
                                                  "${currentDetailUser["first_name"] == null ? "" : currentDetailUser["first_name"]} ${currentDetailUser["last_name"] == null ? "" : currentDetailUser["last_name"]}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.blackBlue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // Navigator.push(
                                                  // context,
                                                  // MaterialPageRoute(
                                                  //   builder: (context) =>
                                                  //       WebViewExample(
                                                  //     // lienDePaiement:
                                                  //     //     'https://groups.faroty.com/',
                                                  //   ),
                                                  // ),

                                                  // MaterialPageRoute(
                                                  //   builder: (context) =>
                                                  //       AdministrationPage(
                                                  //     lienDePaiement:
                                                  //         'https://api.group.rush.faroty.com/',
                                                  //   ),
                                                  // ),
                                                  // );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 10.h,
                                                    horizontal: 15.w,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                        width: 1.w,
                                                        color: AppColors
                                                            .pageBackground,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        // padding: EdgeInsets.only(
                                                        //   left: 8.w,
                                                        //   right: 8.w,
                                                        //   top: 10.h,
                                                        //   bottom: 3.h,
                                                        // ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Text(
                                                          "${"numero_de_téléphone".tr()}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .blackBlue,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${currentDetailUser["first_phone"] == null ? "" : currentDetailUser["first_phone"]}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColors
                                                              .blackBlueAccent1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  // Navigator.push(
                                                  // context,
                                                  // MaterialPageRoute(
                                                  //   builder: (context) =>
                                                  //       WebViewExample(
                                                  //     // lienDePaiement:
                                                  //     //     'https://groups.faroty.com/',
                                                  //   ),
                                                  // ),

                                                  // MaterialPageRoute(
                                                  //   builder: (context) =>
                                                  //       AdministrationPage(
                                                  //     lienDePaiement:
                                                  //         'https://api.group.rush.faroty.com/',
                                                  //   ),
                                                  // ),
                                                  // );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.h,
                                                      horizontal: 15.w),
                                                  decoration: BoxDecoration(
                                                    border: Border.symmetric(
                                                      horizontal: BorderSide(
                                                        width: 1.w,
                                                        color: AppColors
                                                            .pageBackground,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        // padding: EdgeInsets.only(
                                                        //   left: 8.w,
                                                        //   right: 8.w,
                                                        //   top: 10.h,
                                                        //   bottom: 3.h,
                                                        // ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Text(
                                                          "${"matricule".tr()}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .blackBlue,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${currentDetailUser["matricule"]}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColors
                                                              .blackBlueAccent1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                color: AppColors.white,
                                                child: InkWell(
                                                  onTap: () {
                                                    updateTrackingData(
                                                        "profile.copyMemberCode",
                                                        "${DateTime.now()}",
                                                        {});
                                                    Clipboard.setData(
                                                      ClipboardData(
                                                        text:
                                                            "${currentDetailUser["membre_code"]}",
                                                        // "${AppCubitStorage().state.tokenUser}",
                                                      ),
                                                    ).then(
                                                      (value) {
                                                        return toastification
                                                            .show(
                                                          context: context,
                                                          title: Text(
                                                            "Copié".tr(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                color: AppColors
                                                                    .blackBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          autoCloseDuration:
                                                              Duration(
                                                                  seconds: 2),
                                                          type:
                                                              ToastificationType
                                                                  .success,
                                                          // borderSide: BorderSide(
                                                          //   width: 2.w,
                                                          //   color: AppColors.colorButton,
                                                          // ),
                                                          style:
                                                              ToastificationStyle
                                                                  .minimal,
                                                        );

                                                        // ScaffoldMessenger.of(
                                                        //         context)
                                                        //     .showSnackBar(
                                                        //   SnackBar(
                                                        //     content: Center(
                                                        //       child: Text(
                                                        //         '${currentDetailUser["membre_code"]}',
                                                        //         style: TextStyle(
                                                        //             fontSize: 12.sp,
                                                        //             fontWeight:
                                                        //                 FontWeight
                                                        //                     .w500),
                                                        //       ),
                                                        //     ),
                                                        //     padding: EdgeInsets.only(
                                                        //       left: 2.w,
                                                        //       right: 2.w,
                                                        //       top: 7.h,
                                                        //       bottom: 7.h,
                                                        //     ),
                                                        //     backgroundColor:
                                                        //         AppColors.colorButton,
                                                        //     behavior: SnackBarBehavior
                                                        //         .floating,
                                                        //     width: 140.w,
                                                        //     shape: StadiumBorder(),
                                                        //     duration: Duration(
                                                        //         milliseconds: 1000),
                                                        //     elevation: 0,
                                                        //   ),
                                                        // );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.h,
                                                            horizontal: 15.w),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              5,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "${"Code pour paiement".tr()}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .blackBlue,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          5.w),
                                                              child: Text(
                                                                "${currentDetailUser["membre_code"]}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .blackBlueAccent1,
                                                                ),
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .content_copy,
                                                              size: 14.sp,
                                                              color: AppColors
                                                                  .blackBlueAccent1,
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                    10.r,
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                    // top: 20.h,
                                    ),
                                margin: EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 10.h,
                                  left: 10.w,
                                  right: 10.w,
                                ),
                                // child: Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            // top: 15.h,
                                            // left: 10.w,
                                            // right: 10.w,
                                            ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Material(
                                              color: AppColors.white,
                                              child: InkWell(
                                                onTap: () {
                                                  updateTrackingData(
                                                      "profile.memberCard",
                                                      "${DateTime.now()}", {});
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AccountPage(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: 20.h,
                                                    left: 15.w,
                                                    right: 15.w,
                                                    bottom: 20.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          width: 1.r,
                                                          color: Color.fromARGB(
                                                              12, 0, 0, 0)),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: Icon(
                                                                Icons
                                                                    .phone_android_outlined,
                                                                color: AppColors
                                                                    .bleuLight,
                                                                size: 18.sp,
                                                              ),
                                                              margin: EdgeInsets
                                                                  .only(
                                                                right: 10.w,
                                                              ),
                                                            ),
                                                            Text(
                                                              "votre_compte"
                                                                  .tr(),
                                                              style: TextStyle(
                                                                fontSize: 18.sp,
                                                                color: AppColors
                                                                    .blackBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_right,
                                                        color:
                                                            AppColors.blackBlue,
                                                        size: 18.sp,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (currentDetailUser[
                                                    "is_withdrawal_approvers"] ==
                                                1)
                                              Material(
                                                color: AppColors.white,
                                                child: InkWell(
                                                  onTap: () {
                                                    updateTrackingData(
                                                        "profile.withdrawal",
                                                        "${DateTime.now()}",
                                                        {});
                                                    handleDetailUser(
                                                        AppCubitStorage()
                                                            .state
                                                            .membreCode,
                                                        AppCubitStorage()
                                                            .state
                                                            .codeTournois);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RetraitPage()));
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                      top: 20.h,
                                                      left: 15.w,
                                                      right: 15.w,
                                                      bottom: 20.h,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      // color: Colors.black12,
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            width: 1.r,
                                                            color:
                                                                Color.fromARGB(
                                                                    12,
                                                                    0,
                                                                    0,
                                                                    0)),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                child: Icon(
                                                                  Icons
                                                                      .account_balance_wallet_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 18.sp,
                                                                ),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right: 10
                                                                            .w),
                                                              ),
                                                              Text(
                                                                "retrait_en_attente"
                                                                    .tr(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      18.sp,
                                                                  color: AppColors
                                                                      .blackBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.arrow_right,
                                                          color: AppColors
                                                              .blackBlue,
                                                          size: 18.sp,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            // GestureDetector(
                                            //   onTap: () {
                                            //     // context.read<ServiceCubit>().state.currentService!.id;
                                            //     Modal().showBottomSheetListTournoi(
                                            //       context,
                                            //       currentInfoAllTournoiAssCourant
                                            //           .user_group!.tournois!,
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
                                            //                 child: Icon(
                                            //                   Icons.ads_click_outlined,
                                            //                   color: Colors.red,
                                            //                   size: 15.sp,
                                            //                 ),
                                            //                 margin: EdgeInsets.only(
                                            //                   right: 10.w,
                                            //                 ),
                                            //               ),
                                            //               Text(
                                            //                 "tournoi".tr(),
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
                                            //         for (var item
                                            //             in currentInfoAllTournoiAssCourant!
                                            //                 .user_group!.tournois!)
                                            //           if (item.tournois_code ==
                                            //               AppCubitStorage()
                                            //                   .state
                                            //                   .codeTournois)
                                            //             Text(
                                            //               'Tournoi #${item.matricule}',
                                            //               style: TextStyle(
                                            //                 fontSize: 10.sp,
                                            //                 color: Color.fromARGB(
                                            //                     125, 20, 45, 99),
                                            //                 fontWeight: FontWeight.w500,
                                            //               ),
                                            //             ),
                                            //         Icon(Icons.arrow_right,
                                            //             color: AppColors.blackBlue,
                                            //             size: 12.sp),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),

                                            // GestureDetector(
                                            //   onTap: () {
                                            //     // context.read<ServiceCubit>().state.currentService!.id;
                                            //     Modal().showBottomSheetListAss(
                                            //       context,
                                            //       currentInfoAllAssociation,
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
                                            //                 "Groups & associations"
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

                                            Material(
                                              color: AppColors.white,
                                              child: InkWell(
                                                onTap: () {
                                                  updateTrackingData(
                                                      "profile.detailGroup",
                                                      "${DateTime.now()}", {});
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailUsergroupPage(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: 20.h,
                                                    left: 10.w,
                                                    right: 15.w,
                                                    bottom: 20.h,
                                                  ),
                                                  decoration: BoxDecoration(
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 28.w,
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/AssoplusFinal.png",
                                                                // scale: ,
                                                              ),
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10.w),
                                                            ),
                                                            Text(
                                                              "${"Votre groupe".tr()} ASSO+"
                                                                  .tr(),
                                                              style: TextStyle(
                                                                fontSize: 18.sp,
                                                                color: AppColors
                                                                    .blackBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        "${context.read<UserGroupCubit>().state.changeAssData!.user_group!.matricule == null ? "" : context.read<UserGroupCubit>().state.changeAssData!.user_group!.matricule}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          color: Color.fromARGB(
                                                            125,
                                                            20,
                                                            45,
                                                            99,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_right,
                                                        color:
                                                            AppColors.blackBlue,
                                                        size: 18.sp,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                            // GestureDetector(
                                            //   onTap: () {
                                            //     // context.read<MembreCubit>().showMembersAss(
                                            //     //     AppCubitStorage().state.codeAssDefaul);
                                            //     Navigator.push(
                                            //       context,
                                            //       MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             AdministrationPageWebview(
                                            //           forAdmin: false,
                                            //           urlPage:
                                            //               'https://business.faroty.com/groups',
                                            //         ),
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
                                            //                 width: 20.w,
                                            //                 child: Image.asset(
                                            //                   "assets/images/AssoplusFinal.png",
                                            //                   // scale: ,
                                            //                 ),
                                            //                 margin: EdgeInsets.only(
                                            //                     right: 5.w),
                                            //               ),
                                            //               Text(
                                            //                 "Créer un groupe ASSO+"
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
                                            //         Icon(
                                            //           Icons.arrow_right,
                                            //           color: AppColors.blackBlue,
                                            //           size: 12.sp,
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),

                                            // GestureDetector(
                                            //   onTap: () {
                                            //     context
                                            //         .read<MembreCubit>()
                                            //         .showMembersAss(AppCubitStorage()
                                            //             .state
                                            //             .codeAssDefaul);
                                            //     Navigator.push(
                                            //       context,
                                            //       MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             MembersAssPage(),
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
                                            //                 child: Icon(
                                            //                   Icons.groups,
                                            //                   color:
                                            //                       AppColors.blackBlue,
                                            //                   size: 15.sp,
                                            //                 ),
                                            //                 margin: EdgeInsets.only(
                                            //                     right: 10.w),
                                            //               ),
                                            //               Text(
                                            //                 "Membres".tr(),
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
                                            //         Icon(
                                            //           Icons.arrow_right,
                                            //           color: AppColors.blackBlue,
                                            //           size: 12.sp,
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),

                                            Material(
                                              color: AppColors.white,
                                              child: InkWell(
                                                onTap: () {
                                                  updateTrackingData(
                                                      "profile.parameter",
                                                      "${DateTime.now()}", {});
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ParamsAppPage(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: 20.h,
                                                    left: 15.w,
                                                    right: 15.w,
                                                    bottom: 20.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    // color: Colors.black12,
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 1.r,
                                                        color: Color.fromARGB(
                                                            12, 0, 0, 0),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: Icon(
                                                                Icons
                                                                    .settings_outlined,
                                                                color: Colors
                                                                    .brown,
                                                                size: 18.sp,
                                                              ),
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10.w),
                                                            ),
                                                            Text(
                                                              "paramètres".tr(),
                                                              style: TextStyle(
                                                                fontSize: 18.sp,
                                                                color: AppColors
                                                                    .blackBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_right,
                                                        color:
                                                            AppColors.blackBlue,
                                                        size: 18.sp,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Material(
                                              color: AppColors.white,
                                              child: InkWell(
                                                onTap: () {
                                                  updateTrackingData(
                                                      "profile.helpCenter",
                                                      "${DateTime.now()}", {});
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          HelpCenterScreen(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: 20.h,
                                                    left: 15.w,
                                                    right: 15.w,
                                                    bottom: 20.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    // color: Colors.black12,
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 1.r,
                                                        color: Color.fromARGB(
                                                            12, 0, 0, 0),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: Icon(
                                                                Icons
                                                                    .help_outline_rounded,
                                                                color:
                                                                    Colors.red,
                                                                size: 18.sp,
                                                              ),
                                                              margin: EdgeInsets
                                                                  .only(
                                                                right: 10.w,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Centre d'aide"
                                                                  .tr(),
                                                              style: TextStyle(
                                                                fontSize: 18.sp,
                                                                color: AppColors
                                                                    .blackBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_right,
                                                        color:
                                                            AppColors.blackBlue,
                                                        size: 18.sp,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Material(
                                              color: AppColors.white,
                                              child: InkWell(
                                                onTap: () {
                                                  updateTrackingData(
                                                      "profile.shareApp",
                                                      "${DateTime.now()}", {});
                                                  Share.share(
                                                    """${'Gérez vos associations et groupes avec *ASSO+* et obtenez vos bilans instantanément.'.tr()}\n${'Disponible ici'.tr()} : \nhttps://faroty.com/dl/groups \n${'et sur'.tr()} https://groups.faroty.com"""
                                                        .tr(),
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: 20.h,
                                                    left: 15.w,
                                                    right: 15.w,
                                                    bottom: 20.h,
                                                  ),
                                                  decoration: BoxDecoration(
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: Icon(
                                                                Icons
                                                                    .share_outlined,
                                                                color: AppColors
                                                                    .greenAssociation,
                                                                size: 18.sp,
                                                              ),
                                                              margin: EdgeInsets
                                                                  .only(
                                                                right: 10.w,
                                                              ),
                                                            ),
                                                            Text(
                                                              "partager_l'application"
                                                                  .tr(),
                                                              style: TextStyle(
                                                                fontSize: 18.sp,
                                                                color: AppColors
                                                                    .blackBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_right,
                                                        color:
                                                            AppColors.blackBlue,
                                                        size: 18.sp,
                                                      ),
                                                    ],
                                                  ),
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
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
        );
      });
    });
  }
}
