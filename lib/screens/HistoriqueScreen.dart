import 'dart:io';
import 'dart:math';

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
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
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
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/screens/detailTontinePage.dart';
import 'package:faroty_association_1/widget/WidgetActionAppBArChangeAss.dart';
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
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "historiques".tr(),
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
        trailing: widgetAction,
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: Text(
        "historiques".tr(),
      ),
      backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
      elevation: 0,
      actions: [widgetAction],
    ),
    body: child,
  );
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
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
      print(
          "éé22222~===}}}}}}}}}}  ${context.read<CompteCubit>().state.allCompteAss}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllSeanceAss(codeAssociation) async {
    final allSeanceAss =
        await context.read<SeanceCubit>().AllAssSeanceCubit(codeAssociation);

    if (allSeanceAss != null) {
      print("ààààààààààààààààààààààààààààààààààà  ${allSeanceAss}");
      print(
          "àààààààààààààààààààààààààààààààààààà  ${context.read<SeanceCubit>().state.allSeanceAss}");
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

  Map<String, dynamic>? get currentDetailUser {
    return context.read<AuthCubit>().state.detailUser;
  }
  // final currentDetailUser = context.read<AuthCubit>().state.detailUser;

  // final currentDetailUser = context.read<AuthCubit>().state.detailUser;

  Map<String, dynamic>? get currentDetailtournoiCourant {
    return context.read<DetailTournoiCourantCubit>().state.detailtournoiCourant;
  }

  // Future<void> handleDetailUser(userCode) async {
  //   final allCotisationAss =
  //       await context.read<AuthCubit>().detailAuthCubit(userCode);

  //   if (allCotisationAss != null) {
  //     print("objec===============tttddddddddddddddddddd  ${allCotisationAss}");
  //     print(
  //         "éé22==============ssssssssssssssssssssssssss=222ddddddddddddddddddddddddddddd  ${context.read<AuthCubit>().state.detailUser}");
  //   } else {
  //     print("handleDetailUser null");
  //   }
  // }

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

  @override
  void initState() {
    super.initState();
    handleTournoiDefault();
    handleAllUserGroup();
    handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournois);
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
    handleAllSeanceAss(AppCubitStorage().state.codeAssDefaul);
    handleChangeAss(AppCubitStorage().state.codeAssDefaul);
  }

  List<Color> listeDeCouleurs = [
    Colors.red, // Rouge
    Colors.blue, // Bleu
    Colors.green, // Vert
    Colors.brown, // Jaune
    Colors.purple, // Violet
  ];

  Map<String, dynamic>? get currentAssCourant {
    return context.read<UserGroupCubit>().state.ChangeAssData;
  }

  @override
  Widget build(BuildContext context) {
    final currentCompteAss = context.read<CompteCubit>().state.allCompteAss;



    List<Map<String, dynamic>> comptePlusColor =
        currentCompteAss!.asMap().entries.map((entry) {
      final int index = entry.key;
      final Map<String, dynamic> e = entry.value;
      return {
        ...e,
        'color': listeDeCouleurs[index],
      };
    }).toList();

    return BlocBuilder<UserGroupCubit, UserGroupState>(
        builder: (UserGroupContext, UserGroupState) {
      if (UserGroupState.isLoading == null ||
          UserGroupState.isLoading == true ||
          UserGroupState.ChangeAssData == null)
        return Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );

      return BlocBuilder<DetailTournoiCourantCubit, DetailTournoiCourantState>(
          builder: (DetailTournoiContext, DetailTournoiState) {
        if (DetailTournoiState.isLoading == null ||
            DetailTournoiState.isLoading == true ||
            DetailTournoiState.detailtournoiCourant == null)
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        final currentDetailtournoiCourant = context
            .read<DetailTournoiCourantCubit>()
            .state
            .detailtournoiCourant;

        return DefaultTabController(
          length:
              currentAssCourant!['user_group']['is_tontine'] == true ? 5 : 4,
          child: Scaffold(
            backgroundColor: Color(0xFFEFEFEF),
            appBar: AppBar(
              title: Text(
                "historiques".tr(),
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                WidgetActionAppBArChangeAss(
                  ListAss: context.read<UserGroupCubit>().state.userGroup,
                ),
              ],
              elevation: 0,
              backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
              leading: Icon(Icons.arrow_back),
              bottom: TabBar(
                  isScrollable: true,
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  unselectedLabelStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  padding: EdgeInsets.all(0),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 5.0,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 36.0),
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
                    Tab(
                      text: "comptes".tr(),
                    ),
                  ]),
            ),
            body: TabBarView(
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
                            color: const Color.fromRGBO(20, 45, 99, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      currentDetailtournoiCourant!["tournois"]["seance"]!
                                  .length >
                              0
                          ? Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  itemCount:
                                      currentDetailtournoiCourant["tournois"]
                                              ["seance"]
                                          .length,
                                  itemBuilder: (context, index) {
                                    final itemSeance =
                                        currentDetailtournoiCourant["tournois"]
                                            ["seance"][index];

                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: 7, right: 7, top: 3, bottom: 7),
                                      child: WidgetRencontreCard(
                                        codeSeance: itemSeance["seance_code"],
                                        photoProfilRecepteur: "",
                                        dateRencontre:
                                            AppCubitStorage().state.Language ==
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
                                        isActiveRencontre: itemSeance["status"],
                                        prenomRecepteurRencontre:
                                            itemSeance["membre"]["last_name"] ==
                                                    null
                                                ? ""
                                                : itemSeance["membre"]
                                                    ["last_name"],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(top: 200),
                              alignment: Alignment.topCenter,
                              child: Text(
                                "aucune_rencontre".tr(),
                                style: TextStyle(
                                    color: Color.fromRGBO(20, 45, 99, 0.26),
                                    fontWeight: FontWeight.w100,
                                    fontSize: 20),
                              ),
                            ),
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
                                color: const Color.fromRGBO(20, 45, 99, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 0.2),
                          ),
                        ),
                        currentDetailtournoiCourant["tontines"].length > 0
                            ? Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    itemCount:
                                        currentDetailtournoiCourant["tontines"]
                                            .length,
                                    itemBuilder: (context, index) {
                                      print(currentDetailtournoiCourant[
                                          "tontines"]);
                                      final itemTontine =
                                          currentDetailtournoiCourant[
                                              "tontines"][index];

                                      for (var item in itemTontine["membres"])
                                        if (item["membre"]["membre_code"] ==
                                            AppCubitStorage().state.membreCode)
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
                                                    dateCreaTontine: AppCubitStorage()
                                                                .state
                                                                .Language ==
                                                            "fr"
                                                        ? formatDateToFrench(
                                                            itemTontine[
                                                                "created_at"])
                                                        : formatDateToEnglish(
                                                            itemTontine[
                                                                "created_at"]),
                                                    nomTontine:
                                                        "${itemTontine["libele"]}",
                                                    montantTontine:
                                                        "${itemTontine["amount"]}",
                                                    positionBeneficiaire: "0",
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
                                                dateCreaTontine:
                                                    AppCubitStorage()
                                                                .state
                                                                .Language ==
                                                            "fr"
                                                        ? formatDateToFrench(
                                                            itemTontine[
                                                                "created_at"])
                                                        : formatDateToEnglish(
                                                            itemTontine[
                                                                "created_at"]),
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
                              )
                            : Container(
                                padding: EdgeInsets.only(top: 200),
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Aucune tontine",
                                  style: TextStyle(
                                      color: Color.fromRGBO(20, 45, 99, 0.26),
                                      fontWeight: FontWeight.w100,
                                      fontSize: 20),
                                ),
                              ),
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
                        padding:
                            EdgeInsets.only(top: 10, left: 5, bottom: 15),
                        child: Text(
                          "toutes_vos_cotisations".tr(),
                          style: TextStyle(
                              color: const Color.fromRGBO(20, 45, 99, 1),
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
                            color: Colors.white,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                              final currentAllCotisationAssTournoi =
        context.read<CotisationCubit>().state.allCotisationAss;
                        return currentAllCotisationAssTournoi!.length > 0
                            ? Expanded(
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      itemCount:
                                          currentAllCotisationAssTournoi.length,
                                      itemBuilder: (context, index) {
                                        final currentDetail =
                                            currentAllCotisationAssTournoi[
                                                index];
                                        print(
                                            "[[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]] ${currentDetailUser!["cotisation"]}");

                                        if (currentDetail["is_tontine"] == 0 &&
                                            currentDetail["type"] == "0" &&
                                            currentDetail["is_passed"] == 0 &&
                                            currentDetail[
                                                    "association_seance_id"] ==
                                                null) {
                                          return GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 7,
                                                  right: 7,
                                                  top: 3,
                                                  bottom: 7),
                                              child: WidgetCotisationInFixed(
                                                lienDePaiement: currentDetail[
                                                    "cotisation_pay_link"],
                                                type: currentDetail["type"],
                                                contributionOneUser: '2000',
                                                codeCotisation: currentDetail[
                                                    "cotisation_code"],
                                                heureCotisation:
                                                    AppCubitStorage()
                                                                .state
                                                                .Language ==
                                                            "fr"
                                                        ? formatTimeToFrench(
                                                            currentDetail[
                                                                "start_date"])
                                                        : formatTimeToEnglish(
                                                            currentDetail[
                                                                "start_date"]),
                                                dateCotisation:
                                                    AppCubitStorage()
                                                                .state
                                                                .Language ==
                                                            "fr"
                                                        ? formatDateToFrench(
                                                            currentDetail[
                                                                "start_date"])
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
                                                isActive: 1,
                                              ),
                                            ),
                                          );
                                        } else if (currentDetail[
                                                    "is_tontine"] ==
                                                0 &&
                                            currentDetail["type"] == "1" &&
                                            currentDetail["is_passed"] == 0 &&
                                            currentDetail[
                                                    "association_seance_id"] ==
                                                null) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 7,
                                                right: 7,
                                                top: 3,
                                                bottom: 7),
                                            child: WidgetCotisationInProgress(
                                              lienDePaiement: currentDetail[
                                                  "cotisation_pay_link"],
                                              codeCotisation: currentDetail[
                                                  "cotisation_code"],
                                              contributionOneUser: '2000',
                                              heureCotisation: AppCubitStorage()
                                                          .state
                                                          .Language ==
                                                      "fr"
                                                  ? formatTimeToFrench(
                                                      currentDetail[
                                                          "start_date"])
                                                  : formatTimeToEnglish(
                                                      currentDetail[
                                                          "start_date"]),
                                              dateCotisation: AppCubitStorage()
                                                          .state
                                                          .Language ==
                                                      "fr"
                                                  ? formatDateToFrench(
                                                      currentDetail[
                                                          "start_date"])
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
                                        } else if (currentDetail[
                                                    "is_tontine"] ==
                                                0 &&
                                            currentDetail["type"] == "0" &&
                                            currentDetail["is_passed"] == 1 &&
                                            currentDetail[
                                                    "association_seance_id"] ==
                                                null) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 7,
                                                right: 7,
                                                top: 3,
                                                bottom: 7),
                                            child:
                                                WidgetCotisationExpireInFixed(
                                                  lienDePaiement: currentDetail["cotisation_pay_link"]==null? "Le lien n'a pas été généré": currentDetail["cotisation_pay_link"],
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
                                                      currentDetail[
                                                          "start_date"])
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
                                                      currentDetail[
                                                          "start_date"])
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
                                        } else if (currentDetail[
                                                    "is_tontine"] ==
                                                0 &&
                                            currentDetail["type"] == "1" &&
                                            currentDetail["is_passed"] == 1 &&
                                            currentDetail[
                                                    "association_seance_id"] ==
                                                null) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 7,
                                                right: 7,
                                                top: 3,
                                                bottom: 7),
                                            child:
                                                WidgetCotisationExpireInProgress(
                                                  lienDePaiement: currentDetail["cotisation_pay_link"]==null? "Le lien n'a pas été généré": currentDetail["cotisation_pay_link"],
                                              contributionOneUser: '1500',
                                              motifCotisations:
                                                  currentDetail["name"],
                                              dateCotisation: AppCubitStorage()
                                                          .state
                                                          .Language ==
                                                      "fr"
                                                  ? formatDateToFrench(
                                                      currentDetail[
                                                          "start_date"])
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
                                                      currentDetail[
                                                          "start_date"])
                                                  : formatTimeToEnglish(
                                                      currentDetail[
                                                          "start_date"]),
                                              // montantSanctionCollectee: currentDetail["amount_sanction"] ,
                                              nbreParticipantCotisationOK: 10,
                                              nbreParticipant: 12,
                                              soldeCotisation: currentDetail[
                                                  "cotisation_balance"],
                                              isActive: 1,
                                              codeCotisation: currentDetail[
                                                  "cotisation_code"],
                                              type: currentDetail["type"],
                                            ),
                                          );
                                        }

                                        // Ajoutez ici le widget que vous souhaitez afficher pour true
                                      },
                                    )),
                              )
                            : Container(
                                padding: EdgeInsets.only(top: 200),
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "aucune_cotisation".tr(),
                                  style: TextStyle(
                                      color: Color.fromRGBO(20, 45, 99, 0.26),
                                      fontWeight: FontWeight.w100,
                                      fontSize: 20),
                                ),
                              );
                      })
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
                              color: const Color.fromRGBO(20, 45, 99, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 0.2),
                        ),
                      ),
                      currentDetailUser!["sanctions"].length > 0
                          ? Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  itemCount:
                                      currentDetailUser!["sanctions"].length,
                                  itemBuilder: (context, index) {
                                    final ItemDetailUserSanction =
                                        currentDetailUser!["sanctions"][index];

                                    if (ItemDetailUserSanction["type"] == "1" &&
                                        ItemDetailUserSanction[
                                                "is_sanction_payed"] ==
                                            0 &&
                                        ItemDetailUserSanction[
                                                "association_seance_id"] ==
                                            null) {
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
                                    } else if (ItemDetailUserSanction["type"] ==
                                            "0" &&
                                        ItemDetailUserSanction[
                                                "is_sanction_payed"] ==
                                            0 &&
                                        ItemDetailUserSanction[
                                                "association_seance_id"] ==
                                            null) {
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
                                              ItemDetailUserSanction["libelle"],
                                          motifSanction:
                                              ItemDetailUserSanction["motif"],
                                        ),
                                      );
                                    } else if (ItemDetailUserSanction["type"] ==
                                            "1" &&
                                        ItemDetailUserSanction[
                                                "is_sanction_payed"] ==
                                            1 &&
                                        ItemDetailUserSanction[
                                                "association_seance_id"] ==
                                            null) {
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
                                    } else if (ItemDetailUserSanction["type"] ==
                                            "0" &&
                                        ItemDetailUserSanction[
                                                "is_sanction_payed"] ==
                                            1 &&
                                        ItemDetailUserSanction[
                                                "association_seance_id"] ==
                                            null) {
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
                                              ItemDetailUserSanction["libelle"],
                                        ),
                                      );
                                    } else {
                                      return Center(
                                          // child: Text("aucune_sanction".tr()),
                                          );
                                    }
                                  },
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(top: 200),
                              alignment: Alignment.topCenter,
                              child: Text(
                                "aucune_sanction".tr(),
                                style: TextStyle(
                                    color: Color.fromRGBO(20, 45, 99, 0.26),
                                    fontWeight: FontWeight.w100,
                                    fontSize: 20),
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 1.5, left: 1.5, right: 1.5),
                  width: MediaQuery.of(context).size.width,
                  // decoration:
                  // BoxDecoration(color: Color.fromARGB(255, 240, 35, 35),),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10, left: 5, bottom: 15),
                        child: Text(
                          "les_comptes_de_l'association".tr(),
                          style: TextStyle(
                              color: const Color.fromRGBO(20, 45, 99, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 0.2),
                        ),
                      ),
                      Expanded(
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
                    ],
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
