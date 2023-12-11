import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotistion.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/presentation/widgets/widget_recent_event_cotisation.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/presentation/widgets/widget_recent_event_sanction.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/presentation/widgets/widget_recent_event_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanction.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Future<void> handleAllUserGroup() async {
    final AllUserGroup =
        await context.read<UserGroupCubit>().AllUserGroupOfUserCubit();

    if (AllUserGroup != null) {
      print("1");

      // print(context.read<UserGroupCubit>().state.userGroup);
    } else {
      print("AllUserGroup null");
    }
  }

  // Future<void> handleUserGroupDefault() async {
  //   final userGroupDefault = await context
  //       .read<UserGroupCubit>()
  //       .UserGroupDefaultCubit({AppCubitStorage().state.codeAssDefaul});

  //   if (userGroupDefault != null) {
  //     // await AppCubitStorage().updateCodeAssDefaul(
  //   } else {
  //     print("userGroupDefault null");
  //   }
  // }

  Future<void> handleTournoiDefault() async {
    final detailTournoiCourant = await context
        .read<DetailTournoiCourantCubit>()
        .detailTournoiCourantCubit();

    if (detailTournoiCourant != null) {
      print("handleTournoiDefault");
    } else {
      print("handleTournoiDefault null");
    }
  }

  Future<void> handleAllCotisationAssTournoi(codeTournoi) async {
    final allCotisationAss = await context
        .read<CotisationCubit>()
        .AllCotisationAssTournoiCubit(codeTournoi);

    if (allCotisationAss != null) {
      print("handleAllCotisationAss");
    } else {
      print("handleAllCotisationAss null");
    }
  }

  Future<void> handleDetailUser(userCode) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode);

    if (allCotisationAss != null) {
      print("handleDetailUser");
    } else {
      print("handleDetailUser null");
    }
  }

  Future<void> handleAllCompteAss(codeAssociation) async {
    final allCotisationAss =
        await context.read<CompteCubit>().AllCompteAssCubit(codeAssociation);

    if (allCotisationAss != null) {
      print("handleAllCompteAss");
    } else {
      print("handleAllCompteAss null");
    }
  }

  Future<void> handleAllSeanceAss(codeAssociation) async {
    final allSeanceAss =
        await context.read<SeanceCubit>().AllAssSeanceCubit(codeAssociation);

    if (allSeanceAss != null) {
      print("handleAllSeanceAss");
    } else {
      print("handleAllSeanceAss null");
    }
  }

  // Future<void> handleDetailCotisation(codeCotisation) async {
  //   final detailCotisation = await context
  //       .read<CotisationCubit>()
  //       .detailCotisationCubit(codeCotisation);

  //   if (detailCotisation != null) {
  //     print("handleDetailCotisation");
  //   } else {
  //     print("handleDetailCotisation null");
  //   }
  // }

  // Future<void> handleTournoiAll(codeAss) async {
  //   final allTournoi =
  //       await context.read<DetailTournoiCourantCubit>().allTournoiAss(codeAss);

  //   if (allTournoi != null) {
  //     for (var tournoi
  //         in context.read<DetailTournoiCourantCubit>().state.allTournoiAss!) {
  //       if (tournoi["is_active"] == 1) {
  //         AppCubitStorage().updateCodeTournoisDefault(tournoi["tournois_code"]);
  //       }
  //     }
  //   } else {
  //     print("userGroupDefault null");
  //   }
  // }

  Future handleChangeAss(codeAss) async {
    final allCotisationAss =
        await context.read<UserGroupCubit>().ChangeAssCubit(codeAss);

    if (allCotisationAss != null) {
      print("objec~~~~~~~~ttt  ${allCotisationAss}");
      print(
          "éé222sssssssssssssssssssssssssssssssssssssssssstttttttttttsssssss22~~~~~~~~");
    } else {
      print("userGroupDefault null");
    }
  }

  Future handleRecentEvent(codeMembre) async {
    final allRecentEvent =
        await context.read<RecentEventCubit>().AllRecentEventCubit(codeMembre);

    if (allRecentEvent != null) {
      print("objec~~~~~~~~ttt  ${allRecentEvent}");
      print("handleRecentEventhandleRecentEventhandleRecentEvent~~~~~~~~");
    } else {
      print("handleRecentEventhandleRecentEvent null");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // handleUserGroupDefault();
    handleAllUserGroup();
    handleTournoiDefault();
    handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournois);
    handleChangeAss(AppCubitStorage().state.codeAssDefaul);
    handleDetailUser(AppCubitStorage().state.membreCode);
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
    handleAllSeanceAss(AppCubitStorage().state.codeAssDefaul);
    handleRecentEvent(AppCubitStorage().state.membreCode);
    // handleDetailCotisation(AppCubitStorage().state.codeAssDefaul);
    // handleTournoiAll(AppCubitStorage().state.codeAssDefaul);

    super.initState();
  }

  Future refresh() async {
    handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournois);
  }

  var Tab = [true, false, false, true, false, true, 'expi', 'expi'];

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    return BlocBuilder<AuthCubit, AuthState>(builder: (authContext, authState) {
      if (authState.isLoading == null ||
          authState.isLoading == true ||
          authState.detailUser == null)
        return Container(
          color: AppColors.white,
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.bleuLight,
            ),
          ),
        );
      final currentDetailUser = context.read<AuthCubit>().state.detailUser;
      return BlocBuilder<UserGroupCubit, UserGroupState>(
          builder: (UserGroupcontext, UserGroupstate) {
        if (UserGroupstate.isLoading == null ||
            UserGroupstate.isLoading == true ||
            UserGroupstate.ChangeAssData == null ||
            UserGroupstate.userGroup == null)
          return Container(
            color: AppColors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.bleuLight,
              ),
            ),
          );
        final DetailAss =
            UserGroupcontext.read<UserGroupCubit>().state.ChangeAssData;
        return BlocBuilder<DetailTournoiCourantCubit,
            DetailTournoiCourantState>(
          builder: (tournoisContext, tournoisState) {
            if (tournoisState.isLoading == null ||
                tournoisState.isLoading == true ||
                tournoisState.detailtournoiCourant == null)
              return Container(
                color: AppColors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.bleuLight,
                  ),
                ),
              );
            final currentDetailtournoiCourant = context
                .read<DetailTournoiCourantCubit>()
                .state
                .detailtournoiCourant;

            return Scaffold(
              backgroundColor: AppColors.pageBackground,
              body: RefreshIndicator(
                onRefresh: refresh,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar.large(
                      // expandedHeight: 20,
                      // toolbarHeight: 1,
                      leading: Container(),
                      elevation: 0,
                      backgroundColor: Color.fromRGBO(0, 162, 255, 0.915),
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 20,
                          right: 20,
                        ),
                        centerTitle: false,
                        title: Container(
                          child: Stack(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 13),
                                        child: Text(
                                          "${DetailAss!["user_group"]["name"]}",
                                          // nomAss,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.white,
                                          ),
                                          // textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Modal().showBottomSheetListAss(
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
                                            color:
                                                Color.fromARGB(255, 255, 26, 9),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        padding: EdgeInsets.all(1),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            height: 30,
                                            width: 30,
                                            child: Image.network(
                                              // "zz",
                                              "${Variables.LienAIP}${DetailAss!["user_group"]["profile_photo"] == null ? "" : DetailAss!["user_group"]["profile_photo"]}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 2,
                                top: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 26, 9),
                                      borderRadius: BorderRadius.circular(50)),
                                  width: 5,
                                  height: 5,
                                ),
                              )
                            ],
                          ),
                        ),
                        background: Stack(children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Image.network(
                              // "zz",
                              "${Variables.LienAIP}${DetailAss!["user_group"]["background_cover"] == null ? "" : DetailAss!["user_group"]["background_cover"]}",
                              fit: BoxFit.cover,
                            ),
                            // Image.asset(
                            //   "assets/images/associazioni.jpeg",
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(62, 255, 255, 255),
                                  spreadRadius: 1,
                                  blurRadius: 15,
                                  offset: const Offset(5, 5),
                                ),
                                const BoxShadow(
                                    color: Color.fromARGB(4, 255, 255, 255),
                                    offset: Offset(-5, -5),
                                    blurRadius: 15,
                                    spreadRadius: 1),
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromARGB(0, 85, 85, 85),
                                  Color.fromARGB(70, 53, 53, 53),
                                  Color.fromARGB(80, 63, 63, 63),
                                  Color.fromARGB(221, 46, 46, 46),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    if (currentDetailtournoiCourant!["tournois"] != null)
                      if (currentDetailtournoiCourant["tournois"]["seance"]
                              .length >
                          0)
                        if (currentDetailtournoiCourant["tournois"]["seance"][0]
                                ["status"] ==
                            1)
                          SliverPersistentHeader(
                            pinned: false,
                            floating: false,
                            delegate: FixedHeaderBar(
                              isActiveRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["status"],
                              codeSeance:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["seance_code"],
                              matriculeRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["matricule"],
                              nomRecepteurRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                                  ["seance"][0]["membre"]
                                              ["first_name"] ==
                                          null
                                      ? ""
                                      : currentDetailtournoiCourant["tournois"]
                                          ["seance"][0]["membre"]["first_name"],
                              prenomRecepteurRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                                  ["seance"][0]["membre"]
                                              ["last_name"] ==
                                          null
                                      ? ""
                                      : currentDetailtournoiCourant["tournois"]
                                          ["seance"][0]["membre"]["last_name"],
                              photoProfilRecepteur:
                                  currentDetailtournoiCourant["tournois"]
                                                  ["seance"][0]["membre"]
                                              ["photo_profil"] ==
                                          null
                                      ? ""
                                      : currentDetailtournoiCourant["tournois"]
                                              ["seance"][0]["membre"]
                                          ["photo_profil"],
                              dateRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["date_seance"],
                              // descriptionRencontre: itemSeance["zzzzzzzzzzzzzzz"],
                              heureRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["heure_debut"],
                              lieuRencontre:
                                  currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["localisation"],
                              maxExtent: 215,
                              minExtent: 215,
                            ),
                          ),
                    // break;
                    SliverPersistentHeader(
                      pinned: true,
                      floating: false,
                      delegate: SliverTabBar(
                        tabController: _tabController,
                        maxExtent: 50,
                        minExtent: 50,
                      ),
                    ),

                    BlocBuilder<RecentEventCubit, RecentEventState>(
                      builder: (context, state) {
                        if (state.isLoading == null ||
                            state.isLoading == true ||
                            state.allRecentEvent == null)
                          return SliverToBoxAdapter(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Center(
                                // color: AppColors.white,
                                child: CircularProgressIndicator(
                                  color: AppColors.bleuLight,
                                ),
                              ),
                            ),
                          );

                        final currentRecentEvent = context
                            .read<RecentEventCubit>()
                            .state
                            .allRecentEvent;
                        final currentTontine = currentRecentEvent!["tontines"];

                        return currentTontine.length > 0
                            ? SliverList.builder(
                                itemCount: currentTontine.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final itemTontine = currentTontine[index];
                                  return Container(
                                    margin: EdgeInsets.only(
                                        top: 7, left: 7, right: 7, bottom: 3),
                                    child: widgetRecentEventTontine(
                                      nomBeneficiaire: itemTontine["membre"]
                                          ["first_name"],
                                      prenomBeneficiaire: itemTontine["membre"]
                                                  ["last_name"] ==
                                              null
                                          ? ''
                                          : itemTontine["membre"]["last_name"],
                                      dateOpen: itemTontine["start_date"],
                                      dateClose: itemTontine["end_date"],
                                      montantTontine: itemTontine["amount"],
                                      montantCollecte:
                                          itemTontine["tontine_balance"],
                                      codeCotisation: itemTontine["code"],
                                      lienDePaiement:
                                          itemTontine["tontine_pay_link"],
                                      nomTontine: itemTontine["matricule"],
                                    ),
                                  );
                                },
                              )
                            : SliverToBoxAdapter(
                                child: Container(),
                              );
                      },
                    ),

                    BlocBuilder<RecentEventCubit, RecentEventState>(
                      builder: (context, state) {
                        if (state.isLoading == null ||
                            state.isLoading == true ||
                            state.allRecentEvent == null)
                          return SliverToBoxAdapter(
                            child: Container(),
                          );

                        final currentRecentEvent = context
                            .read<RecentEventCubit>()
                            .state
                            .allRecentEvent;
                        final currentCotisation =
                            currentRecentEvent!["cotisations"];

                        return currentCotisation.length > 0
                            ? SliverList.builder(
                                itemCount: currentCotisation.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final itemCotisation =
                                      currentCotisation[index];
                                  return Container(
                                    margin: EdgeInsets.only(
                                        top: 7, left: 7, right: 7, bottom: 3),
                                    child: widgetRecentEventCotisation(
                                      dateOpen: itemCotisation["start_date"],
                                      dateClose: itemCotisation["end_date"],
                                      montantCotisation:
                                          itemCotisation["amount"],
                                      montantCollecte:
                                          itemCotisation["cotisation_balance"],
                                      codeCotisation:
                                          itemCotisation["cotisation_code"],
                                      lienDePaiement:
                                          itemCotisation["cotisation_pay_link"],
                                      nomCotisation: itemCotisation["name"],
                                      type: itemCotisation["type"],
                                    ),
                                  );
                                },
                              )
                            : SliverToBoxAdapter(
                                child: Container(),
                              );
                      },
                    ),

                    BlocBuilder<RecentEventCubit, RecentEventState>(
                      builder: (context, state) {
                        if (state.isLoading == null ||
                            state.isLoading == true ||
                            state.allRecentEvent == null)
                          return SliverToBoxAdapter(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Center(
                                // color: AppColors.white,
                                child: CircularProgressIndicator(
                                  color: AppColors.bleuLight,
                                ),
                              ),
                            ),
                          );

                        final currentRecentEvent = context
                            .read<RecentEventCubit>()
                            .state
                            .allRecentEvent;
                        final currentSanction =
                            currentRecentEvent!["sanctions"];

                        return currentSanction.length > 0
                            ? SliverList.builder(
                                itemCount: currentSanction.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final itemSanction = currentSanction[index];
                                  return Container(
                                    margin: EdgeInsets.only(
                                        top: 7, left: 7, right: 7, bottom: 3),
                                    child: widgetRecentEventSanction(
                                      motif: itemSanction["motif"],
                                      dateOpen: itemSanction["start_date"],
                                      montantSanction:
                                          itemSanction["amount"] == null
                                              ? 0
                                              : itemSanction["amount"],
                                      libelleSanction:
                                          itemSanction["libelle"] == null
                                              ? ""
                                              : itemSanction["libelle"],
                                      montantCollecte:
                                          itemSanction["sanction_balance"],
                                      codeCotisation:
                                          itemSanction["sanction_code"],
                                      lienDePaiement: itemSanction[
                                                  "sanction_pay_link"] ==
                                              null
                                          ? ""
                                          : itemSanction["sanction_pay_link"],
                                      type: itemSanction["type"],
                                    ),
                                  );
                                },
                              )
                            : SliverToBoxAdapter(
                                child: Container(),
                              );
                      },
                    ),

                    BlocBuilder<RecentEventCubit, RecentEventState>(
                      builder: (context, state) {
                        if (state.isLoading == null ||
                            state.isLoading == true ||
                            state.allRecentEvent == null)
                          return SliverToBoxAdapter(
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Center(),
                            ),
                          );
                        List tableauFinal = [];

                        final currentRecentEvent = context
                            .read<RecentEventCubit>()
                            .state
                            .allRecentEvent;
                        // Fusion des tableaux en un seul tableau
                        tableauFinal.addAll(currentRecentEvent!["tontines"]);
                        tableauFinal.addAll(currentRecentEvent!["cotisations"]);
                        tableauFinal.addAll(currentRecentEvent!["sanctions"]);
                        return tableauFinal.length < 1
                            ? SliverToBoxAdapter(
                                child: Container(
                                  color: AppColors.pageBackground,
                                  margin: EdgeInsets.only(top: 50),
                                  child: Center(
                                    child: Text(
                                      "Aucun evenement recent",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(20, 45, 99, 0.26),
                                          fontWeight: FontWeight.w100,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              )
                            : SliverToBoxAdapter(
                                child: Container(),
                              );
                      },
                    ),

                    // BlocBuilder<RecentEventCubit, RecentEventState>(
                    //   builder: (context, state) {
                    //     if (state.isLoading == null ||
                    //         state.isLoading == true ||
                    //         state.allRecentEvent == null)
                    //       return SliverToBoxAdapter(
                    //         child: Container(
                    //           margin: EdgeInsets.only(top: 10),
                    //           child: Center(
                    //             // color: AppColors.white,
                    //             child: CircularProgressIndicator(
                    //               color: AppColors.bleuLight,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     final currentRecentEvent = context
                    //         .read<RecentEventCubit>()
                    //         .state
                    //         .allRecentEvent;

                    //     return SliverToBoxAdapter(
                    //       child: SingleChildScrollView(
                    //         physics: NeverScrollableScrollPhysics(),
                    //         child: Container(
                    //           // height: MediaQuery.of(context).size.height * 2,
                    //           child: Column(
                    //             children: [
                    //               for (var i = 0; i == 1; i++)
                    //                 Container(
                    //                   margin: EdgeInsets.all(10),
                    //                   height: 312,
                    //                   width: 112,
                    //                   color: AppColors.red,
                    //                 ),
                    //               // Container(
                    //               //   height: 400,
                    //               //   child: ListView.builder(
                    //               //     physics: NeverScrollableScrollPhysics(),
                    //               //     itemCount: 1,
                    //               //     itemBuilder:
                    //               //         (BuildContext context, int index) {
                    //               //       return Center(
                    //               //         // color: AppColors.white,
                    //               //         child: Container(
                    //               //           height: 312,
                    //               //           width: 112,
                    //               //           color: AppColors.backgroundAppBAr,
                    //               //         ),
                    //               //       );
                    //               //     },
                    //               //   ),
                    //               // ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),

                    // SliverToBoxAdapter(
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: MediaQuery.of(context).size.height * 2,
                    //     margin: EdgeInsets.all(5),
                    //     child: TabBarView(
                    //       controller: _tabController,
                    //       children: [
                    //         BlocBuilder<CotisationCubit, CotisationState>(
                    //           builder: (context, state) {
                    //             if (state.isLoading == null ||
                    //                 state.isLoading == true ||
                    //                 state.allCotisationAss == null)
                    //               return Container(
                    //                 // color: AppColors.white,
                    //                 child: CircularProgressIndicator(
                    //                   color: AppColors.bleuLight,
                    //                 ),
                    //               );
                    //             final currentAllCotisationAssTournoi = context
                    //                 .read<CotisationCubit>()
                    //                 .state
                    //                 .allCotisationAss;

                    //             List<dynamic> objetCotisationUniquement =
                    //                 currentAllCotisationAssTournoi!
                    //                     .where(
                    //                         (objet) => objet["is_tontine"] == 0)
                    //                     .toList();
                    //             return objetCotisationUniquement.length > 0
                    //                 ? Container(
                    //                   // color: Colors.cyan,
                    //                   child: ListView.builder(
                    //                     itemCount:
                    //                         objetCotisationUniquement.length,
                    //                     physics:
                    //                         NeverScrollableScrollPhysics(),
                    //                     padding: EdgeInsets.all(0),
                    //                     itemBuilder: (BuildContext context,
                    //                         int index) {
                    //                       final ItemDetailCotisation =
                    //                           objetCotisationUniquement[
                    //                               index];

                    //                       return Container(
                    //                           margin: EdgeInsets.only(
                    //                               left: 7,
                    //                               right: 7,
                    //                               top: 3,
                    //                               bottom: 7),
                    //                           child: WidgetCotisation(
                    //                             montantCotisations:
                    //                                 ItemDetailCotisation[
                    //                                     "amount"],
                    //                             motifCotisations:
                    //                                 ItemDetailCotisation[
                    //                                     "name"],
                    //                             dateCotisation: AppCubitStorage()
                    //                                         .state
                    //                                         .Language ==
                    //                                     "fr"
                    //                                 ? formatDateToFrench(
                    //                                     ItemDetailCotisation[
                    //                                         "start_date"])
                    //                                 : formatDateToEnglish(
                    //                                     ItemDetailCotisation[
                    //                                         "start_date"]),
                    //                             heureCotisation: AppCubitStorage()
                    //                                         .state
                    //                                         .Language ==
                    //                                     "fr"
                    //                                 ? formatTimeToFrench(
                    //                                     ItemDetailCotisation[
                    //                                         "start_date"])
                    //                                 : formatTimeToEnglish(
                    //                                     ItemDetailCotisation[
                    //                                         "start_date"]),
                    //                             soldeCotisation:
                    //                                 ItemDetailCotisation[
                    //                                     "cotisation_balance"],
                    //                             codeCotisation:
                    //                                 ItemDetailCotisation[
                    //                                     "cotisation_code"],
                    //                             type:
                    //                                 ItemDetailCotisation[
                    //                                     "type"],
                    //                             lienDePaiement: ItemDetailCotisation[
                    //                                         "cotisation_pay_link"] ==
                    //                                     null
                    //                                 ? "le lien n'a pas été généré"
                    //                                 : ItemDetailCotisation[
                    //                                     "cotisation_pay_link"],
                    //                             is_passed:
                    //                                 ItemDetailCotisation[
                    //                                     "is_passed"],
                    //                             is_tontine:
                    //                                 ItemDetailCotisation[
                    //                                     "is_tontine"],
                    //                           ),
                    //                           );
                    //                     },
                    //                   ),
                    //                 )
                    //                 : Container(
                    //                     padding: EdgeInsets.only(top: 100),
                    //                     alignment: Alignment.topCenter,
                    //                     child: Text(
                    //                       "aucune_cotisation".tr(),
                    //                       style: TextStyle(
                    //                           color: Color.fromRGBO(
                    //                               20, 45, 99, 0.26),
                    //                           fontWeight: FontWeight.w100,
                    //                           fontSize: 20),
                    //                     ),
                    //                   );
                    //           },
                    //         ),
                    //         currentDetailUser!["sanctions"].length > 0
                    //             ? ListView.builder(
                    //                 padding: EdgeInsets.all(0),
                    //                 physics: NeverScrollableScrollPhysics(),
                    //                 itemCount:
                    //                     currentDetailUser["sanctions"].length,
                    //                 itemBuilder:
                    //                     (BuildContext context, int index) {
                    //                   final currentSaction =
                    //                       currentDetailUser!["sanctions"][index];
                    //                   return Container(
                    //                     margin: EdgeInsets.only(
                    //                         left: 7, right: 7, top: 3, bottom: 7),
                    //                     child: WidgetSanction(
                    //                       objetSanction:
                    //                           currentSaction["libelle"] == null
                    //                               ? " "
                    //                               : currentSaction["libelle"],
                    //                       heureSanction: AppCubitStorage()
                    //                                   .state
                    //                                   .Language ==
                    //                               "fr"
                    //                           ? formatTimeToFrench(
                    //                               currentSaction["start_date"])
                    //                           : formatTimeToEnglish(
                    //                               currentSaction["start_date"]),
                    //                       dateSanction: AppCubitStorage()
                    //                                   .state
                    //                                   .Language ==
                    //                               "fr"
                    //                           ? formatDateToFrench(
                    //                               currentSaction["start_date"])
                    //                           : formatDateToEnglish(
                    //                               currentSaction["start_date"]),
                    //                       motifSanction: currentSaction["motif"],
                    //                       montantSanction:
                    //                           currentSaction["amount"].toString(),
                    //                       montantPayeeSanction:
                    //                           currentSaction["sanction_balance"],
                    //                       lienPaiement: currentSaction[
                    //                                   "sanction_pay_link"] ==
                    //                               null
                    //                           ? " "
                    //                           : currentSaction[
                    //                               "sanction_pay_link"],
                    //                       versement: currentSaction["versement"],
                    //                       isSanctionPayed:
                    //                           currentSaction["is_sanction_payed"],
                    //                       typeSaction: currentSaction["type"],
                    //                     ),
                    //                   );
                    //                 },
                    //               )
                    //             : Container(
                    //                 padding: EdgeInsets.only(top: 100),
                    //                 alignment: Alignment.topCenter,
                    //                 child: Text(
                    //                   "aucune_sanction".tr(),
                    //                   style: TextStyle(
                    //                     color: Color.fromRGBO(20, 45, 99, 0.26),
                    //                     fontWeight: FontWeight.w100,
                    //                     fontSize: 20,
                    //                   ),
                    //                 ),
                    //               ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        );
      });
    });
  }
}

