import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:flutter/material.dart';

class WidgetDetailTontineCard extends StatefulWidget {
WidgetDetailTontineCard({super.key, 
    required this.nomTontine,
  required this.montantTontine,
  required this.positionBeneficiaire,
  required this.nbrMembreTontine,
  required this.dateCreaTontine,
  });

String dateCreaTontine;
String nomTontine;
String montantTontine;
  String positionBeneficiaire;
String nbrMembreTontine;

  @override
  State<WidgetDetailTontineCard> createState() =>
      _WidgetDetailTontineCardState();
}

class _WidgetDetailTontineCardState
    extends State<WidgetDetailTontineCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(69, 0, 0, 0),
              spreadRadius: 0.5,
              blurRadius: 2),
        ],
        borderRadius: BorderRadius.circular(15),
      ),


      // decoration: BoxDecoration(
      //   color: Color.fromARGB(255, 255, 255, 255),
      //   borderRadius: BorderRadius.circular(7),
      //   boxShadow: [
      //     BoxShadow(
      //         color: Color.fromARGB(69, 0, 0, 0),
      //         spreadRadius: 1,
      //         blurRadius: 5),
      //   ],
      // ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 12, bottom: 5, right: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        // flex: 1,
                        child: Container(
                          // margin: EdgeInsets.only(right: 15),
                          child: Container(
                            child: Text(
                              widget.nomTontine,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(20, 45, 99, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(61, 76, 175, 79),
                          borderRadius: BorderRadius.circular(5),
                          
                        ),
                        child: Text(
                          "En cours",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(bottom: 3, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "Ouverture:",
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromARGB(160, 20, 45, 99),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.dateCreaTontine,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "Bénéficiaires(${widget.positionBeneficiaire}/${widget.nbrMembreTontine})",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(146, 20, 45, 99),
                                ),
                              ),
                              margin: EdgeInsets.only(right: 5),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                "montant".tr(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(120, 20, 45, 99),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${formatMontantFrancais(double.parse(widget.montantTontine) )} FCFA",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromARGB(255, 20, 45, 99),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
