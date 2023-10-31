import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class widgetDetailHistoriqueTontineCard extends StatefulWidget {
  widgetDetailHistoriqueTontineCard(
      {super.key,
      required this.nomBeneficiaire,
      required this.prenomBeneficiaire,
      required this.dateOpen,
      required this.dateClose,
      required this.montantTontine,
      required this.montantCollecte,
      required this.codeCotisation,
      required this.lienDePaiement,});
  String nomBeneficiaire;
  String dateClose;
  String dateOpen;
  String montantCollecte;
  int montantTontine;
  String prenomBeneficiaire;
  String codeCotisation;
  String lienDePaiement;

  @override
  State<widgetDetailHistoriqueTontineCard> createState() =>
      _widgetDetailHistoriqueTontineCardState();
}

class _widgetDetailHistoriqueTontineCardState
    extends State<widgetDetailHistoriqueTontineCard> {


        Future<void> handleDetailCotisation(codeCotisation) async {
    final detailCotisation = await context
        .read<CotisationCubit>()
        .detailCotisationCubit(codeCotisation);

    if (detailCotisation != null) {
      print("objaaaaaaaaaaaaaaaaaa  ${detailCotisation}");
      print(
          "aaaaaaaaaaaaaaaaaaaaaqqqqq  ${context.read<CotisationCubit>().state.detailCotisation}");
    } else {
      print("userGroupDefault null");
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
                                // margin: EdgeInsets.only(top: 3),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "${"Bénéficiaire".tr()} :",
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
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "${widget.nomBeneficiaire}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(20, 45, 99, 1),
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
                        onTap: () async {
                                Modal().showModalActionPayement(
                                    context,
                                    widget.lienDePaiement);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 162, 255, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            child: Text(
                              "Tontiner",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         child: Text(
                      //           "rencontre".tr(),
                      //           style: TextStyle(
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.w300,
                      //             color: Color.fromRGBO(20, 45, 99, 1),
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         child: Text(
                      //           " 01S01",
                      //           style: TextStyle(
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.bold,
                      //             color: Color.fromRGBO(20, 45, 99, 1),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   child: Text(
                      //     "Bénéficiaire(3/20)",
                      //     style: TextStyle(
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w500,
                      //       color: Color.fromARGB(255, 20, 45, 99),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        child: Text(
                          "${widget.dateOpen} - ${widget.dateClose}",
                          style: TextStyle(
                              fontSize: 10,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(123, 20, 45, 99)),
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
                                        "${formatMontantFrancais(double.parse("${widget.montantTontine}"))} FCFA",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color.fromARGB(255, 20, 45, 99),
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
                                "${formatMontantFrancais(double.parse("${widget.montantCollecte}"))} FCFA",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green,
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