class SliverTabBar extends SliverPersistentHeaderDelegate {
  const SliverTabBar({
    required this.minExtent,
    required this.maxExtent,
    required TabController tabController,
  }) : _tabController = tabController;

  @override
  final double minExtent;

  @override
  final double maxExtent;

  final TabController _tabController;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Future<void> handleAllUserGroup() async {
      final AllUserGroup =
          await context.read<UserGroupCubit>().AllUserGroupOfUserCubit();

      if (AllUserGroup != null) {
        print("1");

        // print(context.read<UserGroupCubit>().state.userGroup);
      } else {
        print("AllUserGroup null");
      }
    }

    Future handleChangeAss(codeAss) async {
      final allCotisationAss =
          await context.read<UserGroupCubit>().ChangeAssCubit(codeAss);

      if (allCotisationAss != null) {
        print("objec~~~~~~~~ttt  ${allCotisationAss}");
        print(
            "éé222sssssssssssssssssssssssssssssssssssssssssstttttttttttsssssss22~~~~~~~~");
      } else {
        print("userGroupDefault null");
      }
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: AppColors.whiteAccent,
          alignment: Alignment.center,

          child: Text(
            "Événements récents",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.blackBlue),
          ),
          // child: TabBar(
          //   isScrollable: true,
          //   labelColor: AppColors.blackBlue,
          //   labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          //   padding: EdgeInsets.all(0),
          //   unselectedLabelStyle: TextStyle(
          //     color: AppColors.blackBlueAccent1,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   indicator: UnderlineTabIndicator(
          //     borderSide: BorderSide(
          //       color: AppColors.blackBlue,
          //       width: 5.0,
          //     ),
          //     insets: EdgeInsets.symmetric(
          //       horizontal: 36.0,
          //     ),
          //   ),
          //   // indicatorWeight: 0,
          //   controller: _tabController,
          //   tabs: [
          //     Tab(
          //       text: "cotisations".tr(),
          //     ),
          //     // ),
          //     Tab(
          //       text: "sanctions".tr(),
          //     )
          //   ],
          // ),
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
    required this.matriculeRencontre,
    required this.nomRecepteurRencontre,
    required this.prenomRecepteurRencontre,
    required this.lieuRencontre,
    required this.dateRencontre,
    required this.heureRencontre,
    required this.photoProfilRecepteur,
    required this.codeSeance,
    required this.isActiveRencontre,
  });
  String nomRecepteurRencontre;
  String photoProfilRecepteur;

  String prenomRecepteurRencontre;
  String dateRencontre;

  String heureRencontre;

  String lieuRencontre;

  String matriculeRencontre;
  String codeSeance;
  int isActiveRencontre;

  @override
  final double minExtent;

  @override
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // return Container();
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          padding: EdgeInsets.only(left: 6, right: 6, bottom: 3, top: 3),
          margin: EdgeInsets.only(left: 8, right: 8, top: 7),
          decoration: BoxDecoration(
            // color: Colors.black87,
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: const Color.fromARGB(110, 117, 117, 117),
                  spreadRadius: 1,
                  blurRadius: 1)
            ],
          ),
          child: Container(
            // width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 7, left: 5, bottom: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "rencontre".tr(),
                          style: TextStyle(
                            color: AppColors.blackBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(244, 67, 54, 1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7, right: 7, top: 5),
                  child: WidgetRencontreCard(
                    codeSeance: codeSeance,
                    dateRencontre: AppCubitStorage().state.Language == "fr"
                        ? formatDateToFrench(dateRencontre)
                        : formatDateToEnglish(dateRencontre),
                    descriptionRencontre:
                        'La rencontres, se tiendra le ${AppCubitStorage().state.Language == "fr" ? formatDateToFrench(dateRencontre) : formatDateToEnglish(dateRencontre)} soyez donc present a ${heureRencontre}',
                    heureRencontre: heureRencontre,
                    identifiantRencontre: matriculeRencontre,
                    isActiveRencontre: isActiveRencontre,
                    lieuRencontre: lieuRencontre,
                    prenomRecepteurRencontre: prenomRecepteurRencontre,
                    nomRecepteurRencontre: nomRecepteurRencontre,
                    photoProfilRecepteur: photoProfilRecepteur,
                  ),
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
