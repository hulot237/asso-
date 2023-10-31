import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class widgetTontineHistoriqueCard extends StatefulWidget {
  widgetTontineHistoriqueCard({
    super.key,
    required this.dateCreaTontine,
    required this.nomTontine,
    required this.montantTontine,
    required this.positionBeneficiaire,
    required this.nbrMembreTontine,
    required this.isActive
  });
  String dateCreaTontine;
  String nomTontine;
  String montantTontine;
  String positionBeneficiaire;
  String nbrMembreTontine;
  int isActive;
  @override
  State<widgetTontineHistoriqueCard> createState() =>
      _widgetTontineHistoriqueCardState();
}

class _widgetTontineHistoriqueCardState
    extends State<widgetTontineHistoriqueCard> {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isActive ==1? Colors.white: Color.fromARGB(12, 0, 0, 0),
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
                  margin: EdgeInsets.only(top: 7),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          // margin: EdgeInsets.only(right: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "${"ouverture".tr()} ",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(20, 45, 99, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // margin: EdgeInsets.only(top: 3),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        widget.dateCreaTontine,
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
                      widget.isActive ==1?
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(48, 76, 175, 79),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "en_cours".tr(),
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      ):Text(
                          "terminé".tr(),
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          // margin: EdgeInsets.only(right: 15),
                          child: Container(
                            child: Container(
                              child: Text(
                                widget.nomTontine,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(20, 45, 99, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: Container(
                                  child: Text(
                                    "montant".tr(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(20, 45, 99, 0.521),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Container(
                                  child: Text(
                                    "${formatMontantFrancais(double.parse(widget.montantTontine))} FCFA",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromRGBO(20, 45, 99, 1),
                                    ),
                                  ),
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
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "${"Participant".tr()} (${widget.nbrMembreTontine})",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(125, 20, 45, 99),
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
