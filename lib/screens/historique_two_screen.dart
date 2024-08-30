import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/presentation/screens/list_compte_screen.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/list_cotisation_screen.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotistion.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/data/prets_epargne_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/presentation/screens/list_epargne_screen.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/business_logic/sanction_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/business_logic/sanction_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/screens/list_sanction_screen.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanction.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/screens/list_meeting_screen.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/screens/list_tontine_screen.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetTontineHistoriqueCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
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
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/screens/detailTontinePage.dart';
import 'package:faroty_association_1/Association_And_Group/association_webview/administrationPage.dart';
import 'package:faroty_association_1/pages/checkInternetConnectionPage.dart';
import 'package:faroty_association_1/pages/home_centrale_screen.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/presentation/widgets/widgetCompteCard.dart';
import 'package:faroty_association_1/pages/updatePage.dart';
import 'package:faroty_association_1/routes/app_router.dart';
import 'package:faroty_association_1/widget/add_asso_button_widget.dart';
import 'package:faroty_association_1/widget/add_asso_element_button_widget.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:faroty_association_1/widget/floating_action_widget.dart';
import 'package:faroty_association_1/widget/widgetCallFunctionFailled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

//@RoutePage()
class HistoriqueTwoScreen extends StatefulWidget {
  const HistoriqueTwoScreen({super.key});

  @override
  State<HistoriqueTwoScreen> createState() => _HistoriqueTwoScreenState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
  required Widget widgetAction,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Historique".tr(),
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
        trailing: widgetAction,
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.white,
    appBar: AppBar(
      title: Text(
        "Historique".tr(),
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.red,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: AppColors.white,
          size: 16.sp,
        ),
      ),
      actions: [widgetAction],
    ),
    body: child,
  );
}

