import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class widgetDetailCotisationCard extends StatefulWidget {
  widgetDetailCotisationCard({
    super.key,
    required this.montantCotisations,
    required this.motifCotisations,
    required this.dateCotisation,
    required this.heureCotisation,
    required this.soldeCotisation,
    // required this.montantSanctionCollectee,
    required this.isPassed,
    required this.type,
    required this.lienDePaiement,
  });
  int montantCotisations;
  String motifCotisations;
  String dateCotisation;
  String heureCotisation;
  String soldeCotisation;
  String type;
  String lienDePaiement;
  // String montantSanctionCollectee;
  int isPassed;

  @override
  State<widgetDetailCotisationCard> createState() =>
      _widgetDetailCotisationCardState();
}

class _widgetDetailCotisationCardState
    extends State<widgetDetailCotisationCard> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(69, 0, 0, 0),
                spreadRadius: 0.5,
                blurRadius: 2),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          // flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    widget.motifCotisations,
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
                        ),
                        BlocBuilder<CotisationDetailCubit,
                            CotisationDetailState>(
                          builder: (CotisationContext, CotisationState) {
                            if (CotisationState.isLoading == null ||
                                CotisationState.isLoading == true ||
                                CotisationState.detailCotisation == null)
                              return Container(
                                width: 60,
                                height: 25,
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.bleuLight,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 0.5,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              );

                            final currentDetailCotisation =
                                CotisationContext.read<CotisationDetailCubit>()
                                    .state
                                    .detailCotisation;
                            return Column(
                              children: [
                                if (currentDetailCotisation!["members"].length >0)
                                  for (var itemDetailCotisation in currentDetailCotisation!["members"])
                                    if (itemDetailCotisation["membre"]["membre_code"] == AppCubitStorage().state.membreCode)
                                      GestureDetector(
                                        onTap: () async {
                                          String msg =
                                              "Aide-moi à payer ma cotisation *${widget.motifCotisations}* .\nMontant: *${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement} pour valider";
                                          Modal().showModalActionPayement(
                                            context,
                                            msg,
                                            widget.lienDePaiement,
                                          );
                                        },
                                        child: widget.isPassed == 0
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  top: 5,
                                                  bottom: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.colorButton,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Text(
                                                  "cotiser".tr(),
                                                  style: TextStyle(
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                              )
                                            : Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      String msg =
                                                          "Aide-moi à payer ma cotisation *${widget.motifCotisations}* .\nMontant: *${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement} pour valider";
                                                      Modal()
                                                          .showModalActionPayement(
                                                        context,
                                                        msg,
                                                        widget.lienDePaiement,
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                        left: 8,
                                                        right: 8,
                                                        top: 5,
                                                        bottom: 5,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.colorButton,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Container(
                                                        child: Text(
                                                          "cotiser".tr(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                            color: AppColors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                    child: Container(
                                                      child: Text(
                                                        "expiré".tr(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 8,
                                                          color: Color.fromARGB(
                                                              255, 255, 0, 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                if (currentDetailCotisation!["versements"].length > 0)
                                  for (var itemDetailCotisation in currentDetailCotisation!["versements"])
                                    if (itemDetailCotisation["membre_code"] == AppCubitStorage().state.membreCode)
                                    Container(),
                                      
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(7),
                          margin: EdgeInsets.only(bottom: 1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(20, 9, 185, 255),
                          ),
                          child: Container(
                            child: Text(
                              widget.type == "1"
                                  ? "type_volontaire".tr()
                                  : "type_fixe".tr(),
                              style: TextStyle(
                                color: AppColors.blackBlue,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "ouverture".tr(),
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Color.fromARGB(160, 20, 45, 99),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                child: Text(
                                  formatDateLiteral(widget.dateCotisation),
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.blackBlue,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
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
                        BlocBuilder<CotisationDetailCubit,
                                CotisationDetailState>(
                            builder: (CotisationContext, CotisationState) {
                          if (CotisationState.isLoading == null ||
                              CotisationState.isLoading == true ||
                              CotisationState.detailCotisation == null)
                            return GestureDetector(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "vous_avez_cotisé".tr(),
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              AppColors.blackBlue,
                                        ),
                                      ),
                                      margin: EdgeInsets.only(right: 5),
                                    ),
                                    Container(
                                      width: 12,
                                      height: 12,
                                      color: AppColors.white,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.bleuLight,
                                          strokeWidth: 0.5,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          final currentDetailCotisation =
                              CotisationContext.read<CotisationDetailCubit>()
                                  .state
                                  .detailCotisation;
                          return Column(
                            children: [
                              if (currentDetailCotisation!["versements"].length > 0)
                                for (var itemDetailCotisation in currentDetailCotisation!["versements"])
                                  if (itemDetailCotisation["membre_code"] == AppCubitStorage().state.membreCode)
                                    GestureDetector(
                                      onTap: () {
                                        Modal().showModalTransactionByEvent(
                                          context,
                                          itemDetailCotisation["versement"] !=
                                                  null
                                              ? itemDetailCotisation[
                                                  "versement"]
                                              : [],
                                          '${widget.montantCotisations}',
                                        );
                                      },
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                "vous_avez_cotisé".tr(),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 20, 45, 99),
                                                ),
                                              ),
                                              margin: EdgeInsets.only(right: 5),
                                            ),
                                            Container(
                                              child: Text(
                                                "${formatMontantFrancais(double.parse(itemDetailCotisation["versement"] != null ? itemDetailCotisation["versement"][0]["balance_after"] : "0"))} FCFA",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w800,
                                                    color: Color.fromARGB(
                                                        255, 20, 45, 99)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              if (currentDetailCotisation!["members"].length > 0)
                                for (var itemDetailCotisation in currentDetailCotisation!["members"])
                                  if (itemDetailCotisation["membre"]["membre_code"] == AppCubitStorage().state.membreCode)
                                    GestureDetector(
                                      onTap: () {
                                        Modal().showModalTransactionByEvent(
                                            // context, itemDetailCotisation["members"]["versement"]!=null? itemDetailCotisation["members"]["versement"] : [], '${widget.montantCotisations}');
                                            // context, itemDetailCotisation["versement"]!=null? itemDetailCotisation["versement"] : [], '${widget.montantCotisations}');
                                            context,
                                            itemDetailCotisation["membre"]["versement"] == null ? [] : itemDetailCotisation["membre"]["versement"],
                                            '${widget.montantCotisations}');
                                      },
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                "vous_avez_cotisé".tr(),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 20, 45, 99),
                                                ),
                                              ),
                                              margin: EdgeInsets.only(right: 5),
                                            ),
                                            Container(
                                              child: Text(
                                                "${formatMontantFrancais(double.parse(itemDetailCotisation["membre"]["versement"].length > 0 ? "${itemDetailCotisation["membre"]["versement"][0]["balance_after"]}" : "0"))} FCFA",
                                                // "${itemDetailCotisation["membre"]["versement"].length}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w800,
                                                    color: Color.fromARGB(
                                                        255, 20, 45, 99)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          );
                        }),
                        checkTransparenceStatus(
                    context
                        .read<UserGroupCubit>()
                        .state
                        .ChangeAssData!["user_group"]["configs"],
                    context.read<AuthCubit>().state.detailUser!["isMember"])
                            ? GestureDetector(
                                // onTap: () {
                                //   Modal()
                                //       .showModalAllTransactionCotisation(context);
                                // },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Text(
                                          "solde".tr(),
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                AppColors.blackBlue,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${formatMontantFrancais(double.parse(widget.soldeCotisation))} FCFA",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.green),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      // onTap: () {
                                      //   Modal().showModalPersonSanctionner(context, [], "");
                                      // },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 3),
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                "montant".tr(),
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color.fromARGB(
                                                        160, 20, 45, 99),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                widget.type == "1"
                                                    ? Container(
                                                        child: Text(
                                                          " : Volontaire",
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      20,
                                                                      45,
                                                                      99),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )
                                                    : Container(
                                                        child: Text(
                                                          " : ${formatMontantFrancais(double.parse("${widget.montantCotisations}"))} FCFA",
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      20,
                                                                      45,
                                                                      99),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                // Container(
                                                //   child: Text(
                                                //     " Min",
                                                //     overflow: TextOverflow.clip,
                                                //     style: TextStyle(
                                                //         fontSize: 7,
                                                //         color: Color.fromARGB(
                                                //             255, 20, 45, 99),
                                                //         fontWeight: FontWeight.w300),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       Modal()
                                    //           .showModalAllTransactionCotisation(context);
                                    //     },
                                    //     child: Container(
                                    //       decoration: BoxDecoration(
                                    //           color: Color.fromARGB(38, 20, 45, 99),
                                    //           borderRadius: BorderRadius.circular(7)),
                                    //       padding: EdgeInsets.only(
                                    //           top: 3, left: 5, right: 2, bottom: 3),
                                    //       child: Row(
                                    //         crossAxisAlignment: CrossAxisAlignment.end,
                                    //         children: [
                                    //           Container(
                                    //             child: Text(
                                    //               "transactions".tr(),
                                    //               style: TextStyle(
                                    //                 fontSize: 10,
                                    //                 fontWeight: FontWeight.w800,
                                    //                 color: AppColors.blackBlue,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //           Container(
                                    //             child: Icon(
                                    //               Icons.keyboard_double_arrow_right_rounded,
                                    //               size: 13,
                                    //               color: AppColors.blackBlue,
                                    //             ),
                                    //           )
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
                  if (checkTransparenceStatus(
                    context
                        .read<UserGroupCubit>()
                        .state
                        .ChangeAssData!["user_group"]["configs"],
                    context.read<AuthCubit>().state.detailUser!["isMember"]))
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            // onTap: () {
                            //   Modal().showModalPersonSanctionner(context, [], "");
                            // },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 3),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "montant".tr(),
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color:
                                              Color.fromARGB(160, 20, 45, 99),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      widget.type == "1"
                                          ? Container(
                                              child: Text(
                                                " : Volontaire",
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color.fromARGB(
                                                        255, 20, 45, 99),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          : Container(
                                              child: Text(
                                                " : ${formatMontantFrancais(double.parse("${widget.montantCotisations}"))} FCFA",
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color.fromARGB(
                                                        255, 20, 45, 99),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                      // Container(
                                      //   child: Text(
                                      //     " Min",
                                      //     overflow: TextOverflow.clip,
                                      //     style: TextStyle(
                                      //         fontSize: 7,
                                      //         color: Color.fromARGB(
                                      //             255, 20, 45, 99),
                                      //         fontWeight: FontWeight.w300),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       Modal()
                          //           .showModalAllTransactionCotisation(context);
                          //     },
                          //     child: Container(
                          //       decoration: BoxDecoration(
                          //           color: Color.fromARGB(38, 20, 45, 99),
                          //           borderRadius: BorderRadius.circular(7)),
                          //       padding: EdgeInsets.only(
                          //           top: 3, left: 5, right: 2, bottom: 3),
                          //       child: Row(
                          //         crossAxisAlignment: CrossAxisAlignment.end,
                          //         children: [
                          //           Container(
                          //             child: Text(
                          //               "transactions".tr(),
                          //               style: TextStyle(
                          //                 fontSize: 10,
                          //                 fontWeight: FontWeight.w800,
                          //                 color: AppColors.blackBlue,
                          //               ),
                          //             ),
                          //           ),
                          //           Container(
                          //             child: Icon(
                          //               Icons.keyboard_double_arrow_right_rounded,
                          //               size: 13,
                          //               color: AppColors.blackBlue,
                          //             ),
                          //           )
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
          ],
        ),
      ),
    );
  }
}
