import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationExpireInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationExpireInProgress.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInProgress.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/WidgetSanctionNonPayeeIsOther.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionNonPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsOther.dart';
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

  Future<void> handleUserGroupDefault() async {
    final userGroupDefault =
        await context.read<UserGroupCubit>().UserGroupDefaultCubit();

    if (userGroupDefault != null) {
      // await AppCubitStorage().updateCodeAssDefaul(
      //     "${context.read<UserGroupCubit>().state.userGroupDefault!["urlcode"]}");
      for (var elt in context
          .read<UserGroupCubit>()
          .state
          .userGroupDefault!["tournois"]) {
        if (elt['is_default'] == 1) {
          print("okkkkkkkkkkkk ${elt["tournois_code"]}");

          // setState(() {

          await AppCubitStorage()
              .updateCodeTournoisDefault("${elt["tournois_code"]}");

          // });

          // AppCubitStorage().updateValeur1WithValA(elt['is_default'], "ournois_cod" );

          print(
            "TournoisCodeDefaultCubitStorage==   ${AppCubitStorage().state.codeTournois}",
          );
        }
      }

      // updateDataTournoisCodeDefaul
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleTournoiDefault() async {
    final detailTournoiCourant = await context
        .read<DetailTournoiCourantCubit>()
        .detailTournoiCourantCubit();

    if (detailTournoiCourant != null) {
      print(
          "objectdddddddddddddddddddddddddddddddddd  ${detailTournoiCourant}");
      print(
          "dddddddddddddddddddddddddddddddddddddddd ${context.read<DetailTournoiCourantCubit>().state.detailtournoiCourant}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllCotisationAss(codeAssociation) async {
    final allCotisationAss = await context
        .read<CotisationCubit>()
        .AllCotisationAssCubit(codeAssociation);

    if (allCotisationAss != null) {
      print("objec~~~~~~~~ttt  ${allCotisationAss}");
      print(
          "éé22222~~~~~~~~  ${context.read<CotisationCubit>().state.allCotisationAss}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleDetailUser(userCode) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode);

    if (allCotisationAss != null) {
      print("objec===============ttt  ${allCotisationAss}");
      print(
          "éé22===========[[[[[[[[[[[[[[[[[[[[[[[[[[[[[([[[[|||````]]]])]]]]]]]]]]]]]]]]]]]]]]]]]]]]]===222  ${context.read<AuthCubit>().state.detailUser}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllCompteAss(codeAssociation) async {
    final allCotisationAss =
        await context.read<CompteCubit>().AllCompteAssCubit(codeAssociation);

    if (allCotisationAss != null) {
      print("obj}===}}}}ttt  ${allCotisationAss}");
      print(
          "éé22222~===}}}}}}}}}}  ${context.read<CompteCubit>().state.allCompteAss}");
    } else {
      print("userGroupDefault null");
    }
  }

  // Map<String, dynamic>? get currentInfoAssociationCourant {
  //   return context.read<UserGroupCubit>().state.userGroupDefault;
  // }

  Map<String, dynamic>? get currentDetailtournoiCourant {
    return context.read<DetailTournoiCourantCubit>().state.detailtournoiCourant;
  }

  @override
  void initState() {
    // TODO: implement initState
    handleUserGroupDefault();
    handleAllUserGroup();
    handleTournoiDefault();
    handleAllCotisationAss(AppCubitStorage().state.codeAssDefaul);
    handleDetailUser(Variables().codeMembre);
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);

    super.initState();
  }

  Map<String, dynamic>? get currentInfoAssociationCourant {
    return context.read<UserGroupCubit>().state.userGroupDefault;
  }

  var Tab = [true, false, false, true, false, true, 'expi', 'expi'];

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    // final currentInfoAssociationCourant =
    //     context.read<UserGroupCubit>().state.userGroupDefault;

    return BlocBuilder<AuthCubit, AuthState>(builder: (authContext, authState) {
      final currentDetailUser = context.read<AuthCubit>().state.detailUser;
      return BlocBuilder<DetailTournoiCourantCubit, DetailTournoiCourantState>(
          builder: (tournoisContext, tournoisState) {
        if (authState.loginInfo == null ||
            authState.detailUser == null ||
            tournoisState.detailtournoiCourant == null) return Container();
        return BlocBuilder<CotisationCubit, CotisationState>(
            builder: (cotisationContext, CotisationState) {
          if (CotisationState.allCotisationAss == null) return Container();
          final currentAllCotisationAss =
              context.read<CotisationCubit>().state.allCotisationAss;
          return BlocBuilder<UserGroupCubit, UserGroupState>(
            builder: (context, state) {
              if (state.userGroup == null || state.userGroupDefault == null)
                return Container();
              return Scaffold(
                backgroundColor: Color(0xFFEFEFEF),
                body: CustomScrollView(
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
                                          "${currentInfoAssociationCourant!["name"]}",
                                          // "dd",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
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
                                              "${Variables.LienAIP}${currentInfoAssociationCourant!['profile_photo'] == null ? "" : currentInfoAssociationCourant!['profile_photo']}",
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
                            child: Image.network(
                              "https://img.freepik.com/premium-vector/lamp-icon-idea-concept-large-group-people-form-create-shape-lamp-vector-illustration_191567-1626.jpg?size=626&ext=jpg&ga=GA1.1.852592464.1694512378&semt=ais",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(85, 255, 255, 255),
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
                    if (currentDetailtournoiCourant!["tournois"]["seance"]
                            .length >
                        0)
                      for (var itemSeance
                          in currentDetailtournoiCourant!["tournois"]["seance"])
                        if (itemSeance["status"] == 1)
                          SliverPersistentHeader(
                            pinned: false,
                            floating: false,
                            delegate: FixedHeaderBar(
                              isActiveRencontre: itemSeance["status"],
                              codeSeance: itemSeance["seance_code"],
                              matriculeRencontre: itemSeance["matricule"],
                              nomRecepteurRencontre:
                                  itemSeance["membre"]["first_name"] == null
                                      ? ""
                                      : itemSeance["membre"]["first_name"],
                              prenomRecepteurRencontre:
                                  itemSeance["membre"]["last_name"] == null
                                      ? ""
                                      : itemSeance["membre"]["last_name"],
                              photoProfilRecepteur:
                                  itemSeance["membre"]["photo_profil"] == null
                                      ? ""
                                      : itemSeance["membre"]["photo_profil"],
                              dateRencontre: itemSeance["date_seance"],
                              // descriptionRencontre: itemSeance["zzzzzzzzzzzzzzz"],
                              heureRencontre: itemSeance["heure_debut"],
                              lieuRencontre: itemSeance["localisation"],
                              maxExtent: 210,
                              minExtent: 210,
                            ),
                          ),
                    SliverPersistentHeader(
                      pinned: true,
                      floating: false,
                      delegate: SliverTabBar(
                        tabController: _tabController,
                        maxExtent: 50,
                        minExtent: 50,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 2,
                        margin: EdgeInsets.all(5),
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            currentAllCotisationAss!.length > 0
                                ? ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    itemCount: currentAllCotisationAss!.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final currentDetail =
                                          currentAllCotisationAss[index];
                                      print(
                                          "^^^^^^^^^^^^^^^^^^^^^^^^ ${currentDetail}");

                                      print(
                                          " is_tontineis_tontineis_tontineis_tontineis_tontine            ${currentDetail["is_tontine"]}");
                                      print(
                                          " typetypetypetypetype            ${currentDetail["type"]}");
                                      print(
                                          " is_passedis_passedis_passedis_passedis_passed            ${currentDetail["is_passed"]}");

                                      if (currentDetail["is_tontine"] == 0 &&
                                          currentDetail["type"] == "0" &&
                                          currentDetail["is_passed"] == 0) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 7,
                                              right: 7,
                                              top: 3,
                                              bottom: 7),
                                          child: WidgetCotisationInFixed(
                                            contributionOneUser: '2000',
                                            codeCotisation: currentDetail[
                                                "cotisation_code"],
                                            heureCotisation: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatTimeToFrench(
                                                    currentDetail["start_date"])
                                                : formatTimeToEnglish(
                                                    currentDetail[
                                                        "start_date"]),

                                            dateCotisation: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatDateToFrench(
                                                    currentDetail["start_date"])
                                                : formatDateToEnglish(
                                                    currentDetail[
                                                        "start_date"]),
                                            montantCotisations:
                                                currentDetail["amount"],
                                            motifCotisations:
                                                currentDetail["name"],
                                            nbreParticipant: 5,
                                            soldeCotisation: currentDetail[
                                                "cotisation_balance"],
                                            nbreParticipantCotisationOK: 4,
                                            type: currentDetail["type"],

                                            // montantSanctionCollectee: currentDetail["amount_sanction"],
                                            isActive: 1,
                                          ),
                                        );
                                      } else if (currentDetail["is_tontine"] ==
                                              0 &&
                                          currentDetail["type"] == "1" &&
                                          currentDetail["is_passed"] == 0) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 7,
                                              right: 7,
                                              top: 3,
                                              bottom: 7),
                                          child: WidgetCotisationInProgress(
                                            codeCotisation: currentDetail[
                                                "cotisation_code"],
                                            contributionOneUser: '2000',
                                            heureCotisation: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatTimeToFrench(
                                                    currentDetail["start_date"])
                                                : formatTimeToEnglish(
                                                    currentDetail[
                                                        "start_date"]),
                                            dateCotisation: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatDateToFrench(
                                                    currentDetail["start_date"])
                                                : formatDateToEnglish(
                                                    currentDetail[
                                                        "start_date"]),
                                            montantCotisations:
                                                currentDetail["amount"],
                                            motifCotisations:
                                                currentDetail["name"],
                                            nbreParticipant: 24,
                                            soldeCotisation: currentDetail[
                                                "cotisation_balance"],
                                            nbreParticipantCotisationOK: 7,
                                            montantSanctionCollectee: '1500',
                                            isActive: 1,
                                            montantMin: "200",
                                            type: currentDetail["type"],
                                          ),
                                        );
                                      } else if (currentDetail["is_tontine"] ==
                                              0 &&
                                          currentDetail["type"] == "0" &&
                                          currentDetail["is_passed"] == 1) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 7,
                                              right: 7,
                                              top: 3,
                                              bottom: 7),
                                          child: WidgetCotisationExpireInFixed(
                                            codeCotisation: currentDetail[
                                                "cotisation_code"],
                                            contributionOneUser: '1500',
                                            motifCotisations:
                                                currentDetail["name"],
                                            dateCotisation: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatDateToFrench(
                                                    currentDetail["start_date"])
                                                : formatDateToEnglish(
                                                    currentDetail[
                                                        "start_date"]),
                                            montantCotisations:
                                                currentDetail["amount"],
                                            heureCotisation: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatTimeToFrench(
                                                    currentDetail["start_date"])
                                                : formatTimeToEnglish(
                                                    currentDetail[
                                                        "start_date"]),
                                            // montantSanctionCollectee: '1500',
                                            nbreParticipantCotisationOK: 10,
                                            nbreParticipant: 12,
                                            soldeCotisation: currentDetail[
                                                "cotisation_balance"],
                                            isActive: 0,
                                            type: currentDetail["type"],
                                          ),
                                        );
                                      } else if (currentDetail["is_tontine"] ==
                                              0 &&
                                          currentDetail["type"] == "1" &&
                                          currentDetail["is_passed"] == 1) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 7,
                                              right: 7,
                                              top: 3,
                                              bottom: 7),
                                          child:
                                              WidgetCotisationExpireInProgress(
                                            contributionOneUser: '1500',
                                            motifCotisations:
                                                currentDetail["name"],
                                            dateCotisation: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatDateToFrench(
                                                    currentDetail["start_date"])
                                                : formatDateToEnglish(
                                                    currentDetail[
                                                        "start_date"]),
                                            montantCotisations:
                                                currentDetail["amount"],
                                            heureCotisation: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatTimeToFrench(
                                                    currentDetail["start_date"])
                                                : formatTimeToEnglish(
                                                    currentDetail[
                                                        "start_date"]),
                                            // montantSanctionCollectee: currentDetail["amount_sanction"] ,
                                            nbreParticipantCotisationOK: 10,
                                            nbreParticipant: 12,
                                            soldeCotisation: currentDetail[
                                                "cotisation_balance"],
                                            isActive: 0,
                                            codeCotisation: currentDetail[
                                                "cotisation_code"],
                                            type: currentDetail["type"],
                                          ),
                                        );
                                      }
                                    },
                                  )
                                : Container(
                                    padding: EdgeInsets.only(top: 100),
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "Vous n'avez pas de cotisation",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(20, 45, 99, 0.26),
                                          fontWeight: FontWeight.w100,
                                          fontSize: 20),
                                    ),
                                  ),
                            currentDetailUser!["sanctions"].length > 0
                                ?
                                // if(false)
                                ListView.builder(
                                    // shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),

                                    padding: EdgeInsets.all(0),
                                    itemCount:
                                        currentDetailUser!["sanctions"].length,
                                    itemBuilder: (context, index) {
                                      final ItemDetailUserSanction =
                                          currentDetailUser["sanctions"][index];

                                      print(
                                          "################ ${ItemDetailUserSanction}");

                                      if (ItemDetailUserSanction["type"] ==
                                              "1" &&
                                          ItemDetailUserSanction[
                                                  "is_sanction_payed"] ==
                                              0) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 7,
                                              right: 7,
                                              top: 3,
                                              bottom: 7),
                                          child: WidgetSanctionNonPayeeIsMoney(
                                            versement: ItemDetailUserSanction[
                                                "versement"],
                                            dateSanction: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatDateToFrench(
                                                    ItemDetailUserSanction[
                                                        "start_date"])
                                                : formatDateToEnglish(
                                                    ItemDetailUserSanction[
                                                        "start_date"]),
                                            heureSanction: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatTimeToFrench(
                                                    ItemDetailUserSanction[
                                                        "start_date"])
                                                : formatTimeToEnglish(
                                                    ItemDetailUserSanction[
                                                        "start_date"]),
                                            montantPayeeSanction:
                                                ItemDetailUserSanction[
                                                    "sanction_balance"],
                                            montantSanction:
                                                ItemDetailUserSanction["amount"]
                                                    .toString(),
                                            motifSanction:
                                                ItemDetailUserSanction["motif"],
                                            lienPaiement: ItemDetailUserSanction[
                                                        "sanction_pay_link"] ==
                                                    null
                                                ? " "
                                                : ItemDetailUserSanction[
                                                    "sanction_pay_link"],
                                          ),
                                        );
                                      } else if (ItemDetailUserSanction[
                                                  "type"] ==
                                              "0" &&
                                          ItemDetailUserSanction[
                                                  "is_sanction_payed"] ==
                                              0) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 7,
                                              right: 7,
                                              top: 3,
                                              bottom: 7),
                                          child: WidgetSanctionNonPayeeIsOther(
                                            dateSanction: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatDateToFrench(
                                                    ItemDetailUserSanction[
                                                        "start_date"])
                                                : formatDateToEnglish(
                                                    ItemDetailUserSanction[
                                                        "start_date"]),
                                            heureSanction: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatTimeToFrench(
                                                    ItemDetailUserSanction[
                                                        "start_date"])
                                                : formatTimeToEnglish(
                                                    ItemDetailUserSanction[
                                                        "start_date"]),
                                            objetSanction:
                                                ItemDetailUserSanction[
                                                    "libelle"],
                                            motifSanction:
                                                ItemDetailUserSanction["motif"],
                                          ),
                                        );
                                      } else if (ItemDetailUserSanction[
                                                  "type"] ==
                                              "1" &&
                                          ItemDetailUserSanction[
                                                  "is_sanction_payed"] ==
                                              1) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 7,
                                              right: 7,
                                              top: 3,
                                              bottom: 7),
                                          child: WidgetSanctionPayeeIsMoney(
                                            versement: ItemDetailUserSanction[
                                                "versement"],
                                            dateSanction: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatDateToFrench(
                                                    ItemDetailUserSanction[
                                                        "start_date"])
                                                : formatDateToEnglish(
                                                    ItemDetailUserSanction[
                                                        "start_date"]),
                                            heureSanction: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatTimeToFrench(
                                                    ItemDetailUserSanction[
                                                        "start_date"])
                                                : formatTimeToEnglish(
                                                    ItemDetailUserSanction[
                                                        "start_date"]),
                                            montantPayeeSanction:
                                                ItemDetailUserSanction[
                                                    "sanction_balance"],
                                            montantSanction:
                                                ItemDetailUserSanction["amount"]
                                                    .toString(),
                                            motifSanction:
                                                ItemDetailUserSanction["motif"],
                                          ),
                                        );
                                      } else if (ItemDetailUserSanction[
                                                  "type"] ==
                                              "0" &&
                                          ItemDetailUserSanction[
                                                  "is_sanction_payed"] ==
                                              1) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 7,
                                              right: 7,
                                              top: 3,
                                              bottom: 7),
                                          child: WidgetSanctionPayeeIsOther(
                                            dateSanction: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatDateToFrench(
                                                    ItemDetailUserSanction[
                                                        "start_date"])
                                                : formatDateToEnglish(
                                                    ItemDetailUserSanction[
                                                        "start_date"]),
                                            heureSanction: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatTimeToFrench(
                                                    ItemDetailUserSanction[
                                                        "start_date"])
                                                : formatTimeToEnglish(
                                                    ItemDetailUserSanction[
                                                        "start_date"]),
                                            motifSanction:
                                                ItemDetailUserSanction["motif"],
                                            objetSanction:
                                                ItemDetailUserSanction[
                                                    "libelle"],
                                          ),
                                        );
                                      }
                                    },
                                  )
                                : Container(
                                    padding: EdgeInsets.only(top: 100),
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "Vous n'avez pas de sanction",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(20, 45, 99, 0.26),
                                          fontWeight: FontWeight.w100,
                                          fontSize: 20),
                                    ),
                                  ),
                            //  Text("2"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
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
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Color.fromARGB(120, 226, 226, 226),
          alignment: Alignment.center,
          child: TabBar(
            isScrollable: true,
            labelColor: Color.fromARGB(255, 20, 45, 99),
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            padding: EdgeInsets.all(0),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 20, 45, 99),
                width: 5.0,
              ),
              insets: EdgeInsets.symmetric(horizontal: 36.0),
            ),
            // indicatorWeight: 0,
            controller: _tabController,
            tabs: [
              Tab(
                text: "Cotisations",
              ),
              Tab(
                text: "Sanctions",
              )
            ],
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

