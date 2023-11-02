import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetCotisationExpireInFixed extends StatefulWidget {
  WidgetCotisationExpireInFixed({
    super.key,
    required this.montantCotisations,
    required this.motifCotisations,
    required this.dateCotisation,
    required this.heureCotisation,
    required this.soldeCotisation,
    required this.contributionOneUser,
    required this.nbreParticipant,
    required this.nbreParticipantCotisationOK,
    required this.isActive,
    required this.codeCotisation,
    required this.type,
    required this.lienDePaiement,
  });
  int montantCotisations;
  String motifCotisations;
  String dateCotisation;
  String heureCotisation;
  String soldeCotisation;
  String contributionOneUser;
  int nbreParticipant;
  int nbreParticipantCotisationOK;
  int isActive;
  String codeCotisation;
  String type;
  String lienDePaiement;

  @override
  State<WidgetCotisationExpireInFixed> createState() =>
      _WidgetCotisationExpireInFixedState();
}

class _WidgetCotisationExpireInFixedState
    extends State<WidgetCotisationExpireInFixed> {
  Future<void> handleDetailCotisation(codeCotisation) async {
    final detailCotisation = await context
        .read<CotisationDetailCubit>()
        .detailCotisationCubit(codeCotisation);

    if (detailCotisation != null) {
      print("objaaaaaaaaaaaaaaaaaa  ${detailCotisation}");
      // print(
      //     "aaaaaaaaaaaaaaaaaaaaaqqqqq  ${context.read<CotisationCubit>().state.detailCotisation}");
    } else {
      print("userGroupDefault null");
    }
  }

  // var contributionOneUser;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CotisationCubit, CotisationState>(
        builder: (context, state) {
      // if (state.detailCotisation == null) return Container();

      // final currentDetailCotisation = context.read<CotisationCubit>().state.detailCotisation;

      // for (var itemDetailCotisation in currentDetailCotisation!["versements"]) {
      //   if (itemDetailCotisation["membre_code"] == AppCubitStorage().state.membreCode) {
      //      contributionOneUser = itemDetailCotisation["balance_after"];

      //   }
      // }

      return GestureDetector(
        onTap: () {
          handleDetailCotisation(widget.codeCotisation);
          context.read<CotisationDetailCubit>().state.detailCotisation;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailCotisationPage(
                lienDePaiement: widget.lienDePaiement,
                contributionOneUser: widget.contributionOneUser,
                dateCotisation: widget.dateCotisation,
                heureCotisation: widget.heureCotisation,
                montantCotisations: widget.montantCotisations,
                motifCotisations: widget.motifCotisations,
                nbreParticipant: widget.nbreParticipant,
                nbreParticipantCotisationOK: widget.nbreParticipantCotisationOK,
                soldeCotisation: widget.soldeCotisation,
                type: widget.type,
                isActive: 0,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 230, 230, 230),
            border: Border.all(
              width: 1,
              color: Colors.white,
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
                                          color:
                                              Color.fromARGB(160, 20, 45, 99),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  String msg =
                                      "Aide-moi à payer ma cotisation *${widget.motifCotisations}*.\nMontant: *${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement} pour valider";
                                  Modal().showModalActionPayement(
                                    context,
                                    msg,
                                    widget.lienDePaiement,
                                  );
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
                              Container(
                                // height: 25,
                                // width: 49,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),

                                  // color: Color.fromARGB(33, 255, 0, 0),
                                ),
                                child: Container(
                                  // color: Colors.black,
                                  child: Text(
                                    "expiré".tr(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 8,
                                      color: Color.fromARGB(255, 255, 0, 0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      padding: EdgeInsets.only(left: 5, right: 5),
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        // color: Color.fromARGB(20, 255, 27, 27),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "type_fixe".tr(),
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
                                    "${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA",
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
                                  margin: EdgeInsets.only(right: 3),
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
                          // Container(
                          //   child: Row(
                          //     children: [
                          //       Container(
                          //         child: Icon(
                          //           Icons.people_alt_rounded,
                          //           size: 16,
                          //           color: Color.fromARGB(255, 20, 45, 99),
                          //         ),
                          //         margin: EdgeInsets.only(right: 3),
                          //       ),
                          //       Container(
                          //         child: Text(
                          //           "${widget.nbreParticipantCotisationOK}/${widget.nbreParticipant}",
                          //           style: TextStyle(
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.w800,
                          //             color: Color.fromARGB(255, 20, 45, 99),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(bottom: 5),
                    //   width: MediaQuery.of(context).size.width / 1.1,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Container(
                    //         child: Row(
                    //           children: [
                    //             Container(
                    //               child: Text(
                    //                 "Vous avez cotisé :",
                    //                 style: TextStyle(
                    //                   fontSize: 11,
                    //                   fontWeight: FontWeight.bold,
                    //                   color: Color.fromARGB(255, 20, 45, 99),
                    //                 ),
                    //               ),
                    //               margin: EdgeInsets.only(right: 5),
                    //             ),
                    //             Container(
                    //               child: Text(
                    //                 "${formatMontantFrancais(double.parse(widget.contributionOneUser))} FCFA",
                    //                 style: TextStyle(
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w800,
                    //                   color: Color.fromARGB(255, 20, 45, 99),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.only(top: 5, bottom: 5),
                    //   alignment: Alignment.centerLeft,
                    //   // margin: EdgeInsets.only(bottom: 7),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     // color: Color.fromARGB(20, 255, 27, 27),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         child: Text(
                    //           "Sanction: ",
                    //           style: TextStyle(
                    //             fontSize: 11,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.red,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         child: Text(
                    //           "${formatMontantFrancais(double.parse(widget.montantSanctionCollectee))} FCFA",
                    //           style: TextStyle(
                    //             fontSize: 12,
                    //             fontWeight: FontWeight.w800,
                    //             color: Colors.red,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    //   // margin: EdgeInsets.only(right: 5),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
