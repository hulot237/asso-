import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class widgetRecentEventSanction extends StatefulWidget {
  widgetRecentEventSanction({
    super.key,
    required this.motif,
    required this.dateOpen,
    required this.montantSanction,
    required this.montantCollecte,
    required this.codeCotisation,
    required this.lienDePaiement,
    required this.libelleSanction,
    required this.type,
    required this.versement,
  });
  String motif;
  String dateOpen;
  String montantCollecte;
  int montantSanction;
  String codeCotisation;
  String lienDePaiement;
  String type;
  String libelleSanction;
  List versement;

  @override
  State<widgetRecentEventSanction> createState() =>
      _widgetRecentEventSanctionState();
}

class _widgetRecentEventSanctionState extends State<widgetRecentEventSanction> {
  Future<void> handleDetailCotisation(codeCotisation) async {
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
    return GestureDetector(
      onTap: () {
        if (widget.type == "1")
          Modal().showModalTransactionByEvent(
              context, widget.versement, widget.montantSanction.toString());
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.blackBlue,
              ),
              child: Text(
                "Sanction".tr(),
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 10,
              ),
              color: AppColors.white,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${widget.motif}",
                      // 'Voir bebe de l"enfant de djousse',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackBlue,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "${formatCompareDateReturnWellValueSanctionRecent(widget.dateOpen)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackBlueAccent1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "a_payer".tr(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackBlueAccent1,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.type == "1"
                                    ? "${formatMontantFrancais(double.parse("${widget.montantSanction}"))} FCFA"
                                    : "${widget.libelleSanction}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.blackBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (widget.type == "1")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  "Avance".tr(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackBlueAccent1,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${formatMontantFrancais(double.parse("${widget.montantCollecte}"))} FCFA",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (widget.type == "1")
                          GestureDetector(
                            onTap: () async {
                              String msg =
                                  "Aide-moi à payer ma sanction de *${widget.motif}* du montant  *${formatMontantFrancais(double.parse(widget.montantSanction.toString()))} FCFA* directement via le lien https://${widget.lienDePaiement}.";
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
                                  "Payer".tr(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Container(),
          ],
        ),
      ),
    );

    // return GestureDetector(

    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: AppColors.white,
    //       borderRadius: BorderRadius.circular(15),
    //     ),
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
    //     child: Row(
    //       children: [
    //         Expanded(
    //           child: Column(
    //             children: [
    //               Container(
    //                 margin: EdgeInsets.only(top: 7),
    //                 width: MediaQuery.of(context).size.width / 1.1,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Expanded(
    //                       child: Container(
    //                         // margin: EdgeInsets.only(right: 15),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Container(
    //                               // margin: EdgeInsets.only(top: 10, bottom: 10),
    //                               child: Column(
    //                                 crossAxisAlignment: CrossAxisAlignment.center,
    //                                 children: [

    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.end,
    //                         children: [
    //                           Container(
    //                             child: Text(
    //                               "Sanction".tr(),
    //                               style: TextStyle(
    //                                 fontSize: 12,
    //                                 fontWeight: FontWeight.w900,
    //                                 color: AppColors.blackBlue,
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(top: 7),
    //                 width: MediaQuery.of(context).size.width / 1.1,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Expanded(
    //                       child: Container(
    //                         // margin: EdgeInsets.only(right: 15),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Container(
    //                               // margin: EdgeInsets.only(top: 3),
    //                               child: Row(
    //                                 children: [
    //                                   Container(
    //                                     child: Text(
    //                                       "${"Motif".tr()} :",
    //                                       style: TextStyle(
    //                                         fontSize: 10,
    //                                         fontWeight: FontWeight.w500,
    //                                         color:
    //                                             Color.fromRGBO(20, 45, 99, 0.534),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             Container(
    //                               child: Text(
    //                                 "${widget.motif}",
    //                                 style: TextStyle(
    //                                   fontSize: 12,
    //                                   fontWeight: FontWeight.w600,
    //                                   color: AppColors.blackBlue,
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     if(widget.type=="1")
    //                     Expanded(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.end,
    //                         children: [
    //                           Container(
    //                             child: Text(
    //                               "Avance".tr(),
    //                               style: TextStyle(
    //                                 fontSize: 10,
    //                                 fontWeight: FontWeight.w500,
    //                                 color: AppColors.blackBlueAccent1,
    //                               ),
    //                             ),
    //                           ),
    //                           Container(
    //                             child: Text(
    //                               "${formatMontantFrancais(double.parse("${widget.montantCollecte}"))} FCFA",
    //                               style: TextStyle(
    //                                 fontSize: 12,
    //                                 color: AppColors.green,
    //                                 fontWeight: FontWeight.w600,
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Container(
    //                 // width: MediaQuery.of(context).size.width / 1.1,
    //                 margin: EdgeInsets.only(bottom: 7, top: 7),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Expanded(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             child: Text(
    //                               "a_payer".tr(),
    //                               style: TextStyle(
    //                                 fontSize: 10,
    //                                 fontWeight: FontWeight.w500,
    //                                 color: AppColors.blackBlueAccent1,
    //                               ),
    //                             ),
    //                           ),
    //                           Container(
    //                             child: Row(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Flexible(
    //                                   child: Container(
    //                                     child: Text(
    //                                       widget.type == "1"?
    //                                       "${formatMontantFrancais(double.parse("${widget.montantSanction}"))} FCFA": "${widget.libelleSanction}",
    //                                       overflow: TextOverflow.ellipsis,
    //                                       style: TextStyle(
    //                                         fontSize: 12,
    //                                         color: AppColors.blackBlue,
    //                                         fontWeight: FontWeight.w600,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     if(widget.type == "1")
    //                     GestureDetector(
    //                       onTap: () async {
    //                         String msg =
    //                                       "Aide-moi à payer ma sanction de *${widget.motif}* du montant  *${formatMontantFrancais(double.parse(widget.montantSanction.toString()))} FCFA* directement via le lien https://${widget.lienDePaiement}.";
    //                         Modal().showModalActionPayement(
    //                           context,
    //                           msg,
    //                           widget.lienDePaiement,
    //                         );
    //                       },
    //                       child: Container(
    //                         padding: EdgeInsets.only(
    //                             left: 8, right: 8, top: 5, bottom: 5),
    //                         decoration: BoxDecoration(
    //                           color: AppColors.colorButton,
    //                           borderRadius: BorderRadius.circular(15),
    //                         ),
    //                         child: Container(
    //                           child: Text(
    //                             "Payer".tr(),
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 12,
    //                               color: AppColors.white,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
