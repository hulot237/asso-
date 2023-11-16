import 'dart:io';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetDetailCotisationCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetHistoriqueCotisation.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCotisationPage extends StatefulWidget {
  DetailCotisationPage({
    super.key,
    required this.montantCotisations,
    required this.motifCotisations,
    required this.dateCotisation,
    required this.heureCotisation,
    required this.soldeCotisation,
    required this.contributionOneUser,
    required this.nbreParticipant,
    required this.nbreParticipantCotisationOK,
    required this.isPassed,
    required this.type,
    required this.lienDePaiement,
    required this.codeCotisation,
  });
  int montantCotisations;
  String motifCotisations;
  String dateCotisation;
  String heureCotisation;
  String soldeCotisation;
  String contributionOneUser;
  int nbreParticipant;
  int nbreParticipantCotisationOK;
  String type;
  String lienDePaiement;
  int isPassed;
  String codeCotisation;

  @override
  State<DetailCotisationPage> createState() => _DetailCotisationPageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFEFEFEF),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "detail_de_la_cotisations".tr(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: Color(0xFFEFEFEF),
    appBar: AppBar(
      title: Text(
        "detail_de_la_cotisations".tr(),
        style: TextStyle(fontSize: 16),
      ),
      backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
      elevation: 0,
    ),
    body: child,
  );
}

