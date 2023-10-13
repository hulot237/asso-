import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:flutter/material.dart';

class WidgetSanctionNonPayeeIsMoney extends StatefulWidget {
  WidgetSanctionNonPayeeIsMoney({
    super.key,
    required this.heureSanction,
    required this.dateSanction,
    required this.motifSanction,
    required this.montantSanction,
    required this.montantPayeeSanction,
  });
  String heureSanction;
  String dateSanction;
  String motifSanction;
  String montantPayeeSanction;
  String montantSanction;

  @override
  State<WidgetSanctionNonPayeeIsMoney> createState() =>
      _WidgetSanctionNonPayeeIsMoneyState();
}

class _WidgetSanctionNonPayeeIsMoneyState
    extends State<WidgetSanctionNonPayeeIsMoney> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modal().showModalTransactionByEvent(context);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 8, color: Colors.red),
            ),
          ),
          padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
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
                                      "${widget.dateSanction} : ${widget.heureSanction}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(160, 20, 45, 99),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${widget.motifSanction}",
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: const Color.fromRGBO(
                                              20, 45, 99, 1),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "A payer",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${formatMontantFrancais(double.parse(widget.montantSanction))} FCFA",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      width: MediaQuery.of(context).size.width / 1.1,
                      color: Colors.red,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Modal().showModalActionPayement(context);
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Text("Voulez-vous payer?"),
                                    margin: EdgeInsets.only(right: 10),
                                  ),
                                  Container(
                                     padding: EdgeInsets.only(left: 8, right: 8, top:5, bottom: 5 ),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 162, 255, 1),
                                      borderRadius: BorderRadius.circular(15),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color:
                                      //           Color.fromARGB(122, 65, 65, 65),
                                      //       spreadRadius: 0.1,
                                      //       blurRadius: 1,
                                      //       offset: Offset(0.5, 2)),
                                      // ],
                                    ),
                                    child: Text(
                                      "Oui",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "Déjà payé",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${formatMontantFrancais(double.parse(widget.montantPayeeSanction))} FCFA",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.green),
                                  ),
                                )
                              ],
                            ),
                          )
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
