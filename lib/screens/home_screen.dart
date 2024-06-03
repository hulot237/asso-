import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/presentation/widgets/widget_recent_event_cotisation.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/presentation/widgets/widget_recent_event_sanction.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/presentation/widgets/widget_recent_event_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_repository.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/network/session_activity/session_cubit.dart';
import 'package:faroty_association_1/pages/checkInternetConnectionPage.dart';
import 'package:faroty_association_1/pages/updatePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

//@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
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

  Future<void> handleTournoiDefault() async {
    final detailTournoiCourant = await context
        .read<DetailTournoiCourantCubit>()
        .detailTournoiCourantCubit(AppCubitStorage().state.codeTournois);

    if (detailTournoiCourant != null) {
      print("handleTournoiDefault");
    } else {
      print("handleTournoiDefault null");
    }
  }

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

  Future<void> handleDetailUser(userCode, codeTournoi) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode, codeTournoi);
  }

  Future<void> ChangerLang(String lang) async {
    await UserGroupRepository()
        .ChangerLang(AppCubitStorage().state.codeAssDefaul, lang);
  }

  Future<void> handleAllSeanceAss(codeAssociation) async {
    final allSeanceAss =
        await context.read<SeanceCubit>().AllAssSeanceCubit(codeAssociation);
  }

  Future handleChangeAss(codeAss) async {
    final allCotisationAss =
        await context.read<UserGroupCubit>().ChangeAssCubit(codeAss);
  }

  Future handleRecentEvent(codeMembre) async {
    final allRecentEvent =
        await context.read<RecentEventCubit>().AllRecentEventCubit(codeMembre);

    if (allRecentEvent != null) {
    } else {
      print("handleRecentEventhandleRecentEvent null");
    }
  }

  Future clearSessionIdStorage() async {
    if (context.read<SessionCubit>().state.isValidSession == false) {
      await AppCubitStorage().updateXSessionId(null);
    }
  }

  @override
  void initState() {
    clearSessionIdStorage();
    handleAllUserGroup();
    handleTournoiDefault();
    handleRecentEvent(AppCubitStorage().state.membreCode);
    handleChangeAss(AppCubitStorage().state.codeAssDefaul);
    handleDetailUser(AppCubitStorage().state.membreCode,
        AppCubitStorage().state.codeTournois);
    context.read<AuthCubit>().getUid();
    context.read<PretEpargneCubit>().getEpargne();
    context.read<PretEpargneCubit>().getPret();
    context.read<SessionCubit>().GetSessionCubit();
    // handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
    WidgetsBinding.instance.addObserver(this);

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
      clearSessionIdStorage();
      handleAllUserGroup();
      handleTournoiDefault();
      handleRecentEvent(AppCubitStorage().state.membreCode);
      handleChangeAss(AppCubitStorage().state.codeAssDefaul);
      handleDetailUser(AppCubitStorage().state.membreCode,
          AppCubitStorage().state.codeTournois);
      context.read<AuthCubit>().getUid();
      context.read<PretEpargneCubit>().getEpargne();
      context.read<PretEpargneCubit>().getPret();
      context.read<SessionCubit>().GetSessionCubit();
      print("RETOUR");
    }
  }

  Future refresh() async {
    handleRecentEvent(AppCubitStorage().state.membreCode);
    handleAllSeanceAss(AppCubitStorage().state.codeAssDefaul);
  }

  var Tab = [true, false, false, true, false, true, 'expi', 'expi'];

  @override
  Widget build(BuildContext context) {
    ChangerLang(context.locale.toString() == "en_US" ? "en" : "fr");

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
      final currentDetailUser = context.read<AuthCubit>().state.detailUser;

      return BlocBuilder<UserGroupCubit, UserGroupState>(
        builder: (UserGroupcontext, UserGroupstate) {
          if (UserGroupstate.isLoading == true &&
              UserGroupstate.changeAssData == null)
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

          final DetailAss =
              UserGroupcontext.read<UserGroupCubit>().state.changeAssData;

          return Material(
            type: MaterialType.transparency,
            child: Scaffold(
              // appBar: AppBar(
              //   systemOverlayStyle: SystemUiOverlayStyle(
              //     // Status bar color
              //     statusBarColor: Colors.red,

              //     // Status bar brightness (optional)
              //     statusBarIconBrightness:
              //         Brightness.dark, // For Android (dark icons)
              //     statusBarBrightness: Brightness.light, // For iOS (dark icons)
              //   ),
              // ),
              backgroundColor: AppColors.pageBackground,
              body:
                  (Authstate.errorLoadDetailAuth == true ||
                          UserGroupstate.errorLoadDetailChangeAss == true)
                      ? checkInternetConnectionPage(
                          backToHome: true,
                          functionToCall: () {},
                        )
                      : !context
                              .read<AuthCubit>()
                              .state
                              .detailUser!["is_app_updated"]
                          ? UpdatePage()
                          : RefreshIndicator(
                              onRefresh: refresh,
                              child: CustomScrollView(
                                slivers: [
                                  SliverAppBar.large(
                                    systemOverlayStyle: SystemUiOverlayStyle(
                                      // Status bar color
                                      statusBarColor: Colors.transparent,

                                      // Status bar brightness (optional)
                                      statusBarIconBrightness: Brightness
                                          .dark, // For Android (dark icons)
                                      statusBarBrightness: Brightness
                                          .dark, // For iOS (dark icons)
                                    ),
                                    leading: Container(),
                                    elevation: 0,
                                    backgroundColor: AppColors.backgroundAppBAr,
                                    flexibleSpace:
                                        UserGroupstate.isLoadingChangeAss ==
                                                    true &&
                                                UserGroupstate.changeAssData ==
                                                    null
                                            // UserGroupstate.userGroup != null
                                            ? EasyLoader(
                                                backgroundColor: Color.fromARGB(
                                                    0, 255, 255, 255),
                                                iconSize: 50.r,
                                                iconColor:
                                                    AppColors.blackBlueAccent1,
                                                image: AssetImage(
                                                  "assets/images/AssoplusFinal.png",
                                                ),
                                              )
                                            : FlexibleSpaceBar(
                                                titlePadding: EdgeInsets.only(
                                                  top: 10.h,
                                                  bottom: 10.h,
                                                  left: 10.w,
                                                  right: 10.w,
                                                ),
                                                centerTitle: false,
                                                title: Container(
                                                  // Container(
                                                  //   width: 120,
                                                  //   height: 20,
                                                  // ),
                                                  child: Container(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              right: 13.w,
                                                            ),
                                                            child: Text(
                                                              "${DetailAss!.user_group!.name}",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                color: AppColors
                                                                    .white,
                                                              ),
                                                              // textAlign: TextAlign.center,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            // GestureDetector(
                                                            //   onTap: () {
                                                            //     Navigator.push(
                                                            //       context,
                                                            //       MaterialPageRoute(
                                                            //         builder: (context) =>
                                                            //             AdministrationPageWebview(
                                                            //           forAdmin: false,
                                                            //           urlPage:
                                                            //               'https://business.faroty.com/groups',
                                                            //           // 'https://business.rush.faroty.com/group',
                                                            //         ),
                                                            //       ),
                                                            //     );
                                                            //   },
                                                            //   child: Container(
                                                            //     margin: EdgeInsets.only(
                                                            //       right: 5.h,
                                                            //     ),
                                                            //     padding:
                                                            //         EdgeInsets.all(1.r),
                                                            //     decoration: BoxDecoration(
                                                            //       border: Border.all(
                                                            //         width: 1.r,
                                                            //         color:
                                                            //             AppColors.blackBlue,
                                                            //       ),
                                                            //       color: AppColors
                                                            //           .blackBlueAccent2,
                                                            //       borderRadius:
                                                            //           BorderRadius.circular(
                                                            //               50.r),
                                                            //     ),
                                                            //     height: 20.w,
                                                            //     width: 20.w,
                                                            //     child: Icon(
                                                            //       Icons.add,
                                                            //       size: 16.sp,
                                                            //       color: AppColors.white,
                                                            //     ),
                                                            //   ),
                                                            // ),

                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        updateTrackingData(
                                                                            "home.btnSwitch",
                                                                            "${DateTime.now()}",
                                                                            {});
                                                                        Modal()
                                                                            .showBottomSheetListAss(
                                                                          context,
                                                                          context
                                                                              .read<UserGroupCubit>()
                                                                              .state
                                                                              .userGroup,
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              26,
                                                                              9,
                                                                            ),
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            50.r,
                                                                          ),
                                                                        ),
                                                                        padding:
                                                                            EdgeInsets.all(1.r),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50.r),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(50.r),
                                                                            ),
                                                                            height:
                                                                                20.w,
                                                                            width:
                                                                                20.w,
                                                                            child:
                                                                                Image.network(
                                                                              // "zz",
                                                                              "${Variables.LienAIP}${DetailAss.user_group!.profile_photo == null ? "" : DetailAss.user_group!.profile_photo}",
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      right:
                                                                          2.w,
                                                                      top: 2.h,
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              26,
                                                                              9),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            50.r,
                                                                          ),
                                                                        ),
                                                                        width:
                                                                            5.w,
                                                                        height:
                                                                            5.w,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                if (!context
                                                                        .read<
                                                                            AuthCubit>()
                                                                        .state
                                                                        .detailUser![
                                                                    "isMember"])
                                                                  Row(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          updateTrackingData(
                                                                              "home.btnAdminister",
                                                                              "${DateTime.now()}",
                                                                              {});
                                                                          await launchUrlString(
                                                                            "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com&app_mode=mobile",
                                                                            mode:
                                                                                LaunchMode.platformDefault,
                                                                          );
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets.only(
                                                                                top: 5.h,
                                                                              ),
                                                                              padding: EdgeInsets.all(
                                                                                3.r,
                                                                              ),
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(
                                                                                  width: 1.r,
                                                                                  color: AppColors.blackBlue,
                                                                                ),
                                                                                color: AppColors.whiteAccent1,
                                                                                borderRadius: BorderRadius.circular(
                                                                                  50.r,
                                                                                ),
                                                                              ),
                                                                              // height: 20.w,
                                                                              // width: 20.w,
                                                                              child: Row(
                                                                                children: [
                                                                                  Image.asset(
                                                                                    "assets/images/Groupe_ou_Asso.png",
                                                                                    width: 18.w,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 2.w,
                                                                                  ),
                                                                                  Text(
                                                                                    "Administrer".tr(),
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      color: AppColors.blackBlue,
                                                                                      fontSize: 8.sp,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                background: Stack(children: [
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      child: Image.network(
                                                        "${Variables.LienAIP}${DetailAss.user_group!.background_cover == null ? "" : DetailAss.user_group!.background_cover}",
                                                        fit: BoxFit.cover,
                                                      )),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.transparent,
                                                          Colors.transparent,
                                                          const Color.fromARGB(
                                                              167, 150, 191, 53)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                  ),
                                  SliverToBoxAdapter(
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            // Container(
                                            //   decoration: BoxDecoration(
                                            //     color: AppColors.white,
                                            //     borderRadius:
                                            //         BorderRadius.circular(30.r),
                                            //   ),
                                            //   padding: EdgeInsets.all(12),
                                            //   margin: EdgeInsets.only(
                                            //     top: 7.h,
                                            //     left: 8.w,
                                            //     right: 8.w,
                                            //   ),
                                            //   // width: MediaQuery.of(context).size.width /
                                            //   //     1.4,
                                            //   child: Row(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.spaceEvenly,
                                            //     children: [
                                            //       Container(
                                            //         width: 40.w,
                                            //         child: Image.asset(
                                            //           "assets/images/Groupe_ou_Asso.png",
                                            //           // scale: 4,
                                            //         ),
                                            //       ),
                                            //       Text(
                                            //         "Administrer le groupe",
                                            //         style: TextStyle(
                                            //           fontWeight: FontWeight.w600,
                                            //           color: AppColors.blackBlue,
                                            //           fontSize: 20.sp,
                                            //         ),
                                            //       )
                                            //     ],
                                            //   ),
                                            // ),
                                            if (currentDetailUser!["is_saver"])
                                              BlocBuilder<PretEpargneCubit,
                                                  PretEpargneState>(
                                                builder: (PretEpargnecontext,
                                                    PretEpargnestate) {
                                                  if (PretEpargnestate.isLoadingEpargne == true && PretEpargnestate.epargne == null)
                                                    return Container(
                                                      padding: EdgeInsets.only(
                                                          top: 15.h),
                                                      child: EasyLoader(
                                                        backgroundColor:
                                                            Color.fromARGB(0,
                                                                255, 255, 255),
                                                        iconSize: 50.r,
                                                        iconColor: AppColors
                                                            .blackBlueAccent1,
                                                        image: AssetImage(
                                                          'assets/images/AssoplusFinal.png',
                                                        ),
                                                      ),
                                                    );
                                                  final epargne =
                                                      PretEpargnecontext.read<
                                                              PretEpargneCubit>()
                                                          .state
                                                          .epargne;
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                      left: 8.w,
                                                      right: 8.w,
                                                      top: 7.h,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                              25,
                                                              117,
                                                              117,
                                                              117),
                                                          spreadRadius: 1,
                                                          blurRadius: 1,
                                                        )
                                                      ],
                                                    ),
                                                    padding: EdgeInsets.only(
                                                      left: 10.w,
                                                      right: 10.w,
                                                      top: 10.h,
                                                      bottom: 10.h,
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    updateTrackingData(
                                                                        "home.savingTransaction",
                                                                        "${DateTime.now()}",
                                                                        {});
                                                                    Modal()
                                                                        .showModalTransactionEpargne(
                                                                      context,
                                                                    );
                                                                    context
                                                                        .read<
                                                                            PretEpargneCubit>()
                                                                        .getDetailEpargne(
                                                                            epargne['saving_code']);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        width:
                                                                            1.5,
                                                                        color: AppColors
                                                                            .blackBlueAccent2,
                                                                      ),
                                                                    ),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      // vertical: 10.h,
                                                                      horizontal:
                                                                          10.w,
                                                                    ),
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2.3,
                                                                    height:
                                                                        97.h,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Container(
                                                                                  child: Text(
                                                                                    "TOTAL EPARGNES".tr(),
                                                                                    style: TextStyle(
                                                                                      fontSize: 12.sp,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      color: AppColors.blackBlue,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  margin: EdgeInsets.only(
                                                                                    top: 3.h,
                                                                                    bottom: 3.h,
                                                                                  ),
                                                                                  child: Text(
                                                                                    // "${formatMontantFrancais(double.parse("13000"))} FCFA",

                                                                                    "${formatMontantFrancais(double.parse(epargne!['amount_saved']))} FCFA",
                                                                                    style: TextStyle(
                                                                                      fontSize: 18.sp,
                                                                                      fontWeight: FontWeight.w700,
                                                                                      color: AppColors.blackBlue,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.list_rounded,
                                                                              size: 18.sp,
                                                                              color: AppColors.blackBlue,
                                                                            ),
                                                                            Container(
                                                                              child: Text(
                                                                                "Historiques".tr(),
                                                                                style: TextStyle(
                                                                                  fontSize: 12.sp,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  color: AppColors.blackBlue,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    // color: AppColors.bleuLight,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width:
                                                                          1.5,
                                                                      color: AppColors
                                                                          .blackBlueAccent2,
                                                                    ),
                                                                  ),
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          10.h,
                                                                      horizontal:
                                                                          10.w),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2.3,
                                                                  height: 97.h,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          "INTÉRÊTS EN COURS"
                                                                              .tr(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                AppColors.blackBlue,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        // margin: EdgeInsets.only(top: 5, bottom: 5,),
                                                                        child:
                                                                            Text(
                                                                          "${formatMontantFrancais(double.parse(epargne!['total_interest']))} FCFA",
                                                                          // "${formatMontantFrancais(double.parse("2000"))} FCFA",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18.sp,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color:
                                                                                AppColors.blackBlue,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                updateTrackingData(
                                                                    "home.btnSave",
                                                                    "${DateTime.now()}",
                                                                    {});
                                                                String msg =
                                                                    "Aide-moi à épargner.\nMerci de suivre le lien https://${epargne["saving_pay_link"]}?code=${AppCubitStorage().state.membreCode} pour valider";
                                                                String
                                                                    raisonComplete =
                                                                    "Effectuer une épargne"
                                                                        .tr();
                                                                String motif =
                                                                    "Epargner vous même"
                                                                        .tr();
                                                                String
                                                                    paiementProcheMsg =
                                                                    "Un proche épargne pour vous"
                                                                        .tr();
                                                                String
                                                                    msgAppBarPaiementPage =
                                                                    "Effectuer une épargne"
                                                                        .tr();
                                                                String
                                                                    elementUrl =
                                                                    "https://groups.faroty.com/loan";
                                                                Modal()
                                                                    .showModalActionPayement(
                                                                  context,
                                                                  msg,
                                                                  epargne[
                                                                      "saving_pay_link"],
                                                                  raisonComplete,
                                                                  motif,
                                                                  paiementProcheMsg,
                                                                  msgAppBarPaiementPage,
                                                                  elementUrl,
                                                                );
                                                              },

                                                              // onTap: () {

                                                              //   saving_pay_link
                                                              //   context
                                                              //       .read<PretEpargneCubit>()
                                                              //       .getEpargne();
                                                              // },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .colorButton,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                ),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 10
                                                                            .h,
                                                                        bottom:
                                                                            10.h),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 10
                                                                            .h),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      "ÉPARGNEZ"
                                                                          .tr(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18.sp,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        color: AppColors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        if (PretEpargnestate
                                                                    .isLoadingEpargne ==
                                                                true &&
                                                            PretEpargnestate
                                                                    .epargne !=
                                                                null)
                                                          Center(
                                                            child: Container(
                                                              height: 160.h,
                                                              // color:
                                                              //     AppColors.blackBlueAccent2,
                                                              // margin: EdgeInsets.only(top: 40.h),
                                                              child: EasyLoader(
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
                                                                  'assets/images/AssoplusFinal.png',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            if (currentDetailUser!["is_owe"])
                                              BlocBuilder<PretEpargneCubit,
                                                      PretEpargneState>(
                                                  builder: (PretEpargnecontext,
                                                      PretEpargnestate) {
                                                if (PretEpargnestate
                                                            .isLoadingPret ==
                                                        true &&
                                                    PretEpargnestate.pret ==
                                                        null)
                                                  return Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10.h),
                                                    child: EasyLoader(
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              0, 255, 255, 255),
                                                      iconSize: 50.r,
                                                      iconColor: AppColors
                                                          .blackBlueAccent1,
                                                      image: AssetImage(
                                                        'assets/images/Groupe_ou_Asso.png',
                                                      ),
                                                    ),
                                                  );

                                                final pret =
                                                    PretEpargnecontext.read<
                                                            PretEpargneCubit>()
                                                        .state
                                                        .pret;
                                                return GestureDetector(
                                                  onTap: () {
                                                    updateTrackingData(
                                                        "home.loanTransaction",
                                                        "${DateTime.now()}",
                                                        {});
                                                    Modal()
                                                        .showModalTransactionPret(
                                                            context);
                                                    context
                                                        .read<
                                                            PretEpargneCubit>()
                                                        .getDetailPret(
                                                            pret['loan_code']);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      left: 8.w,
                                                      right: 8.w,
                                                      top: 7.h,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                              25,
                                                              117,
                                                              117,
                                                              117),
                                                          spreadRadius: 1,
                                                          blurRadius: 1,
                                                        )
                                                      ],
                                                      border: Border.all(
                                                        color:
                                                            pret!["is_passed"] ==
                                                                    0
                                                                ? AppColors
                                                                    .white
                                                                : AppColors.red,
                                                        width: 0.5.r,
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
                                                      left: 10.w,
                                                      right: 10.w,
                                                      top: 10.h,
                                                      bottom: 10.h,
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          10.h),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    width: 72.w,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: 8.w,
                                                                      right:
                                                                          8.w,
                                                                      top: 5.h,
                                                                      bottom:
                                                                          5.h,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Prêts en cours"
                                                                        .tr()
                                                                        .toUpperCase(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppColors
                                                                          .blackBlue,
                                                                      fontSize:
                                                                          15.sp,
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      updateTrackingData(
                                                                          "home.btnRefund",
                                                                          "${DateTime.now()}",
                                                                          {});
                                                                      String
                                                                          msg =
                                                                          "Aide-moi à payer ma dette.\nMerci de suivre le lien https://${pret["loan_pay_link"]}?code=${AppCubitStorage().state.membreCode} pour valider";
                                                                      String
                                                                          raisonComplete =
                                                                          "Remboursement"
                                                                              .tr();
                                                                      String
                                                                          motif =
                                                                          "Rembourser vous même"
                                                                              .tr();
                                                                      String
                                                                          paiementProcheMsg =
                                                                          "partager_le_lien_de_paiement"
                                                                              .tr();
                                                                      String
                                                                          msgAppBarPaiementPage =
                                                                          "Effectuer une remboursement"
                                                                              .tr();
                                                                      String
                                                                          elementUrl =
                                                                          "https://groups.faroty.com/loan";
                                                                      Modal().showModalActionPayement(
                                                                          context,
                                                                          msg,
                                                                          pret[
                                                                              "loan_pay_link"],
                                                                          raisonComplete,
                                                                          motif,
                                                                          paiementProcheMsg,
                                                                          msgAppBarPaiementPage,
                                                                          elementUrl);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      width:
                                                                          84.w,
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        left:
                                                                            8.w,
                                                                        right:
                                                                            8.w,
                                                                        top:
                                                                            5.h,
                                                                        bottom:
                                                                            5.h,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColors
                                                                            .colorButton,
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            Text(
                                                                          "Rembourser"
                                                                              .tr(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                11.sp,
                                                                            color:
                                                                                AppColors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "montant"
                                                                          .tr()
                                                                          .toUpperCase(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: AppColors
                                                                            .blackBlueAccent1,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "${formatMontantFrancais(double.parse(pret!["loan_amount"]))} FCFA",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16.sp,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        color: AppColors
                                                                            .blackBlue,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      "a rembourser"
                                                                          .tr()
                                                                          .toUpperCase(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: AppColors
                                                                            .blackBlueAccent1,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "${formatMontantFrancais(double.parse(pret!["remaining_amount"]))} FCFA",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18.sp,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        color: AppColors
                                                                            .red,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 5.h),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "intérêts"
                                                                            .tr()
                                                                            .toUpperCase(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12.sp,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color:
                                                                              AppColors.blackBlueAccent1,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "${formatMontantFrancais(double.parse(pret!["interest_generated"]))} FCFA",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              16.sp,
                                                                          fontWeight:
                                                                              FontWeight.w900,
                                                                          color:
                                                                              AppColors.blackBlue,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    "${formatCompareDateUnikReturnWellValue(pret!["end_date"])}"
                                                                        .toUpperCase(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppColors
                                                                          .blackBlue,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        if (PretEpargnestate
                                                                    .isLoadingPret ==
                                                                true &&
                                                            PretEpargnestate
                                                                    .pret !=
                                                                null)
                                                          Center(
                                                            child: Container(
                                                              height: 120.h,
                                                              // color:
                                                              //     AppColors.blackBlueAccent2,
                                                              // margin: EdgeInsets.only(top: 40.h),
                                                              child: EasyLoader(
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
                                                                  'assets/images/AssoplusFinal.png',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                            if (currentDetailUser![
                                                    "is_inscription_payed"] ==
                                                0)
                                              Container(
                                                margin: EdgeInsets.only(
                                                  left: 8.w,
                                                  right: 8.w,
                                                  top: 7.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color.fromARGB(
                                                            25, 117, 117, 117),
                                                        spreadRadius: 1,
                                                        blurRadius: 1)
                                                  ],
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 10.w,
                                                    right: 10.w,
                                                    top: 7.h,
                                                    bottom: 7.h),
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 10.h),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Fonds de caisse"
                                                                    .tr()
                                                                    .toUpperCase(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColors
                                                                        .blackBlue,
                                                                    fontSize:
                                                                        15.sp),
                                                              ),
                                                              // if (Authstate.isLoading != true)
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    '${"reste à payer".tr().toUpperCase()}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppColors
                                                                          .blackBlueAccent1,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "${formatMontantFrancais(double.parse((int.parse(currentDetailUser["entry_amount"]) - int.parse(currentDetailUser["inscription_balance"])).toString()))} FCFA"
                                                                        .tr(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppColors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "${formatMontantFrancais(double.parse(currentDetailUser["entry_amount"]))} FCFA"
                                                                      .tr(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColors
                                                                        .blackBlue,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                updateTrackingData(
                                                                    "home.btnRegistrationFund",
                                                                    "${DateTime.now()}",
                                                                    {});
                                                                String msg =
                                                                    "Aide-moi à payer mon inscription.\nMontant: ${formatMontantFrancais(double.parse((int.parse(currentDetailUser["entry_amount"]) - int.parse(currentDetailUser["inscription_balance"])).toString()))} FCFA.\nMerci de suivre le lien https://${currentDetailUser["inscription_pay_link"]}?code=${AppCubitStorage().state.membreCode} pour valider";
                                                                String
                                                                    raisonComplete =
                                                                    "Paiement du fonds de caisse"
                                                                        .tr();
                                                                String motif =
                                                                    "payer_vous_même"
                                                                        .tr();
                                                                String
                                                                    paiementProcheMsg =
                                                                    "partager_le_lien_de_paiement"
                                                                        .tr();
                                                                String
                                                                    msgAppBarPaiementPage =
                                                                    "Effectuer le paiement de votre fond de caisse"
                                                                        .tr();
                                                                String
                                                                    elementUrl =
                                                                    "https://groups.faroty.com/fond-caisse";
                                                                if (currentDetailUser[
                                                                        "is_inscription_payed"] !=
                                                                    1)
                                                                  Modal().showModalActionPayement(
                                                                      context,
                                                                      msg,
                                                                      currentDetailUser[
                                                                          "inscription_pay_link"],
                                                                      raisonComplete,
                                                                      motif,
                                                                      paiementProcheMsg,
                                                                      msgAppBarPaiementPage,
                                                                      elementUrl);
                                                              },
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 72.w,
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 8.w,
                                                                  right: 8.w,
                                                                  top: 5.h,
                                                                  bottom: 5.h,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .colorButton,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.r),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  child: Text(
                                                                    "Payer"
                                                                        .tr(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: AppColors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    if (Authstate.isLoading ==
                                                            true &&
                                                        Authstate.detailUser !=
                                                            null)
                                                      Center(
                                                        child: Container(
                                                          height: 80.h,
                                                          // color:
                                                          //     AppColors.blackBlueAccent2,
                                                          // margin: EdgeInsets.only(top: 40.h),
                                                          child: EasyLoader(
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    0,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            iconSize: 50.r,
                                                            iconColor: AppColors
                                                                .blackBlueAccent1,
                                                            image: AssetImage(
                                                              'assets/images/AssoplusFinal.png',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 8.w,
                                                right: 8.w,
                                                top: 7.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          25, 117, 117, 117),
                                                      spreadRadius: 1,
                                                      blurRadius: 1)
                                                ],
                                              ),
                                              padding: EdgeInsets.only(
                                                left: 10.w,
                                                right: 10.w,
                                                top: 7.h,
                                                bottom: 7.h,
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding: EdgeInsets.only(
                                                      top: 7.h,
                                                      left: 5.w,
                                                      bottom: 7.h,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(),
                                                        Container(
                                                          child: Text(
                                                            "rencontre"
                                                                .tr()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18.sp,
                                                              color: AppColors
                                                                  .blackBlue,
                                                            ),
                                                            // ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            right: 10.w,
                                                          ),
                                                          width: 10.r,
                                                          height: 10.r,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color
                                                                .fromRGBO(
                                                                244, 67, 54, 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100.r),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  BlocBuilder<
                                                      DetailTournoiCourantCubit,
                                                      DetailTournoiCourantState>(
                                                    builder: (tournoisContext,
                                                        tournoisState) {
                                                      if (tournoisState
                                                                  .isLoading ==
                                                              true &&
                                                          tournoisState
                                                                  .detailtournoiCourant ==
                                                              null)
                                                        return Container(
                                                          margin: EdgeInsets.only(
                                                              top: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  13),
                                                          child: EasyLoader(
                                                            backgroundColor:
                                                                Color.fromARGB(
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
                                                          ),
                                                        );
                                                      final currentDetailtournoiCourant = context
                                                          .read<
                                                              DetailTournoiCourantCubit>()
                                                          .state
                                                          .detailtournoiCourant;

                                                      return currentDetailtournoiCourant![
                                                                      "tournois"] !=
                                                                  null &&
                                                              currentDetailtournoiCourant[
                                                                              "tournois"]
                                                                          [
                                                                          "seance"]
                                                                      .length >
                                                                  0 &&
                                                              currentDetailtournoiCourant[
                                                                              "tournois"]
                                                                          [
                                                                          "seance"][0]
                                                                      [
                                                                      "status"] ==
                                                                  1
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    // left: 7.w,
                                                                    // right: 7.w,
                                                                    top: 5.h,
                                                                    bottom: 7.h,
                                                                  ),
                                                                  child:
                                                                      WidgetRencontreCard(
                                                                        codeTournoi: AppCubitStorage().state.codeTournois!,
                                                                    rapportUrl: currentDetailtournoiCourant["tournois"]
                                                                            [
                                                                            "seance"][0]
                                                                        [
                                                                        "rapport"],
                                                                    // typeRencontre: currentDetailtournoiCourant["type_rencontre"],
                                                                    screenSource:
                                                                        "home.meeting",
                                                                    typeRencontre:
                                                                        currentDetailtournoiCourant["tournois"]["seance"][0]
                                                                            [
                                                                            "type_rencontre"],
                                                                    maskElt:
                                                                        true,
                                                                    codeSeance: currentDetailtournoiCourant["tournois"]
                                                                            [
                                                                            "seance"][0]
                                                                        [
                                                                        "seance_code"],
                                                                    dateRencontre: AppCubitStorage().state.Language ==
                                                                            "fr"
                                                                        ? formatDateToFrench(
                                                                            currentDetailtournoiCourant!["tournois"]["seance"][0]["date_seance"],
                                                                          )
                                                                        : formatDateToEnglish(
                                                                            currentDetailtournoiCourant!["tournois"]["seance"][0]["date_seance"],
                                                                          ),
                                                                    descriptionRencontre:
                                                                        '${formatDateTimeintegral(context.locale.toString() == "en_US" ? "en" : "fr", currentDetailtournoiCourant["tournois"]["seance"][0]["date_seance"]).toUpperCase()} ${"à".tr()} ${currentDetailtournoiCourant["tournois"]["seance"][0]["heure_debut"]}',
                                                                    heureRencontre:
                                                                        currentDetailtournoiCourant["tournois"]["seance"][0]
                                                                            [
                                                                            "heure_debut"],
                                                                    identifiantRencontre:
                                                                        currentDetailtournoiCourant["tournois"]["seance"][0]
                                                                            [
                                                                            "matricule"],
                                                                    isActiveRencontre:
                                                                        currentDetailtournoiCourant["tournois"]["seance"][0]
                                                                            [
                                                                            "status"],
                                                                    lieuRencontre:
                                                                        currentDetailtournoiCourant["tournois"]["seance"][0]
                                                                            [
                                                                            "localisation"],
                                                                    prenomRecepteurRencontre: currentDetailtournoiCourant["tournois"]["seance"][0]["membre"]["last_name"] ==
                                                                            null
                                                                        ? ""
                                                                        : currentDetailtournoiCourant["tournois"]["seance"][0]["membre"]
                                                                            [
                                                                            "last_name"],
                                                                    nomRecepteurRencontre: currentDetailtournoiCourant["tournois"]["seance"][0]["membre"]["first_name"] ==
                                                                            null
                                                                        ? ""
                                                                        : currentDetailtournoiCourant["tournois"]["seance"][0]["membre"]
                                                                            [
                                                                            "first_name"],
                                                                    photoProfilRecepteur: currentDetailtournoiCourant["tournois"]["seance"][0]["membre"]["photo_profil"] ==
                                                                            null
                                                                        ? ""
                                                                        : currentDetailtournoiCourant["tournois"]["seance"][0]["membre"]
                                                                            [
                                                                            "photo_profil"],
                                                                    dateRencontreAPI:
                                                                        currentDetailtournoiCourant["tournois"]["seance"][0]
                                                                            [
                                                                            "date_seance"],
                                                                  ),
                                                                ),
                                                                if (tournoisState
                                                                            .isLoading ==
                                                                        true &&
                                                                    tournoisState
                                                                            .detailtournoiCourant !=
                                                                        null)
                                                                  Container(
                                                                    height:
                                                                        160.h,
                                                                    // color: AppColors.green,
                                                                    child:
                                                                        EasyLoader(
                                                                      backgroundColor: Color.fromARGB(
                                                                          0,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      iconSize:
                                                                          50.r,
                                                                      iconColor:
                                                                          AppColors
                                                                              .blackBlueAccent1,
                                                                      image:
                                                                          AssetImage(
                                                                        "assets/images/AssoplusFinal.png",
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            )
                                                          : Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          40.h),
                                                              child: Center(
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      "Pas de rencontre en cours"
                                                                          .tr(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color
                                                                            .fromRGBO(
                                                                                20,
                                                                                45,
                                                                                99,
                                                                                0.26),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w100,
                                                                        fontSize:
                                                                            20.sp,
                                                                      ),
                                                                    ),
                                                                    


                                                                     if (!context.read<AuthCubit>().state.detailUser!["isMember"])
                                                                            InkWell(
                                                                              onTap: () async {
                                                                                updateTrackingData("transactions.btnAddMeeting", "${DateTime.now()}", {});
                                                                                await launchUrlString(
                                                                                  "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/seances?query=1&app_mode=mobile",
                                                                                  mode: LaunchMode.platformDefault,
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                height: 40.h,
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
                                                                                  top: 10.w,
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
                                                                                      width: 20.w,
                                                                                      height: 20.w,
                                                                                      margin: EdgeInsets.only(left: 3.w),
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(360),
                                                                                        border: Border.all(
                                                                                          width: 1.5.w,
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
                                                              ),
                                                            );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SliverPersistentHeader(
                                    pinned: true,
                                    floating: false,
                                    delegate: SliverTabBar(
                                      maxExtent: 50.r,
                                      minExtent: 50.r,
                                    ),
                                  ),
                                  BlocBuilder<RecentEventCubit,
                                      RecentEventState>(
                                    builder: (context, state) {
                                      if (state.isLoading == true ||
                                          state.allRecentEvent == null)
                                        return SliverToBoxAdapter(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    7),
                                            child: EasyLoader(
                                              backgroundColor: Color.fromARGB(
                                                  0, 255, 255, 255),
                                              iconSize: 50.r,
                                              iconColor:
                                                  AppColors.blackBlueAccent1,
                                              image: AssetImage(
                                                "assets/images/AssoplusFinal.png",
                                              ),
                                            ),
                                          ),
                                        );

                                      final currentRecentEvent = context
                                          .read<RecentEventCubit>()
                                          .state
                                          .allRecentEvent;

                                      final currentTontine =
                                          currentRecentEvent!["tontines"];
                                      final currentCotisation =
                                          currentRecentEvent!["cotisations"];
                                      final currentSanction =
                                          currentRecentEvent!["sanctions"];

                                      List listeTontine = currentTontine;
                                      List listeCotisation = currentCotisation;
                                      List listeSanction = currentSanction;

                                      List<Widget> listWidgetTontine =
                                          listeTontine.map((monObjet) {
                                        return widgetRecentEventTontine(
                                          nomBeneficiaire: monObjet["membre"]
                                              ["first_name"],
                                          prenomBeneficiaire: monObjet["membre"]
                                                      ["last_name"] ==
                                                  null
                                              ? ''
                                              : monObjet["membre"]["last_name"],
                                          dateOpen: monObjet["start_date"],
                                          dateClose: monObjet["end_date"],
                                          montantTontine: monObjet["amount"],
                                          montantCollecte:
                                              monObjet["total_cotise"],
                                          codeCotisation: monObjet["code"],
                                          lienDePaiement:
                                              monObjet["tontine_pay_link"],
                                          nomTontine: monObjet["matricule"],
                                        );
                                      }).toList();

                                      List<Widget> listWidgetCotisation =
                                          listeCotisation.map((monObjet) {
                                        print("$monObjet");
                                        return widgetRecentEventCotisation(
                                          rapportUrl: monObjet["rapport"],
                                          rublique: monObjet["ass_rubrique"] ==
                                                  null
                                              ? ""
                                              : '(${monObjet["ass_rubrique"]["name"]})',
                                          dateOpen: monObjet["start_date"],
                                          dateClose: monObjet["end_date"],
                                          montantCotisation: monObjet["amount"],
                                          montantCollecte:
                                              monObjet["total_cotise"],
                                          codeCotisation:
                                              monObjet["cotisation_code"],
                                          lienDePaiement:
                                              monObjet["cotisation_pay_link"],
                                          motif: monObjet["name"],
                                          type: monObjet["type"],
                                          isPassed: monObjet["is_passed"],
                                          source: monObjet["seance"] == null
                                              ? ''
                                              : '${'rencontre'.tr()} ${monObjet["seance"]["matricule"]}',
                                          nomBeneficiaire: monObjet["membre"] ==
                                                  null
                                              ? ''
                                              : monObjet["membre"]
                                                          ["last_name"] ==
                                                      null
                                                  ? "${monObjet["membre"]["first_name"]}"
                                                  : "${monObjet["membre"]["first_name"]} ${monObjet["membre"]["last_name"]}",
                                          is_tontine: monObjet["is_tontine"],
                                        );
                                      }).toList();

                                      List<Widget> listWidgetSanction =
                                          listeSanction.map((monObjet) {
                                        final currentDetailUser = context
                                            .read<AuthCubit>()
                                            .state
                                            .detailUser;
                                            print("${monObjet}");
                                        return widgetRecentEventSanction(
                                          membreCode: AppCubitStorage().state.membreCode,
                                          // "${monObjet["membre"]["membre_code"]}",
                                          nomProprietaire: "${currentDetailUser!["first_name"] == null ? "" : currentDetailUser["first_name"]} ${currentDetailUser["last_name"] == null ? "" : currentDetailUser["last_name"]}",
                                          // "${monObjet["membre"]["first_name"]} ${monObjet["membre"]["last_name"] ?? ""}",
                                          resteAPayer:
                                              monObjet["amount_remaining"],
                                          motif: monObjet["motif"],
                                          dateOpen: monObjet["start_date"],
                                          montantSanction:
                                              monObjet["amount"] == null
                                                  ? 0
                                                  : monObjet["amount"],
                                          libelleSanction:
                                              monObjet["libelle"] == null
                                                  ? ""
                                                  : monObjet["libelle"],
                                          montantCollecte:
                                              monObjet["sanction_balance"],
                                          codeCotisation:
                                              monObjet["sanction_code"],
                                          lienDePaiement: monObjet[
                                                      "sanction_pay_link"] ==
                                                  null
                                              ? ""
                                              : monObjet["sanction_pay_link"],
                                          type: monObjet["type"],
                                          versement: monObjet["versement"],
                                        );
                                      }).toList();

                                      final listeWidgetFinale = [
                                        ...listWidgetTontine,
                                        ...listWidgetCotisation,
                                        ...listWidgetSanction,
                                        Container(
                                          margin: EdgeInsets.only(
                                            bottom:
                                                Platform.isIOS ? 70.h : 10.h,
                                          ),
                                        ),
                                      ];

                                      return listWidgetTontine.length > 0 || listWidgetCotisation.length > 0 || listWidgetSanction.length > 0

                                          ? SliverList.builder(
                                              itemCount:
                                                  listeWidgetFinale.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final itemEventRecent =
                                                    listeWidgetFinale[index];
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    top: 7.h,
                                                    left: 7.w,
                                                    right: 7.w,
                                                    bottom: 3.h,
                                                  ),
                                                  child: itemEventRecent,
                                                );
                                              },
                                            )
                                          : SliverToBoxAdapter(
                                              child: Container(
                                                color: AppColors.pageBackground,
                                                margin:
                                                    EdgeInsets.only(top: 50.h),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Aucun_evenement_recent"
                                                            .tr(),
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              20, 45, 99, 0.26),
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontSize: 20.sp,
                                                        ),
                                                      ),
                                                       if (!context.read<AuthCubit>().state.detailUser!["isMember"])
                                                                            InkWell(
                                                                              onTap:
                                                                          () async {
                                                                        updateTrackingData(
                                                                            "transactions.btnAddContribution",
                                                                            "${DateTime.now()}",
                                                                            {});
                                                                        await launchUrlString(
                                                                          "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations?query=1&app_mode=mobile",
                                                                          mode:
                                                                              LaunchMode.platformDefault,
                                                                        );
                                                                      },
                                                                              child: Container(
                                                                                height: 40.h,
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
                                                                                  top: 10.w,
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
                                                                                      "Ajouter une cotisation".tr(),
                                                                                      style: TextStyle(
                                                                                        color: AppColors.blackBlue.withOpacity(1),
                                                                                        fontWeight: FontWeight.w900,
                                                                                        fontSize: 18.sp,
                                                                                        letterSpacing: 0.2.w,
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      width: 20.w,
                                                                                      height: 20.w,
                                                                                      margin: EdgeInsets.only(left: 3.w),
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(360),
                                                                                        border: Border.all(
                                                                                          width: 1.5.w,
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
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ],
                              ),
                            ),
            ),
          );
        },
      );
    });
  }
  // });
  // }
}

class SliverTabBar extends SliverPersistentHeaderDelegate {
  const SliverTabBar({
    required this.minExtent,
    required this.maxExtent,
  });

  @override
  final double minExtent;

  @override
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          margin: EdgeInsets.only(top: 10.h),
          color: AppColors.whiteAccent,
          alignment: Alignment.centerLeft,
          child: BlocBuilder<RecentEventCubit, RecentEventState>(
              builder: (context, state) {
            if (state.isLoading == true || state.allRecentEvent == null)
              return Row(
                children: [
                  Text(
                    "Événements_récents".tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: AppColors.blackBlueAccent1),
                  ),
                  // Icon(Icons.notifications_active_outlined)
                ],
              );

            final currentRecentEvent =
                context.read<RecentEventCubit>().state.allRecentEvent;

            final currentTontine = currentRecentEvent!["tontines"];
            final currentCotisation = currentRecentEvent!["cotisations"];
            final currentSanction = currentRecentEvent!["sanctions"];
            int allLenght = currentTontine.length +
                currentCotisation.length +
                currentSanction.length;
            if (allLenght == 0) {
              return Container();
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Événements_récents".tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: AppColors.blackBlueAccent1),
                  ),
                ],
              );
            }
          }),
        ),
      ],
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
