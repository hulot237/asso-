import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';

class WidgetSanction extends StatefulWidget {
  WidgetSanction({
    super.key,
    required this.heureSanction,
    required this.dateSanction,
    required this.motifSanction,
    required this.montantSanction,
    required this.montantPayeeSanction,
    required this.lienPaiement,
    required this.versement,
    required this.isSanctionPayed,
    required this.typeSaction,
    required this.objetSanction,
  });
  String heureSanction;
  String dateSanction;
  String motifSanction;
  String montantPayeeSanction;
  String montantSanction;
  String lienPaiement;
  List versement;
  int isSanctionPayed;
  String typeSaction;
  String objetSanction;

  @override
  State<WidgetSanction> createState() => _WidgetSanctionState();
}

class _WidgetSanctionState extends State<WidgetSanction> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.typeSaction == "1")
          Modal().showModalTransactionByEvent(context, widget.versement, widget.montantSanction);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
              left: BorderSide(
                  width: 8,
                  color:
                      widget.isSanctionPayed == 0 ? AppColors.red : AppColors.green),
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
                                    widget.isSanctionPayed == 1 ?  formatDateLiteral(widget.dateSanction) : formatCompareDateReturnWellValueSanctionRecent(widget.dateSanction),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blackBlueAccent1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${widget.motifSanction}",
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.blackBlue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (widget.typeSaction == "1" &&
                              widget.isSanctionPayed == 0)
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "a_payer".tr(),
                                      style: TextStyle(fontSize: 12, color: AppColors.blackBlue),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${formatMontantFrancais(double.parse(widget.montantSanction))} FCFA",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.red,),
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
                      color: widget.isSanctionPayed == 0
                          ? AppColors.red
                          : AppColors.green,
                    ),
                    widget.typeSaction == "1" && widget.isSanctionPayed == 0
                        ? Container(
                            margin: EdgeInsets.only(bottom: 8),
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    String msg =
                                        "Aide-moi à payer ma sanction de *${widget.motifSanction}* du montant  *${formatMontantFrancais(double.parse(widget.montantSanction))} FCFA* directement via le lien https://${widget.lienPaiement}.";
                                    Modal().showModalActionPayement(
                                      context,
                                      msg,
                                      widget.lienPaiement,
                                    );
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          child:
                                              Text("voulez_vous_payer?".tr(), style: TextStyle(
                                                color: AppColors.blackBlue,
                                              ),),
                                          margin: EdgeInsets.only(right: 10),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 5,
                                              bottom: 5),
                                          decoration: BoxDecoration(
                                            color: AppColors.colorButton,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Text(
                                            "oui".tr(),
                                            style: TextStyle(
                                                color: AppColors.white,
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
                                          "déjà_payé".tr(),
                                          style: TextStyle(fontSize: 12, color: AppColors.blackBlue),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${formatMontantFrancais(double.parse(widget.montantPayeeSanction))} FCFA",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.green),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : widget.typeSaction == "1" &&
                                widget.isSanctionPayed == 1
                            ? Container(
                                margin: EdgeInsets.only(bottom: 8),
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              "a_payer".tr(),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "${formatMontantFrancais(double.parse(widget.montantSanction))} FCFA",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                  color: AppColors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: Text(
                                              "déjà_payé".tr(),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "${formatMontantFrancais(double.parse(widget.montantPayeeSanction))} FCFA",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                  color: AppColors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(bottom: 8),
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            child:
                                                Text("${widget.objetSanction}"),
                                            margin: EdgeInsets.only(right: 10),
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
        ),
      ),
    );
  }
}
