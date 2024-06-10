import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotistion.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/data/prets_epargne_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/business_logic/sanction_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/business_logic/sanction_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanction.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_cubit.dart';
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
import 'package:faroty_association_1/widget/widgetCallFunctionFailled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

//@RoutePage()
class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({super.key});

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreenState();
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
          "historiques".tr(),
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
        "historiques".tr(),
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.red,
      elevation: 0,
      leading: GestureDetector(
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

class _HistoriqueScreenState extends State<HistoriqueScreen>
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
    return BlocBuilder<AuthCubit, AuthState>(builder: (Authcontext, Authstate) {
      if (Authstate.isLoading == true && Authstate.detailUser == null)
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
      return BlocBuilder<UserGroupCubit, UserGroupState>(
        builder: (UserGroupContext, UserGroupState) {
          final currentInfoAllTournoiAssCourant =
              UserGroupContext.read<UserGroupCubit>().state.changeAssData;
          // int lengthTab = 4;
          // if (UserGroupState.changeAssData!.user_group!.is_tontine == false) {
          //   setState(() {
          //     lengthTab = lengthTab+1;
          //   });

          // }

          if (UserGroupState.isLoading == true &&
              UserGroupState.changeAssData == null)
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
          if (UserGroupState.errorLoadDetailChangeAss != true)
            _tabController = TabController(
              length: 3 +
                  (UserGroupState.changeAssData!.user_group!.is_tontine == true
                      ? 1
                      : 0) +
                  (checkTransparenceStatus(
                          context
                              .read<UserGroupCubit>()
                              .state
                              .changeAssData!
                              .user_group!
                              .configs,
                          context
                              .read<AuthCubit>()
                              .state
                              .detailUser!["isMember"])
                      ? 1
                      : 0) +
                  (checkTransparenceLoans(
                          context
                              .read<UserGroupCubit>()
                              .state
                              .changeAssData!
                              .user_group!
                              .configs,
                          context
                              .read<AuthCubit>()
                              .state
                              .detailUser!["isMember"])
                      ? 1
                      : 0),

              // UserGroupState.changeAssData!.user_group!.is_tontine == false
              //         || !checkTransparenceStatus(context.read<UserGroupCubit>().state.changeAssData!.user_group!.configs, context.read<AuthCubit>().state.detailUser!["isMember"],)
              //     ? 4
              //     : 5,
              vsync: this,
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
                  (Authstate.errorLoadDetailAuth == true ||
                          UserGroupState.errorLoadDetailChangeAss == true)
                      ? checkInternetConnectionPage(
                          backToHome: true,
                          functionToCall: () {},
                        )
                      : !context
                              .read<AuthCubit>()
                              .state
                              .detailUser!["is_app_updated"]
                          ? UpdatePage()
                          : Scaffold(
                              backgroundColor: AppColors.pageBackground,
                              appBar: PreferredSize(
                                preferredSize: Size.fromHeight(110.h),
                                child: AppBar(
                                  centerTitle: false,
                                  // toolbarHeight: 130.h,
                                  title: Text(
                                    "historiques".tr(),
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
                                                margin: EdgeInsets.only(
                                                    right: 10.w),
                                                // padding: EdgeInsets.all(1.r),
                                                child: AddAssoWidget(
                                                  screenSource:
                                                      "transactions.btnAddAsso",
                                                ),
                                              ),
                                              if (!context
                                                  .read<AuthCubit>()
                                                  .state
                                                  .detailUser!["isMember"])
                                                GestureDetector(
                                                  onTap: () async {
                                                    updateTrackingData(
                                                        "transactions.btnAdminister",
                                                        "${DateTime.now()}",
                                                        {});
                                                     launchWeb(
                                                      "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com&app_mode=mobile",
                                                   
                                                    );
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      right: 10.w,
                                                    ),
                                                    padding:
                                                        EdgeInsets.all(1.r),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1.r,
                                                          color: AppColors
                                                              .blackBlue),
                                                      color: AppColors
                                                          .blackBlueAccent2,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.r),
                                                    ),
                                                    height: 30.h,
                                                    width: 30.h,
                                                    child: Image.asset(
                                                      "assets/images/Groupe_ou_Asso.png",
                                                      scale: 4,
                                                    ),
                                                  ),
                                                ),
                                              GestureDetector(
                                                onTap: () {
                                                  updateTrackingData(
                                                      "transactions.btnSwitch",
                                                      "${DateTime.now()}", {});
                                                  Modal()
                                                      .showBottomSheetListAss(
                                                    context,
                                                    context
                                                        .read<UserGroupCubit>()
                                                        .state
                                                        .userGroup,
                                                  );
                                                },
                                                child: Container(
                                                  child: Container(
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
                                  leading: Platform.isAndroid
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        HomeCentraleScreen(),
                                              ),
                                              (route) => false,
                                            );
                                            print("object");
                                          },
                                          child: BackButtonWidget(
                                            colorIcon: AppColors.white,
                                          ),
                                        )
                                      : Container(),
                                  bottom: TabBar(
                                    onTap: (value) {
                                      value == 0
                                          ? updateTrackingData(
                                              "transactions.meetingTabBar",
                                              "${DateTime.now()}", {})
                                          : value == 1
                                              ? updateTrackingData(
                                                  "transactions.tontineTabBar",
                                                  "${DateTime.now()}", {})
                                              : value == 2
                                                  ? updateTrackingData(
                                                      "transactions.contributionTabBar",
                                                      "${DateTime.now()}", {})
                                                  : value == 3
                                                      ? updateTrackingData(
                                                          "transactions.sanctionTabBar",
                                                          "${DateTime.now()}",
                                                          {})
                                                      : updateTrackingData(
                                                          "transactions.Account",
                                                          "${DateTime.now()}",
                                                          {});
                                    },
                                    labelPadding: EdgeInsets.only(
                                        right: 10.w, left: 10.w),
                                    controller: _tabController,
                                    isScrollable: true,
                                    labelColor: AppColors.white,
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                    padding: EdgeInsets.all(0),
                                    unselectedLabelStyle: TextStyle(
                                      color: AppColors.whiteAccent1,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                    indicator: UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                        color: AppColors.white,
                                        width: 2.h,
                                      ),
                                      insets: EdgeInsets.symmetric(
                                        horizontal: 20.0.w,
                                      ),
                                    ),
                                    // indicatorWeight: 30.h,
                                    tabs: [
                                      Tab(
                                        text: "rencontres".tr(),
                                      ),
                                      if (UserGroupState.changeAssData!
                                              .user_group!.is_tontine ==
                                          true)
                                        Tab(
                                          text: "Tontines",
                                        ),
                                      Tab(
                                        text: "cotisations".tr(),
                                      ),
                                      Tab(
                                        text: "Sanctions",
                                      ),
                                      if (checkTransparenceLoans(
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
                                        Tab(
                                          text: "Epargne".tr(),
                                        ),
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
                                        Tab(
                                          text: "comptes".tr(),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              body: Container(
                                // decoration: BoxDecoration(
                                //   image: DecorationImage(
                                //     image: AssetImage("assets/images/BG.png"),
                                //     fit: BoxFit.cover,
                                //     opacity: 0.2
                                //   ),
                                // ),
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 1.5.h,
                                        left: 1.5.w,
                                        right: 1.5.w,
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Container(
                                            // color: AppColors.barrierColorModal,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(
                                              top: 10.h,
                                              left: 5.w,
                                              bottom: 10.h,
                                            ),
                                            child: Text(
                                              "toutes_les_rencontres".tr(),
                                              style: TextStyle(
                                                color: AppColors.blackBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp,
                                                letterSpacing: 0.2.w,
                                              ),
                                            ),
                                          ),
                                          if (currentInfoAllTournoiAssCourant!
                                                  .user_group!
                                                  .tournois!
                                                  .length >
                                              1)
                                            BlocBuilder<
                                                    DetailTournoiCourantCubit,
                                                    DetailTournoiCourantState>(
                                                builder: (DetailTournoiContext,
                                                    DetailTournoiState) {
                                              if (DetailTournoiState
                                                          .isLoading ==
                                                      true &&
                                                  DetailTournoiState
                                                          .detailtournoiCourantHist ==
                                                      null)
                                                return Container(
                                                    // child: Expanded(
                                                    //   child: EasyLoader(
                                                    //     backgroundColor:
                                                    //         Color.fromARGB(
                                                    //             0, 255, 255, 255),
                                                    //     iconSize: 50.r,
                                                    //     iconColor: AppColors
                                                    //         .blackBlueAccent1,
                                                    //     image: AssetImage(
                                                    //       "assets/images/AssoplusFinal.png",
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    );

                                              return PopupMenuButton(
                                                elevation: 5,
                                                shadowColor:
                                                    AppColors.barrierColorModal,
                                                child: Column(
                                                  children: [
                                                    for (var item
                                                        in currentInfoAllTournoiAssCourant!
                                                            .user_group!
                                                            .tournois!)
                                                      if (item.tournois_code ==
                                                          AppCubitStorage()
                                                              .state
                                                              .codeTournoisHist)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            right: 10.w,
                                                            left: 10.w,
                                                            bottom: 10.h,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              width: 1.w,
                                                              color: AppColors
                                                                  .blackBlue,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              20.r,
                                                            ),
                                                          ),
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: 7.h,
                                                            bottom: 7.h,
                                                            left: 20.w,
                                                            right: 15.w,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Tournoi #${item.matricule}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14.sp,
                                                                        color: AppColors
                                                                            .blackBlue,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              if (DetailTournoiState
                                                                      .isLoading ==
                                                                  true)
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        15.h,
                                                                    width: 50.h,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          2.w,
                                                                      color: AppColors
                                                                          .greenAssociation,
                                                                    ),
                                                                  ),
                                                                ),
                                                              Row(
                                                                children: [
                                                                  if (item.is_default ==
                                                                      0)
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .dangerous,
                                                                          size:
                                                                              12.sp,
                                                                          color:
                                                                              AppColors.red,
                                                                        ),
                                                                        // Text(
                                                                        //   "Inactif"
                                                                        //       .tr(),
                                                                        //   style:
                                                                        //       TextStyle(
                                                                        //     color: AppColors
                                                                        //         .red,
                                                                        //     fontWeight:
                                                                        //         FontWeight
                                                                        //             .bold,
                                                                        //     fontSize:
                                                                        //         12.sp,
                                                                        //   ),
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: AppColors
                                                                        .blackBlue,
                                                                    size: 20.sp,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                  ],
                                                ),
                                                // onSelected: (value) async {
                                                //   if (value == "tournoi") {
                                                //     print(value);
                                                //     await AppCubitStorage().updateCodeTournoisDefault(item.matricule);
                                                //     // await launchWeb(
                                                //     //   "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/details-seances/${widget.codeSeance}?query=1&app_mode=mobile",
                                                //     //   mode: LaunchMode.platformDefault,
                                                //     // );
                                                //   }
                                                //  },
                                                itemBuilder:
                                                    (BuildContext context) =>
                                                        <PopupMenuEntry>[
                                                  for (var item
                                                      in currentInfoAllTournoiAssCourant!
                                                          .user_group!
                                                          .tournois!)
                                                    PopupMenuItem(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      value: "tournoi",
                                                      onTap: () async {
                                                        print(
                                                            " before ${item.tournois_code}");
                                                        await AppCubitStorage()
                                                            .updateCodeTournoisHist(
                                                                item.tournois_code!);
                                                        print(
                                                            " after ${AppCubitStorage().state.codeTournoisHist}");

                                                        await handleTournoiDefault(
                                                            AppCubitStorage()
                                                                .state
                                                                .codeTournoisHist);
                                                        handleAllCotisationAssTournoi(
                                                            AppCubitStorage()
                                                                .state
                                                                .codeTournoisHist,
                                                            AppCubitStorage()
                                                                .state
                                                                .membreCode);
                                                        context
                                                            .read<
                                                                SanctionCubit>()
                                                            .getAllSanctions(
                                                                AppCubitStorage()
                                                                    .state
                                                                    .codeTournoisHist);
                                                      },
                                                      child: Container(
                                                        color: item.tournois_code! ==
                                                                AppCubitStorage()
                                                                    .state
                                                                    .codeTournoisHist
                                                            ? AppColors
                                                                .blackBlue
                                                                .withOpacity(
                                                                    .05)
                                                            : null,
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 15.h,
                                                          bottom: 15.h,
                                                          left: 10.w,
                                                          right: 10.w,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 7.w,
                                                                  ),
                                                                  Text(
                                                                    '${"tournoi".tr()} #${item.matricule}'
                                                                        .tr(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: AppColors
                                                                          .blackBlue,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 70.w,
                                                            ),
                                                            if (item.is_default ==
                                                                1)
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .green
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.r),
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 10.w,
                                                                  right: 10.w,
                                                                  top: 3.h,
                                                                  bottom: 3.h,
                                                                ),
                                                                child: Text(
                                                                  'Actif'.tr(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: AppColors
                                                                        .green,
                                                                    // fontWeight:
                                                                    //     FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }),
                                          BlocBuilder<DetailTournoiCourantCubit,
                                              DetailTournoiCourantState>(
                                            builder: (DetailTournoiContext,
                                                DetailTournoiState) {
                                              if (DetailTournoiState
                                                          .isLoadingHist ==
                                                      true &&
                                                  DetailTournoiState
                                                          .detailtournoiCourantHist ==
                                                      null)
                                                return Container(
                                                  child: Expanded(
                                                    child: EasyLoader(
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              0, 255, 255, 255),
                                                      iconSize: 50.r,
                                                      iconColor: AppColors
                                                          .blackBlueAccent1,
                                                      image: AssetImage(
                                                        "assets/images/AssoplusFinal.png",
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              // if (DetailTournoiState
                                              //             .isLoading ==
                                              //         true &&
                                              //     DetailTournoiState
                                              //             .detailtournoiCourantHist ==
                                              //         null)
                                              //   return Container(
                                              //     child: Center(
                                              //       child:
                                              //           CircularProgressIndicator(
                                              //         color: const Color.fromARGB(255, 191, 53, 53),
                                              //       ),
                                              //     ),
                                              //   );
                                              final currentDetailtournoiCourant =
                                                  DetailTournoiContext.read<
                                                          DetailTournoiCourantCubit>()
                                                      .state
                                                      .detailtournoiCourantHist;
                                              return currentDetailtournoiCourant![
                                                                  "tournois"]
                                                              ["seance"]!
                                                          .length >
                                                      0
                                                  ? Expanded(
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              bottom:
                                                                  Platform.isIOS
                                                                      ? 70.h
                                                                      : 0.h,
                                                            ),
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child:
                                                                RefreshIndicator(
                                                              onRefresh:
                                                                  refreshRencontre,
                                                              child: ListView
                                                                  .builder(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount: currentDetailtournoiCourant[
                                                                            "tournois"]
                                                                        [
                                                                        "seance"]
                                                                    .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  final itemSeance =
                                                                      currentDetailtournoiCourant["tournois"]
                                                                              [
                                                                              "seance"]
                                                                          [
                                                                          index];

                                                                  return Container(
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: 7.w,
                                                                      right:
                                                                          7.w,
                                                                      top: 3.h,
                                                                      bottom:
                                                                          7.h,
                                                                    ),
                                                                    child:
                                                                        WidgetRencontreCard(
                                                                      codeTournoi: AppCubitStorage()
                                                                          .state
                                                                          .codeTournoisHist!,
                                                                      screenSource:
                                                                          "transactions.meeting",
                                                                      typeRencontre:
                                                                          itemSeance[
                                                                              "type_rencontre"],
                                                                      rapportUrl:
                                                                          itemSeance[
                                                                              "rapport"],
                                                                      maskElt:
                                                                          false,
                                                                      codeSeance:
                                                                          itemSeance[
                                                                              "seance_code"],
                                                                      photoProfilRecepteur: itemSeance["membre"]["photo_profil"] ==
                                                                              null
                                                                          ? ''
                                                                          : itemSeance["membre"]
                                                                              [
                                                                              "photo_profil"],
                                                                      dateRencontre: AppCubitStorage().state.Language ==
                                                                              "fr"
                                                                          ? formatDateToFrench(itemSeance[
                                                                              "date_seance"])
                                                                          : formatDateToEnglish(
                                                                              itemSeance["date_seance"]),
                                                                      descriptionRencontre:
                                                                          '${formatDateTimeintegral(context.locale.toString() == "en_US" ? "en" : "fr", itemSeance["date_seance"]).toUpperCase()} ${"à".tr()} ${itemSeance["heure_debut"]}',
                                                                      heureRencontre:
                                                                          itemSeance[
                                                                              "heure_debut"],
                                                                      identifiantRencontre:
                                                                          itemSeance[
                                                                              "matricule"],
                                                                      lieuRencontre:
                                                                          itemSeance[
                                                                              "localisation"],
                                                                      nomRecepteurRencontre: itemSeance["membre"]["first_name"] ==
                                                                              null
                                                                          ? ""
                                                                          : itemSeance["membre"]
                                                                              [
                                                                              "first_name"],
                                                                      isActiveRencontre:
                                                                          itemSeance[
                                                                              "status"],
                                                                      prenomRecepteurRencontre: itemSeance["membre"]["last_name"] ==
                                                                              null
                                                                          ? ""
                                                                          : itemSeance["membre"]
                                                                              [
                                                                              "last_name"],
                                                                      dateRencontreAPI:
                                                                          itemSeance[
                                                                              "date_seance"],
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          AddAssoElement(
                                                            screenSource:
                                                                "transactions.btnAddMeeting",
                                                            text:
                                                                "Ajouter une rencontre"
                                                                    .tr(),
                                                            routeElement:
                                                                "seances?query=1",
                                                          ),
                                                          if (DetailTournoiState
                                                                      .isLoading ==
                                                                  true &&
                                                              DetailTournoiState
                                                                      .detailtournoiCourant !=
                                                                  null)
                                                            EasyLoader(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          0,
                                                                          255,
                                                                          255,
                                                                          255),
                                                              iconSize: 50.r,
                                                              iconColor: AppColors
                                                                  .blackBlueAccent1,
                                                              image: AssetImage(
                                                                "assets/images/AssoplusFinal.png",
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    )
                                                  : Expanded(
                                                      child: Stack(
                                                        children: [
                                                          RefreshIndicator(
                                                            onRefresh:
                                                                refreshRencontre,
                                                            child: ListView
                                                                .builder(
                                                                    itemCount:
                                                                        1,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return Column(
                                                                        children: [
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.only(top: 200.h),
                                                                            alignment:
                                                                                Alignment.topCenter,
                                                                            child:
                                                                                Text(
                                                                              "aucune_rencontre".tr(),
                                                                              style: TextStyle(
                                                                                color: AppColors.blackBlueAccent1,
                                                                                fontWeight: FontWeight.w100,
                                                                                fontSize: 20.sp,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          if (!context
                                                                              .read<AuthCubit>()
                                                                              .state
                                                                              .detailUser!["isMember"])
                                                                            InkWell(
                                                                              onTap: () async {
                                                                                updateTrackingData("transactions.btnAddMeeting", "${DateTime.now()}", {});
                                                                                 launchWeb(
                                                                                  "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/seances?query=1&app_mode=mobile",
                                                                               
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                height: 50,
                                                                                decoration: BoxDecoration(
                                                                                  color: AppColors.pageBackground,
                                                                                  border: Border.all(
                                                                                    width: 2.w,
                                                                                    color: AppColors.blackBlue.withOpacity(1),
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    20.r,
                                                                                  ),
                                                                                ),
                                                                                margin: EdgeInsets.only(
                                                                                  top: 8.w,
                                                                                ),
                                                                                padding: EdgeInsets.symmetric(
                                                                                  horizontal: 10.w,
                                                                                  vertical: 7.h,
                                                                                ),
                                                                                width: MediaQuery.of(context).size.width / 1.5,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                  children: [
                                                                                    Text(
                                                                                      "Ajouter une rencontre".tr(),
                                                                                      style: TextStyle(
                                                                                        color: AppColors.blackBlue.withOpacity(1),
                                                                                        fontWeight: FontWeight.w900,
                                                                                        fontSize: 18.sp,
                                                                                        letterSpacing: 0.2.w,
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      width: 25.w,
                                                                                      height: 25.w,
                                                                                      margin: EdgeInsets.only(left: 3.w),
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(360),
                                                                                        border: Border.all(
                                                                                          width: 2.w,
                                                                                          color: AppColors.blackBlue.withOpacity(1),
                                                                                        ),
                                                                                      ),
                                                                                      child: SvgPicture.asset(
                                                                                        "assets/images/addIcon.svg",
                                                                                        fit: BoxFit.scaleDown,
                                                                                        color: AppColors.blackBlue.withOpacity(1),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      );
                                                                    }),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (UserGroupState.changeAssData!
                                            .user_group!.is_tontine ==
                                        true)
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 1.5.h,
                                          left: 1.5.w,
                                          right: 1.5.w,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                  top: 10.h,
                                                  left: 5.w,
                                                  bottom: 10.h),
                                              child: Text(
                                                "Toutes vos tontines".tr(),
                                                style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  letterSpacing: 0.2.w,
                                                ),
                                              ),
                                            ),
                                            if (currentInfoAllTournoiAssCourant!
                                                    .user_group!
                                                    .tournois!
                                                    .length >
                                                1)
                                              BlocBuilder<
                                                      DetailTournoiCourantCubit,
                                                      DetailTournoiCourantState>(
                                                  builder:
                                                      (DetailTournoiContext,
                                                          DetailTournoiState) {
                                                if (DetailTournoiState
                                                            .isLoading ==
                                                        true &&
                                                    DetailTournoiState
                                                            .detailtournoiCourantHist ==
                                                        null)
                                                  return Container();

                                                return PopupMenuButton(
                                                  elevation: 5,
                                                  shadowColor: AppColors
                                                      .barrierColorModal,
                                                  child: Column(
                                                    children: [
                                                      for (var item
                                                          in currentInfoAllTournoiAssCourant!
                                                              .user_group!
                                                              .tournois!)
                                                        if (item.tournois_code ==
                                                            AppCubitStorage()
                                                                .state
                                                                .codeTournoisHist)
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              right: 10.w,
                                                              left: 10.w,
                                                              bottom: 10.h,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                width: 1.w,
                                                                color: AppColors
                                                                    .blackBlue,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                20.r,
                                                              ),
                                                            ),
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 7.h,
                                                              bottom: 7.h,
                                                              left: 20.w,
                                                              right: 15.w,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        'Tournoi #${item.matricule}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14.sp,
                                                                          color:
                                                                              AppColors.blackBlue,
                                                                          fontWeight:
                                                                              FontWeight.w900,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                if (DetailTournoiState
                                                                        .isLoading ==
                                                                    true)
                                                                  Container(
                                                                    height:
                                                                        15.h,
                                                                    width: 15.h,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          2.w,
                                                                      color: AppColors
                                                                          .greenAssociation,
                                                                    ),
                                                                  ),
                                                                Row(
                                                                  children: [
                                                                    if (item.is_default ==
                                                                        0)
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.dangerous,
                                                                            size:
                                                                                12.sp,
                                                                            color:
                                                                                AppColors.red,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                      color: AppColors
                                                                          .blackBlue,
                                                                      size:
                                                                          20.sp,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                    ],
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext context) =>
                                                          <PopupMenuEntry>[
                                                    for (var item
                                                        in currentInfoAllTournoiAssCourant!
                                                            .user_group!
                                                            .tournois!)
                                                      PopupMenuItem(
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        value: "tournoi",
                                                        onTap: () async {
                                                          print(
                                                              " before ${item.tournois_code}");
                                                          await AppCubitStorage()
                                                              .updateCodeTournoisHist(
                                                                  item.tournois_code!);
                                                          print(
                                                              " after ${AppCubitStorage().state.codeTournoisHist}");
                                                          await handleTournoiDefault(
                                                              AppCubitStorage()
                                                                  .state
                                                                  .codeTournoisHist);
                                                          handleAllCotisationAssTournoi(
                                                              AppCubitStorage()
                                                                  .state
                                                                  .codeTournoisHist,
                                                              AppCubitStorage()
                                                                  .state
                                                                  .membreCode);
                                                          context
                                                              .read<
                                                                  SanctionCubit>()
                                                              .getAllSanctions(
                                                                  AppCubitStorage()
                                                                      .state
                                                                      .codeTournoisHist);
                                                        },
                                                        child: Container(
                                                          color: item.tournois_code! ==
                                                                  AppCubitStorage()
                                                                      .state
                                                                      .codeTournoisHist
                                                              ? AppColors
                                                                  .blackBlue
                                                                  .withOpacity(
                                                                      .05)
                                                              : null,
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: 15.h,
                                                            bottom: 15.h,
                                                            left: 10.w,
                                                            right: 10.w,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          7.w,
                                                                    ),
                                                                    Text(
                                                                      '${"tournoi".tr()} #${item.matricule}'
                                                                          .tr(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14.sp,
                                                                        color: AppColors
                                                                            .blackBlue,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 70.w,
                                                              ),
                                                              if (item.is_default ==
                                                                  1)
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors
                                                                        .green
                                                                        .withOpacity(
                                                                            .1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.r),
                                                                  ),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 10.w,
                                                                    right: 10.w,
                                                                    top: 3.h,
                                                                    bottom: 3.h,
                                                                  ),
                                                                  child: Text(
                                                                    'Actif'
                                                                        .tr(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: AppColors
                                                                          .green,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              }),
                                            BlocBuilder<
                                                    DetailTournoiCourantCubit,
                                                    DetailTournoiCourantState>(
                                                builder: (DetailTournoiContext,
                                                    DetailTournoiState) {
                                              if (DetailTournoiState
                                                          .isLoading ==
                                                      true &&
                                                  DetailTournoiState
                                                          .detailtournoiCourantHist ==
                                                      null)
                                                return Container(
                                                  child: Expanded(
                                                    child: EasyLoader(
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              0, 255, 255, 255),
                                                      iconSize: 50.r,
                                                      iconColor: AppColors
                                                          .blackBlueAccent1,
                                                      image: AssetImage(
                                                        "assets/images/AssoplusFinal.png",
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              final currentDetailtournoiCourant =
                                                  DetailTournoiContext.read<
                                                          DetailTournoiCourantCubit>()
                                                      .state
                                                      .detailtournoiCourantHist;

                                              List<dynamic> listeTontines =
                                                  currentDetailtournoiCourant![
                                                      "tontines"];

                                              List<dynamic>
                                                  tontinesMembreConnect = [];

                                              for (var tontine
                                                  in listeTontines) {
                                                for (var item
                                                    in tontine["membres"]) {
                                                  if (item["membre"]
                                                          ["membre_code"] ==
                                                      AppCubitStorage()
                                                          .state
                                                          .membreCode) {
                                                    tontinesMembreConnect
                                                        .add(tontine);
                                                    break;
                                                  }
                                                }
                                              }
                                              return tontinesMembreConnect
                                                          .length >
                                                      0
                                                  ? Expanded(
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              bottom:
                                                                  Platform.isIOS
                                                                      ? 70.h
                                                                      : 10.h,
                                                            ),
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child:
                                                                RefreshIndicator(
                                                              onRefresh:
                                                                  refreshTontine,
                                                              child: ListView
                                                                  .builder(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    tontinesMembreConnect
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  print(
                                                                      tontinesMembreConnect);
                                                                  final itemTontine =
                                                                      tontinesMembreConnect[
                                                                          index];
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      updateTrackingData(
                                                                          "transactions.tontine",
                                                                          "${DateTime.now()}",
                                                                          {});
                                                                      handleDetailTontine(
                                                                          AppCubitStorage()
                                                                              .state
                                                                              .codeTournoisHist,
                                                                          itemTontine[
                                                                              "tontine_code"]);

                                                                      print(
                                                                          "${itemTontine["tontine_code"]}");
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              DetailTontinePage(
                                                                            codeTontine:
                                                                                itemTontine["tontine_code"],
                                                                            isActive:
                                                                                itemTontine["is_active"],
                                                                            dateCreaTontine:
                                                                                itemTontine["created_at"],
                                                                            nomTontine:
                                                                                "${itemTontine["libele"]}",
                                                                            montantTontine:
                                                                                "${itemTontine["amount"]}",
                                                                            positionBeneficiaire:
                                                                                "${itemTontine["membres"].where((objet) => objet["is_passed"] == 1).length}",
                                                                            nbrMembreTontine:
                                                                                "${itemTontine["membres"].length}",
                                                                            listMembre:
                                                                                itemTontine["membres"],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets.only(
                                                                          left: 7
                                                                              .w,
                                                                          right: 7
                                                                              .w,
                                                                          top: 3
                                                                              .h,
                                                                          bottom:
                                                                              7.h),
                                                                      child:
                                                                          widgetTontineHistoriqueCard(
                                                                        isActive:
                                                                            itemTontine["is_active"],
                                                                        dateCreaTontine:
                                                                            itemTontine["created_at"],
                                                                        nomTontine:
                                                                            "${itemTontine["libele"]}",
                                                                        montantTontine:
                                                                            "${itemTontine["amount"]}",
                                                                        positionBeneficiaire:
                                                                            "0",
                                                                        nbrMembreTontine:
                                                                            "${itemTontine["membres"].length}",
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          if (DetailTournoiState
                                                                      .isLoading ==
                                                                  true ||
                                                              DetailTournoiState
                                                                      .detailtournoiCourant ==
                                                                  null)
                                                            EasyLoader(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          0,
                                                                          255,
                                                                          255,
                                                                          255),
                                                              iconSize: 50.r,
                                                              iconColor: AppColors
                                                                  .blackBlueAccent1,
                                                              image: AssetImage(
                                                                "assets/images/AssoplusFinal.png",
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    )
                                                  : Expanded(
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: RefreshIndicator(
                                                          onRefresh:
                                                              refreshTontine,
                                                          child:
                                                              ListView.builder(
                                                            itemCount: 1,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 200
                                                                            .h),
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child: Text(
                                                                  "Aucune tontine",
                                                                  style:
                                                                      TextStyle(
                                                                    color: AppColors
                                                                        .blackBlueAccent1,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w100,
                                                                    fontSize:
                                                                        20.sp,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                            }),
                                          ],
                                        ),
                                      ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 1.5.h,
                                        left: 1.5.w,
                                        right: 1.5.w,
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(
                                                top: 10.h,
                                                left: 5.w,
                                                bottom: 10.h),
                                            child: Text(
                                              "toutes_vos_cotisations".tr(),
                                              style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  letterSpacing: 0.2.w),
                                            ),
                                          ),
                                          if (currentInfoAllTournoiAssCourant!
                                                  .user_group!
                                                  .tournois!
                                                  .length >
                                              1)
                                            BlocBuilder<CotisationCubit,
                                                    CotisationState>(
                                                builder: (CotisationContext,
                                                    CotisationState) {
                                              if (CotisationState.isLoading ==
                                                      true &&
                                                  CotisationState
                                                          .allCotisationAss ==
                                                      null) return Container();
                                              return PopupMenuButton(
                                                elevation: 5,
                                                shadowColor:
                                                    AppColors.barrierColorModal,
                                                child: Column(
                                                  children: [
                                                    for (var item
                                                        in currentInfoAllTournoiAssCourant!
                                                            .user_group!
                                                            .tournois!)
                                                      if (item.tournois_code ==
                                                          AppCubitStorage()
                                                              .state
                                                              .codeTournoisHist)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            right: 10.w,
                                                            left: 10.w,
                                                            bottom: 10.h,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              width: 1.w,
                                                              color: AppColors
                                                                  .blackBlue,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              20.r,
                                                            ),
                                                          ),
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: 7.h,
                                                            bottom: 7.h,
                                                            left: 20.w,
                                                            right: 15.w,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Tournoi #${item.matricule}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14.sp,
                                                                        color: AppColors
                                                                            .blackBlue,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              if (CotisationState
                                                                      .isLoading ==
                                                                  true)
                                                                Container(
                                                                  height: 15.h,
                                                                  width: 15.h,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2.w,
                                                                    color: AppColors
                                                                        .greenAssociation,
                                                                  ),
                                                                ),
                                                              Row(
                                                                children: [
                                                                  if (item.is_default ==
                                                                      0)
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .dangerous,
                                                                          size:
                                                                              12.sp,
                                                                          color:
                                                                              AppColors.red,
                                                                        ),
                                                                        // Text(
                                                                        //   "Inactif"
                                                                        //       .tr(),
                                                                        //   style:
                                                                        //       TextStyle(
                                                                        //     color: AppColors
                                                                        //         .red,
                                                                        //     fontWeight:
                                                                        //         FontWeight
                                                                        //             .bold,
                                                                        //     fontSize:
                                                                        //         12.sp,
                                                                        //   ),
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: AppColors
                                                                        .blackBlue,
                                                                    size: 20.sp,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                  ],
                                                ),
                                                // onSelected: (value) async {
                                                //   if (value == "tournoi") {
                                                //     print(value);
                                                //     await AppCubitStorage().updateCodeTournoisDefault(item.matricule);
                                                //     // await launchWeb(
                                                //     //   "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/details-seances/${widget.codeSeance}?query=1&app_mode=mobile",
                                                //     //   mode: LaunchMode.platformDefault,
                                                //     // );
                                                //   }
                                                //  },
                                                itemBuilder:
                                                    (BuildContext context) =>
                                                        <PopupMenuEntry>[
                                                  for (var item
                                                      in currentInfoAllTournoiAssCourant!
                                                          .user_group!
                                                          .tournois!)
                                                    PopupMenuItem(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      value: "tournoi",
                                                      onTap: () async {
                                                        print(
                                                            " before ${item.tournois_code}");
                                                        await AppCubitStorage()
                                                            .updateCodeTournoisHist(
                                                                item.tournois_code!);
                                                        print(
                                                            " after ${AppCubitStorage().state.codeTournoisHist}");
                                                        await handleAllCotisationAssTournoi(
                                                            AppCubitStorage()
                                                                .state
                                                                .codeTournoisHist,
                                                            AppCubitStorage()
                                                                .state
                                                                .membreCode);
                                                        context
                                                            .read<
                                                                SanctionCubit>()
                                                            .getAllSanctions(
                                                                AppCubitStorage()
                                                                    .state
                                                                    .codeTournoisHist);
                                                      },
                                                      child: Container(
                                                        color: item.tournois_code! ==
                                                                AppCubitStorage()
                                                                    .state
                                                                    .codeTournoisHist
                                                            ? AppColors
                                                                .blackBlue
                                                                .withOpacity(
                                                                    .05)
                                                            : null,
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 15.h,
                                                          bottom: 15.h,
                                                          left: 10.w,
                                                          right: 10.w,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 7.w,
                                                                  ),
                                                                  Text(
                                                                    '${"tournoi".tr()} #${item.matricule}'
                                                                        .tr(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: AppColors
                                                                          .blackBlue,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 70.w,
                                                            ),
                                                            if (item.is_default ==
                                                                1)
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .green
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.r),
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 10.w,
                                                                  right: 10.w,
                                                                  top: 3.h,
                                                                  bottom: 3.h,
                                                                ),
                                                                child: Text(
                                                                  'Actif'.tr(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: AppColors
                                                                        .green,
                                                                    // fontWeight:
                                                                    //     FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }),
                                          BlocBuilder<CotisationCubit,
                                              CotisationState>(
                                            builder: (CotisationContext,
                                                CotisationState) {
                                              if (CotisationState.isLoading ==
                                                      true &&
                                                  CotisationState
                                                          .allCotisationAss ==
                                                      null)
                                                return Container(
                                                  child: Expanded(
                                                    child: EasyLoader(
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              0, 255, 255, 255),
                                                      iconSize: 50.r,
                                                      iconColor: AppColors
                                                          .blackBlueAccent1,
                                                      image: AssetImage(
                                                        "assets/images/AssoplusFinal.png",
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              final currentAllCotisationAssTournoi =
                                                  context
                                                      .read<CotisationCubit>()
                                                      .state
                                                      .allCotisationAss;

                                              List<dynamic>
                                                  objetCotisationUniquement =
                                                  currentAllCotisationAssTournoi!
                                                      .where((objet) =>
                                                          objet["is_tontine"] ==
                                                          0)
                                                      .toList();

                                              return objetCotisationUniquement
                                                          .length >
                                                      0
                                                  ? Expanded(
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              bottom:
                                                                  Platform.isIOS
                                                                      ? 70.h
                                                                      : 10.h,
                                                            ),
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child:
                                                                RefreshIndicator(
                                                              onRefresh:
                                                                  refreshCotisation,
                                                              child: ListView
                                                                  .builder(
                                                                itemCount:
                                                                    objetCotisationUniquement
                                                                        .length,
                                                                // physics: NeverScrollableScrollPhysics(),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  final ItemDetailCotisation =
                                                                      objetCotisationUniquement[
                                                                          index];
                                                                  return Container(
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            7.w,
                                                                        right:
                                                                            7.w,
                                                                        top:
                                                                            3.h,
                                                                        bottom:
                                                                            7.h),
                                                                    child:
                                                                        WidgetCotisation(
                                                                      rapportUrl:
                                                                          ItemDetailCotisation[
                                                                              "rapport"],
                                                                      screenSource:
                                                                          "transactions",
                                                                      isPayed:
                                                                          ItemDetailCotisation[
                                                                              "is_payed"],
                                                                      rubrique: ItemDetailCotisation["ass_rubrique"] ==
                                                                              null
                                                                          ? ""
                                                                          : ItemDetailCotisation["ass_rubrique"]
                                                                              [
                                                                              "name"],
                                                                      montantCotisations:
                                                                          ItemDetailCotisation[
                                                                              "amount"],
                                                                      motifCotisations:
                                                                          ItemDetailCotisation[
                                                                              "name"],
                                                                      dateCotisation:
                                                                          ItemDetailCotisation[
                                                                              "start_date"],
                                                                      heureCotisation: AppCubitStorage().state.Language ==
                                                                              "fr"
                                                                          ? formatTimeToFrench(ItemDetailCotisation[
                                                                              "start_date"])
                                                                          : formatTimeToEnglish(
                                                                              ItemDetailCotisation["start_date"]),
                                                                      soldeCotisation:
                                                                          ItemDetailCotisation[
                                                                              "total_cotise"],
                                                                      codeCotisation:
                                                                          ItemDetailCotisation[
                                                                              "cotisation_code"],
                                                                      type: ItemDetailCotisation[
                                                                          "type"],
                                                                      lienDePaiement: ItemDetailCotisation["cotisation_pay_link"] ==
                                                                              null
                                                                          ? "le lien n'a pas été généré"
                                                                          : ItemDetailCotisation[
                                                                              "cotisation_pay_link"],
                                                                      is_passed:
                                                                          ItemDetailCotisation[
                                                                              "is_passed"],
                                                                      is_tontine:
                                                                          ItemDetailCotisation[
                                                                              "is_tontine"],
                                                                      source: ItemDetailCotisation["seance"] ==
                                                                              null
                                                                          ? ''
                                                                          : '(${'rencontre'.tr()} ${ItemDetailCotisation["seance"]["matricule"]})',
                                                                      nomBeneficiaire: ItemDetailCotisation["membre"] ==
                                                                              null
                                                                          ? ''
                                                                          : '(${ItemDetailCotisation["membre"]["last_name"] == null ? "${ItemDetailCotisation["membre"]["first_name"]}" : "${ItemDetailCotisation["membre"]["first_name"]} ${ItemDetailCotisation["membre"]["last_name"]}"})',
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          AddAssoElement(
                                                            screenSource:
                                                                "transactions.btnAddContribution",
                                                            text:
                                                                "Ajouter une cotisation"
                                                                    .tr(),
                                                            routeElement:
                                                                "cotisations?query=1",
                                                          ),
                                                          if (CotisationState
                                                                      .isLoading ==
                                                                  true ||
                                                              CotisationState
                                                                      .allCotisationAss ==
                                                                  null)
                                                            EasyLoader(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          0,
                                                                          255,
                                                                          255,
                                                                          255),
                                                              iconSize: 50.r,
                                                              iconColor: AppColors
                                                                  .blackBlueAccent1,
                                                              image: AssetImage(
                                                                "assets/images/AssoplusFinal.png",
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    )
                                                  : Expanded(
                                                      child: RefreshIndicator(
                                                        onRefresh:
                                                            refreshCotisation,
                                                        child: ListView.builder(
                                                          itemCount: 1,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 200
                                                                          .h),
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "aucune_cotisation"
                                                                        .tr(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .blackBlueAccent1,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w100,
                                                                      fontSize:
                                                                          20.sp,
                                                                    ),
                                                                  ),
                                                                  if (!context
                                                                          .read<
                                                                              AuthCubit>()
                                                                          .state
                                                                          .detailUser![
                                                                      "isMember"])
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        updateTrackingData(
                                                                            "transactions.btnAddContribution",
                                                                            "${DateTime.now()}",
                                                                            {});
                                                                         launchWeb(
                                                                          "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations?query=1&app_mode=mobile",
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            50,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColors.pageBackground,
                                                                          border:
                                                                              Border.all(
                                                                            width:
                                                                                2.w,
                                                                            color:
                                                                                AppColors.blackBlue.withOpacity(1),
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            20.r,
                                                                          ),
                                                                        ),
                                                                        // alignment: Alignment
                                                                        //     .bottomLeft,
                                                                        margin:
                                                                            EdgeInsets.only(
                                                                          top: 8
                                                                              .w,
                                                                        ),
                                                                        padding:
                                                                            EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.w,
                                                                          vertical:
                                                                              7.h,
                                                                        ),
                                                                        width: MediaQuery.of(context).size.width /
                                                                            1.5,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            Text(
                                                                              "Ajouter une cotisation".tr(),
                                                                              style: TextStyle(
                                                                                color: AppColors.blackBlue.withOpacity(1),
                                                                                fontWeight: FontWeight.w900,
                                                                                fontSize: 18.sp,
                                                                                letterSpacing: 0.2.w,
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: 25.w,
                                                                              height: 25.w,
                                                                              margin: EdgeInsets.only(left: 3.w),
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(360),
                                                                                border: Border.all(
                                                                                  width: 2.w,
                                                                                  color: AppColors.blackBlue.withOpacity(1),
                                                                                ),
                                                                              ),
                                                                              child: SvgPicture.asset(
                                                                                "assets/images/addIcon.svg",
                                                                                fit: BoxFit.scaleDown,
                                                                                color: AppColors.blackBlue.withOpacity(1),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 1.5.h,
                                          left: 1.5.w,
                                          right: 1.5.w),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(
                                                top: 10.h,
                                                left: 5.w,
                                                bottom: 10.h),
                                            child: Text(
                                              "toutes_vos_sanctions".tr(),
                                              style: TextStyle(
                                                color: AppColors.blackBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp,
                                                letterSpacing: 0.2.w,
                                              ),
                                            ),
                                          ),
                                          if (currentInfoAllTournoiAssCourant!
                                                  .user_group!
                                                  .tournois!
                                                  .length >
                                              1)
                                            BlocBuilder<CotisationCubit,
                                                    CotisationState>(
                                                builder: (CotisationContext,
                                                    CotisationState) {
                                              if (CotisationState.isLoading ==
                                                      true &&
                                                  CotisationState
                                                          .allCotisationAss ==
                                                      null) return Container();
                                              return PopupMenuButton(
                                                elevation: 5,
                                                shadowColor:
                                                    AppColors.barrierColorModal,
                                                child: Column(
                                                  children: [
                                                    for (var item
                                                        in currentInfoAllTournoiAssCourant!
                                                            .user_group!
                                                            .tournois!)
                                                      if (item.tournois_code ==
                                                          AppCubitStorage()
                                                              .state
                                                              .codeTournoisHist)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            right: 10.w,
                                                            left: 10.w,
                                                            bottom: 10.h,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              width: 1.w,
                                                              color: AppColors
                                                                  .blackBlue,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              20.r,
                                                            ),
                                                          ),
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: 7.h,
                                                            bottom: 7.h,
                                                            left: 20.w,
                                                            right: 15.w,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Tournoi #${item.matricule}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14.sp,
                                                                        color: AppColors
                                                                            .blackBlue,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              if (CotisationState
                                                                      .isLoading ==
                                                                  true)
                                                                Container(
                                                                  height: 15.h,
                                                                  width: 15.h,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2.w,
                                                                    color: AppColors
                                                                        .greenAssociation,
                                                                  ),
                                                                ),
                                                              Row(
                                                                children: [
                                                                  if (item.is_default ==
                                                                      0)
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .dangerous,
                                                                          size:
                                                                              12.sp,
                                                                          color:
                                                                              AppColors.red,
                                                                        ),
                                                                        // Text(
                                                                        //   "Inactif"
                                                                        //       .tr(),
                                                                        //   style:
                                                                        //       TextStyle(
                                                                        //     color: AppColors
                                                                        //         .red,
                                                                        //     fontWeight:
                                                                        //         FontWeight
                                                                        //             .bold,
                                                                        //     fontSize:
                                                                        //         12.sp,
                                                                        //   ),
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: AppColors
                                                                        .blackBlue,
                                                                    size: 20.sp,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                  ],
                                                ),
                                                itemBuilder:
                                                    (BuildContext context) =>
                                                        <PopupMenuEntry>[
                                                  for (var item
                                                      in currentInfoAllTournoiAssCourant!
                                                          .user_group!
                                                          .tournois!)
                                                    PopupMenuItem(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      value: "tournoi",
                                                      onTap: () async {
                                                        print(
                                                            " before ${item.tournois_code}");
                                                        await AppCubitStorage()
                                                            .updateCodeTournoisHist(
                                                                item.tournois_code!);
                                                        print(
                                                            " after ${AppCubitStorage().state.codeTournoisHist}");
                                                        await context
                                                            .read<
                                                                SanctionCubit>()
                                                            .getAllSanctions(
                                                                AppCubitStorage()
                                                                    .state
                                                                    .codeTournoisHist);
                                                        handleTournoiDefault(
                                                            AppCubitStorage()
                                                                .state
                                                                .codeTournoisHist);
                                                        handleAllCotisationAssTournoi(
                                                            AppCubitStorage()
                                                                .state
                                                                .codeTournoisHist,
                                                            AppCubitStorage()
                                                                .state
                                                                .membreCode);
                                                      },
                                                      child: Container(
                                                        color: item.tournois_code! ==
                                                                AppCubitStorage()
                                                                    .state
                                                                    .codeTournoisHist
                                                            ? AppColors
                                                                .blackBlue
                                                                .withOpacity(
                                                                    .05)
                                                            : null,
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 15.h,
                                                          bottom: 15.h,
                                                          left: 10.w,
                                                          right: 10.w,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 7.w,
                                                                  ),
                                                                  Text(
                                                                    '${"tournoi".tr()} #${item.matricule}'
                                                                        .tr(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: AppColors
                                                                          .blackBlue,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 70.w,
                                                            ),
                                                            if (item.is_default ==
                                                                1)
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .green
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.r),
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 10.w,
                                                                  right: 10.w,
                                                                  top: 3.h,
                                                                  bottom: 3.h,
                                                                ),
                                                                child: Text(
                                                                  'Actif'.tr(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: AppColors
                                                                        .green,
                                                                    // fontWeight:
                                                                    //     FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }),
                                          if (context
                                              .read<AuthCubit>()
                                              .state
                                              .detailUser!["isMember"])
                                            BlocBuilder<AuthCubit, AuthState>(
                                              builder:
                                                  (AuthContext, AuthState) {
                                                final currentDetailUser =
                                                    context
                                                        .read<AuthCubit>()
                                                        .state
                                                        .detailUser;
                                                return currentDetailUser![
                                                                "sanctions"]
                                                            .length >
                                                        0
                                                    ? Expanded(
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                bottom: Platform
                                                                        .isIOS
                                                                    ? 70.h
                                                                    : 10.h,
                                                              ),
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child:
                                                                  RefreshIndicator(
                                                                onRefresh:
                                                                    refreshSanction,
                                                                child: ListView
                                                                    .builder(
                                                                  itemCount:
                                                                      currentDetailUser[
                                                                              "sanctions"]
                                                                          .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    final currentSaction =
                                                                        currentDetailUser!["sanctions"]
                                                                            [
                                                                            index];
                                                                    return Container(
                                                                      margin: EdgeInsets.only(
                                                                          left: 7
                                                                              .w,
                                                                          right: 7
                                                                              .w,
                                                                          top: 3
                                                                              .h,
                                                                          bottom:
                                                                              7.h),
                                                                      child:
                                                                          WidgetSanction(
                                                                        codeTournoi: AppCubitStorage()
                                                                            .state
                                                                            .codeTournoisHist!,
                                                                        sanction_code:
                                                                            currentSaction["sanction_code"],
                                                                        membreCode:
                                                                            "",
                                                                        nomProprietaire:
                                                                            "",
                                                                        isAdmin:
                                                                            false,
                                                                        screenSource:
                                                                            "transactions.sanction",
                                                                        objetSanction: currentSaction["libelle"] ==
                                                                                null
                                                                            ? " "
                                                                            : currentSaction["libelle"],
                                                                        heureSanction: AppCubitStorage().state.Language ==
                                                                                "fr"
                                                                            ? formatTimeToFrench(currentSaction["start_date"])
                                                                            : formatTimeToEnglish(currentSaction["start_date"]),
                                                                        dateSanction:
                                                                            currentSaction["start_date"],
                                                                        motifSanction:
                                                                            currentSaction["motif"],
                                                                        montantSanction:
                                                                            currentSaction["amount"].toString(),
                                                                        montantPayeeSanction:
                                                                            currentSaction["sanction_balance"],
                                                                        lienPaiement: currentSaction["sanction_pay_link"] ==
                                                                                null
                                                                            ? " "
                                                                            : currentSaction["sanction_pay_link"],
                                                                        versement:
                                                                            currentSaction["payments"],
                                                                        isSanctionPayed:
                                                                            currentSaction["is_sanction_payed"],
                                                                        typeSaction:
                                                                            currentSaction["type"],
                                                                        resteAPayer:
                                                                            currentSaction["amount_remaining"],
                                                                        dejaPayer:
                                                                            currentSaction["sanction_balance"],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            AddAssoElement(
                                                              screenSource:
                                                                  "transactions.btnAddSanction",
                                                              text:
                                                                  "Ajouter une sanction"
                                                                      .tr(),
                                                              routeElement:
                                                                  "sanctions?query=1",
                                                            ),
                                                            if (AuthState
                                                                        .isLoading ==
                                                                    true ||
                                                                AuthState
                                                                        .detailUser ==
                                                                    null)
                                                              EasyLoader(
                                                                backgroundColor:
                                                                    Color.fromARGB(
                                                                        0,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                iconSize: 50.r,
                                                                iconColor: AppColors
                                                                    .blackBlueAccent1,
                                                                image:
                                                                    AssetImage(
                                                                  "assets/images/AssoplusFinal.png",
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                      )
                                                    : Expanded(
                                                        child: RefreshIndicator(
                                                          onRefresh:
                                                              refreshSanction,
                                                          child:
                                                              ListView.builder(
                                                            itemCount: 1,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 200
                                                                            .h),
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      "aucune_sanction"
                                                                          .tr(),
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .blackBlueAccent1,
                                                                          fontWeight: FontWeight
                                                                              .w100,
                                                                          fontSize:
                                                                              20.sp),
                                                                    ),
                                                                    if (!context
                                                                        .read<
                                                                            AuthCubit>()
                                                                        .state
                                                                        .detailUser!["isMember"])
                                                                      InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          updateTrackingData(
                                                                              "transactions.btnAddSanction",
                                                                              "${DateTime.now()}",
                                                                              {});
                                                                           launchWeb(
                                                                            "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/sanctions?query=1&app_mode=mobile",
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                AppColors.pageBackground,
                                                                            border:
                                                                                Border.all(
                                                                              width: 2.w,
                                                                              color: AppColors.blackBlue.withOpacity(1),
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              20.r,
                                                                            ),
                                                                          ),
                                                                          // alignment: Alignment
                                                                          //     .bottomLeft,
                                                                          margin:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                8.w,
                                                                          ),
                                                                          padding:
                                                                              EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10.w,
                                                                            vertical:
                                                                                7.h,
                                                                          ),
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 1.5,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Text(
                                                                                "Ajouter une sanction".tr(),
                                                                                style: TextStyle(
                                                                                  color: AppColors.blackBlue.withOpacity(1),
                                                                                  fontWeight: FontWeight.w900,
                                                                                  fontSize: 18.sp,
                                                                                  letterSpacing: 0.2.w,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 25.w,
                                                                                height: 25.w,
                                                                                margin: EdgeInsets.only(left: 3.w),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(360),
                                                                                  border: Border.all(
                                                                                    width: 2.w,
                                                                                    color: AppColors.blackBlue.withOpacity(1),
                                                                                  ),
                                                                                ),
                                                                                child: SvgPicture.asset(
                                                                                  "assets/images/addIcon.svg",
                                                                                  fit: BoxFit.scaleDown,
                                                                                  color: AppColors.blackBlue.withOpacity(1),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                              },
                                            ),
                                          if (!context
                                              .read<AuthCubit>()
                                              .state
                                              .detailUser!["isMember"])
                                            BlocBuilder<SanctionCubit,
                                                SanctionState>(
                                              builder: (SanctionContext,
                                                  SanctionState) {
                                                final currentDetailUser =
                                                    context
                                                        .read<SanctionCubit>()
                                                        .state
                                                        .sanctions;

                                                print(
                                                    "currentDetailUsercurrentDetailUsercurrentDetailUser ${currentDetailUser}");
                                                return currentDetailUser!
                                                            .length >
                                                        0
                                                    ? Expanded(
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                bottom: Platform
                                                                        .isIOS
                                                                    ? 70.h
                                                                    : 10.h,
                                                              ),
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child:
                                                                  RefreshIndicator(
                                                                onRefresh:
                                                                    refreshSanction,
                                                                child: ListView
                                                                    .builder(
                                                                  itemCount:
                                                                      currentDetailUser
                                                                          .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    final currentSaction =
                                                                        currentDetailUser[
                                                                            index];
                                                                    return Container(
                                                                      margin: EdgeInsets.only(
                                                                          left: 7
                                                                              .w,
                                                                          right: 7
                                                                              .w,
                                                                          top: 3
                                                                              .h,
                                                                          bottom:
                                                                              7.h),
                                                                      child:
                                                                          WidgetSanction(
                                                                        codeTournoi: AppCubitStorage()
                                                                            .state
                                                                            .codeTournoisHist!,
                                                                        sanction_code:
                                                                            currentSaction["sanction_code"],
                                                                        membreCode:
                                                                            "${currentSaction["membre"]["membre_code"]}",
                                                                        nomProprietaire:
                                                                            "${currentSaction["membre"]["first_name"]} ${currentSaction["membre"]["last_name"] ?? ""}",
                                                                        isAdmin:
                                                                            true,
                                                                        screenSource:
                                                                            "transactions.sanction",
                                                                        objetSanction: currentSaction["libelle"] ==
                                                                                null
                                                                            ? " "
                                                                            : currentSaction["libelle"],
                                                                        heureSanction: AppCubitStorage().state.Language ==
                                                                                "fr"
                                                                            ? formatTimeToFrench(currentSaction["start_date"])
                                                                            : formatTimeToEnglish(currentSaction["start_date"]),
                                                                        dateSanction:
                                                                            currentSaction["start_date"],
                                                                        motifSanction:
                                                                            currentSaction["motif"],
                                                                        montantSanction:
                                                                            currentSaction["amount"].toString(),
                                                                        montantPayeeSanction:
                                                                            currentSaction["sanction_balance"],
                                                                        lienPaiement: currentSaction["sanction_pay_link"] ==
                                                                                null
                                                                            ? " "
                                                                            : currentSaction["sanction_pay_link"],
                                                                        versement:
                                                                            currentSaction["versement"],
                                                                        isSanctionPayed:
                                                                            currentSaction["is_sanction_payed"],
                                                                        typeSaction:
                                                                            currentSaction["type"],
                                                                        resteAPayer:
                                                                            currentSaction["amount_remaining"],
                                                                        dejaPayer:
                                                                            currentSaction["sanction_balance"],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            AddAssoElement(
                                                              screenSource:
                                                                  "transactions.btnAddSanction",
                                                              text:
                                                                  "Ajouter une sanction"
                                                                      .tr(),
                                                              routeElement:
                                                                  "sanctions?query=1",
                                                            ),
                                                            if (SanctionState
                                                                    .isLoading ==
                                                                true)
                                                              EasyLoader(
                                                                backgroundColor:
                                                                    Color.fromARGB(
                                                                        0,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                iconSize: 50.r,
                                                                iconColor: AppColors
                                                                    .blackBlueAccent1,
                                                                image:
                                                                    AssetImage(
                                                                  "assets/images/AssoplusFinal.png",
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                      )
                                                    : Expanded(
                                                        child: RefreshIndicator(
                                                          onRefresh:
                                                              refreshSanction,
                                                          child:
                                                              ListView.builder(
                                                            itemCount: 1,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 200
                                                                            .h),
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      "aucune_sanction"
                                                                          .tr(),
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .blackBlueAccent1,
                                                                          fontWeight: FontWeight
                                                                              .w100,
                                                                          fontSize:
                                                                              20.sp),
                                                                    ),
                                                                    if (!context
                                                                        .read<
                                                                            AuthCubit>()
                                                                        .state
                                                                        .detailUser!["isMember"])
                                                                      InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          updateTrackingData(
                                                                              "transactions.btnAddSanction",
                                                                              "${DateTime.now()}",
                                                                              {});
                                                                           launchWeb(
                                                                            "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/sanctions?query=1&app_mode=mobile",
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                AppColors.pageBackground,
                                                                            border:
                                                                                Border.all(
                                                                              width: 2.w,
                                                                              color: AppColors.blackBlue.withOpacity(1),
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              20.r,
                                                                            ),
                                                                          ),
                                                                          // alignment: Alignment
                                                                          //     .bottomLeft,
                                                                          margin:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                8.w,
                                                                          ),
                                                                          padding:
                                                                              EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10.w,
                                                                            vertical:
                                                                                7.h,
                                                                          ),
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 1.5,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Text(
                                                                                "Ajouter une sanction".tr(),
                                                                                style: TextStyle(
                                                                                  color: AppColors.blackBlue.withOpacity(1),
                                                                                  fontWeight: FontWeight.w900,
                                                                                  fontSize: 18.sp,
                                                                                  letterSpacing: 0.2.w,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 25.w,
                                                                                height: 25.w,
                                                                                margin: EdgeInsets.only(left: 3.w),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(360),
                                                                                  border: Border.all(
                                                                                    width: 2.w,
                                                                                    color: AppColors.blackBlue.withOpacity(1),
                                                                                  ),
                                                                                ),
                                                                                child: SvgPicture.asset(
                                                                                  "assets/images/addIcon.svg",
                                                                                  fit: BoxFit.scaleDown,
                                                                                  color: AppColors.blackBlue.withOpacity(1),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                    if (checkTransparenceLoans(
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
                                        padding: EdgeInsets.only(
                                            top: 1.5.h,
                                            left: 1.5.w,
                                            right: 1.5.w),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                  top: 10.h,
                                                  left: 5.w,
                                                  bottom: 10.h),
                                              child: Text(
                                                "toutes_les_epargnes".tr(),
                                                style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  letterSpacing: 0.2.w,
                                                ),
                                              ),
                                            ),
                                            if (currentInfoAllTournoiAssCourant!
                                                    .user_group!
                                                    .tournois!
                                                    .length >
                                                1)
                                              BlocBuilder<CotisationCubit,
                                                      CotisationState>(
                                                  builder: (CotisationContext,
                                                      CotisationState) {
                                                return PopupMenuButton(
                                                  elevation: 5,
                                                  shadowColor: AppColors
                                                      .barrierColorModal,
                                                  child: Column(
                                                    children: [
                                                      for (var item
                                                          in currentInfoAllTournoiAssCourant!
                                                              .user_group!
                                                              .tournois!)
                                                        if (item.tournois_code ==
                                                            AppCubitStorage()
                                                                .state
                                                                .codeTournoisHist)
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              right: 10.w,
                                                              left: 10.w,
                                                              bottom: 10.h,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                width: 1.w,
                                                                color: AppColors
                                                                    .blackBlue,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                20.r,
                                                              ),
                                                            ),
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 7.h,
                                                              bottom: 7.h,
                                                              left: 20.w,
                                                              right: 15.w,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        'Tournoi #${item.matricule}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14.sp,
                                                                          color:
                                                                              AppColors.blackBlue,
                                                                          fontWeight:
                                                                              FontWeight.w900,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                if (CotisationState
                                                                        .isLoading ==
                                                                    true)
                                                                  Container(
                                                                    height:
                                                                        15.h,
                                                                    width: 15.h,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          2.w,
                                                                      color: AppColors
                                                                          .greenAssociation,
                                                                    ),
                                                                  ),
                                                                Row(
                                                                  children: [
                                                                    if (item.is_default ==
                                                                        0)
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.dangerous,
                                                                            size:
                                                                                12.sp,
                                                                            color:
                                                                                AppColors.red,
                                                                          ),
                                                                          // Text(
                                                                          //   "Inactif"
                                                                          //       .tr(),
                                                                          //   style:
                                                                          //       TextStyle(
                                                                          //     color: AppColors
                                                                          //         .red,
                                                                          //     fontWeight:
                                                                          //         FontWeight
                                                                          //             .bold,
                                                                          //     fontSize:
                                                                          //         12.sp,
                                                                          //   ),
                                                                          // ),
                                                                        ],
                                                                      ),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                      color: AppColors
                                                                          .blackBlue,
                                                                      size:
                                                                          20.sp,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                    ],
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext context) =>
                                                          <PopupMenuEntry>[
                                                    for (var item
                                                        in currentInfoAllTournoiAssCourant!
                                                            .user_group!
                                                            .tournois!)
                                                      PopupMenuItem(
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        value: "tournoi",
                                                        onTap: () async {
                                                          print(
                                                              " before ${item.tournois_code}");
                                                          await AppCubitStorage()
                                                              .updateCodeTournoisHist(
                                                                  item.tournois_code!);
                                                          print(
                                                              " after ${AppCubitStorage().state.codeTournoisHist}");
                                                          await context
                                                              .read<
                                                                  PretEpargneCubit>()
                                                              .getAllAssEpargnes(
                                                                  AppCubitStorage()
                                                                      .state
                                                                      .codeTournoisHist);
                                                          context
                                                              .read<
                                                                  SanctionCubit>()
                                                              .getAllSanctions(
                                                                  AppCubitStorage()
                                                                      .state
                                                                      .codeTournoisHist);
                                                          handleTournoiDefault(
                                                              AppCubitStorage()
                                                                  .state
                                                                  .codeTournoisHist);
                                                          handleAllCotisationAssTournoi(
                                                              AppCubitStorage()
                                                                  .state
                                                                  .codeTournoisHist,
                                                              AppCubitStorage()
                                                                  .state
                                                                  .membreCode);
                                                        },
                                                        child: Container(
                                                          color: item.tournois_code! ==
                                                                  AppCubitStorage()
                                                                      .state
                                                                      .codeTournoisHist
                                                              ? AppColors
                                                                  .blackBlue
                                                                  .withOpacity(
                                                                      .05)
                                                              : null,
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: 15.h,
                                                            bottom: 15.h,
                                                            left: 10.w,
                                                            right: 10.w,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          7.w,
                                                                    ),
                                                                    Text(
                                                                      '${"tournoi".tr()} #${item.matricule}'
                                                                          .tr(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14.sp,
                                                                        color: AppColors
                                                                            .blackBlue,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 70.w,
                                                              ),
                                                              if (item.is_default ==
                                                                  1)
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors
                                                                        .green
                                                                        .withOpacity(
                                                                            .1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.r),
                                                                  ),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 10.w,
                                                                    right: 10.w,
                                                                    top: 3.h,
                                                                    bottom: 3.h,
                                                                  ),
                                                                  child: Text(
                                                                    'Actif'
                                                                        .tr(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: AppColors
                                                                          .green,
                                                                      // fontWeight:
                                                                      //     FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              }),
                                            BlocBuilder<PretEpargneCubit,
                                                PretEpargneState>(
                                              builder: (PretEpargneContext,
                                                  PretEpargneState) {
                                                if (PretEpargneState
                                                            .isLoadingAllAssEpargne ==
                                                        true &&
                                                    PretEpargneState
                                                            .allAssEpargne ==
                                                        null)
                                                  return Container(
                                                    padding: EdgeInsets.only(
                                                        top: 15.h),
                                                    child: EasyLoader(
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              0, 255, 255, 255),
                                                      iconSize: 50.r,
                                                      iconColor: AppColors
                                                          .blackBlueAccent1,
                                                      image: AssetImage(
                                                        'assets/images/AssoplusFinal.png',
                                                      ),
                                                    ),
                                                  );
                                                final currentAllEpargne = context
                                                        .read<PretEpargneCubit>()
                                                        .state
                                                        .allAssEpargne![
                                                    "membre_savings"];
                                                print(
                                                    "ddd ${currentAllEpargne}");

                                                print(
                                                    "currentDetailUsercurrentDetailUsercurrentDetailUser ${currentAllEpargne}");
                                                return currentAllEpargne!
                                                            .length >
                                                        0
                                                    ? Expanded(
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                bottom: Platform
                                                                        .isIOS
                                                                    ? 70.h
                                                                    : 10.h,
                                                              ),
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child:
                                                                  RefreshIndicator(
                                                                onRefresh:
                                                                    refreshSanction,
                                                                child: ListView
                                                                    .builder(
                                                                  itemCount:
                                                                      currentAllEpargne
                                                                          .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    final currentEpargne =
                                                                        currentAllEpargne[
                                                                            index];
                                                                    return Container(
                                                                      margin: EdgeInsets.only(
                                                                          left: 7
                                                                              .w,
                                                                          right: 7
                                                                              .w,
                                                                          top: 3
                                                                              .h,
                                                                          bottom:
                                                                              10.h),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(
                                                                            width:
                                                                                1.w,
                                                                            color: currentEpargne["is_active"] == 0
                                                                                ? AppColors.red
                                                                                : AppColors.green,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(15.r),
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          left:
                                                                              10.w,
                                                                          top: 10
                                                                              .h,
                                                                          bottom:
                                                                              5.h,
                                                                          right:
                                                                              10.w,
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Container(
                                                                                  width: 10.r,
                                                                                  height: 10.r,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(360),
                                                                                    color: currentEpargne["is_active"] == 0 ? AppColors.red : AppColors.green,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5.w,
                                                                                ),
                                                                                Text(
                                                                                  currentEpargne["is_active"] == 1 ? "Actif".tr() : "Suspendu".tr(),
                                                                                  style: TextStyle(
                                                                                    color: currentEpargne["is_active"] == 0 ? AppColors.red : AppColors.green,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 12.sp,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  "${currentEpargne["type_interest"] == "1" ? "Fixe mensuel".tr() : "Indexé sur les prêts".tr()}".toUpperCase(),
                                                                                  style: TextStyle(
                                                                                    fontSize: 13.sp,
                                                                                    color: AppColors.colorButton,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                                ),
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    Text(
                                                                                      "montant épargné".tr().toUpperCase(),
                                                                                      style: TextStyle(
                                                                                        fontSize: 13.sp,
                                                                                        color: AppColors.blackBlueAccent1,
                                                                                        fontWeight: FontWeight.w900,
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 2.h,
                                                                                    ),
                                                                                    Text(
                                                                                      "${formatMontantFrancais(double.parse(currentEpargne["amount_saved"].toString()))} FCFA",
                                                                                      style: TextStyle(
                                                                                        fontSize: 14.sp,
                                                                                        color: AppColors.blackBlue,
                                                                                        fontWeight: FontWeight.w900,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.h,
                                                                            ),
                                                                            Text(
                                                                              "${currentEpargne["membre"]["first_name"]} ${currentEpargne["membre"]["last_name"] ?? ""}",
                                                                              style: TextStyle(
                                                                                fontSize: 14.sp,
                                                                                color: AppColors.blackBlue,
                                                                                fontWeight: FontWeight.w900,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.h,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  "INTÉRÊT GÉNÉRÉ".tr(),
                                                                                  style: TextStyle(
                                                                                    fontSize: 13.sp,
                                                                                    color: AppColors.blackBlueAccent1,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  "${formatMontantFrancais(double.parse(currentEpargne["total_interest"].toString()))} FCFA",
                                                                                  style: TextStyle(
                                                                                    fontSize: 14.sp,
                                                                                    color: AppColors.blackBlue,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.h,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  "INTERÊT RECENT".tr(),
                                                                                  style: TextStyle(
                                                                                    fontSize: 13.sp,
                                                                                    color: AppColors.blackBlueAccent1,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  "${formatMontantFrancais(double.parse(currentEpargne["interest_added"] ?? "0".toString()))} FCFA",
                                                                                  style: TextStyle(
                                                                                    fontSize: 14.sp,
                                                                                    color: AppColors.blackBlue,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.h,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Text(
                                                                                  "Créé le, ".tr(),
                                                                                  style: TextStyle(
                                                                                    fontSize: 12.sp,
                                                                                    color: AppColors.blackBlueAccent1,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  "${formatDateLiteral(currentEpargne["created_at"])}",
                                                                                  style: TextStyle(
                                                                                    fontSize: 12.sp,
                                                                                    color: AppColors.blackBlueAccent1,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Container(
                                                                              margin: EdgeInsets.only(
                                                                                top: 8.h,
                                                                              ),
                                                                              padding: EdgeInsets.only(
                                                                                top: 7.h,
                                                                                bottom: 4.h,
                                                                              ),
                                                                              decoration: BoxDecoration(
                                                                                border: Border(
                                                                                  top: BorderSide(
                                                                                    width: .5.r,
                                                                                    color: AppColors.blackBlueAccent2,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  if (!context.read<AuthCubit>().state.detailUser!["isMember"])
                                                                                    // if (widget.nomBeneficiaire != "")
                                                                                    Expanded(
                                                                                      child: InkWell(
                                                                                        onTap: () async {
                                                                                          showModalPayEpargne(
                                                                                            context,
                                                                                            "${currentEpargne["membre"]["first_name"]} ${currentEpargne["membre"]["last_name"] ?? ""}",
                                                                                            // "resteAPayer",
                                                                                            "${currentEpargne["saving_code"]}",
                                                                                            "${currentEpargne["membre"]["membre_code"]}",
                                                                                            9,
                                                                                          );
                                                                                          //   updateTrackingData(
                                                                                          //       "${widget.screenSource}.btnwithdrawnFundsContribution",
                                                                                          //       "${DateTime.now()}", {});
                                                                                          //   await launchWeb(
                                                                                          //     "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations-details/${widget.codeCotisation}?query=1&app_mode=mobile",
                                                                                          //     mode: LaunchMode.platformDefault,
                                                                                          //   );
                                                                                          //   print("object1");
                                                                                        },
                                                                                        child: Column(
                                                                                          children: [
                                                                                            Container(
                                                                                              height: 17.h,
                                                                                              child: SvgPicture.asset(
                                                                                                "assets/images/walletPayIcon.svg",
                                                                                                fit: BoxFit.scaleDown,
                                                                                                color: AppColors.blackBlueAccent1,
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 3.h,
                                                                                            ),
                                                                                            Text(
                                                                                              "Dépôt".tr(),
                                                                                              style: TextStyle(
                                                                                                color: AppColors.blackBlueAccent1,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                fontSize: 11.sp,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  // if (!context
                                                                                  //     .read<AuthCubit>()
                                                                                  //     .state
                                                                                  //     .detailUser!["isMember"])
                                                                                  // https://groups.faroty.com/cotisation-details/code
                                                                                  Expanded(
                                                                                    child: buttonSuspend(currentEpargne: currentEpargne),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            AddAssoElement(
                                                              screenSource:
                                                                  "transactions.btnAddSanction",
                                                              text:
                                                                  "Ajouter un épargnant"
                                                                      .tr(),
                                                              routeElement:
                                                                  "loan?query=1",
                                                            ),
                                                            if (PretEpargneState
                                                                        .isLoadingAllAssEpargne ==
                                                                    true &&
                                                                PretEpargneState
                                                                        .allAssEpargne !=
                                                                    null)
                                                              EasyLoader(
                                                                backgroundColor:
                                                                    Color.fromARGB(
                                                                        0,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                iconSize: 50.r,
                                                                iconColor: AppColors
                                                                    .blackBlueAccent1,
                                                                image:
                                                                    AssetImage(
                                                                  "assets/images/AssoplusFinal.png",
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                      )
                                                    : Expanded(
                                                        child: RefreshIndicator(
                                                          onRefresh:
                                                              refreshSanction,
                                                          child:
                                                              ListView.builder(
                                                            itemCount: 1,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 200
                                                                            .h),
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      "aucune_epargnant"
                                                                          .tr(),
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .blackBlueAccent1,
                                                                          fontWeight: FontWeight
                                                                              .w100,
                                                                          fontSize:
                                                                              20.sp),
                                                                    ),
                                                                    if (!context
                                                                        .read<
                                                                            AuthCubit>()
                                                                        .state
                                                                        .detailUser!["isMember"])
                                                                      InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          updateTrackingData(
                                                                              "transactions.btnAddSaving",
                                                                              "${DateTime.now()}",
                                                                              {});
                                                                           launchWeb(
                                                                            "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/loan?query=1&app_mode=mobile",
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                AppColors.pageBackground,
                                                                            border:
                                                                                Border.all(
                                                                              width: 2.w,
                                                                              color: AppColors.blackBlue.withOpacity(1),
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              20.r,
                                                                            ),
                                                                          ),
                                                                          // alignment: Alignment
                                                                          //     .bottomLeft,
                                                                          margin:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                8.w,
                                                                          ),
                                                                          padding:
                                                                              EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10.w,
                                                                            vertical:
                                                                                7.h,
                                                                          ),
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 1.5,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Text(
                                                                                "Ajouter un épargnant".tr(),
                                                                                style: TextStyle(
                                                                                  color: AppColors.blackBlue.withOpacity(1),
                                                                                  fontWeight: FontWeight.w900,
                                                                                  fontSize: 18.sp,
                                                                                  letterSpacing: 0.2.w,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 25.w,
                                                                                height: 25.w,
                                                                                margin: EdgeInsets.only(left: 3.w),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(360),
                                                                                  border: Border.all(
                                                                                    width: 2.w,
                                                                                    color: AppColors.blackBlue.withOpacity(1),
                                                                                  ),
                                                                                ),
                                                                                child: SvgPicture.asset(
                                                                                  "assets/images/addIcon.svg",
                                                                                  fit: BoxFit.scaleDown,
                                                                                  color: AppColors.blackBlue.withOpacity(1),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
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
                                        padding: EdgeInsets.only(
                                          top: 1.5.h,
                                          left: 1.5.w,
                                          right: 1.5.w,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                top: 10.h,
                                                left: 5.w,
                                                bottom: 15.h,
                                              ),
                                              child: Text(
                                                "les_comptes_de_l'association"
                                                    .tr(),
                                                style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  letterSpacing: 0.2.w,
                                                ),
                                              ),
                                            ),
                                            BlocBuilder<CompteCubit,
                                                    CompteState>(
                                                builder: (CompteContext,
                                                    compteState) {
                                              if (compteState.isLoading ==
                                                      true &&
                                                  compteState.allCompteAss ==
                                                      null)
                                                return Container(
                                                  child: Expanded(
                                                    child: EasyLoader(
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              0, 255, 255, 255),
                                                      iconSize: 50.r,
                                                      iconColor: AppColors
                                                          .blackBlueAccent1,
                                                      image: AssetImage(
                                                        "assets/images/AssoplusFinal.png",
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              final currentCompteAss = context
                                                  .read<CompteCubit>()
                                                  .state
                                                  .allCompteAss;

                                              List<String> listeDeCouleurs = [
                                                "#F44336", // Rouge
                                                "#F44336", // Rouge
                                                "#2196F3", // Bleu
                                                "#96BF35", // Vert
                                                "#795548", // Jaune
                                                "#9C27B0", // Violet
                                              ];
                                              int i = 0;

                                              List<Widget> listWidgetCompte =
                                                  currentCompteAss!.map((item) {
                                                i++;
                                                return GestureDetector(
                                                  onTap: () async {
                                                    updateTrackingData(
                                                        "transactions.account",
                                                        "${DateTime.now()}",
                                                        {});
                                                    context
                                                        .read<CompteCubit>()
                                                        .getTransactionCompte(
                                                            item.public_ref);

                                                    showModalBottomTransactionCompte(
                                                        context);
                                                  },
                                                  child: WidgetCompteCard(
                                                    montantCompte:
                                                        "${int.parse(item.balance!) + int.parse(item.faroti_balance!)}",
                                                    nomCompte: item.name!,
                                                    numeroCompte:
                                                        item.public_ref!,
                                                    couleur: listeDeCouleurs[i],
                                                  ),
                                                );
                                              }).toList();

                                              return Expanded(
                                                child: Stack(
                                                  children: [
                                                    RefreshIndicator(
                                                      onRefresh: refreshCompte,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            bottom:
                                                                Platform.isIOS
                                                                    ? 70.h
                                                                    : 10.h,
                                                          ),
                                                          child: Wrap(
                                                            alignment:
                                                                WrapAlignment
                                                                    .spaceBetween,
                                                            children:
                                                                listWidgetCompte,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    if (compteState.isLoading ==
                                                        true)
                                                      EasyLoader(
                                                        backgroundColor:
                                                            Color.fromARGB(0,
                                                                255, 255, 255),
                                                        iconSize: 50.r,
                                                        iconColor: AppColors
                                                            .blackBlueAccent1,
                                                        image: AssetImage(
                                                          "assets/images/AssoplusFinal.png",
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
            ),
          );
        },
      );
    });
  }

  Future<dynamic> showModalBottomTransactionCompte(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.h, bottom: 5.h),
                height: 5.h,
                width: 55.w,
                decoration: BoxDecoration(
                  color: AppColors.blackBlue,
                  borderRadius: BorderRadius.circular(50.r),
                ),
              ),
              BlocBuilder<CompteCubit, CompteState>(
                  builder: (CompteContext, compteState) {
                final currentTransactionCompte =
                    context.read<CompteCubit>().state.transactionCompte;
                if (compteState.isLoadingTransaction &&
                    compteState.transactionCompte == null)
                  return Expanded(
                    child: EasyLoader(
                      backgroundColor: Color.fromARGB(0, 255, 255, 255),
                      iconSize: 50.r,
                      iconColor: AppColors.blackBlueAccent1,
                      image: AssetImage(
                        "assets/images/AssoplusFinal.png",
                      ),
                    ),
                  );
                return Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: currentTransactionCompte!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final itemTransaction =
                              currentTransactionCompte[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.blackBlueAccent2,
                            ),
                            padding: EdgeInsets.all(10.r),
                            margin: EdgeInsets.all(7.r),
                            child: Column(
                              children: [
                                // Container(
                                // margin: EdgeInsets.only(bottom: 5),
                                // child:

                                Html(
                                  data:
                                      "<p style='color:#142D63 ; font-size:${14.sp}px'>${itemTransaction["description"]}</p>",
                                ),

                                Container(
                                  margin: EdgeInsets.only(bottom: 5.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${formatMontantFrancais(double.parse(itemTransaction["amount"]))} FCFA",
                                        style: TextStyle(
                                          color: itemTransaction["type"] == "0"
                                              ? AppColors.green
                                              : AppColors.red,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      itemTransaction["type"] == "0"
                                          ? Icon(
                                              Icons.arrow_downward_sharp,
                                              size: 14.sp,
                                              color:
                                                  itemTransaction["type"] == "0"
                                                      ? AppColors.green
                                                      : AppColors.red,
                                            )
                                          : Icon(
                                              Icons.arrow_upward_sharp,
                                              color:
                                                  itemTransaction["type"] == "0"
                                                      ? AppColors.green
                                                      : AppColors.red,
                                              size: 14.sp,
                                            ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Via ",
                                            style: TextStyle(
                                              color: AppColors.blackBlue,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          Text(
                                            itemTransaction["mode"] == "0"
                                                ? "Admin"
                                                : "Lien de paiement".tr(),
                                            style: TextStyle(
                                              color: AppColors.blackBlue,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        formatDateLiteral(
                                            itemTransaction["created_at"]),
                                        style: TextStyle(
                                          color: AppColors.blackBlue,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Solde après".tr(),
                                          style: TextStyle(
                                            color: AppColors.blackBlueAccent1,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        Text(
                                          "${formatMontantFrancais(double.parse(itemTransaction["balance_after"]))} FCFA",
                                          style: TextStyle(
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      if (compteState.isLoadingTransaction &&
                          compteState.transactionCompte != null)
                        EasyLoader(
                          backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          iconSize: 50.r,
                          iconColor: AppColors.blackBlueAccent1,
                          image: AssetImage(
                            "assets/images/AssoplusFinal.png",
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void showModalPayEpargne(context, nom, codeEpargne, codeMembre, typeEpargne) {
    showDialog(
        context: context,
        barrierColor: AppColors.barrierColorModal,
        builder: (BuildContext context) {
          Future<void> handleDetailCotisation(codeSanction) async {
            // final detailTournoiCourant = await context
            //     .read<DetailTournoiCourantCubit>()
            //     .detailTournoiCourantCubit();
            // final detailCotisation = await context
            //     .read<CotisationDetailCubit>()
            //     .detailCotisationCubit(codeSanction);
          }

          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              child: Container(
                height: 250.h,
                child: PayEpargneWidget(
                  nom: nom,
                  codeEpargne: codeEpargne,
                  codeMembre: codeMembre,
                  // resteAPayer: resteAPayer,
                  typeEpargne: typeEpargne,
                  // objectSanction: objectSanction,
                ),
              )

              // Container(
              //   // constraints:
              //       // BoxConstraints(maxHeight: typeSaction == "1" ? 250.h : 200.h),
              //   // child: PaiementSanctionWidget(
              //   //   nom: nom,
              //   //   codeSanction: codeSanction,
              //   //   codeMembre: codeMembre,
              //   //   resteAPayer: resteAPayer,
              //   //   typeSanction: typeSaction,
              //   //   objectSanction: objectSanction,
              //   // ),
              // ),
              );
        });
  }
}

class buttonSuspend extends StatefulWidget {
  buttonSuspend({
    super.key,
    required this.currentEpargne,
  });

  var currentEpargne;

  @override
  State<buttonSuspend> createState() => _buttonSuspendState();
}

class _buttonSuspendState extends State<buttonSuspend> {
  bool suspendLoaded = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.blackBlue,
      onTap: () async {
        setState(() {
          suspendLoaded = true;
        });

        if (widget.currentEpargne["is_active"] == 1) {
          await PretEpargneRepository()
              .suspendEpargne(widget.currentEpargne["saving_code"]);
        } else {
          await PretEpargneRepository()
              .activeEpargne(widget.currentEpargne["saving_code"]);
        }
        await context
            .read<PretEpargneCubit>()
            .getAllAssEpargnes(AppCubitStorage().state.codeTournoisHist);

        setState(() {
          suspendLoaded = false;
        });
        //   print("object3");
        //   updateTrackingData(
        //       "${widget.screenSource}.btnShareContribution",
        //       "${DateTime.now()}", {});

        //   Share.share(context
        //           .read<AuthCubit>()
        //           .state
        //           .detailUser!["isMember"]
        //       ? "Aide-moi à payer ma cotisation *${widget.motifCotisations}*.\nMontant: *${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode} pour valider"
        //       : "Nouvelle cotisation créée dans le groupe *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* concernant ${widget.source == '' ? "*${(widget.nomBeneficiaire)}*" : "*${(widget.source)}*"}.\nSoyez le premier à contribuer ici : https://${widget.lienDePaiement}");
        // },
        // onTap: () async {
        //   updateTrackingData("transactions.btnAddSharesaving", "${DateTime.now()}", {});
        //     Share.share(
        //        "Vous pouvez *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* concernant ${widget.source == '' ? "*${(widget.nomBeneficiaire)}*" : "*${(widget.source)}*"}.\nSoyez le premier à contribuer ici : https://${widget.lienDePaiement}");
        //   await launchWeb(
        //     "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/loan?query=1&app_mode=mobile",
        //     mode: LaunchMode.platformDefault,
        //   );
      },
      child: suspendLoaded
          ? Center(
              child: Container(
                width: 20.r,
                height: 20.r,
                child: CircularProgressIndicator(
                  color: AppColors.green,
                  strokeWidth: 2.w,
                ),
              ),
            )
          : Column(
              children: [
                Container(
                  height: 17.h,
                  child: SvgPicture.asset(
                    widget.currentEpargne["is_active"] == 1
                        ? "assets/images/suspendIcon.svg"
                        : "assets/images/activeIcon.svg",
                    fit: BoxFit.scaleDown,
                    color: widget.currentEpargne["is_active"] == 1
                        ? AppColors.red
                        : AppColors.green,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  widget.currentEpargne["is_active"] == 1
                      ? "Suspendre".tr()
                      : "Activer".tr(),
                  style: TextStyle(
                    color: widget.currentEpargne["is_active"] == 1
                        ? AppColors.red
                        : AppColors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
    );
  }
}

class PayEpargneWidget extends StatefulWidget {
  PayEpargneWidget({
    super.key,
    // required this.infoUserController,
    required this.nom,
    required this.codeEpargne,
    required this.codeMembre,
    required this.typeEpargne,
    // required this.typeSanction,
    // required this.objectSanction,
  });
  var nom;

  var codeEpargne;

  var codeMembre;

  var typeEpargne;

  // var typeSanction;

  // var objectSanction;
  @override
  State<PayEpargneWidget> createState() => _PayEpargneWidgetState();
}

class _PayEpargneWidgetState extends State<PayEpargneWidget> {
  bool load = false;

  late TextEditingController infoUserController;

  @override
  void initState() {
    super.initState();
    infoUserController = TextEditingController(text: "0");
  }

  @override
  Widget build(BuildContext context) {
    String? jsonString = context.read<AuthCubit>().state.dataCookies;

    // Analyse de la réponse JSON
    Map<String, dynamic> data = jsonDecode(jsonString!);

    // Récupération du hash_id
    String hashId = data['user']['hash_id'];
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: 10.h,
          // ),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.blackBlue,
              ),
              text: "Vous confirmez avoir reçu le paiement de ".tr(),
              children: <InlineSpan>[
                TextSpan(
                  text: "${widget.nom} ",
                  // widget.typeSanction == "1"
                  //     ? "${widget.nom} ?"
                  // : "${widget.objectSanction} ",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackBlue),
                ),
                // if (widget.typeSanction == "0")
                TextSpan(
                  text: "pour son épargne ?".tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.blackBlue,
                  ),
                ),
                // if (widget.typeSanction == "0")
                // TextSpan(
                //   // text: widget.nom,
                //   text: "rrrr",
                //   style: TextStyle(
                //       fontSize: 14.sp,
                //       fontWeight: FontWeight.bold,
                //       color: AppColors.blackBlue),
                // )
              ],
            ),
          ),
          // if (widget.typeSanction == "1")
          SizedBox(
            height: 20.h,
          ),
          // if (widget.typeSanction == "1")
          SizedBox(
            height: 60.h,
            child: TextField(
              controller: infoUserController,
              autofocus: true,
              style: TextStyle(fontSize: 20.sp),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.w,
                      color: AppColors.blackBlue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.w,
                      color: AppColors.blackBlue,
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                load = true;
              });
              print(load);
              await CotisationRepository().PayOneCotisation(
                widget.codeEpargne,
                infoUserController.text,
                widget.codeMembre,
                AppCubitStorage().state.codeAssDefaul,
                hashId,
                9,
              );
              context
                  .read<PretEpargneCubit>()
                  .getAllAssEpargnes(AppCubitStorage().state.codeTournoisHist);
              // context.read<RecentEventCubit>().AllRecentEventCubit(AppCubitStorage().state.membreCode);
              setState(() {
                load = false;
              });
              print(load);
              Navigator.pop(context);
            },
            child: load == true
                ? CircularProgressIndicator(
                    color: AppColors.colorButton,
                  )
                : Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                        color: AppColors.colorButton,
                        borderRadius: BorderRadius.circular(10.r)),
                    alignment: Alignment.center,
                    child: Text(
                      "Confirmer",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