class _DetailCotisationPageState extends State<DetailCotisationPage>
    with TickerProviderStateMixin {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, false, true];

  Future<void> handleDetailCotisation(codeCotisation) async {
    // final detailTournoiCourant = await context
    //     .read<DetailTournoiCourantCubit>()
    //     .detailTournoiCourantCubit();
    final detailCotisation = await context
        .read<CotisationDetailCubit>()
        .detailCotisationCubit(codeCotisation);

    if (detailCotisation != null) {
      print("objaaaaaaaaaaaaaaaaaa  ${detailCotisation}");
      print(
          "aaaaaaaaaaaaaaaaaaaaaqqqqq  ${context.read<CotisationDetailCubit>().state.detailCotisation}");
    } else {
      print("userGroupDefault null");
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

  Future refresh() async {
    handleDetailCotisation(widget.codeCotisation);
  }

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);

    return PageScaffold(
      context: context,
      child: Container(
        margin: EdgeInsets.only(top: 0, left: 5, right: 5),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: widgetDetailCotisationCard(
                type: widget.type,
                contributionOneUser: widget.contributionOneUser,
                dateCotisation: widget.dateCotisation,
                heureCotisation: widget.heureCotisation,
                montantCotisations: widget.montantCotisations,
                motifCotisations: widget.motifCotisations,
                nbreParticipant: widget.nbreParticipant,
                nbreParticipantCotisationOK: widget.nbreParticipantCotisationOK,
                soldeCotisation: widget.soldeCotisation,
                lienDePaiement: widget.lienDePaiement,
                isPassed: widget.isPassed,
              ),
            ),
            Container(
              // color: Colors.deepOrange,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "historique_des_cotisations".tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(20, 45, 99, 1),
                ),
              ),
            ),
            // Container(
            //   // color: Colors.black26,
            //   alignment: Alignment.center,
            //   width: MediaQuery.of(context).size.width,
            //   margin: EdgeInsets.only(top: 10),
            //   height: 30,
            //   child: CustomSlidingSegmentedControl<int>(
            //     padding: 10,
            //     // height: 25,
            //     initialValue: 0,
            //     children: {
            //       0: Row(
            //         children: [
            //           Text(
            //             'cotisé'.tr(),
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 15),
            //           ),
            //           Container(
            //             child: Text(
            //               // "(${currentDetailCotisation!["versements"].length == null ? 0 : currentDetailCotisation!["versements"].length})",
            //               "2",
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 11,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //         ],
            //       ),
            //       1: Row(
            //         children: [
            //           Text(
            //             'non_cotisé'.tr(),
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 15),
            //           ),
            //           Container(
            //             alignment: Alignment.center,
            //             child: Text(
            //               // " (${currentDetailCotisation!["members"].length == null ? 0 : currentDetailCotisation!["members"].length})",
            //               "1",
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 11,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //         ],
            //       ),
            //     },
            //     decoration: BoxDecoration(
            //       color: Color.fromARGB(85, 9, 185, 255),
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     thumbDecoration: BoxDecoration(
            //       color: Color.fromARGB(255, 9, 185, 255),
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //     duration: Duration(milliseconds: 300),
            //     curve: Curves.ease,
            //     onValueChanged: (index) {
            //       setState(() {
            //         _pageIndex = index;
            //         print(_pageIndex);
            //       });
            //     },
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              padding: EdgeInsets.only(top: 15, bottom: 15),
              color: Color.fromARGB(120, 226, 226, 226),
              alignment: Alignment.center,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Color.fromARGB(255, 20, 45, 99),
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                padding: EdgeInsets.all(0),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 20, 45, 99),
                    width: 5.0,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 36.0),
                ),
                tabs: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          "${"cotisé".tr()}",
                        ),
                        BlocBuilder<CotisationDetailCubit,
                                CotisationDetailState>(
                            builder: (CotisationContext, CotisationState) {
                          if (CotisationState.isLoading == null ||
                              CotisationState.isLoading == true ||
                              CotisationState.detailCotisation == null)
                            return Container(
                              width: 10,
                              height: 10,
                              child: Center(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 0.5,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                  ),
                                ),
                              ),
                            );
                          final currentDetailCotisation =
                              CotisationContext.read<CotisationDetailCubit>()
                                  .state
                                  .detailCotisation;
                          return Text(
                            "(${currentDetailCotisation!["versements"].length == null ? 0 : currentDetailCotisation!["versements"].length})",
                            style: TextStyle(fontSize: 10),
                          );
                        }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          'non_cotisé'.tr(),
                        ),
                        BlocBuilder<CotisationDetailCubit,
                                CotisationDetailState>(
                            builder: (CotisationContext, CotisationState) {
                          if (CotisationState.isLoading == null ||
                              CotisationState.isLoading == true ||
                              CotisationState.detailCotisation == null)
                            return Container(
                              width: 10,
                              height: 10,
                              child: Center(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 0.5,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                  ),
                                ),
                              ),
                            );
                          final currentDetailCotisation =
                              CotisationContext.read<CotisationDetailCubit>()
                                  .state
                                  .detailCotisation;
                          return Text(
                            "(${currentDetailCotisation!["members"].length == null ? 0 : currentDetailCotisation!["members"].length})",
                            style: TextStyle(fontSize: 10),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
                    builder: (CotisationDetailcontext, CotisationDetailstate) {
                      if (CotisationDetailstate.isLoading == null ||
                          CotisationDetailstate.isLoading == true ||
                          CotisationDetailstate.detailCotisation == null)
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      final currentDetailCotisation =
                          CotisationDetailcontext.read<CotisationDetailCubit>()
                              .state
                              .detailCotisation;
                      return currentDetailCotisation!["versements"].length > 0
                          ? ListView.builder(
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              itemCount:
                                  currentDetailCotisation!["versements"].length,
                              itemBuilder: (context, index) {
                                final currentDetailPersonCotis =
                                    currentDetailCotisation!["versements"];

                                return WidgetHistoriqueCotisation(
                                  is_versement_finished:
                                      currentDetailPersonCotis[index]
                                                      ["versement"]
                                                  .length ==
                                              0
                                          ? 0
                                          : currentDetailPersonCotis[index]
                                                  ["versement"][0]
                                              ["is_versement_finished"],
                                  matricule: currentDetailPersonCotis[index]
                                              ["matricule"] ==
                                          null
                                      ? ""
                                      : currentDetailPersonCotis[index]
                                          ["matricule"],
                                  montantTotalAVerser:
                                      currentDetailPersonCotis[index]
                                                      ["versement"]
                                                  .length ==
                                              0
                                          ? "0"
                                          : currentDetailPersonCotis[index]
                                              ["versement"][0]["source_amount"],
                                  montantVersee: currentDetailPersonCotis[index]
                                                  ["versement"]
                                              .length ==
                                          0
                                      ? "0"
                                      : currentDetailPersonCotis[index]
                                          ["versement"][0]["balance_after"],
                                  nom: currentDetailPersonCotis[index]
                                              ["first_name"] ==
                                          null
                                      ? ""
                                      : currentDetailPersonCotis[index]
                                          ["first_name"],
                                  photoProfil: currentDetailPersonCotis[index]
                                              ["photo_profil"] ==
                                          null
                                      ? ""
                                      : currentDetailPersonCotis[index]
                                          ["photo_profil"],
                                  prenom: currentDetailPersonCotis[index]
                                              ["last_name"] ==
                                          null
                                      ? ""
                                      : currentDetailPersonCotis[index]
                                          ["last_name"],
                                );
                              },
                            )
                          : RefreshIndicator(
                              onRefresh: refresh,
                              child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.only(top: 100),
                                    alignment: Alignment.topCenter,
                                    child: Icon(
                                      Icons.playlist_remove,
                                      size: 100,
                                      color: Color.fromRGBO(20, 45, 99, 0.26),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  ),
                  BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
                    builder: (CotisationDetailcontext, CotisationDetailstate) {
                      if (CotisationDetailstate.isLoading == null ||
                          CotisationDetailstate.isLoading == true)
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      final currentDetailCotisation =
                          CotisationDetailcontext.read<CotisationDetailCubit>()
                              .state
                              .detailCotisation;

                      return currentDetailCotisation!["members"].length > 0
                          ? RefreshIndicator(
                              onRefresh: refresh,
                              child: ListView.builder(
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                itemCount:
                                    currentDetailCotisation!["members"].length,
                                itemBuilder: (context, index) {
                                  final currentDetailPersonNonCotis =
                                      currentDetailCotisation!["members"]
                                          [index];

                                  return WidgetHistoriqueCotisation(
                                    is_versement_finished:
                                        currentDetailPersonNonCotis["membre"]
                                                        ["versement"]
                                                    .length ==
                                                0
                                            ? 0
                                            : currentDetailPersonNonCotis[
                                                    "membre"]["versement"][0]
                                                ["is_versement_finished"],
                                    matricule: currentDetailPersonNonCotis[
                                                "membre"]["matricule"] ==
                                            null
                                        ? ""
                                        : currentDetailPersonNonCotis["membre"]
                                            ["matricule"],
                                    montantTotalAVerser:
                                        currentDetailPersonNonCotis["membre"]
                                                        ["versement"]
                                                    .length ==
                                                0
                                            ? "0"
                                            : currentDetailPersonNonCotis[
                                                    "membre"]["versement"][0]
                                                ["source_amount"],
                                    montantVersee: currentDetailPersonNonCotis[
                                                    "membre"]["versement"]
                                                .length ==
                                            0
                                        ? "0"
                                        : currentDetailPersonNonCotis["membre"]
                                            ["versement"][0]["balance_after"],
                                    nom: currentDetailPersonNonCotis["membre"]
                                                ["first_name"] ==
                                            null
                                        ? ""
                                        : currentDetailPersonNonCotis["membre"]
                                            ["first_name"],
                                    photoProfil: currentDetailPersonNonCotis[
                                                "membre"]["photo_profil"] ==
                                            null
                                        ? ""
                                        : currentDetailPersonNonCotis["membre"]
                                            ["photo_profil"],
                                    prenom: currentDetailPersonNonCotis[
                                                "membre"]["last_name"] ==
                                            null
                                        ? ""
                                        : currentDetailPersonNonCotis["membre"]
                                            ["last_name"],
                                  );
                                },
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: refresh,
                              child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.only(top: 100),
                                    alignment: Alignment.topCenter,
                                    child: Icon(
                                      Icons.playlist_add_check,
                                      size: 100,
                                      color: Color.fromRGBO(20, 45, 99, 0.26),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
