import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetCotisationInProgress extends StatefulWidget {
   WidgetCotisationInProgress({    super.key,
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
    required this.montantMin,
    required this.codeCotisation,
    required this.type,
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
  String montantMin;
  String codeCotisation;
  String type;

  @override
  State<WidgetCotisationInProgress> createState() =>
      _WidgetCotisationInProgressState();
}

class _WidgetCotisationInProgressState
    extends State<WidgetCotisationInProgress> {

        Future<void> handleDetailCotisation(codeCotisation) async {
    // final detailTournoiCourant = await context
    //     .read<DetailTournoiCourantCubit>()
    //     .detailTournoiCourantCubit();
    final detailCotisation =
        await context.read<CotisationCubit>().detailCotisationCubit(codeCotisation);

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
    return GestureDetector(
      onTap: () {
                handleDetailCotisation(widget.codeCotisation);
        print("ééééééééééééééééééééééééééééééé");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailCotisationPage(
              contributionOneUser: widget.contributionOneUser,
              dateCotisation: widget.dateCotisation,
              heureCotisation: widget.heureCotisation,
              montantCotisations: widget.montantCotisations,
              // montantSanctionCollectee: widget.montantSanctionCollectee,
              motifCotisations: widget.motifCotisations,
              nbreParticipant: widget.nbreParticipant,
              nbreParticipantCotisationOK: widget.nbreParticipantCotisationOK,
              soldeCotisation: widget.soldeCotisation,
              isActive:widget.isActive, type: widget.type,
            ),
          ),
        );
      },
      child: Container(
        // margin: EdgeInsets.only(
        //   left: 3,
        //   right: 3,
        // ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          
          // border: Border(
          //   left: BorderSide(width: 5, color: Colors.black)
          // )
        ),
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 7),
                                child: Text(
                                  widget.motifCotisations,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(20, 45, 99, 1),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${widget.dateCotisation} : ${widget.heureCotisation}",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Color.fromARGB(160, 20, 45, 99),
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                              Modal().showModalActionPayement(context, "zz");
                            },
                          child: Container(
                             padding: EdgeInsets.only(left: 8, right: 8, top:5, bottom: 5 ),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 162, 255, 1),
                                borderRadius: BorderRadius.circular(15),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color:
                                //         Color.fromARGB(122, 65, 65, 65),
                                //     spreadRadius: 0.1,
                                //     blurRadius: 1,
                                //     offset: Offset(0.5, 2)
                                //   ),
                                // ],
                                ),
                            child: Container(
                              child: Text(
                                "cotiser".tr(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    // padding: EdgeInsets.only(left: 5, right: 5),
                    width: MediaQuery.of(context).size.width / 1.1,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(5),
                    //   // color: Color.fromARGB(20, 9, 185, 255),
                    // ),
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
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "Min ",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color.fromARGB(255, 20, 45, 99),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 20, 45, 99),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
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
                                "${formatMontantFrancais(double.parse(widget.soldeCotisation))} FCFA",
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
                                    color: Color.fromARGB(255, 20, 45, 99)),
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Modal().showModalTransactionByEvent(context, [], widget.montantCotisations);
                  //   },
                  //   child: Container(
                  //     // color: Colors.brown,
                  //     padding: EdgeInsets.only(top: 3, bottom: 5),
                  //     // width: MediaQuery.of(context).size.width / 1.1,
                  //     child: Row(
                  //       // mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () {
                  //             Modal().showModalTransactionByEvent(context, [], widget.montantCotisations);
                  //           },
                  //           child: Container(
                  //             child: Row(
                  //               // crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: [
                  //                 Container(
                  //                   child: Text(
                  //                     "Vous avez cotisé :",
                  //                     style: TextStyle(
                  //                       fontSize: 11,
                  //                       fontWeight: FontWeight.bold,
                  //                       color: Color.fromARGB(255, 20, 45, 99),
                  //                     ),
                  //                   ),
                  //                   margin: EdgeInsets.only(right: 5),
                  //                 ),
                  //                 Container(
                  //                   child: Text(
                  //                     "${formatMontantFrancais(double.parse(widget.contributionOneUser))} FCFA",
                  //                     style: TextStyle(
                  //                         fontSize: 12,
                  //                         fontWeight: FontWeight.w800,
                  //                         color: Color.fromARGB(255, 20, 45, 99)),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
