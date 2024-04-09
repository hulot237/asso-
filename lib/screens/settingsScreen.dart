import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/business_logic/membres_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/presentation/screens/notification_page.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_webview/administration_webview.dart';
import 'package:faroty_association_1/Association_And_Group/association_webview/create_new_ass.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/loginScreen.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/FicheMembrePage.dart';
import 'package:faroty_association_1/Association_And_Group/association_webview/administrationPage.dart';
import 'package:faroty_association_1/pages/checkInternetConnectionPage.dart';
import 'package:faroty_association_1/pages/homePage.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/presentation/screens/members_Ass_Page.dart';
import 'package:faroty_association_1/pages/paramsAppPage.dart';
import 'package:faroty_association_1/pages/profilPersonnelPage.dart';
import 'package:faroty_association_1/pages/proposAidePage.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/presentation/screens/retraitPage.dart';
import 'package:faroty_association_1/pages/testWebViewOne.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
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
    // TODO: implement initState
    countNotifications();

    super.initState();
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

        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(),
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
              : Scaffold(
                  backgroundColor: AppColors.pageBackground,
                  appBar: AppBar(
                    title: Text(
                      "Profil".tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                    ),
                    backgroundColor: AppColors.backgroundAppBAr,
                    elevation: 0,
                    leading: Platform.isAndroid
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.white,
                              size: 16.sp,
                            ),
                          )
                        : Container(),
                    actions: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => createNewAss(
                                //         // forAdmin: false,
                                //         // urlPage: 'https://business.faroty.com/groups',
                                //       ),
                                //     ),
                                //   );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AdministrationPageWebview(
                                      forAdmin: false,
                                      urlPage:
                                          'https://business.faroty.com/groups',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.w),
                                padding: EdgeInsets.all(1.r),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.r, color: AppColors.blackBlue),
                                  color: AppColors.blackBlueAccent2,
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                height: 25.h,
                                width: 25.h,
                                child: Icon(
                                  Icons.add,
                                  size: 11.sp,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
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
                                      size: 20.sp,
                                    ),
                                  ),
                                  BlocBuilder<NotificationCubit,
                                      NotificationState>(
                                    builder: (NotificationContext,
                                        NotificationState) {
                                      if (NotificationState
                                                  .isLoadingNomberNotif ==
                                              true &&
                                          NotificationState.nomberNotif == null)
                                        return Positioned(
                                          top: 8.h,
                                          left: 8.w,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 15.w,
                                            height: 15.w,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 0.1,
                                              color: AppColors.blackBlue,
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
                                                    BorderRadius.circular(360),
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
                  body: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.h, bottom: 5.h),
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
                                padding: EdgeInsets.all(3.r),
                                decoration: BoxDecoration(
                                    color: AppColors.colorButton,
                                    borderRadius: BorderRadius.circular(100)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    width: 90.w,
                                    height: 90.w,
                                    child: Image.network(
                                      "${Variables.LienAIP}${currentDetailUser!["photo_profil"] == null ? "" : currentDetailUser!["photo_profil"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProfilPersonnelPage(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 5.w, right: 5.w, top: 5.h),
                                      child: Text(
                                        "${currentDetailUser["first_name"] == null ? "" : currentDetailUser["first_name"]} ${currentDetailUser["last_name"] == null ? "" : currentDetailUser["last_name"]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
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
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: 8.w,
                                                right: 8.w,
                                                top: 5.h,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                "${"matricule".tr()}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors
                                                      .blackBlueAccent1,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "${currentDetailUser["matricule"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    AppColors.blackBlueAccent1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                                  text:
                                                      "${currentDetailUser["membre_code"]}"))
                                              .then(
                                            (value) {
                                              return ScaffoldMessenger.of(
                                                      context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Center(
                                                    child: Text(
                                                      '${currentDetailUser["membre_code"]}',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                    left: 2.w,
                                                    right: 2.w,
                                                    top: 7.h,
                                                    bottom: 7.h,
                                                  ),
                                                  backgroundColor:
                                                      AppColors.colorButton,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  width: 140.w,
                                                  shape: StadiumBorder(),
                                                  duration: Duration(
                                                      milliseconds: 1000),
                                                  elevation: 0,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                top: 5.h,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                "${"Code pour paiement".tr()}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors
                                                      .blackBlueAccent1,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 5.w),
                                                  child: Text(
                                                    "${currentDetailUser["membre_code"]}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors
                                                          .blackBlueAccent1,
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.content_copy,
                                                  size: 12.sp,
                                                  color: AppColors
                                                      .blackBlueAccent1,
                                                ),
                                              ],
                                            )
                                          ],
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AccountPage(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          top: 15.h,
                                          left: 10.w,
                                          right: 10.w,
                                          bottom: 15.h,
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
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Icon(
                                                      Icons
                                                          .phone_android_outlined,
                                                      color:
                                                          AppColors.bleuLight,
                                                      size: 15.sp,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                      right: 10.w,
                                                    ),
                                                  ),
                                                  Text(
                                                    "votre_compte".tr(),
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color:
                                                          AppColors.blackBlue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_right,
                                              color: AppColors.blackBlue,
                                              size: 12.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (currentDetailUser[
                                            "is_withdrawal_approvers"] ==
                                        1)
                                      GestureDetector(
                                        onTap: () {
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
                                            top: 15.h,
                                            left: 10.w,
                                            right: 10.w,
                                            bottom: 15.h,
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
                                                CrossAxisAlignment.center,
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
                                                      margin: EdgeInsets.only(
                                                          right: 10.w),
                                                    ),
                                                    Text(
                                                      "retrait_en_attente".tr(),
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color:
                                                            AppColors.blackBlue,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_right,
                                                color: AppColors.blackBlue,
                                                size: 12.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    GestureDetector(
                                      onTap: () {
                                        // context.read<ServiceCubit>().state.currentService!.id;
                                        Modal().showBottomSheetListTournoi(
                                          context,
                                          currentInfoAllTournoiAssCourant
                                              .user_group!.tournois!,
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          top: 15.h,
                                          left: 10.w,
                                          right: 10.w,
                                          bottom: 15.h,
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
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Icon(
                                                      Icons.ads_click_outlined,
                                                      color: Colors.red,
                                                      size: 15.sp,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                      right: 10.w,
                                                    ),
                                                  ),
                                                  Text(
                                                    "tournoi".tr(),
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color:
                                                          AppColors.blackBlue,
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
                                                    fontSize: 10.sp,
                                                    color: Color.fromARGB(
                                                        125, 20, 45, 99),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                            Icon(Icons.arrow_right,
                                                color: AppColors.blackBlue,
                                                size: 12.sp),
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
                                          top: 15.h,
                                          left: 10.w,
                                          right: 10.w,
                                          bottom: 15.h,
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
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 16.w,
                                                    child: Image.asset(
                                                      "assets/images/Groupe_ou_Asso.png",
                                                      // scale: ,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 10.w),
                                                  ),
                                                  Text(
                                                    "Groups & associations"
                                                        .tr(),
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color:
                                                          AppColors.blackBlue,
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
                                                fontSize: 10.sp,
                                                color: Color.fromARGB(
                                                  125,
                                                  20,
                                                  45,
                                                  99,
                                                ),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_right,
                                              color: AppColors.blackBlue,
                                              size: 12.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // context.read<MembreCubit>().showMembersAss(
                                        //     AppCubitStorage().state.codeAssDefaul);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AdministrationPageWebview(
                                              forAdmin: false,
                                              urlPage:
                                                  'https://business.faroty.com/groups',
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          top: 15.h,
                                          left: 10.w,
                                          right: 10.w,
                                          bottom: 15.h,
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
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 20.w,
                                                    child: Image.asset(
                                                      "assets/images/AssoplusFinal.png",
                                                      // scale: ,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 5.w),
                                                  ),
                                                  Text(
                                                    "Créer un groupe ASSO+".tr(),
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color:
                                                          AppColors.blackBlue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_right,
                                              color: AppColors.blackBlue,
                                              size: 12.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<MembreCubit>()
                                            .showMembersAss(AppCubitStorage()
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
                                        padding: EdgeInsets.only(
                                          top: 15.h,
                                          left: 10.w,
                                          right: 10.w,
                                          bottom: 15.h,
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
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Icon(
                                                      Icons.groups,
                                                      color:
                                                          AppColors.blackBlue,
                                                      size: 15.sp,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 10.w),
                                                  ),
                                                  Text(
                                                    "Membres".tr(),
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color:
                                                          AppColors.blackBlue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_right,
                                              color: AppColors.blackBlue,
                                              size: 12.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
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
                                          top: 15.h,
                                          left: 10.w,
                                          right: 10.w,
                                          bottom: 15.h,
                                        ),
                                        decoration: BoxDecoration(
                                          // color: Colors.black12,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.r,
                                              color:
                                                  Color.fromARGB(12, 0, 0, 0),
                                            ),
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
                                                      Icons.settings_outlined,
                                                      color: Colors.brown,
                                                      size: 15.sp,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 10.w),
                                                  ),
                                                  Text(
                                                    "paramètres".tr(),
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color:
                                                          AppColors.blackBlue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_right,
                                              color: AppColors.blackBlue,
                                              size: 12.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Share.share(
                                          """${'Gérez vos associations et groupes avec *Groups & Assocations* et obtenez vos bilans instantanément.'.tr()}\n${'Disponible ici'.tr()} :  Play Store https://play.google.com/store/apps/details?id=com.faroty.groups "${'et sur'.tr()}" groups.faroty.com"""
                                              .tr(),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          top: 15.h,
                                          left: 10.w,
                                          right: 10.w,
                                          bottom: 15.h,
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
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Icon(
                                                      Icons.share_outlined,
                                                      color: AppColors
                                                          .greenAssociation,
                                                      size: 15.sp,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 10.w),
                                                  ),
                                                  Text(
                                                    "partager_l'application"
                                                        .tr(),
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color:
                                                          AppColors.blackBlue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_right,
                                              color: AppColors.blackBlue,
                                              size: 12.sp,
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
                        ),
                      ),
                    ],
                  ),
                ),
        );
      });
    });
  }
}
