import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetDetailCotisationCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetHistoriqueCotisation.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
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

  @override
  State<DetailCotisationPage> createState() => _DetailCotisationPageState();
}

class _DetailCotisationPageState extends State<DetailCotisationPage> {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, false, true];

  Map<String, dynamic>? get currentDetailCotisation {
    return context.read<CotisationCubit>().state.detailCotisation;
  }
  

  @override
  Widget build(BuildContext context) {
  // final  currentDetailCotisation = context.read<CotisationCubit>().state.detailCotisation;
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text(
          "Detail de la cotisations",
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
              child: widgetDetailCotisationCard(
                  contributionOneUser: widget.contributionOneUser,
                  dateCotisation: widget.dateCotisation,
                  heureCotisation: widget.heureCotisation,
                  montantCotisations: widget.montantCotisations,
                  motifCotisations: widget.motifCotisations,
                  nbreParticipant: widget.nbreParticipant,
                  nbreParticipantCotisationOK:
                      widget.nbreParticipantCotisationOK,
                  soldeCotisation: widget.soldeCotisation,
                  isActive: widget.isActive),
            ),
            Container(
              // color: Colors.deepOrange,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Historique des cotisations",
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
                        'Cotisé',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Container(
                        child: Text(
                          "(${currentDetailCotisation!["versements"].length})",
                          // "3",
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
                        'Non cotisé',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "(${currentDetailCotisation!["members"].length})",
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
                          final currentDetailPersonCotis= currentDetailCotisation!["versements"];

                          return WidgetHistoriqueCotisation(
                            is_versement_finished: currentDetailPersonCotis[index]["versement"].length==0 ? 0 : currentDetailPersonCotis[index]["versement"][0]["is_versement_finished"],
                            matricule: currentDetailPersonCotis[index]["matricule"] ==null ? "" :currentDetailPersonCotis[index]["matricule"],
                            montantTotalAVerser: currentDetailPersonCotis[index]["versement"].length==0 ? "0" : currentDetailPersonCotis[index]["versement"][0]["source_amount"],
                            montantVersee: currentDetailPersonCotis[index]["versement"].length==0 ? "0" : currentDetailPersonCotis[index]["versement"][0]["balance_after"],
                            nom: currentDetailPersonCotis[index]["first_name"]==null? "" : currentDetailPersonCotis[index]["first_name"],
                            photoProfil: currentDetailPersonCotis[index]["photo_profil"]==null? "": currentDetailPersonCotis[index]["photo_profil"],
                            prenom: currentDetailPersonCotis[index]["last_name"]==null? "" :currentDetailPersonCotis[index]["last_name"],
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
                          final currentDetailPersonNonCotis= currentDetailCotisation!["members"];
                          print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${currentDetailPersonNonCotis[index]["membre"]["versement"].length}");

                          return WidgetHistoriqueCotisation(
                            is_versement_finished: currentDetailPersonNonCotis[index]["membre"]["versement"].length==0 ? 0 : currentDetailPersonNonCotis[index]["membre"]["versement"][0]["is_versement_finished"],

                            matricule: currentDetailPersonNonCotis[index]["membre"]["matricule"]==null? "" : currentDetailPersonNonCotis[index]["membre"]["matricule"],
                            montantTotalAVerser: currentDetailPersonNonCotis[index]["membre"]["versement"].length==0 ? "0" : currentDetailPersonNonCotis[index]["membre"]["versement"][0]["source_amount"],
                            montantVersee: currentDetailPersonNonCotis[index]["membre"]["versement"].length==0 ? "0" : currentDetailPersonNonCotis[index]["membre"]["versement"][0]["balance_after"],
                            nom: currentDetailPersonNonCotis[index]["membre"]["first_name"]==null? "" : currentDetailPersonNonCotis[index]["membre"]["first_name"],
                            photoProfil: currentDetailPersonNonCotis[index]["membre"]["photo_profil"]==null? "": currentDetailPersonNonCotis[index]["photo_profil"],
                            prenom: currentDetailPersonNonCotis[index]["membre"]["last_name"]==null? "" :currentDetailPersonNonCotis[index]["membre"]["last_name"],
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
  }
}
