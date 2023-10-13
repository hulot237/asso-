import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:flutter/material.dart';

class WidgetCotisationExpireInProgress extends StatefulWidget {
   WidgetCotisationExpireInProgress({
    super.key,
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
  State<WidgetCotisationExpireInProgress> createState() =>
      _WidgetCotisationExpireInProgressState();
}

class _WidgetCotisationExpireInProgressState
    extends State<WidgetCotisationExpireInProgress> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailCotisationPage(
              contributionOneUser: widget.contributionOneUser,
              dateCotisation: widget.dateCotisation,
              heureCotisation: widget.heureCotisation,
              montantCotisations: widget.montantCotisations,
              montantSanctionCollectee: widget.montantSanctionCollectee,
              motifCotisations: widget.motifCotisations,
              nbreParticipant: widget.nbreParticipant,
              nbreParticipantCotisationOK: widget.nbreParticipantCotisationOK,
              soldeCotisation: widget.soldeCotisation,
              isActive: widget.isActive,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          margin: EdgeInsets.only(left: 3, right: 3),
          decoration: BoxDecoration(
            color: Color.fromARGB(216, 255, 255, 255),
            border: Border(
              left: BorderSide(
                width: 10,
                color: Color.fromARGB(20, 9, 185, 255),
              ),
            ),
          ),
          padding: EdgeInsets.only(left: 7, top: 5, bottom: 5),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      // color: Colors.deepPurple,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            // flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 7),
                                    child: Text(
                                      "Anniversaire de Paul BIYA",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(20, 45, 99, 1),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "12/02/2023 : 12h19",
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color:
                                              Color.fromARGB(160, 20, 45, 99),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 49,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: EdgeInsets.all(1),
                                backgroundColor: Color.fromARGB(110, 255, 0, 0),
                              ),
                              onPressed: () {
                                null;
                              },
                              child: Container(
                                // color: Colors.black,
                                child: Text(
                                  "Expiré",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      padding: EdgeInsets.all(7),
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Color.fromARGB(20, 9, 185, 255),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Type: Volontaire",
                              style: TextStyle(
                                color: Color.fromARGB(255, 20, 45, 99),
                              ),
                            ),
                          ),
                          Container(
                            // padding: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    "montant".tr(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 20, 45, 99),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Volontaire",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 20, 45, 99),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.wallet_rounded,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    size: 16,
                                  ),
                                  margin: EdgeInsets.only(right: 5),
                                ),
                                Container(
                                    child: Text(
                                  formatMontantFrancais(double.parse(widget.soldeCotisation)),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.green),
                                ))
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.people_alt_rounded,
                                    size: 16,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                  ),
                                  margin: EdgeInsets.only(right: 5),
                                ),
                                Container(
                                    child: Text(
                                  "${widget.nbreParticipantCotisationOK}/${widget.nbreParticipant}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.green),
                                ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3, bottom: 7),
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    "Vous avez cotisé :",
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
                                        color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Modal()
                                  .showModalAllTransactionCotisation(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(38, 20, 45, 99),
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.only(
                                  top: 3, left: 5, right: 2, bottom: 3),
                              child: Row(
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