class FixedHeaderBar extends SliverPersistentHeaderDelegate {
  FixedHeaderBar({
    required this.minExtent,
    required this.maxExtent,
    required this.matriculeRencontre,
    required this.nomRecepteurRencontre,
    required this.prenomRecepteurRencontre,
    // required this.descriptionRencontre,
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

  // String descriptionRencontre;

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
          margin: EdgeInsets.only(left: 8, right: 8, top: 7),
          padding: EdgeInsets.only(left: 6, right: 6, bottom: 3, top: 3),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: const Color.fromARGB(110, 117, 117, 117),
                  spreadRadius: 1,
                  blurRadius: 1)
            ],
          ),
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
                          color: const Color.fromRGBO(20, 45, 99, 1),
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
                      'Jeudi se tiendra notre 3 rencontres, soyez donc present a 10h10',
                  heureRencontre: heureRencontre,
                  identifiantRencontre: matriculeRencontre,
                  isActiveRencontre: isActiveRencontre,
                  lieuRencontre: lieuRencontre,
                  prenomRecepteurRencontre: prenomRecepteurRencontre,
                  nomRecepteurRencontre: nomRecepteurRencontre,
                  photoProfilRecepteur: photoProfilRecepteur,
                ),
              ),
              // Container(
              //   alignment: Alignment.bottomCenter,
              //   // height: 22,
              //   margin: EdgeInsets.only(left: 5, top: 7),
              //   child: Row(
              //     // crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       // Container(
              //       //   child: Text(
              //       //     "Voir les details de la Rencontre",
              //       //     style: TextStyle(
              //       //       color: Color.fromARGB(164, 20, 45, 99),
              //       //       fontWeight: FontWeight.w500,
              //       //       fontSize: 11,
              //       //       letterSpacing: 0.2,
              //       //     ),
              //       //   ),
              //       // ),
              //       Container(
              //         child: Icon(
              //           Icons.keyboard_double_arrow_right_rounded,
              //           size: 12,
              //           color: Color.fromARGB(164, 20, 45, 99),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
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
