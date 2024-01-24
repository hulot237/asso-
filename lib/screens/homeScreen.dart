import 'dart:async';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/business_logic/membres_cubit.dart';
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
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/checkInternetConnection.dart';
import 'package:faroty_association_1/pages/checkInternetConnectionPage.dart';
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
    handleAllUserGroup();
    handleTournoiDefault();
    handleRecentEvent(AppCubitStorage().state.membreCode);
    handleChangeAss(AppCubitStorage().state.codeAssDefaul);
    handleDetailUser(AppCubitStorage().state.membreCode);
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
    context.read<MembreCubit>().showMembersAss(AppCubitStorage().state.codeAssDefaul);

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

    return FutureBuilder<bool>(
        future: ConnectivityService.checkConnectivity(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                child: EasyLoader(
              backgroundColor: Color.fromARGB(0, 255, 255, 255),
              iconSize: 50,
              iconColor: AppColors.blackBlueAccent1,
              image: AssetImage(
                'assets/images/Groupe_ou_Asso.png',
              ),
            ));
          } else if (snapshot.hasError == snapshot.data) {
            return checkInternetConnectionPage();
          } else {
            return BlocBuilder<UserGroupCubit, UserGroupState>(
                builder: (UserGroupcontext, UserGroupstate) {
              print(
                  'UserGroupstate.ChangeAssData UserGroupstate.ChangeAssData ${UserGroupstate.ChangeAssData}');
              print(
                  'UserGroupstate.userGroup UserGroupstate.userGroup  ${UserGroupstate.userGroup}');
              if (UserGroupstate.isLoading == true &&
                  UserGroupstate.ChangeAssData == null &&
                  UserGroupstate.userGroup == null)
                return Container(
                  child: EasyLoader(
                    backgroundColor: Color.fromARGB(0, 255, 255, 255),
                    iconSize: 50,
                    iconColor: AppColors.blackBlueAccent1,
                    image: AssetImage(
                      'assets/images/Groupe_ou_Asso.png',
                    ),
                  ),
                );
              final DetailAss =
                  UserGroupcontext.read<UserGroupCubit>().state.ChangeAssData;
              return BlocBuilder<DetailTournoiCourantCubit,
                  DetailTournoiCourantState>(
                builder: (tournoisContext, tournoisState) {
                  if (tournoisState.isLoading == true &&
                      tournoisState.detailtournoiCourant == null)
                    return Container(
                      child: EasyLoader(
                        backgroundColor: Color.fromARGB(0, 255, 255, 255),
                        iconSize: 50,
                        iconColor: AppColors.blackBlueAccent1,
                        image: AssetImage(
                          'assets/images/Groupe_ou_Asso.png',
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
                            leading: Container(),
                            elevation: 0,
                            backgroundColor: AppColors.backgroundAppBAr,
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
                                              margin:
                                                  EdgeInsets.only(right: 13),
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
                                                  color: Color.fromARGB(
                                                      255, 255, 26, 9),
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
                                                        BorderRadius.circular(
                                                            50),
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
                                            color:
                                                Color.fromARGB(255, 255, 26, 9),
                                            borderRadius:
                                                BorderRadius.circular(50)),
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
                                    "${Variables.LienAIP}${DetailAss!["user_group"]["background_cover"] == null ? "" : DetailAss!["user_group"]["background_cover"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(62, 255, 255, 255),
                                        spreadRadius: 1,
                                        blurRadius: 15,
                                        offset: const Offset(5, 5),
                                      ),
                                      const BoxShadow(
                                          color:
                                              Color.fromARGB(4, 255, 255, 255),
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
                            if (currentDetailtournoiCourant["tournois"]
                                        ["seance"]
                                    .length >
                                0)
                              if (currentDetailtournoiCourant["tournois"]
                                      ["seance"][0]["status"] ==
                                  1)
                                SliverPersistentHeader(
                                  pinned: false,
                                  floating: false,
                                  delegate: FixedHeaderBar(
                                    dateRencontreAPI:
                                        currentDetailtournoiCourant["tournois"]
                                            ["seance"][0]["date_seance"],
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
                                            : currentDetailtournoiCourant[
                                                    "tournois"]["seance"][0]
                                                ["membre"]["first_name"],
                                    prenomRecepteurRencontre:
                                        currentDetailtournoiCourant["tournois"]
                                                        ["seance"][0]["membre"]
                                                    ["last_name"] ==
                                                null
                                            ? ""
                                            : currentDetailtournoiCourant[
                                                    "tournois"]["seance"][0]
                                                ["membre"]["last_name"],
                                    photoProfilRecepteur:
                                        currentDetailtournoiCourant["tournois"]
                                                        ["seance"][0]["membre"]
                                                    ["photo_profil"] ==
                                                null
                                            ? ""
                                            : currentDetailtournoiCourant[
                                                    "tournois"]["seance"][0]
                                                ["membre"]["photo_profil"],
                                    dateRencontre:
                                        currentDetailtournoiCourant["tournois"]
                                            ["seance"][0]["date_seance"],
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
                          SliverPersistentHeader(
                            pinned: true,
                            floating: false,
                            delegate: SliverTabBar(
                              maxExtent: 50,
                              minExtent: 50,
                            ),
                          ),
                          BlocBuilder<RecentEventCubit, RecentEventState>(
                            builder: (context, state) {
                              if (state.isLoading == true ||
                                  state.allRecentEvent == null)
                                return SliverToBoxAdapter(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                7),
                                    child: EasyLoader(
                                      backgroundColor:
                                          Color.fromARGB(0, 255, 255, 255),
                                      iconSize: 50,
                                      iconColor: AppColors.blackBlueAccent1,
                                      image: AssetImage(
                                        'assets/images/Groupe_ou_Asso.png',
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
                                  dateOpen: monObjet["start_date"],
                                  dateClose: monObjet["end_date"],
                                  montantCotisation: monObjet["amount"],
                                  montantCollecte:
                                      monObjet["cotisation_balance"],
                                  codeCotisation: monObjet["cotisation_code"],
                                  lienDePaiement:
                                      monObjet["cotisation_pay_link"],
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final itemEventRecent =
                                            listeWidgetFinale[index];
                                        return Container(
                                          margin: EdgeInsets.only(
                                            top: 7,
                                            left: 7,
                                            right: 7,
                                            bottom: 3,
                                          ),
                                          child: itemEventRecent,
                                        );
                                      },
                                    )
                                  : SliverToBoxAdapter(
                                      child: Container(
                                        color: AppColors.pageBackground,
                                        margin: EdgeInsets.only(top: 50),
                                        child: Center(
                                          child: Text(
                                            "Aucun_evenement_recent".tr(),
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  20, 45, 99, 0.26),
                                              fontWeight: FontWeight.w100,
                                              fontSize: 20,
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
                  );
                },
              );
            });
          }
        });
  }
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
          padding: EdgeInsets.only(left: 10),
          color: AppColors.whiteAccent,
          alignment: Alignment.centerLeft,
          child: Text(
            "Événements_récents".tr(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.blackBlueAccent1),
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
    required this.lieuRencontre,
    required this.dateRencontre,
    required this.heureRencontre,
    required this.photoProfilRecepteur,
    required this.codeSeance,
    required this.isActiveRencontre,
    required this.dateRencontreAPI,
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
  String dateRencontreAPI;

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
                      Container(),
                      Container(
                        child: Text(
                          "rencontre".tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.blackBlue),
                          // ),
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
                BlocBuilder<DetailTournoiCourantCubit,
                  DetailTournoiCourantState>(
                builder: (tournoisContext, tournoisState) {
                  if (tournoisState.isLoading == true ||
                      tournoisState.detailtournoiCourant == null)
                    return Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/13),
                      child: EasyLoader(
                        backgroundColor: Color.fromARGB(0, 255, 255, 255),
                        iconSize: 50,
                        iconColor: AppColors.blackBlueAccent1,
                        image: AssetImage(
                          'assets/images/Groupe_ou_Asso.png',
                        ),
                      ),
                    );
                    return Container(
                      margin: EdgeInsets.only(left: 7, right: 7, top: 5),
                      child: WidgetRencontreCard(
                        maskElt: true,
                        codeSeance: codeSeance,
                        dateRencontre: AppCubitStorage().state.Language == "fr"
                            ? formatDateToFrench(dateRencontre)
                            : formatDateToEnglish(dateRencontre),
                        descriptionRencontre:
                            '${'La rencontres, se tiendra le'.tr()} ${AppCubitStorage().state.Language == "fr" ? formatDateToFrench(dateRencontre) : formatDateToEnglish(dateRencontre)} ${"soyez donc present a".tr()} ${heureRencontre}',
                        heureRencontre: heureRencontre,
                        identifiantRencontre: matriculeRencontre,
                        isActiveRencontre: isActiveRencontre,
                        lieuRencontre: lieuRencontre,
                        prenomRecepteurRencontre: prenomRecepteurRencontre,
                        nomRecepteurRencontre: nomRecepteurRencontre,
                        photoProfilRecepteur: photoProfilRecepteur,
                        dateRencontreAPI: dateRencontreAPI,
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
