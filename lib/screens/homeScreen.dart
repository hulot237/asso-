import 'dart:async';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/business_logic/membres_cubit.dart';
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
import 'package:faroty_association_1/pages/administrationPage.dart';
import 'package:faroty_association_1/pages/checkInternetConnection.dart';
import 'package:faroty_association_1/pages/checkInternetConnectionPage.dart';
import 'package:faroty_association_1/widget/widgetCallFunctionFailled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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

  // Future<void> handleAllCompteAss(codeAssociation) async {
  //   final allCotisationAss =
  //       await context.read<CompteCubit>().AllCompteAssCubit(codeAssociation);

  //   if (allCotisationAss != null) {
  //     print("handleAllCompteAss");
  //   } else {
  //     print("handleAllCompteAss null");
  //   }
  // }

  Future<void> handleAllSeanceAss(codeAssociation) async {
    final allSeanceAss =
        await context.read<SeanceCubit>().AllAssSeanceCubit(codeAssociation);

    if (allSeanceAss != null) {
      print("handleAllSeanceAss");
    } else {
      print("handleAllSeanceAss null");
    }
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

  @override
  void initState() {
    handleAllUserGroup();
    handleTournoiDefault();
    handleRecentEvent(AppCubitStorage().state.membreCode);
    handleChangeAss(AppCubitStorage().state.codeAssDefaul);
    handleDetailUser(AppCubitStorage().state.membreCode,
        AppCubitStorage().state.codeTournois);
    // handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);

    super.initState();
  }

  Future refresh() async {
    handleRecentEvent(AppCubitStorage().state.membreCode);
    handleAllSeanceAss(AppCubitStorage().state.codeAssDefaul);
  }

  var Tab = [true, false, false, true, false, true, 'expi', 'expi'];

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    ChangerLang(context.locale.toString() == "en_US" ? "en" : "fr");

    // return FutureBuilder<bool>(
    //     future: ConnectivityService.checkConnectivity(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Container(
    //           child: EasyLoader(
    //             backgroundColor: Color.fromARGB(0, 255, 255, 255),
    //             iconSize: 50,
    //             iconColor: AppColors.blackBlueAccent1,
    //             image: AssetImage(
    //               'assets/images/Groupe_ou_Asso.png',
    //             ),
    //           ),
    //         );
    //       } else if (snapshot.hasError == snapshot.data) {
    //         return checkInternetConnectionPage();
    //       } else {
    return BlocBuilder<AuthCubit, AuthState>(builder: (Authcontext, Authstate) {
      // ChangerLang(context.locale.toString() == "en_US" ? "en" : "fr");

      if (Authstate.isLoading == true && Authstate.detailUser == null)
        return Container(
          child: EasyLoader(
            backgroundColor: Color.fromARGB(0, 255, 255, 255),
            iconSize: 50.r,
            iconColor: AppColors.blackBlueAccent1,
            image: AssetImage(
              'assets/images/Groupe_ou_Asso.png',
            ),
          ),
        );
      final currentDetailUser = context.read<AuthCubit>().state.detailUser;

      return BlocBuilder<UserGroupCubit, UserGroupState>(
        builder: (UserGroupcontext, UserGroupstate) {
          if (UserGroupstate.isLoading == true &&
                  UserGroupstate.changeAssData == null ||
              UserGroupstate.userGroup == null)
            return Container(
              child: EasyLoader(
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                iconSize: 50.r,
                iconColor: AppColors.blackBlueAccent1,
                image: AssetImage(
                  'assets/images/Groupe_ou_Asso.png',
                ),
              ),
            );

          final DetailAss =
              UserGroupcontext.read<UserGroupCubit>().state.changeAssData;

          return Material(
            type: MaterialType.transparency,
            child: Scaffold(
              backgroundColor: AppColors.pageBackground,
              body: RefreshIndicator(
                onRefresh: refresh,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar.large(
                      leading: Container(),
                      elevation: 0,
                      backgroundColor: AppColors.backgroundAppBAr,
                      flexibleSpace: UserGroupstate.isLoadingChangeAss ==
                                  true &&
                              UserGroupstate.changeAssData == null
                          // UserGroupstate.userGroup != null
                          ? EasyLoader(
                              backgroundColor: Color.fromARGB(0, 255, 255, 255),
                              iconSize: 50.r,
                              iconColor: AppColors.blackBlueAccent1,
                              image: AssetImage(
                                'assets/images/Groupe_ou_Asso.png',
                              ),
                            )
                          : FlexibleSpaceBar(
                              titlePadding: EdgeInsets.only(
                                top: 10.h,
                                bottom: 10.h,
                                left: 20.w,
                                right: 20.w,
                              ),
                              centerTitle: false,
                              title: Container(
                                // Container(
                                //   width: 120,
                                //   height: 20,
                                // ),
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            right: 13.w,
                                          ),
                                          child: Text(
                                            "${DetailAss!.user_group!.name}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.white,
                                            ),
                                            // textAlign: TextAlign.center,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          if (!context
                                              .read<AuthCubit>()
                                              .state
                                              .detailUser!["isMember"])
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AdministrationPage(
                                                      lienDePaiement: '',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 5.h,
                                                ),
                                                padding: EdgeInsets.all(1.r),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1.r,
                                                      color:
                                                          AppColors.blackBlue),
                                                  color: AppColors
                                                      .blackBlueAccent2,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.r),
                                                ),
                                                height: 20.w,
                                                width: 20.w,
                                                child: Image.asset(
                                                  "assets/images/Groupe_ou_Asso.png",
                                                  scale: 4,
                                                ),
                                              ),
                                            ),
                                          Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
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
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color.fromARGB(
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
                                                  padding: EdgeInsets.all(1.r),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.r),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.r),
                                                      ),
                                                      height: 20.w,
                                                      width: 20.w,
                                                      child: Image.network(
                                                        // "zz",
                                                        "${Variables.LienAIP}${DetailAss.user_group!.profile_photo == null ? "" : DetailAss.user_group!.profile_photo}",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 2.w,
                                                top: 2.h,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 255, 26, 9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      50.r,
                                                    ),
                                                  ),
                                                  width: 5.w,
                                                  height: 5.w,
                                                ),
                                              )
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
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Image.network(
                                      "${Variables.LienAIP}${DetailAss.user_group!.background_cover == null ? "" : DetailAss.user_group!.background_cover}",
                                      fit: BoxFit.cover,
                                    )),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.transparent,
                                        const Color.fromARGB(167, 150, 191, 53)
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                    ),
                    // if (currentDetailUser!["is_saver"])
                    //   SliverToBoxAdapter(
                    //     child: BlocBuilder<PretEpargneCubit, PretEpargneState>(
                    //         builder: (PretEpargnecontext, PretEpargnestate) {
                    //       if (PretEpargnestate.isLoadingEpargne == true &&
                    //           PretEpargnestate.epargne == null)
                    //         return Container(
                    //           child: EasyLoader(
                    //             backgroundColor:
                    //                 Color.fromARGB(0, 255, 255, 255),
                    //             iconSize: 50,
                    //             iconColor: AppColors.blackBlueAccent1,
                    //             image: AssetImage(
                    //               'assets/images/Groupe_ou_Asso.png',
                    //             ),
                    //           ),
                    //         );

                    //       final epargne =
                    //           PretEpargnecontext.read<PretEpargneCubit>()
                    //               .state
                    //               .epargne;
                    //       return Stack(
                    //         children: [
                    //           Container(
                    //             margin:
                    //                 EdgeInsets.only(left: 8, right: 8, top: 7),
                    //             decoration: BoxDecoration(
                    //               color: AppColors.white,
                    //               borderRadius: BorderRadius.circular(15),
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                     color:
                    //                         Color.fromARGB(25, 117, 117, 117),
                    //                     spreadRadius: 1,
                    //                     blurRadius: 1)
                    //               ],
                    //             ),
                    //             padding: EdgeInsets.only(
                    //                 left: 10, right: 10, top: 10, bottom: 10),
                    //             child: Column(
                    //               children: [
                    //                 Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   // crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Container(
                    //                       decoration: BoxDecoration(
                    //                         borderRadius:
                    //                             BorderRadius.circular(15),
                    //                         border: Border.all(
                    //                           width: 1.5,
                    //                           color: AppColors.blackBlueAccent2,
                    //                         ),
                    //                       ),
                    //                       padding: EdgeInsets.all(10),
                    //                       width: MediaQuery.of(context)
                    //                               .size
                    //                               .width /
                    //                           2.3,
                    //                       height: 82,
                    //                       child: Column(
                    //                         children: [
                    //                           Row(
                    //                             mainAxisAlignment:
                    //                                 MainAxisAlignment.start,
                    //                             children: [
                    //                               Column(
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment
                    //                                         .start,
                    //                                 // mainAxisAlignment: MainAxisAlignment.start,
                    //                                 children: [
                    //                                   Container(
                    //                                     child: Text(
                    //                                       "TOTAL EPARGNES".tr(),
                    //                                       style: TextStyle(
                    //                                         fontSize: 12,
                    //                                         fontWeight:
                    //                                             FontWeight.w500,
                    //                                         color: AppColors
                    //                                             .blackBlue,
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                   Container(
                    //                                     margin: EdgeInsets.only(
                    //                                       top: 3,
                    //                                       bottom: 3,
                    //                                     ),
                    //                                     child: Text(
                    //                                       "${formatMontantFrancais(double.parse(epargne!['amount_saved']))} FCFA",
                    //                                       style: TextStyle(
                    //                                         fontSize: 18,
                    //                                         fontWeight:
                    //                                             FontWeight.w700,
                    //                                         color: AppColors
                    //                                             .blackBlue,
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ],
                    //                           ),
                    //                           Row(
                    //                             mainAxisAlignment:
                    //                                 MainAxisAlignment.end,
                    //                             children: [
                    //                               Icon(
                    //                                 Icons.list_rounded,
                    //                                 size: 18,
                    //                                 color: AppColors.blackBlue,
                    //                               ),
                    //                               Container(
                    //                                 child: Text(
                    //                                   "Historiques".tr(),
                    //                                   style: TextStyle(
                    //                                     fontSize: 12,
                    //                                     fontWeight:
                    //                                         FontWeight.w500,
                    //                                     color:
                    //                                         AppColors.blackBlue,
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                     Container(
                    //                       decoration: BoxDecoration(
                    //                         // color: AppColors.bleuLight,
                    //                         borderRadius:
                    //                             BorderRadius.circular(15),
                    //                         border: Border.all(
                    //                           width: 1.5,
                    //                           color: AppColors.blackBlueAccent2,
                    //                         ),
                    //                       ),
                    //                       padding: EdgeInsets.all(10),
                    //                       width: MediaQuery.of(context)
                    //                               .size
                    //                               .width /
                    //                           2.3,
                    //                       height: 82,
                    //                       child: Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.spaceAround,
                    //                         children: [
                    //                           Container(
                    //                             child: Text(
                    //                               "INTÉRÊTS EN COURS".tr(),
                    //                               style: TextStyle(
                    //                                 fontSize: 12,
                    //                                 fontWeight: FontWeight.w500,
                    //                                 color: AppColors.blackBlue,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           Container(
                    //                             // margin: EdgeInsets.only(top: 5, bottom: 5,),
                    //                             child: Text(
                    //                               "${formatMontantFrancais(double.parse(epargne!['total_interest']))} FCFA",
                    //                               style: TextStyle(
                    //                                 fontSize: 18,
                    //                                 fontWeight: FontWeight.w700,
                    //                                 color: AppColors.blackBlue,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 GestureDetector(
                    //                   onTap: () async {
                    //                     String msg =
                    //                         "Aide-moi à épargner.\nMerci de suivre le lien https://${epargne["saving_pay_link"]} pour valider";

                    //                     Modal().showModalActionPayement(
                    //                       context,
                    //                       msg,
                    //                       epargne["saving_pay_link"],
                    //                     );
                    //                   },

                    //                   // onTap: () {

                    //                   //   saving_pay_link
                    //                   //   context
                    //                   //       .read<PretEpargneCubit>()
                    //                   //       .getEpargne();
                    //                   // },
                    //                   child: Container(
                    //                     decoration: BoxDecoration(
                    //                       color: AppColors.colorButton,
                    //                       borderRadius:
                    //                           BorderRadius.circular(15),
                    //                     ),
                    //                     padding: EdgeInsets.only(
                    //                         top: 10, bottom: 10),
                    //                     margin: EdgeInsets.only(top: 10),
                    //                     width:
                    //                         MediaQuery.of(context).size.width,
                    //                     child: Column(
                    //                       children: [
                    //                         Text(
                    //                           "EPARGNEZ",
                    //                           style: TextStyle(
                    //                             fontSize: 18,
                    //                             fontWeight: FontWeight.w900,
                    //                             color: AppColors.white,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       );
                    //     }),
                    //   ),
                    // if (currentDetailUser!["is_owe"])
                    //   SliverToBoxAdapter(
                    //     child: Container(
                    //       margin: EdgeInsets.only(left: 8, right: 8, top: 7),
                    //       decoration: BoxDecoration(
                    //         color: AppColors.white,
                    //         borderRadius: BorderRadius.circular(15),
                    //         boxShadow: [
                    //           BoxShadow(
                    //               color: Color.fromARGB(25, 117, 117, 117),
                    //               spreadRadius: 1,
                    //               blurRadius: 1)
                    //         ],
                    //       ),
                    //       padding: EdgeInsets.only(
                    //           left: 10, right: 10, top: 7, bottom: 7),
                    //       child: Column(
                    //         children: [
                    //           Container(
                    //             margin: EdgeInsets.only(bottom: 5),
                    //             child: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Container(
                    //                   alignment: Alignment.center,
                    //                   width: 72,
                    //                   padding: EdgeInsets.only(
                    //                     left: 8,
                    //                     right: 8,
                    //                     top: 5,
                    //                     bottom: 5,
                    //                   ),
                    //                   // decoration: BoxDecoration(
                    //                   //   color: AppColors.colorButton,
                    //                   //   borderRadius:
                    //                   //       BorderRadius.circular(15),
                    //                   // ),
                    //                   // child: Container(
                    //                   //   child: Text(
                    //                   //     "Payer".tr(),
                    //                   //     style: TextStyle(
                    //                   //       fontWeight: FontWeight.bold,
                    //                   //       fontSize: 12,
                    //                   //       color: AppColors.white,
                    //                   //     ),
                    //                   //   ),
                    //                   // ),
                    //                 ),
                    //                 Text(
                    //                   "Prêts en cours".tr().toUpperCase(),
                    //                   style: TextStyle(
                    //                       fontWeight: FontWeight.w600,
                    //                       color: AppColors.blackBlue),
                    //                 ),
                    //                 GestureDetector(
                    //                   onTap: () async {
                    //                     // String msg =
                    //                     // "Aide-moi à payer mon inscription.\nMontant: ${formatMontantFrancais(double.parse((int.parse(currentDetailUser["entry_amount"]) - int.parse(currentDetailUser["inscription_balance"])).toString()))} FCFA.\nMerci de suivre le lien ${currentDetailUser["inscription_pay_link"]} pour valider";
                    //                     // if (currentDetailUser[
                    //                     //         "is_inscription_payed"] !=
                    //                     //     1)
                    //                     //   Modal().showModalActionPayement(
                    //                     //     context,
                    //                     //     msg,
                    //                     //     currentDetailUser[
                    //                     //         "inscription_pay_link"],
                    //                     //   );
                    //                   },
                    //                   child: Container(
                    //                     alignment: Alignment.center,
                    //                     width: 72,
                    //                     padding: EdgeInsets.only(
                    //                       left: 8,
                    //                       right: 8,
                    //                       top: 5,
                    //                       bottom: 5,
                    //                     ),
                    //                     decoration: BoxDecoration(
                    //                       color: AppColors.colorButton,
                    //                       borderRadius:
                    //                           BorderRadius.circular(15),
                    //                     ),
                    //                     child: Container(
                    //                       child: Text(
                    //                         "Rembourser".tr(),
                    //                         style: TextStyle(
                    //                           fontWeight: FontWeight.bold,
                    //                           fontSize: 10,
                    //                           color: AppColors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //           Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(
                    //                     "montant".tr().toUpperCase(),
                    //                     style: TextStyle(
                    //                       fontSize: 12,
                    //                       fontWeight: FontWeight.w600,
                    //                       color: AppColors.blackBlueAccent1,
                    //                     ),
                    //                   ),
                    //                   Text(
                    //                     "3 000 FCFA".tr(),
                    //                     style: TextStyle(
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w900,
                    //                       color: AppColors.blackBlue,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.end,
                    //                 children: [
                    //                   Text(
                    //                     "a rembourser".tr().toUpperCase(),
                    //                     style: TextStyle(
                    //                       fontSize: 12,
                    //                       fontWeight: FontWeight.w600,
                    //                       color: AppColors.blackBlueAccent1,
                    //                     ),
                    //                   ),
                    //                   Text(
                    //                     "2 000 FCFA".tr(),
                    //                     style: TextStyle(
                    //                       fontSize: 18,
                    //                       fontWeight: FontWeight.w900,
                    //                       color: AppColors.red,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //           Container(
                    //             margin: EdgeInsets.only(top: 5),
                    //             child: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       "intérêts".tr().toUpperCase(),
                    //                       style: TextStyle(
                    //                         fontSize: 12,
                    //                         fontWeight: FontWeight.w600,
                    //                         color: AppColors.blackBlueAccent1,
                    //                       ),
                    //                     ),
                    //                     Text(
                    //                       "1 000 FCFA".tr(),
                    //                       style: TextStyle(
                    //                         fontSize: 16,
                    //                         fontWeight: FontWeight.w900,
                    //                         color: AppColors.blackBlue,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Text(
                    //                   "Avant le 20 jan 2024".tr().toUpperCase(),
                    //                   style: TextStyle(
                    //                     fontSize: 12,
                    //                     fontWeight: FontWeight.w600,
                    //                     color: AppColors.blackBlue,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    if (currentDetailUser!["is_inscription_payed"] == 0)
                      SliverToBoxAdapter(
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 8.w, right: 8.w, top: 7.h),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(25, 117, 117, 117),
                                  spreadRadius: 1,
                                  blurRadius: 1)
                            ],
                          ),
                          padding: EdgeInsets.only(
                              left: 10.w, right: 10.w, top: 7.h, bottom: 7.h),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Fonds de caisse".tr().toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.blackBlue),
                                    ),
                                    if (Authstate.isLoading != true)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${"reste à payer".tr()}',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.blackBlueAccent1,
                                            ),
                                          ),
                                          Text(
                                            "${formatMontantFrancais(double.parse((int.parse(currentDetailUser["entry_amount"]) - int.parse(currentDetailUser["inscription_balance"])).toString()))} FCFA"
                                                .tr(),
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              Authstate.isLoading == true
                                  ? Container(
                                      child: EasyLoader(
                                        backgroundColor:
                                            Color.fromARGB(0, 255, 255, 255),
                                        iconSize: 25.sp,
                                        iconColor: AppColors.blackBlueAccent1,
                                        image: AssetImage(
                                          'assets/images/Groupe_ou_Asso.png',
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${formatMontantFrancais(double.parse(currentDetailUser["entry_amount"]))} FCFA"
                                                  .tr(),
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.blackBlue,
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            String msg =
                                                "Aide-moi à payer mon inscription.\nMontant: ${formatMontantFrancais(double.parse((int.parse(currentDetailUser["entry_amount"]) - int.parse(currentDetailUser["inscription_balance"])).toString()))} FCFA.\nMerci de suivre le lien https://${currentDetailUser["inscription_pay_link"]} pour valider";
                                            if (currentDetailUser[
                                                    "is_inscription_payed"] !=
                                                1)
                                              Modal().showModalActionPayement(
                                                context,
                                                msg,
                                                currentDetailUser[
                                                    "inscription_pay_link"],
                                              );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 72.w,
                                            padding: EdgeInsets.only(
                                              left: 8.w,
                                              right: 8.w,
                                              top: 5.h,
                                              bottom: 5.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.colorButton,
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            child: Container(
                                              child: Text(
                                                "Payer".tr(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    SliverPersistentHeader(
                      pinned: false,
                      floating: false,
                      delegate: FixedHeaderBar(
                        maxExtent: 220.r,
                        minExtent: 220.r,
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
                    BlocBuilder<RecentEventCubit, RecentEventState>(
                      builder: (context, state) {
                        if (state.isLoading == true ||
                            state.allRecentEvent == null)
                          return SliverToBoxAdapter(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 7),
                              child: EasyLoader(
                                backgroundColor:
                                    Color.fromARGB(0, 255, 255, 255),
                                iconSize: 50.sp,
                                iconColor: AppColors.blackBlueAccent1,
                                image: AssetImage(
                                  'assets/images/Groupe_ou_Asso.png',
                                ),
                              ),
                            ),
                          );

                        // if (state.isLoading == false &&
                        //     state.allRecentEvent == {})
                        //   return SliverToBoxAdapter(
                        //     child: callFunctionFailled(
                        //       reFunction: () => context
                        //           .read<RecentEventCubit>()
                        //           .AllRecentEventCubit(
                        //             AppCubitStorage().state.membreCode,
                        //           ),
                        //     ),
                        //   );

                        final currentRecentEvent = context
                            .read<RecentEventCubit>()
                            .state
                            .allRecentEvent;

                        final currentTontine = currentRecentEvent!["tontines"];
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
                            nomBeneficiaire: monObjet["membre"]["first_name"],
                            prenomBeneficiaire:
                                monObjet["membre"]["last_name"] == null
                                    ? ''
                                    : monObjet["membre"]["last_name"],
                            dateOpen: monObjet["start_date"],
                            dateClose: monObjet["end_date"],
                            montantTontine: monObjet["amount"],
                            montantCollecte: monObjet["tontine_balance"],
                            codeCotisation: monObjet["code"],
                            lienDePaiement: monObjet["tontine_pay_link"],
                            nomTontine: monObjet["matricule"],
                          );
                        }).toList();

                        List<Widget> listWidgetCotisation =
                            listeCotisation.map((monObjet) {
                          return widgetRecentEventCotisation(
                            rublique: monObjet["ass_rubrique"] == null
                                ? ""
                                : '(${monObjet["ass_rubrique"]["name"]})',
                            dateOpen: monObjet["start_date"],
                            dateClose: monObjet["end_date"],
                            montantCotisation: monObjet["amount"],
                            montantCollecte: monObjet["cotisation_balance"],
                            codeCotisation: monObjet["cotisation_code"],
                            lienDePaiement: monObjet["cotisation_pay_link"],
                            motif: monObjet["name"],
                            type: monObjet["type"],
                            isPassed: monObjet["is_passed"],
                            source: monObjet["seance"] == null
                                ? ''
                                : '${'rencontre'.tr()} ${monObjet["seance"]["matricule"]}',
                            nomBeneficiaire: monObjet["membre"] == null
                                ? ''
                                : monObjet["membre"]["last_name"] == null
                                    ? "${monObjet["membre"]["first_name"]}"
                                    : "${monObjet["membre"]["first_name"]} ${monObjet["membre"]["last_name"]}",
                          );
                        }).toList();

                        List<Widget> listWidgetSanction =
                            listeSanction.map((monObjet) {
                          return widgetRecentEventSanction(
                            motif: monObjet["motif"],
                            dateOpen: monObjet["start_date"],
                            montantSanction: monObjet["amount"] == null
                                ? 0
                                : monObjet["amount"],
                            libelleSanction: monObjet["libelle"] == null
                                ? ""
                                : monObjet["libelle"],
                            montantCollecte: monObjet["sanction_balance"],
                            codeCotisation: monObjet["sanction_code"],
                            lienDePaiement:
                                monObjet["sanction_pay_link"] == null
                                    ? ""
                                    : monObjet["sanction_pay_link"],
                            type: monObjet["type"],
                            versement: monObjet["versement"],
                          );
                        }).toList();

                        final listeWidgetFinale = [
                          ...listWidgetTontine,
                          ...listWidgetCotisation,
                          ...listWidgetSanction
                        ];

                        return listeWidgetFinale.length > 0
                            ? SliverList.builder(
                                itemCount: listeWidgetFinale.length,
                                itemBuilder: (BuildContext context, int index) {
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
                                  margin: EdgeInsets.only(top: 50.h),
                                  child: Center(
                                    child: Text(
                                      "Aucun_evenement_recent".tr(),
                                      style: TextStyle(
                                        color: Color.fromRGBO(20, 45, 99, 0.26),
                                        fontWeight: FontWeight.w100,
                                        fontSize: 20.sp,
                                      ),
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
          padding: EdgeInsets.only(left: 10.w),
          margin: EdgeInsets.only(top: 6.h),
          color: AppColors.whiteAccent,
          alignment: Alignment.centerLeft,
          child: BlocBuilder<RecentEventCubit, RecentEventState>(
              builder: (context, state) {
            if (state.isLoading == true || state.allRecentEvent == null)
              return Text(
                "Événements_récents".tr(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: AppColors.blackBlueAccent1),
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
              return Text(
                "Événements_récents".tr(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: AppColors.blackBlueAccent1),
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

class FixedHeaderBar extends SliverPersistentHeaderDelegate {
  FixedHeaderBar({
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
          padding: EdgeInsets.symmetric(
            horizontal: 6.w,
            // vertical: 3.h,
          ),
          margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 7.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(25, 117, 117, 117),
                spreadRadius: 1,
                blurRadius: 1,
              )
            ],
          ),
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 7.h, left: 5.w, bottom: 7.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Container(
                        child: Text(
                          "rencontre".tr().toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: AppColors.blackBlue,),
                          // ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10.w),
                        width: 10.r,
                        height: 10.r,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(244, 67, 54, 1),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<DetailTournoiCourantCubit,
                    DetailTournoiCourantState>(
                  builder: (tournoisContext, tournoisState) {
                    if (tournoisState.isLoading == true ||
                        tournoisState.detailtournoiCourant == null)
                      return Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 13),
                        child: EasyLoader(
                          backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          iconSize: 50.sp,
                          iconColor: AppColors.blackBlueAccent1,
                          image: AssetImage(
                            'assets/images/Groupe_ou_Asso.png',
                          ),
                        ),
                      );
                    // if (tournoisState.isLoading == false &&
                    //     tournoisState.detailtournoiCourant == {})
                    //   return callFunctionFailled(
                    //     reFunction: () => tournoisContext
                    //         .read<DetailTournoiCourantCubit>()
                    //         .detailTournoiCourantCubit(
                    //           AppCubitStorage().state.codeTournois,
                    //         ),
                    //   );
                    final currentDetailtournoiCourant = context
                        .read<DetailTournoiCourantCubit>()
                        .state
                        .detailtournoiCourant;

                    return currentDetailtournoiCourant!["tournois"] != null &&
                            currentDetailtournoiCourant["tournois"]["seance"]
                                    .length >
                                0 &&
                            currentDetailtournoiCourant["tournois"]["seance"][0]
                                    ["status"] ==
                                1
                        ? Container(
                            margin: EdgeInsets.only(
                                left: 7.w, right: 7.w, top: 5.h),
                            child: WidgetRencontreCard(
                              // typeRencontre: currentDetailtournoiCourant["type_rencontre"],
                              typeRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["type_rencontre"],
                              maskElt: true,
                              codeSeance:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["seance_code"],
                              dateRencontre: AppCubitStorage().state.Language ==
                                      "fr"
                                  ? formatDateToFrench(
                                      currentDetailtournoiCourant!["tournois"]
                                          ["seance"][0]["date_seance"],
                                    )
                                  : formatDateToEnglish(
                                      currentDetailtournoiCourant!["tournois"]
                                          ["seance"][0]["date_seance"],
                                    ),
                              descriptionRencontre:
                                  '${formatDateTimeintegral(context.locale.toString() == "en_US" ? "en" : "fr", currentDetailtournoiCourant["tournois"]["seance"][0]["date_seance"]).toUpperCase()} ${"à".tr()} ${currentDetailtournoiCourant["tournois"]["seance"][0]["heure_debut"]}',
                              heureRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["heure_debut"],
                              identifiantRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["matricule"],
                              isActiveRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["status"],
                              lieuRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["localisation"],
                              prenomRecepteurRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                                  ["seance"][0]["membre"]
                                              ["last_name"] ==
                                          null
                                      ? ""
                                      : currentDetailtournoiCourant["tournois"]
                                          ["seance"][0]["membre"]["last_name"],
                              nomRecepteurRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                                  ["seance"][0]["membre"]
                                              ["first_name"] ==
                                          null
                                      ? ""
                                      : currentDetailtournoiCourant["tournois"]
                                          ["seance"][0]["membre"]["first_name"],
                              photoProfilRecepteur:
                                  currentDetailtournoiCourant["tournois"]
                                                  ["seance"][0]["membre"]
                                              ["photo_profil"] ==
                                          null
                                      ? ""
                                      : currentDetailtournoiCourant["tournois"]
                                              ["seance"][0]["membre"]
                                          ["photo_profil"],
                              dateRencontreAPI:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["date_seance"],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 50.h),
                            child: Center(
                              child: Text(
                                "Pas de rencontre en cours".tr(),
                                style: TextStyle(
                                  color: Color.fromRGBO(20, 45, 99, 0.26),
                                  fontWeight: FontWeight.w100,
                                  fontSize: 20.sp,
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
