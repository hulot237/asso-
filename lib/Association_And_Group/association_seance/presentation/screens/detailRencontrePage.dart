import 'dart:math';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationExpireInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationExpireInProgress.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInProgress.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/WidgetSanctionNonPayeeIsOther.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionNonPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsOther.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetDetailRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetTontineRencontreCard.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class detailRencontrePage extends StatefulWidget {
  detailRencontrePage({
    super.key,
    required this.nomRecepteurRencontre,
    required this.identifiantRencontre,
    required this.isActiveRencontre,
    required this.descriptionRencontre,
    required this.lieuRencontre,
    required this.dateRencontre,
    required this.heureRencontre,
    required this.prenomRecepteurRencontre,
    required this.photoProfilRecepteur,
  });

  String nomRecepteurRencontre;
  String identifiantRencontre;
  int isActiveRencontre;
  String descriptionRencontre;
  String lieuRencontre;
  String dateRencontre;
  String heureRencontre;
  String prenomRecepteurRencontre;
  String photoProfilRecepteur;
  @override
  State<detailRencontrePage> createState() => _detailRencontrePageState();
}

class _detailRencontrePageState extends State<detailRencontrePage>
    with TickerProviderStateMixin {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, "end", "end"];

  Map<String, dynamic>? get currentInfoAssociationCourant {
    return context.read<UserGroupCubit>().state.userGroupDefault;
  }

  Map<String, dynamic>? get currentDetailSeance {
    return context.read<SeanceCubit>().state.detailSeance;
  }

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);
    // final currentDetailSeance =

    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text(
          "Detail de la rencontre",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 0, left: 5, right: 5),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: widgetDetailRencontreCard(
                nbrPresence:
                    ("${currentDetailSeance!["abs"].length + currentDetailSeance!["presents"].length}"),
                dateRencontre: widget.dateRencontre,
                descriptionRencontre: widget.descriptionRencontre,
                heureRencontre: widget.heureRencontre,
                identifiantRencontre: widget.identifiantRencontre,
                isActiveRencontre: widget.isActiveRencontre,
                lieuRencontre: widget.lieuRencontre,
                nomRecepteurRencontre: widget.nomRecepteurRencontre,
                prenomRecepteurRencontre: widget.prenomRecepteurRencontre,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              height: 30,
              child: CustomSlidingSegmentedControl<int>(
                padding: 10,
                initialValue:
                    currentInfoAssociationCourant!['is_tontine'] ? 0 : 1,
                children: {
                  if (currentInfoAssociationCourant!['is_tontine'])
                    0: Row(
                      children: [
                        Text(
                          'Tontines',
                          style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  1: Row(
                    children: [
                      Text(
                        'Cotisations',
                        style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  2: Row(
                    children: [
                      Text(
                        'Sanctions',
                        style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                },
                decoration: BoxDecoration(
                  color: Color.fromARGB(85, 9, 185, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                thumbDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 9, 185, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
                onValueChanged: (index) {
                  // currentInfoAssociationCourant!['is_tontine']
                  //     ? _pageIndex = 0
                  //     : _pageIndex = 1;
                  setState(() {
                    _pageIndex = index;
                    print(_pageIndex);
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 7),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color.fromARGB(85, 9, 185, 255),
                  ),
                ),
                child: _pageIndex == 0
                    ? ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: Tab.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Modal().showBottomSheetHistTontine(
                                  context, _tabController);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetTontineRencontreCard(
                                dateTontine: '30/12/2023',
                                montantCollecte: '50000',
                                montantTontine: '500',
                                nomBeneficiaire: 'Cedric NDOUMBE',
                                nomTontine: 'Tontine du bureau',
                                positionBeneficiaire: "3",
                                nbrMembreTontine: '6',
                              ),
                            ),
                          );
                        },
                      )
                    : _pageIndex == 1
                        ? ListView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount:
                                currentDetailSeance!["cotisation"].length,
                            itemBuilder: (context, index) {
                              final currentDetail =
                                  currentDetailSeance!["cotisation"][index];

                              if (currentDetail["is_tontine"] == 0 &&
                                  currentDetail["type"] == "0" &&
                                  currentDetail["is_passed"] == 0) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 7, right: 7, top: 3, bottom: 7),
                                    child: WidgetCotisationInFixed(
                                      contributionOneUser: '2000',
                                      codeCotisation:
                                          currentDetail["cotisation_code"],
                                      heureCotisation: formatTime(
                                          currentDetail["start_date"]),
                                      dateCotisation: formatDate(
                                          currentDetail["start_date"]),
                                      montantCotisations:
                                          currentDetail["amount"],
                                      motifCotisations: currentDetail["name"],
                                      nbreParticipant: 5,
                                      soldeCotisation:
                                          currentDetail["cotisation_balance"],
                                      nbreParticipantCotisationOK: 4,

                                      // montantSanctionCollectee: currentDetail["amount_sanction"],
                                      isActive: 1,
                                    ),
                                  ),
                                );
                              } else if (currentDetail["is_tontine"] == 0 &&
                                  currentDetail["type"] == "1" &&
                                  currentDetail["is_passed"] == 0) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 7, right: 7, top: 3, bottom: 7),
                                  child: WidgetCotisationInProgress(
                                    codeCotisation:
                                        currentDetail["cotisation_code"],
                                    contributionOneUser: '2000',
                                    heureCotisation:
                                        formatTime(currentDetail["start_date"]),
                                    dateCotisation:
                                        formatDate(currentDetail["start_date"]),
                                    montantCotisations: currentDetail["amount"],
                                    motifCotisations: currentDetail["name"],
                                    nbreParticipant: 24,
                                    soldeCotisation:
                                        currentDetail["cotisation_balance"],
                                    nbreParticipantCotisationOK: 7,
                                    montantSanctionCollectee: '1500',
                                    isActive: 1,
                                    montantMin: "200",
                                  ),
                                );
                              } else if (currentDetail["is_tontine"] == 0 &&
                                  currentDetail["type"] == "0" &&
                                  currentDetail["is_passed"] == 1) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 7, right: 7, top: 3, bottom: 7),
                                  child: WidgetCotisationExpireInFixed(
                                    codeCotisation:
                                        currentDetail["cotisation_code"],
                                    contributionOneUser: '1500',
                                    motifCotisations: currentDetail["name"],
                                    dateCotisation:
                                        formatDate(currentDetail["start_date"]),
                                    montantCotisations: currentDetail["amount"],
                                    heureCotisation:
                                        formatTime(currentDetail["start_date"]),
                                    // montantSanctionCollectee: '1500',
                                    nbreParticipantCotisationOK: 10,
                                    nbreParticipant: 12,
                                    soldeCotisation:
                                        currentDetail["cotisation_balance"],
                                    isActive: 0,
                                  ),
                                );
                              } else if (currentDetail["is_tontine"] == 0 &&
                                  currentDetail["type"] == "1" &&
                                  currentDetail["is_passed"] == 1) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 7, right: 7, top: 3, bottom: 7),
                                  child: WidgetCotisationExpireInProgress(
                                    contributionOneUser: '1500',
                                    motifCotisations: currentDetail["name"],
                                    dateCotisation:
                                        formatDate(currentDetail["start_date"]),
                                    montantCotisations: currentDetail["amount"],
                                    heureCotisation:
                                        formatTime(currentDetail["start_date"]),
                                    // montantSanctionCollectee: currentDetail["amount_sanction"] ,
                                    nbreParticipantCotisationOK: 10,
                                    nbreParticipant: 12,
                                    soldeCotisation:
                                        currentDetail["cotisation_balance"],
                                    isActive: 0,
                                    codeCotisation:
                                        currentDetail["cotisation_code"],
                                  ),
                                );
                              }
                            },
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount: currentDetailSeance!["sanctions"].length,
                            itemBuilder: (context, index) {
                              // var valeurBool = Tab[index];
                              // final currentDetail = currentDetailSeance["cotisation"][index];
                              final ItemDetailSeanceSanction =
                                  currentDetailSeance!["sanctions"][index];
                              // print(
                              //     "]]]]]]]]]]]]]]]]] ${ItemDetailSeanceSanction["membre"]["membre_code"]}");

                              if (ItemDetailSeanceSanction["type"] == "1" &&
                                  ItemDetailSeanceSanction["membre"][
                                          "membre_code"] ==
                                      Variables.codeMembre &&
                                  ItemDetailSeanceSanction[
                                          "is_sanction_payed"] ==
                                      0) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 7, right: 7, top: 3, bottom: 7),
                                  child: WidgetSanctionNonPayeeIsMoney(
                                    dateSanction: formatDate(
                                        ItemDetailSeanceSanction["start_date"]),
                                    heureSanction: formatTime(
                                        ItemDetailSeanceSanction["start_date"]),
                                    montantPayeeSanction:
                                        ItemDetailSeanceSanction[
                                            "sanction_balance"],
                                    montantSanction:
                                        ItemDetailSeanceSanction["amount"]
                                            .toString(),
                                    motifSanction:
                                        ItemDetailSeanceSanction["motif"],
                                    lienPaiement: ItemDetailSeanceSanction[
                                                "sanction_pay_link"] ==
                                            null
                                        ? " "
                                        : ItemDetailSeanceSanction[
                                            "sanction_pay_link"],
                                  ),
                                );
                              } else if (ItemDetailSeanceSanction["type"] ==
                                      "0" &&
                                  ItemDetailSeanceSanction["membre"]
                                          ["membre_code"] ==
                                      Variables.codeMembre &&
                                  ItemDetailSeanceSanction[
                                          "is_sanction_payed"] ==
                                      0) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 7, right: 7, top: 3, bottom: 7),
                                  child: WidgetSanctionNonPayeeIsOther(
                                    dateSanction: formatDate(
                                        ItemDetailSeanceSanction["start_date"]),
                                    heureSanction: formatTime(
                                        ItemDetailSeanceSanction["start_date"]),
                                    objetSanction:
                                        ItemDetailSeanceSanction["libelle"],
                                    motifSanction:
                                        ItemDetailSeanceSanction["motif"],
                                  ),
                                );
                              } else if (ItemDetailSeanceSanction["type"] ==
                                      "1" &&
                                  ItemDetailSeanceSanction[
                                          "is_sanction_payed"] ==
                                      1 &&
                                  ItemDetailSeanceSanction["membre"]
                                          ["membre_code"] ==
                                      Variables.codeMembre) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 7, right: 7, top: 3, bottom: 7),
                                  child: WidgetSanctionPayeeIsMoney(
                                    dateSanction: formatDate(
                                        ItemDetailSeanceSanction["start_date"]),
                                    heureSanction: formatTime(
                                        ItemDetailSeanceSanction["start_date"]),
                                    montantPayeeSanction:
                                        ItemDetailSeanceSanction[
                                            "sanction_balance"],
                                    montantSanction:
                                        ItemDetailSeanceSanction["amount"]
                                            .toString(),
                                    motifSanction:
                                        ItemDetailSeanceSanction["motif"],
                                  ),
                                );
                              } else if (ItemDetailSeanceSanction["type"] ==
                                      "0" &&
                                  ItemDetailSeanceSanction[
                                          "is_sanction_payed"] ==
                                      1 &&
                                  ItemDetailSeanceSanction["membre"]
                                          ["membre_code"] ==
                                      Variables.codeMembre) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 7, right: 7, top: 3, bottom: 7),
                                  child: WidgetSanctionPayeeIsOther(
                                    dateSanction: formatDate(
                                        ItemDetailSeanceSanction["start_date"]),
                                    heureSanction: formatTime(
                                        ItemDetailSeanceSanction["start_date"]),
                                    motifSanction:
                                        ItemDetailSeanceSanction["motif"],
                                    objetSanction:
                                        ItemDetailSeanceSanction["libelle"],
                                  ),
                                );
                              }
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
