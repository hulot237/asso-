import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WidgetTontineRencontreCard extends StatefulWidget {
  WidgetTontineRencontreCard({
    super.key,
    required this.nomTontine,
    required this.dateTontine,
    required this.positionBeneficiaire,
    required this.nomBeneficiaire,
    required this.montantTontine,
    required this.montantCollecte,
    required this.nbrMembreTontine,
  });

  String nomTontine;
  String dateTontine;
  String positionBeneficiaire;
  String nomBeneficiaire;
  String montantTontine;
  String montantCollecte;
  String nbrMembreTontine;

  @override
  State<WidgetTontineRencontreCard> createState() =>
      _WidgetTontineRencontreCardState();
}

class _WidgetTontineRencontreCardState
    extends State<WidgetTontineRencontreCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          // margin: EdgeInsets.only(right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        widget.nomTontine,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        widget.dateTontine,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(20, 45, 99, 0.534),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        // onTap: () async {
                        //           String msg =
                        //               "Aide-moi à payer ma tontine ${widget.nomTontine}.\nMontant: ${formatMontantFrancais(widget.montantTontine.toDouble())} FCFA.\nMerci de suivre le lien ${widget.lienDePaiement} pour valider";
                        //           Modal().showModalActionPayement(
                        //             context,
                        //             msg,
                        //             widget,
                        //           );
                        //         },
                        child: Container(
                          padding: EdgeInsets.only(left: 8, right: 8, top:5, bottom: 5 ),
                          decoration: BoxDecoration(
                            color: AppColors.colorButton,
                            borderRadius: BorderRadius.circular(15),
                            
                          ),
                          child: Text(
                            "Tontiner",
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "${"bénéficiaire".tr()}(${widget.positionBeneficiaire}/${widget.nbrMembreTontine})",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(125, 20, 45, 99),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        child: Text(
                          widget.nomBeneficiaire,
                          style: TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackBlue,),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "montant".tr(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(125, 20, 45, 99),
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 3),
                                      child: Text(
                                        "${formatMontantFrancais(double.parse(widget.montantTontine))} FCFA",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                AppColors.blackBlue,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                "montant_collecté".tr(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(125, 20, 45, 99),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                "${formatMontantFrancais(double.parse(widget.montantCollecte))} FCFA",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.green,
                                    fontWeight: FontWeight.w600),
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
