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
    required this.isActive,
    required this.type,
    required this.lienDePaiement,
  });
  int montantCotisations;
  String motifCotisations;
  String dateCotisation;
  String heureCotisation;
  String soldeCotisation;
  String contributionOneUser;
  int nbreParticipant;
  int nbreParticipantCotisationOK;
  int isActive;
  String type;
  String lienDePaiement;

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

class _DetailCotisationPageState extends State<DetailCotisationPage> {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, false, true];

  Map<String, dynamic>? get currentDetailCotisation {
    return context.read<CotisationDetailCubit>().state.detailCotisation;
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
        builder: (CotisationDetailcontext, CotisationDetailstate) {
      if (CotisationDetailstate.isLoading == null || CotisationDetailstate.isLoading == true)
        return Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
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
                    nbreParticipantCotisationOK:
                        widget.nbreParticipantCotisationOK,
                    soldeCotisation: widget.soldeCotisation,
                    isActive: widget.isActive, 
                    lienDePaiement: widget.lienDePaiement,),
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
              Container(
                // color: Colors.black26,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10),
                height: 30,
                child: CustomSlidingSegmentedControl<int>(
                  padding: 10,
                  // height: 25,
                  initialValue: 0,
                  children: {
                    0: Row(
                      children: [
                        Text(
                          'cotisé'.tr(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Container(
                          child: Text(
                            "(${currentDetailCotisation!["versements"].length == null ? 0 : currentDetailCotisation!["versements"].length})",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    1: Row(
                      children: [
                        Text(
                          'non_cotisé'.tr(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            " (${currentDetailCotisation!["members"].length == null ? 0 : currentDetailCotisation!["members"].length})",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
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
                    setState(() {
                      _pageIndex = index;
                      print(_pageIndex);
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  // color: Color.fromARGB(85, 9, 185, 255),
                  padding: EdgeInsets.only(right: 6, left: 6, top: 10),
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(
                    width: 1,
                    color: Color.fromARGB(85, 9, 185, 255),
                  )),
                  child: _pageIndex == 0
                      ? ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount:
                              currentDetailCotisation!["versements"].length,
                          itemBuilder: (context, index) {
                            // Vérifiez la valeur du booléen à l'index actuel
                            // bool valeurBool = Tab[index];
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
                                  currentDetailPersonCotis[index]["versement"]
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
                                  : currentDetailPersonCotis[index]["versement"]
                                      [0]["balance_after"],
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
                      : ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: currentDetailCotisation!["members"].length,
                          itemBuilder: (context, index) {
                            // Vérifiez la valeur du booléen à l'index actuel
                            // bool valeurBool = Tab[index];
                            final currentDetailPersonNonCotis =
                                currentDetailCotisation!["members"][index];
    
                            return WidgetHistoriqueCotisation(
                              is_versement_finished:
                                  currentDetailPersonNonCotis["membre"]
                                                  ["versement"]
                                              .length ==
                                          0
                                      ? 0
                                      : currentDetailPersonNonCotis["membre"]
                                              ["versement"][0]
                                          ["is_versement_finished"],
                              matricule: currentDetailPersonNonCotis["membre"]
                                          ["matricule"] ==
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
                                      : currentDetailPersonNonCotis["membre"]
                                          ["versement"][0]["source_amount"],
                              montantVersee:
                                  currentDetailPersonNonCotis["membre"]
                                                  ["versement"]
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
                              photoProfil: currentDetailPersonNonCotis["membre"]
                                          ["photo_profil"] ==
                                      null
                                  ? ""
                                  : currentDetailPersonNonCotis["membre"]
                                      ["photo_profil"],
                              prenom: currentDetailPersonNonCotis["membre"]
                                          ["last_name"] ==
                                      null
                                  ? ""
                                  : currentDetailPersonNonCotis["membre"]
                                      ["last_name"],
                            );
                            // Ajoutez ici le widget que vous souhaitez afficher pour true
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
