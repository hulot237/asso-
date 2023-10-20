import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:flutter/material.dart';

class WidgetSanctionPayeeIsMoney extends StatefulWidget {
  WidgetSanctionPayeeIsMoney({super.key,
  
    required this.heureSanction,
    required this.dateSanction,
    required this.motifSanction,
    required this.montantSanction,
    required this.montantPayeeSanction,
    required this.versement,
  });
  String heureSanction;
  String dateSanction;
  String motifSanction;
  String montantPayeeSanction;
  String montantSanction;
  List versement;
  @override
  State<WidgetSanctionPayeeIsMoney> createState() =>
      _WidgetSanctionPayeeIsMoneyState();
}

class _WidgetSanctionPayeeIsMoneyState
    extends State<WidgetSanctionPayeeIsMoney> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modal().showModalTransactionByEvent(context, widget.versement, widget.montantSanction);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 8, color: Colors.green),
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
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      width: MediaQuery.of(context).size.width / 1.1,
                      color: Colors.green,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color: Colors.green),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
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
