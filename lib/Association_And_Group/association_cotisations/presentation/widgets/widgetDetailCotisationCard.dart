import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:flutter/material.dart';

class widgetDetailCotisationCard extends StatefulWidget {
  widgetDetailCotisationCard({    super.key,
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
  State<widgetDetailCotisationCard> createState() =>
      _widgetDetailCotisationCardState();
}

class _widgetDetailCotisationCardState
    extends State<widgetDetailCotisationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      alignment: Alignment.center,
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(top: 10, bottom: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        // flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  widget.motifCotisations,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(20, 45, 99, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                              Modal().showModalActionPayement(context);
                            },
                        child: widget.isActive == 1? Container(
                           padding: EdgeInsets.only(left: 8, right: 8, top:5, bottom: 5 ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 162, 255, 1),
                            borderRadius: BorderRadius.circular(15),
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Color.fromARGB(122, 65, 65, 65),
                            //       spreadRadius: 0.1,
                            //       blurRadius: 1,
                            //       offset: Offset(0.5, 2)),
                            // ],
                          ),
                          child: Text(
                            "cotiser".tr(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ):Container(
                          height: 25,
                          width: 49,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),

                            // color: Color.fromARGB(33, 255, 0, 0),
                          ),
                          child: Container(
                            // color: Colors.black,
                            child: Text(
                              "Expiré",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color.fromARGB(255, 255, 0, 0),
                              ),
                            ),
                          ),
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
                        padding: EdgeInsets.all(7),
                        margin: EdgeInsets.only(bottom: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(20, 9, 185, 255),
                        ),
                        child: Container(
                          child: Text(
                            "Type: Volontaire",
                            style: TextStyle(
                              color: Color.fromARGB(255, 20, 45, 99),
                            ),
                          ),
                        ),
                      ),
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
                                widget.dateCotisation,
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
                  // width: MediaQuery.of(context).size.width / 1.1,
                  margin: EdgeInsets.only(bottom: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                    Modal().showModalTransactionByEvent(context);
                  },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "Vous avez cotisé",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                  ),
                                ),
                                margin: EdgeInsets.only(right: 5),
                              ),
                              Container(
                                child: Text(
                                  "${formatMontantFrancais(double.parse(widget.contributionOneUser))} FCFA",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromARGB(255, 20, 45, 99)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                            Modal().showModalAllTransactionCotisation(context);
                          },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  "Solde",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${formatMontantFrancais(double.parse(widget.soldeCotisation))} FCFA",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                              Modal().showModalPersonSanctionner(context);
                            },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 3),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  "Sanction future:",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Color.fromARGB(160, 255, 32, 32),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${formatMontantFrancais(double.parse(widget.montantSanctionCollectee))} FCFA",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 255, 32, 32),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Modal().showModalAllTransactionCotisation(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(38, 20, 45, 99),
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(
                                top: 3, left: 5, right: 2, bottom: 3),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  child: Text(
                                    "Transactions",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromARGB(255, 20, 45, 99),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    Icons.keyboard_double_arrow_right_rounded,
                                    size: 13,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                  ),
                                )
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
        ],
      ),
    );
  }
}
