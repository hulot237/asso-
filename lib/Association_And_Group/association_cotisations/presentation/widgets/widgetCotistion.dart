import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetCotisation extends StatefulWidget {
  WidgetCotisation({
    super.key,
    required this.montantCotisations,
    required this.motifCotisations,
    required this.dateCotisation,
    required this.heureCotisation,
    required this.soldeCotisation,
    required this.codeCotisation,
    required this.type,
    required this.lienDePaiement,
    required this.is_tontine,
    required this.is_passed,
  });
  int montantCotisations;
  String motifCotisations;
  String dateCotisation;
  String heureCotisation;
  String soldeCotisation;
  String codeCotisation;
  String type;
  String lienDePaiement;
  int is_tontine;
  int is_passed;

  @override
  State<WidgetCotisation> createState() => _WidgetCotisationState();
}

class _WidgetCotisationState extends State<WidgetCotisation> {
  Future<void> handleDetailCotisation(codeCotisation) async {
    // final detailTournoiCourant = await context
    //     .read<DetailTournoiCourantCubit>()
    //     .detailTournoiCourantCubit();
    final detailCotisation = await context
        .read<CotisationDetailCubit>()
        .detailCotisationCubit(codeCotisation);

    if (detailCotisation != null) {
      print("objaaaaaaaaaaaaaaaaaa  ${detailCotisation}");
      print(
          "aaaaaaaaaaaaaaaaaaaaaqqqqq  ${context.read<CotisationDetailCubit>().state.detailCotisation}");
    } else {
      print("userGroupDefault null");
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CotisationCubit, CotisationState>(
        builder: (CotisationContext, CotisationState) {
      // if (CotisationState.detailCotisation != null) return Container();

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
          print("ééééééééééééééééééééééééééééééé");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailCotisationPage(
                codeCotisation: widget.codeCotisation,
                lienDePaiement: widget.lienDePaiement,
                dateCotisation: widget.dateCotisation,
                heureCotisation: widget.heureCotisation,
                montantCotisations: widget.montantCotisations,
                motifCotisations: widget.motifCotisations,
                soldeCotisation: widget.soldeCotisation,
                type: widget.type,
                isPassed: widget.is_passed,
              ),
            ),
          );
        },
        child: Container(
          // margin: EdgeInsets.only(left: 3, right: 3),

          decoration: widget.is_passed == 0
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.white,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.whiteAccent,
                  border: Border.all(
                    width: 1,
                    color: AppColors.white,
                  ),
                ),
          padding: EdgeInsets.only(left: 10, top: 5, bottom: 10, right: 10),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
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
                                        color: AppColors.blackBlue,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${widget.dateCotisation} : ${widget.heureCotisation}",
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color:AppColors.blackBlueAccent1,
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
                                    color: AppColors.colorButton,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Container(
                                    child: Text(
                                      "cotiser".tr(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (widget.is_passed == 1)
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Container(
                                    child: Text(
                                      "expiré".tr(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 8,
                                        color: AppColors.red,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    widget.type == "1"
                        ? Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            // padding: EdgeInsets.only(left: 5, right: 5),
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
                                    "type_volontaire".tr(),
                                    style: TextStyle(
                                      color: AppColors.blackBlue,
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
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA",
                                          style: TextStyle(
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "type_fixe".tr(),
                                    style: TextStyle(
                                      color: AppColors.blackBlue,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Text(
                                          "montant".tr(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA",
                                          style: TextStyle(
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                    if (checkTransparenceStatus(
                    context
                        .read<UserGroupCubit>()
                        .state
                        .ChangeAssData!["user_group"]["configs"],
                    context.read<AuthCubit>().state.detailUser!["isMember"]))
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
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
                                      color: AppColors.blackBlue,
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
                                        color: AppColors.green),
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
                            //           color: AppColors.blackBlue,
                            //         ),
                            //         margin: EdgeInsets.only(right: 5),
                            //       ),
                            //       Container(
                            //           child: Text(
                            //         "${widget.nbreParticipantCotisationOK}/${widget.nbreParticipant}",
                            //         style: TextStyle(
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w800,
                            //             color: AppColors.blackBlue,),
                            //       ))
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    // GestureDetector(
                    //   onTap: () {
                    //             Modal().showModalTransactionByEvent(context, [], widget.montantCotisations);
                    //           },
                    //   child: Container(
                    //     // color: Colors.deepOrangeAccent,
                    //     padding: EdgeInsets.only(top: 5, bottom: 5),
                    //     // width: MediaQuery.of(context).size.width / 1.1,
                    //     child: Container(
                    //       child: Row(
                    //         // mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Container(
                    //             child: Text(
                    //               "Vous avez cotisé :",
                    //               style: TextStyle(
                    //                 fontSize: 11,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: AppColors.blackBlue,
                    //               ),
                    //             ),
                    //             margin: EdgeInsets.only(right: 5),
                    //           ),
                    //           Container(
                    //             child: Text(
                    //               "${formatMontantFrancais(double.parse(widget.contributionOneUser))} FCFA",
                    //               style: TextStyle(
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w800,
                    //                 color: AppColors.blackBlue,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
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
    });
  }
}
