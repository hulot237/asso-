import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInProgress.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/WidgetSanctionNonPayeeIsOther.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionNonPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetTontineHistoriqueCard.dart';
import 'package:faroty_association_1/pages/detailSeancePage1.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/screens/detailTontinePage.dart';
import 'package:faroty_association_1/widget/WidgetActionAppBArChangeAss.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/presentation/widgets/widgetCompteCard.dart';
import 'package:flutter/material.dart';

class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({super.key});

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
  var tabs = [true, false, false, true, false, true];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Color(0xFFEFEFEF),
        appBar: AppBar(
          title: Text(
            "Historiques",
            style: TextStyle(fontSize: 16),
          ),
          actions: [WidgetActionAppBArChangeAss()],
          elevation: 0,
          backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
          leading: Icon(Icons.arrow_back),
          bottom: TabBar(
              isScrollable: true,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
                  text: "Rencontres",
                ),
                Tab(
                  text: "Tontines",
                ),
                Tab(
                  text: "Cotisations",
                ),
                Tab(
                  text: "Sanctions",
                ),
                Tab(
                  text: "Comptes",
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
                      "Toutes les rencontres",
                      style: TextStyle(
                        color: const Color.fromRGBO(20, 45, 99, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 7, right: 7, top: 3, bottom: 7),
                            child: WidgetRencontreCard(
                              dateRencontre: '23/12/2035',
                              descriptionRencontre:
                                  'Le rencontre du 23/12/2035 sera très speciale',
                              heureRencontre: '19h15',
                              identifiantRencontre: '01S02',
                              lieuRencontre: 'Terminus bonamoussadi',
                              nomRecepteurRencontre: 'John Fitzgerald Kennedy ',
                              isActiveRencontre: 1,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                      "Toutes vos tontines",
                      style: TextStyle(
                          color: const Color.fromRGBO(20, 45, 99, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: tabs.length,
                        itemBuilder: (context, index) {
                          // Vérifiez la valeur du booléen à l'index actuel
                          bool valeurBool = tabs[index];

                          if (valeurBool) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailTontinePage(),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 7, right: 7, top: 3, bottom: 7),
                                child: widgetTontineHistoriqueCard(
                                  dateCreaTontine: '23/12/2023',
                                  montantTontine: '30000',
                                  nbrMembreTontine: '10',
                                  nomTontine: 'Tontine du bureau AMI',
                                  positionBeneficiaire: '2',
                                ),
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
                      "Toutes vos cotisations",
                      style: TextStyle(
                          color: const Color.fromRGBO(20, 45, 99, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: tabs.length,
                          itemBuilder: (context, index) {
                            // Vérifiez la valeur du booléen à l'index actuel
                            bool valeurBool = tabs[index];

                            if (valeurBool) {
                              return GestureDetector(
                                // onTap: () {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => DetailSeancePage1(),
                                //     ),
                                //   );
                                // },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: 7, right: 7, top: 3, bottom: 7),
                                    child: WidgetCotisationInFixed(
                                      contributionOneUser: '2000',
                                      heureCotisation: '12h30',
                                      dateCotisation: '21/02/2024',
                                      montantCotisations: 3000,
                                      motifCotisations:
                                          'Cotistion reguliere du staff',
                                      nbreParticipant: 24,
                                      soldeCotisation: '40000',
                                      nbreParticipantCotisationOK: 7,
                                      montantSanctionCollectee: '24000',
                                      isActive: 1,
                                    )),
                              );
                            } else {
                              return Container(
                                      margin: EdgeInsets.only(
                                          left: 7, right: 7, top: 3, bottom: 7),
                                      child: WidgetCotisationInProgress(
                                        contributionOneUser: '2000',
                                        heureCotisation: '12h30',
                                        dateCotisation: '21/02/2024',
                                        montantCotisations: 3000,
                                        motifCotisations:
                                            'Cotistion reguliere du staff',
                                        nbreParticipant: 24,
                                        soldeCotisation: '37000',
                                        nbreParticipantCotisationOK: 7,
                                        montantSanctionCollectee: '24000',
                                        isActive: 1,
                                        montantMin: "300",
                                      ))
                                  // Ajoutez ici le widget que vous souhaitez afficher pour false
                                  ;
                            }
                            // Ajoutez ici le widget que vous souhaitez afficher pour true
                          },
                        )),
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
                      "Toutes vos sanctions",
                      style: TextStyle(
                          color: const Color.fromRGBO(20, 45, 99, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: tabs.length,
                        itemBuilder: (context, index) {
                          bool valeurBool = tabs[index];

                          if (valeurBool) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailSeancePage1(),
                                  ),
                                );
                              },
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 7, right: 7, top: 3, bottom: 7),
                                  child: WidgetSanctionNonPayeeIsMoney(
                                    dateSanction: '23/20/2021',
                                    heureSanction: '21h12',
                                    montantPayeeSanction: '100',
                                    montantSanction: "1200",
                                    motifSanction:
                                        "Non participation à la tontine",
                                  )),
                            );
                          } else {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetSanctionNonPayeeIsOther(
                                dateSanction: '23/20/2021',
                                heureSanction: '21h12',
                                objetSanction:
                                    "Deux casiers de petite Guinness",
                                motifSanction: "Vous etes arrivee en retard",
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
                      "Les comptes de l'association",
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
                            for (var i = 0; i < 5; i++)
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 7,
                                  right: 5,
                                  top: 5,
                                  left: 5,
                                ),
                                child: WidgetCompteCard(
                                  montantCompte: '3000',
                                  nomCompte: 'Compte Epagne',
                                  numeroCompte: '01',
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
  }
}