class _HistoriqueTwoScreenState extends State<HistoriqueTwoScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;

  Future<void> handleAllCotisationAssTournoi(codeTournoi, codeMembre) async {
    final allCotisationAss = await context
        .read<CotisationCubit>()
        .AllCotisationAssTournoiCubit(codeTournoi, codeMembre);

    if (allCotisationAss != null) {
      print("handleAllCotisationAss");
    } else {
      print("handleAllCotisationAss null");
    }
  }

  Future<void> handleAllCompteAss(codeAssociation) async {
    final allCotisationAss =
        await context.read<CompteCubit>().AllCompteAssCubit(codeAssociation);

    if (allCotisationAss != null) {
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllSeanceAss(codeAssociation) async {
    final allSeanceAss =
        await context.read<SeanceCubit>().AllAssSeanceCubit(codeAssociation);
  }

  Future<void> handleAllSanction() async {
    await context
        .read<SanctionCubit>()
        .getAllSanctions(AppCubitStorage().state.codeTournoisHist);
  }

  Future<void> handleTournoiDefault(codeTournoi) async {
    final detailTournoiCourant = await context
        .read<DetailTournoiCourantCubit>()
        .detailTournoiCourantCubitHist(codeTournoi);

    if (detailTournoiCourant != null) {
      print(
          "objectdddddddddddddddddddddddddddddddddd  ${detailTournoiCourant}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleDetailTontine(codeTournoi, codeTontine) async {
    final detailTontine = await context
        .read<TontineCubit>()
        .detailTontineCubit(codeTournoi, codeTontine);
  }

  Future<void> handleAllUserGroup() async {
    final AllUserGroup = await context
        .read<UserGroupCubit>()
        .AllUserGroupOfUserCubit(AppCubitStorage().state.tokenUser);

    if (AllUserGroup != null) {
      print("1");
    } else {
      print("AllUserGroup null");
    }
  }

  Future handleChangeAss(codeAss) async {
    final allCotisationAss =
        await context.read<UserGroupCubit>().ChangeAssCubit(codeAss);
  }

  // Future getNotifications() async {
  //   final getNotificationsVar = await context
  //       .read<NotificationCubit>()
  //       .getNotification(AppCubitStorage().state.tokenUser,
  //           AppCubitStorage().state.codeAssDefaul);

  //   print("cdddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcrrrr");
  // }

  Future<void> handleDetailUser(userCode, codeTournoi) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode, codeTournoi);
  }

  Future refreshRencontre() async {
    handleTournoiDefault(AppCubitStorage().state.codeTournoisHist);
  }

  Future refreshTontine() async {
    handleTournoiDefault(AppCubitStorage().state.codeTournoisHist);
  }

  Future refreshCotisation() async {
    handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournoisHist,
        AppCubitStorage().state.membreCode);
  }

  Future refreshSanction() async {
    handleDetailUser(
      AppCubitStorage().state.membreCode,
      AppCubitStorage().state.codeTournoisHist,
    );
    handleAllSanction();
  }

  Future refreshCompte() async {
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
  }

  @override
  void dispose() {
    _tabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    handleTournoiDefault(AppCubitStorage().state.codeTournoisHist);
    // handleAllUserGroup();
    handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournoisHist,
        AppCubitStorage().state.membreCode);
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
    handleAllSanction();
    context
        .read<PretEpargneCubit>()
        .getAllAssEpargnes(AppCubitStorage().state.codeTournoisHist);

    _tabController = TabController(length: 0, vsync: this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      handleTournoiDefault(AppCubitStorage().state.codeTournoisHist);
      // handleAllUserGroup();
      handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournoisHist,
          AppCubitStorage().state.membreCode);
      handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
      handleAllSanction();
      context
          .read<PretEpargneCubit>()
          .getAllAssEpargnes(AppCubitStorage().state.codeTournoisHist);

      print("RETOUR");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (AuthContext, AuthState) {
      if (AuthState.isLoading == true && AuthState.detailUser == null)
        return Container(
          child: EasyLoader(
            backgroundColor: Color.fromARGB(0, 255, 255, 255),
            iconSize: 50.r,
            iconColor: AppColors.blackBlueAccent1,
            image: AssetImage(
              "assets/images/AssoplusFinal.png",
            ),
          ),
        );
      final currentDetailUser = AuthContext.read<AuthCubit>().state.detailUser;
      return BlocBuilder<UserGroupCubit, UserGroupState>(
          builder: (UserGroupContext, UserGroupState) {
        if (UserGroupState.errorLoadDetailChangeAss == true)
          return checkInternetConnectionPage(
            backToHome: true,
            functionToCall: () {},
          );

        return Material(
          type: MaterialType.transparency,
          child: WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => HomeCentraleScreen(),
                ),
                (route) => false,
              );
              return true;
            },
            child:
                // (Authstate.errorLoadDetailAuth == true ||
                //         UserGroupState.errorLoadDetailChangeAss == true)
                //     ? checkInternetConnectionPage(
                //         backToHome: true,
                //         functionToCall: () {},
                //       )
                //     : !context
                //             .read<AuthCubit>()
                //             .state
                //             .detailUser!["is_app_updated"]
                //         ? UpdatePage()
                //         :
                !context.read<AuthCubit>().state.detailUser!["is_app_updated"]
                    ? UpdatePage()
                    : Scaffold(
                        backgroundColor: AppColors.pageBackground,
                        floatingActionButton: FloatingAction(),
                        appBar: PreferredSize(
                          preferredSize: Size.fromHeight(60.h),
                          child: AppBar(
                              centerTitle: false,
                              // toolbarHeight: 130.h,
                              title: Text(
                                'Historique'.tr(),
                                // "historiques".tr(),
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              actions: [
                                Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            // color: const Color.fromARGB(255, 20, 99, 70),
                                            height: 30.h,
                                            width: 30.h,
                                            margin:
                                                EdgeInsets.only(right: 10.w),
                                            // padding: EdgeInsets.all(1.r),
                                            child: AddAssoWidget(
                                              screenSource:
                                                  "transactions.btnAddAsso",
                                            ),
                                          ),
                                          // if (!context
                                          //     .read<AuthCubit>()
                                          //     .state
                                          //     .detailUser!["isMember"])
                                          //   GestureDetector(
                                          //     onTap: () async {
                                          //       updateTrackingData(
                                          //           "transactions.btnAdminister",
                                          //           "${DateTime.now()}",
                                          //           {});
                                          //        launchWeb(
                                          //         "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com&app_mode=mobile",

                                          //       );
                                          //     },
                                          //     child: Container(
                                          //       margin: EdgeInsets.only(
                                          //         right: 10.w,
                                          //       ),
                                          //       padding:
                                          //           EdgeInsets.all(1.r),
                                          //       decoration: BoxDecoration(
                                          //         border: Border.all(
                                          //             width: 1.r,
                                          //             color: AppColors
                                          //                 .blackBlue),
                                          //         color: AppColors
                                          //             .blackBlueAccent2,
                                          //         borderRadius:
                                          //             BorderRadius.circular(
                                          //                 50.r),
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
                                              updateTrackingData(
                                                  "transactions.btnSwitch",
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
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      right: 15.w,
                                                    ),
                                                    height: 30.h,
                                                    width: 30.h,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: AppColors.red,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              360.r),
                                                    ),
                                                    padding:
                                                        EdgeInsets.all(1.r),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              360.r),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      360.r),
                                                        ),
                                                        child: Image.network(
                                                          "${Variables.LienAIP}${context.read<UserGroupCubit>().state.changeAssData!.user_group!.profile_photo == null ? "" : context.read<UserGroupCubit>().state.changeAssData!.user_group!.profile_photo}",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 17.w,
                                                    top: 2.h,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 255, 26, 9),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          50.r,
                                                        ),
                                                      ),
                                                      width: 5.w,
                                                      height: 5.w,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 10.h,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                              elevation: 0,
                              backgroundColor: AppColors.backgroundAppBAr,
                              leading: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeCentraleScreen(),
                                    ),
                                    (route) => false,
                                  );
                                  print("object");
                                },
                                child: BackButtonWidget(
                                  colorIcon: AppColors.white,
                                ),
                              )),
                        ),
                        body: Container(
                          // color: AppColors.barrierColorModal,
                          width: MediaQuery.of(context).size.width,

                          child: Wrap(
                            alignment: WrapAlignment.center,
                            // runAlignment: WrapAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 10.h,
                                  right: 5.w,
                                  left: 5.w,
                                ),
                                child: Material(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                    10.r,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      updateTrackingData(
                                          "transactions.btnShowMeeting",
                                          "${DateTime.now()}", {});
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ListMeetingScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.r),
                                            height: 60.h,
                                            width: 60.h,
                                            child: SvgPicture.asset(
                                              "assets/images/meetingTransIcon.svg",
                                              fit: BoxFit.cover,
                                              color: AppColors.blackBlue,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.only(
                                              bottom: 10.h,
                                            ),
                                            decoration: BoxDecoration(
                                                // color: AppColors.blackBlue,
                                                borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.r),
                                              bottomRight:
                                                  Radius.circular(10.r),
                                            )),
                                            child: Text(
                                              "rencontres".tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.blackBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (UserGroupState
                                      .changeAssData!.user_group!.is_tontine ==
                                  true)
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 10.h,
                                    right: 5.w,
                                    left: 5.w,
                                  ),
                                  child: Material(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        updateTrackingData(
                                            "transactions.btnShowTontine",
                                            "${DateTime.now()}", {});
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListTontineScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10.r),
                                              height: 60.h,
                                              width: 60.h,
                                              child: SvgPicture.asset(
                                                "assets/images/tontineTransIcon.svg",
                                                fit: BoxFit.cover,
                                                color: AppColors.blackBlue,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.only(
                                                bottom: 10.h,
                                              ),
                                              decoration: BoxDecoration(
                                                  // color: AppColors.blackBlue,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(10.r),
                                                bottomRight:
                                                    Radius.circular(10.r),
                                              )),
                                              child: Text(
                                                "Tontines".tr(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 10.h,
                                  right: 5.w,
                                  left: 5.w,
                                ),
                                child: Material(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                    10.r,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      updateTrackingData(
                                          "transactions.btnShowContribution",
                                          "${DateTime.now()}", {});
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ListCotisationScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.r),
                                            // height: 50.h,
                                            height: 60.h,
                                            width: 60.h,
                                            child: SvgPicture.asset(
                                              "assets/images/contributionTransIcon1.svg",
                                              fit: BoxFit.cover,
                                              color: AppColors.blackBlue,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.only(
                                              bottom: 10.h,
                                            ),
                                            decoration: BoxDecoration(
                                                // color: AppColors.blackBlue,
                                                borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.r),
                                              bottomRight:
                                                  Radius.circular(10.r),
                                            )),
                                            child: Text(
                                              "cotisations".tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.blackBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 10.h,
                                  right: 5.w,
                                  left: 5.w,
                                ),
                                child: Material(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                    10.r,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      updateTrackingData(
                                          "transactions.btnShowSancton",
                                          "${DateTime.now()}", {});
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ListSanctionScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.r),
                                            height: 60.h,
                                            width: 60.h,
                                            child: SvgPicture.asset(
                                              "assets/images/sanctionTransIcon.svg",
                                              fit: BoxFit.cover,
                                              color: AppColors.blackBlue,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.only(
                                              bottom: 10.h,
                                            ),
                                            decoration: BoxDecoration(
                                                // color: AppColors.blackBlue,
                                                borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10.r),
                                              bottomRight:
                                                  Radius.circular(10.r),
                                            )),
                                            child: Text(
                                              "Vos sanctions".tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.blackBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (checkTransparenceLoans(
                                  context
                                      .read<UserGroupCubit>()
                                      .state
                                      .changeAssData!
                                      .user_group!
                                      .configs,
                                  AuthContext.read<AuthCubit>()
                                      .state
                                      .detailUser!["isMember"]))
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 10.h,
                                    right: 5.w,
                                    left: 5.w,
                                  ),
                                  child: Material(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        updateTrackingData(
                                            "transactions.btnShowSaving",
                                            "${DateTime.now()}", {});
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListEpargneScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10.r),
                                              height: 60.h,
                                              width: 60.h,
                                              child: SvgPicture.asset(
                                                "assets/images/savingTransIcon.svg",
                                                fit: BoxFit.cover,
                                                color: AppColors.blackBlue,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.only(
                                                bottom: 10.h,
                                              ),
                                              decoration: BoxDecoration(
                                                  // color: AppColors.blackBlue,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(10.r),
                                                bottomRight:
                                                    Radius.circular(10.r),
                                              )),
                                              child: Text(
                                                "Epargne".tr(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              // InkWell(
                              //   child: Container(
                              //     width: MediaQuery.of(context).size.width / 2.15,
                              //     margin: EdgeInsets.only(top: 10.h, right: 5.w, left: 5.w),
                              //     decoration: BoxDecoration(
                              //       color: AppColors.white,
                              //       borderRadius: BorderRadius.circular(
                              //         10.r,
                              //       ),
                              //     ),
                              //     child: Column(
                              //       children: [
                              //         Container(
                              //           padding: EdgeInsets.all(10.r),
                              //           // height: 50.h,
                              //           child: SvgPicture.asset(
                              //             width: 40.h,
                              //             "assets/images/loanTransIcon.svg",
                              //             fit: BoxFit.cover,
                              //             color: AppColors.blackBlue,
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           height: 3.h,
                              //         ),
                              //         Container(
                              //           width: double.infinity,
                              //           padding: EdgeInsets.only(
                              //             bottom: 10.h,
                              //           ),
                              //           decoration: BoxDecoration(
                              //               // color: AppColors.blackBlue,
                              //               borderRadius: BorderRadius.only(
                              //             bottomLeft: Radius.circular(10.r),
                              //             bottomRight: Radius.circular(10.r),
                              //           )),
                              //           child: Text(
                              //             "Prêts".tr(),
                              //             textAlign: TextAlign.center,
                              //             style: TextStyle(
                              //               color: AppColors.blackBlue,
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 16.sp,
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              if (checkTransparenceStatus(
                                  context
                                      .read<UserGroupCubit>()
                                      .state
                                      .changeAssData!
                                      .user_group!
                                      .configs,
                                  context
                                      .read<AuthCubit>()
                                      .state
                                      .detailUser!["isMember"]))
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 10.h,
                                    right: 5.w,
                                    left: 5.w,
                                  ),
                                  child: Material(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(
                                      10.r,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        updateTrackingData(
                                            "transactions.btnShowAccount",
                                            "${DateTime.now()}", {});
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListCompteScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10.r),
                                              height: 60.h,
                                              width: 60.h,
                                              child: SvgPicture.asset(
                                                "assets/images/compteTransIcon.svg",
                                                fit: BoxFit.cover,
                                                color: AppColors.blackBlue,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.only(
                                                bottom: 10.h,
                                              ),
                                              decoration: BoxDecoration(
                                                  // color: AppColors.blackBlue,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(10.r),
                                                bottomRight:
                                                    Radius.circular(10.r),
                                              )),
                                              child: Text(
                                                "comptes".tr(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.1,
                              ),
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
