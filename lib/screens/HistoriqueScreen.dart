import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotistion.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanction.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetTontineHistoriqueCard.dart';
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
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/screens/detailTontinePage.dart';
import 'package:faroty_association_1/pages/homePage.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/presentation/widgets/widgetCompteCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          style: TextStyle(fontSize: 16, color: AppColors.white),
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
        style: TextStyle(fontSize: 16, color: AppColors.white),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: AppColors.white),
      ),
      actions: [widgetAction],
    ),
    body: child,
  );
}

class _HistoriqueScreenState extends State<HistoriqueScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _dataLoaded = false;

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

  Future<void> handleAllCompteAss(codeAssociation) async {
    final allCotisationAss =
        await context.read<CompteCubit>().AllCompteAssCubit(codeAssociation);

    if (allCotisationAss != null) {
      print("obj}===}}}}ttt  ${allCotisationAss}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllSeanceAss(codeAssociation) async {
    final allSeanceAss =
        await context.read<SeanceCubit>().AllAssSeanceCubit(codeAssociation);

    if (allSeanceAss != null) {
      print("ààààààààààààààààààààààààààààààààààà  ${allSeanceAss}");
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
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleDetailTontine(codeTournoi, codeTontine) async {
    final detailTontine = await context
        .read<TontineCubit>()
        .detailTontineCubit(codeTournoi, codeTontine);

    if (detailTontine != null) {
      print("objaaaaaaaaaaaaaaaaaa  ${detailTontine}");
      print(
          "aaaaaaaaaaaaaaaaaaaaaqqqqq  ${context.read<TontineCubit>().state.detailTontine}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllUserGroup() async {
    final AllUserGroup =
        await context.read<UserGroupCubit>().AllUserGroupOfUserCubit();

    if (AllUserGroup != null) {
      print("1");
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

    Future<void> handleDetailUser(userCode) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode);

    if (allCotisationAss != null) {
      print("handleDetailUser");
    } else {
      print("handleDetailUser null");
    }
  }

  Future refresh() async {
    handleTournoiDefault();
    // handleAllUserGroup();
    handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournois);
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
    handleAllSeanceAss(AppCubitStorage().state.codeAssDefaul);
    handleDetailUser(AppCubitStorage().state.membreCode);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    handleTournoiDefault();
    // handleAllUserGroup();
    handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournois);
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
    handleAllSeanceAss(AppCubitStorage().state.codeAssDefaul);
    // handleChangeAss(AppCubitStorage().state.codeAssDefaul);

    _tabController = TabController(length: 0, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 0) {
          print("0");
          handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
          // handleTournoiDefault();
          // handleAllSeanceAss(AppCubitStorage().state.codeAssDefaul);
        } else if (_tabController.index == 1) {
          print("1");
          refresh();
          // handleAllSeanceAss(AppCubitStorage().state.codeAssDefaul);
          // handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournois);
        } else if (_tabController.index == 2) {
          print("2");
          refresh();
          // handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournois);
        } else if (_tabController.index == 3) {
          print("3");
          refresh();
          // handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournois);
          // handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
        } else if (_tabController.index == 4) {
          print("4");
          refresh();
          // handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
          // handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournois);
        }
      }
    });
  }

  List<Color> listeDeCouleurs = [
    Colors.red, // Rouge
    Colors.blue, // Bleu
    AppColors.green, // Vert
    Colors.brown, // Jaune
    Colors.purple, // Violet
  ];

  // Map<String, dynamic>? get currentAssCourant {
  //   return context.read<UserGroupCubit>().state.ChangeAssData;
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserGroupCubit, UserGroupState>(
      builder: (UserGroupContext, UserGroupState) {
        if (UserGroupState.isLoading == null ||
            UserGroupState.isLoading == true ||
            UserGroupState.ChangeAssData == null)
          return Container(
            color: AppColors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.bleuLight,
              ),
            ),
          );
        _dataLoaded = true;
        final currentAssCourant =
            context.read<UserGroupCubit>().state.ChangeAssData;
        _tabController = TabController(
          length: currentAssCourant!['user_group']['is_tontine'] == true ||
                  !checkTransparenceStatus(
                    context
                        .read<UserGroupCubit>()
                        .state
                        .ChangeAssData!["user_group"]["configs"],
                    context.read<AuthCubit>().state.detailUser!["isMember"],
                  )
              ? 5
              : 4,
          vsync: this,
        );

        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(),
              ),
              (route) => false,
            );
            return false;
          },
          child: Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: AppBar(
              title: Text(
                "historiques".tr(),
                style: TextStyle(fontSize: 16, color: AppColors.white),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Modal().showBottomSheetListAss(
                      context,
                      context.read<UserGroupCubit>().state.userGroup,
                    );
                  },
                  child: Container(
                    // color: Colors.black45,
                    // width: 70,
                    child: Container(
                      margin: EdgeInsets.all(15),

                      width: 25,
                      // height: 15,
                      decoration: BoxDecoration(
                        // color: Colors.grey,
                        border: Border.all(
                          color: Color.fromARGB(255, 255, 26, 9),
                        ),
                        borderRadius: BorderRadius.circular(360),
                      ),
                      padding: EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(360),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                          ),
                          child: Image.network(
                            "${Variables.LienAIP}${context.read<UserGroupCubit>().state.ChangeAssData!["user_group"]["profile_photo"] == null ? "" : context.read<UserGroupCubit>().state.ChangeAssData!["user_group"]["profile_photo"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              elevation: 0,
              backgroundColor: AppColors.backgroundAppBAr,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(),
                    ),
                    (route) => false,
                  );
                },
                child: Icon(Icons.arrow_back, color: AppColors.white),
              ),
              bottom: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: AppColors.white,
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  padding: EdgeInsets.all(0),
                  unselectedLabelStyle: TextStyle(
                    color: AppColors.whiteAccent1,
                    fontWeight: FontWeight.bold,
                  ),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: AppColors.white,
                      width: 5.0,
                    ),
                    insets: EdgeInsets.symmetric(
                      horizontal: 36.0,
                    ),
                  ),
                  indicatorWeight: 0,
                  tabs: [
                    Tab(
                      text: "rencontres".tr(),
                    ),
                    if (currentAssCourant!['user_group']['is_tontine'] == true)
                      Tab(
                        text: "Tontines",
                      ),
                    Tab(
                      text: "cotisations".tr(),
                    ),
                    Tab(
                      text: "Sanctions",
                    ),
                    if (checkTransparenceStatus(
                        context
                            .read<UserGroupCubit>()
                            .state
                            .ChangeAssData!["user_group"]["configs"],
                        context
                            .read<AuthCubit>()
                            .state
                            .detailUser!["isMember"]))
                      Tab(
                        text: "comptes".tr(),
                      ),
                  ]),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 1.5,
                    left: 1.5,
                    // bottom: 10,
                    right: 1.5,
                  ),
                  width: MediaQuery.of(context).size.width,
                  // decoration: BoxDecoration(
                  //   color: Color.fromARGB(255, 226, 226, 226),
                  // ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10, left: 5, bottom: 15),
                        child: Text(
                          "toutes_les_rencontres".tr(),
                          style: TextStyle(
                            color: AppColors.blackBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      BlocBuilder<DetailTournoiCourantCubit,
                              DetailTournoiCourantState>(
                          builder: (DetailTournoiContext, DetailTournoiState) {
                        if (DetailTournoiState.isLoading == null ||
                            DetailTournoiState.isLoading == true ||
                            DetailTournoiState.detailtournoiCourant == null)
                          return Container(
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
                        return currentDetailtournoiCourant!["tournois"]
                                        ["seance"]!
                                    .length >
                                0
                            ? Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: RefreshIndicator(
                                    onRefresh: refresh,
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      itemCount: currentDetailtournoiCourant[
                                              "tournois"]["seance"]
                                          .length,
                                      itemBuilder: (context, index) {
                                        final itemSeance =
                                            currentDetailtournoiCourant[
                                                "tournois"]["seance"][index];

                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 7,
                                              right: 7,
                                              top: 3,
                                              bottom: 7),
                                          child: WidgetRencontreCard(
                                            codeSeance:
                                                itemSeance["seance_code"],
                                            photoProfilRecepteur: "",
                                            dateRencontre: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatDateToFrench(
                                                    itemSeance["date_seance"])
                                                : formatDateToEnglish(
                                                    itemSeance["date_seance"]),
                                            descriptionRencontre:
                                                'Le rencontre du ${AppCubitStorage().state.Language == "fr" ? formatDateToFrench(itemSeance["date_seance"]) : formatDateToEnglish(itemSeance["date_seance"])} se tiendra à ${itemSeance["heure_debut"]}',
                                            heureRencontre:
                                                itemSeance["heure_debut"],
                                            identifiantRencontre:
                                                itemSeance["matricule"],
                                            lieuRencontre:
                                                itemSeance["localisation"],
                                            nomRecepteurRencontre:
                                                itemSeance["membre"]
                                                            ["first_name"] ==
                                                        null
                                                    ? ""
                                                    : itemSeance["membre"]
                                                        ["first_name"],
                                            isActiveRencontre:
                                                itemSeance["status"],
                                            prenomRecepteurRencontre:
                                                itemSeance["membre"]
                                                            ["last_name"] ==
                                                        null
                                                    ? ""
                                                    : itemSeance["membre"]
                                                        ["last_name"],
                                            dateRencontreAPI:
                                                itemSeance["date_seance"],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: RefreshIndicator(
                                  onRefresh: refresh,
                                  child: ListView.builder(
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          padding: EdgeInsets.only(top: 200),
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            "aucune_rencontre".tr(),
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    20, 45, 99, 0.26),
                                                fontWeight: FontWeight.w100,
                                                fontSize: 20),
                                          ),
                                        );
                                      }),
                                ),
                              );
                      }),
                    ],
                  ),
                ),
                if (currentAssCourant!['user_group']['is_tontine'] == true)
                  Container(
                    padding: EdgeInsets.only(
                      top: 1.5,
                      left: 1.5,
                      right: 1.5,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.only(top: 10, left: 5, bottom: 15),
                          child: Text(
                            "Toutes vos tontines",
                            style: TextStyle(
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 0.2),
                          ),
                        ),
                        BlocBuilder<DetailTournoiCourantCubit,
                                DetailTournoiCourantState>(
                            builder:
                                (DetailTournoiContext, DetailTournoiState) {
                          if (DetailTournoiState.isLoading == null ||
                              DetailTournoiState.isLoading == true ||
                              DetailTournoiState.detailtournoiCourant == null)
                            return Container(
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

                          List<dynamic> listeTontines =
                              currentDetailtournoiCourant!["tontines"];

                          List<dynamic> tontinesMembreConnect = [];

                          for (var tontine in listeTontines) {
                            for (var item in tontine["membres"]) {
                              if (item["membre"]["membre_code"] ==
                                  AppCubitStorage().state.membreCode) {
                                tontinesMembreConnect.add(tontine);
                                break;
                              }
                            }
                          }
                          return tontinesMembreConnect.length > 0
                              ? Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RefreshIndicator(
                                      onRefresh: refresh,
                                      child: ListView.builder(
                                        padding: EdgeInsets.all(0),
                                        shrinkWrap: true,
                                        itemCount: tontinesMembreConnect.length,
                                        itemBuilder: (context, index) {
                                          print(tontinesMembreConnect);
                                          final itemTontine =
                                              tontinesMembreConnect[index];
                                          return GestureDetector(
                                            onTap: () {
                                              handleDetailTontine(
                                                  AppCubitStorage()
                                                      .state
                                                      .codeTournois,
                                                  itemTontine["tontine_code"]);

                                              print(
                                                  "${itemTontine["tontine_code"]}");
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailTontinePage(
                                                    isActive: itemTontine[
                                                        "is_active"],
                                                    dateCreaTontine: 
                                                            itemTontine[
                                                                "created_at"],
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
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 7,
                                                  right: 7,
                                                  top: 3,
                                                  bottom: 7),
                                              child:
                                                  widgetTontineHistoriqueCard(
                                                isActive:
                                                    itemTontine["is_active"],
                                                dateCreaTontine:itemTontine[
                                                                "created_at"],
                                                nomTontine:
                                                    "${itemTontine["libele"]}",
                                                montantTontine:
                                                    "${itemTontine["amount"]}",
                                                positionBeneficiaire: "0",
                                                nbrMembreTontine:
                                                    "${itemTontine["membres"].length}",
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: refresh,
                                    child: ListView.builder(
                                        itemCount: 1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            padding: EdgeInsets.only(top: 200),
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              "Aucune tontine",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      20, 45, 99, 0.26),
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 20),
                                            ),
                                          );
                                        }),
                                  ),
                                );
                        }),
                      ],
                    ),
                  ),
                Container(
                  padding: EdgeInsets.only(
                    top: 1.5,
                    left: 1.5,
                    right: 1.5,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10, left: 5, bottom: 15),
                        child: Text(
                          "toutes_vos_cotisations".tr(),
                          style: TextStyle(
                              color: AppColors.blackBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 0.2),
                        ),
                      ),
                      // if (currentAllCotisationAssTournoi != null)
                      BlocBuilder<CotisationCubit, CotisationState>(
                        builder: (CotisationContext, CotisationState) {
                          if (CotisationState.isLoading == null ||
                              CotisationState.isLoading == true ||
                              CotisationState.allCotisationAss == null)
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.bleuLight,
                                ),
                              ),
                            );
                          final currentAllCotisationAssTournoi = context
                              .read<CotisationCubit>()
                              .state
                              .allCotisationAss;

                          List<dynamic> objetCotisationUniquement =
                              currentAllCotisationAssTournoi!
                                  .where((objet) => objet["is_tontine"] == 0)
                                  .toList();

                          return objetCotisationUniquement.length > 0
                              ? Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: refresh,
                                    child: ListView.builder(
                                      itemCount:
                                          objetCotisationUniquement.length,
                                      // physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(0),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final ItemDetailCotisation =
                                            objetCotisationUniquement[index];
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 7,
                                              right: 7,
                                              top: 3,
                                              bottom: 7),
                                          child: WidgetCotisation(
                                            montantCotisations:
                                                ItemDetailCotisation["amount"],
                                            motifCotisations:
                                                ItemDetailCotisation["name"],
                                            dateCotisation: ItemDetailCotisation[
                                                        "start_date"],
                                            heureCotisation: AppCubitStorage()
                                                        .state
                                                        .Language ==
                                                    "fr"
                                                ? formatTimeToFrench(
                                                    ItemDetailCotisation[
                                                        "start_date"])
                                                : formatTimeToEnglish(
                                                    ItemDetailCotisation[
                                                        "start_date"]),
                                            soldeCotisation:
                                                ItemDetailCotisation[
                                                    "cotisation_balance"],
                                            codeCotisation:
                                                ItemDetailCotisation[
                                                    "cotisation_code"],
                                            type: ItemDetailCotisation["type"],
                                            lienDePaiement: ItemDetailCotisation[
                                                        "cotisation_pay_link"] ==
                                                    null
                                                ? "le lien n'a pas été généré"
                                                : ItemDetailCotisation[
                                                    "cotisation_pay_link"],
                                            is_passed: ItemDetailCotisation[
                                                "is_passed"],
                                            is_tontine: ItemDetailCotisation[
                                                "is_tontine"],
                                                                                      source: ItemDetailCotisation["seance"]==null? '' : '${'rencontre'.tr()} ${ItemDetailCotisation["seance"]["matricule"]}',
                                      nomBeneficiaire: ItemDetailCotisation["membre"]==null? '' : ItemDetailCotisation["membre"]["last_name"]==null? "${ItemDetailCotisation["membre"]["first_name"]}":"${ItemDetailCotisation["membre"]["first_name"]} ${ItemDetailCotisation["membre"]["last_name"]}",
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: refresh,
                                    child: ListView.builder(
                                        itemCount: 1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            padding: EdgeInsets.only(top: 200),
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              "aucune_cotisation".tr(),
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      20, 45, 99, 0.26),
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 20),
                                            ),
                                          );
                                        }),
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 1.5, left: 1.5, right: 1.5),
                  width: MediaQuery.of(context).size.width,
                  // decoration:
                  //     BoxDecoration(color: Color.fromARGB(255, 203, 45, 45)),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10, left: 5, bottom: 15),
                        child: Text(
                          "toutes_vos_sanctions".tr(),
                          style: TextStyle(
                              color: AppColors.blackBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 0.2),
                        ),
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (AuthContext, AuthState) {
                          if (AuthState.isLoading == null ||
                              AuthState.isLoading == true ||
                              AuthState.detailUser == null)
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.bleuLight,
                                ),
                              ),
                            );
                          final currentDetailUser =
                              context.read<AuthCubit>().state.detailUser;
 
                          return currentDetailUser!["sanctions"].length > 0
                              ? Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RefreshIndicator(
                                      onRefresh: refresh,
                                      child: ListView.builder(
                                        itemCount:
                                            currentDetailUser["sanctions"]
                                                .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final currentSaction =
                                              currentDetailUser!["sanctions"]
                                                  [index];
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 7,
                                                right: 7,
                                                top: 3,
                                                bottom: 7),
                                            child: WidgetSanction(
                                              objetSanction: currentSaction[
                                                          "libelle"] ==
                                                      null
                                                  ? " "
                                                  : currentSaction["libelle"],
                                              heureSanction: AppCubitStorage()
                                                          .state
                                                          .Language ==
                                                      "fr"
                                                  ? formatTimeToFrench(
                                                      currentSaction[
                                                          "start_date"])
                                                  : formatTimeToEnglish(
                                                      currentSaction[
                                                          "start_date"]),
                                              dateSanction: 
                                                      currentSaction[
                                                          "start_date"],
                                              motifSanction:
                                                  currentSaction["motif"],
                                              montantSanction:
                                                  currentSaction["amount"]
                                                      .toString(),
                                              montantPayeeSanction:
                                                  currentSaction[
                                                      "sanction_balance"],
                                              lienPaiement: currentSaction[
                                                          "sanction_pay_link"] ==
                                                      null
                                                  ? " "
                                                  : currentSaction[
                                                      "sanction_pay_link"],
                                              versement:
                                                  currentSaction["versement"],
                                              isSanctionPayed: currentSaction[
                                                  "is_sanction_payed"],
                                              typeSaction:
                                                  currentSaction["type"],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: refresh,
                                    child: ListView.builder(
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          padding: EdgeInsets.only(top: 200),
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            "aucune_sanction".tr(),
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    20, 45, 99, 0.26),
                                                fontWeight: FontWeight.w100,
                                                fontSize: 20),
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
                        .ChangeAssData!["user_group"]["configs"],
                    context.read<AuthCubit>().state.detailUser!["isMember"]))
                  Container(
                    padding: EdgeInsets.only(top: 1.5, left: 1.5, right: 1.5),
                    width: MediaQuery.of(context).size.width,
                    // decoration:
                    // BoxDecoration(color: Color.fromARGB(255, 240, 35, 35),),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.only(top: 10, left: 5, bottom: 15),
                          child: Text(
                            "les_comptes_de_l'association".tr(),
                            style: TextStyle(
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 0.2),
                          ),
                        ),
                        BlocBuilder<CompteCubit, CompteState>(
                            builder: (CompteContext, CompteState) {
                          if (CompteState.isLoading == null ||
                              CompteState.isLoading == true)
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.bleuLight,
                                ),
                              ),
                            );
                          final currentCompteAss =
                              context.read<CompteCubit>().state.allCompteAss;

                          List<Map<String, dynamic>> comptePlusColor =
                              currentCompteAss!.asMap().entries.map((entry) {
                            final int index = entry.key;
                            final Map<String, dynamic> e = entry.value;
                            return {
                              ...e,
                              'color': listeDeCouleurs[index],
                            };
                          }).toList();
                          return Expanded(
                            child: RefreshIndicator(
                              onRefresh: refresh,
                              child: SingleChildScrollView(
                                child: Container(
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: [
                                      for (var item in comptePlusColor)
                                        Container(
                                          margin: EdgeInsets.only(
                                            bottom: 7,
                                            right: 5,
                                            top: 5,
                                            left: 5,
                                          ),
                                          child: WidgetCompteCard(
                                            montantCompte:
                                                "${int.parse(item["balance"]) + int.parse(item["faroti_balance"])}",
                                            nomCompte: item["name"],
                                            numeroCompte: item["id"].toString(),
                                            couleur: item["color"],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
