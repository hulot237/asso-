import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/WidgetSanctionNonPayeeIsOther.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionNonPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsOther.dart';
import 'package:flutter/material.dart';

class SanctionPage extends StatefulWidget {
  const SanctionPage({super.key});

  @override
  State<SanctionPage> createState() => _SanctionPageState();
}

class _SanctionPageState extends State<SanctionPage> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final screens = [
    //   WidgetSanctionNonPayeeIsMoney(),
    //   WidgetSanctionNonPayeeIsOther()
    // ];

    var Tab = [true, false, false, true, false, true];

    return Scaffold(
            backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text("Saction"),
        backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
        elevation: 0,
      ),
      body: Column(
        children: [
          
          Container(
            margin: EdgeInsets.all(15),
            child: CustomSlidingSegmentedControl<int>(
              padding: 10,
              // height: 25,
              initialValue: 0,
              children: {
                0: Row(
                  children: [
                    Text(
                      'Sanctions non payées',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 13,
                      width: 13,
                      margin: EdgeInsets.only(left: 3),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "${Tab.length}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                1: Text(
                  'Sanctions payées',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              },
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black),
                color: Color.fromARGB(85, 9, 185, 255),
                borderRadius: BorderRadius.circular(8),
              ),
              thumbDecoration: BoxDecoration(
                // Color.fromARGB(255, 9, 185, 255),
                color: Color.fromARGB(255, 9, 185, 255),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(97, 0, 0, 0),
                    blurRadius: 5.0,
                    spreadRadius: 0.1,
                    // offset: Offset(
                    //   0.0,
                    //   2.0,
                    // ),
                  ),
                ],
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
            child: _pageIndex == 0
                ? ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: Tab.length,
                    itemBuilder: (context, index) {
                      // Vérifiez la valeur du booléen à l'index actuel
                      bool valeurBool = Tab[index];

                      // Renvoyez un widget différent en fonction de la valeur du booléen
                      if (valeurBool) {
                        return WidgetSanctionNonPayeeIsMoney(
                           dateSanction: '23/20/2021',
                                heureSanction: '21h12',
                                montantPayeeSanction: '200',
                                montantSanction: "1200",
                                motifSanction: "Retard de paiement de la tontine de 5000 FCFA",
                        )
                            // Ajoutez ici le widget que vous souhaitez afficher pour true
                            ;
                      } else {
                        return WidgetSanctionNonPayeeIsOther(dateSanction: '23/20/2021',
                                heureSanction: '21h12',
                                objetSanction: "ddddddddddddddd",
                                motifSanction: "Retard de paiement de la tontine de 5000 FCFA",)
                            // Ajoutez ici le widget que vous souhaitez afficher pour false
                            ;
                      }
                    },
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: Tab.length,
                    itemBuilder: (context, index) {
                      // Vérifiez la valeur du booléen à l'index actuel
                      bool valeurBool = Tab[index];

                      // Renvoyez un widget différent en fonction de la valeur du booléen
                      if (valeurBool) {
                        return WidgetSanctionPayeeIsMoney(
                          dateSanction: '23/20/2021',
                                heureSanction: '21h12',
                                montantPayeeSanction: '0',
                                montantSanction: "1200",
                                motifSanction: "Retard de paiement de la tontine de 5000 FCFA",
                        )
                            // Ajoutez ici le widget que vous souhaitez afficher pour true
                            ;
                      } else {
                        return WidgetSanctionPayeeIsOther(
                          dateSanction: '23/20/2021',
                                heureSanction: '21h12',
                                objetSanction: "ddddddddddddddd",
                                motifSanction: "Retard de paiement de la tontine de 5000 FCFA",
                        )
                            // Ajoutez ici le widget que vous souhaitez afficher pour false
                            ;
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
