import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationExpireInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInProgress.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/WidgetSanctionNonPayeeIsOther.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionNonPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetDetailRencontreCard.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/pages/detailSeancePage1.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetTontineRencontreCard.dart';
import 'package:flutter/material.dart';

class detailRencontrePage extends StatefulWidget {
   detailRencontrePage({super.key,
  required this.nomRecepteurRencontre,
  required this.identifiantRencontre,
  required this.isActiveRencontre,
  required this.descriptionRencontre,
  required this.lieuRencontre,
  required this.dateRencontre,
  required this.heureRencontre,

  });

String nomRecepteurRencontre;
String identifiantRencontre;
int isActiveRencontre;
String descriptionRencontre;
String lieuRencontre;
String dateRencontre;
  String heureRencontre;

  @override
  State<detailRencontrePage> createState() => _detailRencontrePageState();
}

class _detailRencontrePageState extends State<detailRencontrePage>
    with TickerProviderStateMixin {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, "end", "end"];
  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text("Detail de la rencontre", style: TextStyle(fontSize: 16),),
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
                dateRencontre: widget.dateRencontre,
                descriptionRencontre: widget.descriptionRencontre,
                heureRencontre: widget.heureRencontre,
                identifiantRencontre: widget.identifiantRencontre,
                isActiveRencontre: widget.isActiveRencontre,
                lieuRencontre: widget.lieuRencontre,
                nomRecepteurRencontre: widget.nomRecepteurRencontre,
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              height: 30,
              child: CustomSlidingSegmentedControl<int>(
                padding: 10,
                initialValue: 0,
                children: {
                  0: Row(
                    children: [
                      Text(
                        'Tontines',
                        style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 15),
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
                            fontSize: 15),
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
                            fontSize: 15),
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
                  padding: EdgeInsets.only(top: 7),
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 1,
                    color: Color.fromARGB(85, 9, 185, 255),
                  )),
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
                              itemCount: Tab.length,
                              itemBuilder: (context, index) {
                                var valeurBool = Tab[index];

                                if (valeurBool == true) {
                                  return GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 7, right: 7, top: 3, bottom: 7),
                                      child: WidgetCotisationInFixed(
                                        contributionOneUser: '2000',
                                        heureCotisation: '20h40',
                                        dateCotisation: '03/03/2034',
                                        montantCotisations: 5000,
                                        motifCotisations:
                                            'Fonds de developpement',
                                        nbreParticipant: 5,
                                        soldeCotisation: '20000',
                                        nbreParticipantCotisationOK: 4,
                                        montantSanctionCollectee: '24000',
                                        isActive: 1,
                                      ),
                                    ),
                                  );
                                } else if (valeurBool == false) {
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
                                      soldeCotisation: "25000",
                                      nbreParticipantCotisationOK: 7,
                                      montantSanctionCollectee: '24000',
                                      isActive: 1,
                                      montantMin: "200",
                                    ),
                                  );
                                } else {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 7, right: 7, top: 3, bottom: 7),
                                    child: WidgetCotisationExpireInFixed(
                                      contributionOneUser: '1500',
                                      motifCotisations:
                                          'Collecte pour l\'orphelinat coeur des anges',
                                      dateCotisation: '22/03/2023',
                                      montantCotisations: 3000,
                                      heureCotisation: '12h12',
                                      montantSanctionCollectee: '2000',
                                      nbreParticipantCotisationOK: 10,
                                      nbreParticipant: 12,
                                      soldeCotisation: '30000',
                                      isActive: 0,
                                    ),
                                  );
                                }
                              },
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              itemCount: Tab.length,
                              itemBuilder: (context, index) {
                                var valeurBool = Tab[index];
                                if (valeurBool == true) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 7, right: 7, top: 3, bottom: 7),
                                    child: WidgetSanctionNonPayeeIsMoney(
                                      dateSanction: '23/20/2012',
                                heureSanction: '21h30',
                                montantPayeeSanction: '200',
                                montantSanction: "1200",
                                motifSanction: "Retard de paiement de l'inscription",
                                    ),
                                  );
                                } else if (valeurBool == false) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 7, right: 7, top: 3, bottom: 7),
                                    child: WidgetSanctionNonPayeeIsOther(
                                      dateSanction: '23/20/2021',
                                heureSanction: '21h12',
                                objetSanction: "3 sacs de sels",
                                motifSanction: "Injure publique du president",
                                    ),
                                  );
                                } else {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 7, right: 7, top: 3, bottom: 7),
                                    child: WidgetSanctionPayeeIsMoney(
                                      dateSanction: '23/20/2021',
                                heureSanction: '21h12',
                                montantPayeeSanction: '1200',
                                montantSanction: "1200",
                                motifSanction: "Retard de paiement de la tontine de 5000 FCFA",
                                    ),
                                  );
                                }
                              },
                            )),
            ),
          ],
        ),
      ),
    );
  }
}
