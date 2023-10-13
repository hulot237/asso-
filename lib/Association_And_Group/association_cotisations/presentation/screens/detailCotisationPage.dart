import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetDetailCotisationCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetHistoriqueCotisation.dart';
import 'package:flutter/material.dart';

class DetailCotisationPage extends StatefulWidget {
  DetailCotisationPage({super.key,
    required this.montantCotisations,
    required this.motifCotisations,
    required this.dateCotisation,
    required this.heureCotisation,
    required this.soldeCotisation,
    required this.contributionOneUser,
    required this.nbreParticipant,
    required this.nbreParticipantCotisationOK,
    required this.montantSanctionCollectee,
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
  String montantSanctionCollectee;
  int isActive;

  @override
  State<DetailCotisationPage> createState() => _DetailCotisationPageState();
}

class _DetailCotisationPageState extends State<DetailCotisationPage> {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, false, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text("Detail de la cotisations", style: TextStyle(fontSize: 16),),
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
                montantSanctionCollectee: widget.montantSanctionCollectee,
                nbreParticipant: widget.nbreParticipant,
                nbreParticipantCotisationOK: widget.nbreParticipantCotisationOK,
                soldeCotisation: widget.soldeCotisation,
                isActive: widget.isActive
              ),
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
                          "(${Tab.length})",
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
                          "(4)",
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
                        itemCount: Tab.length,
                        itemBuilder: (context, index) {
                          // Vérifiez la valeur du booléen à l'index actuel
                          bool valeurBool = Tab[index];

                          return WidgetHistoriqueCotisation();
                        },
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: Tab.length,
                        itemBuilder: (context, index) {
                          // Vérifiez la valeur du booléen à l'index actuel
                          bool valeurBool = Tab[index];

                          return WidgetHistoriqueCotisation();
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
