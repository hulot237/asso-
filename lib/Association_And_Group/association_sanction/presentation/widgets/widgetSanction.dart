import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    required this.resteAPayer,
    required this.dejaPayer,
    required this.screenSource,
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
  String dejaPayer;
  String resteAPayer;
  String screenSource;

  @override
  State<WidgetSanction> createState() => _WidgetSanctionState();
}

class _WidgetSanctionState extends State<WidgetSanction> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.typeSaction == "1")
          Modal().showModalTransactionByEvent(
            context,
            widget.versement,
            widget.montantSanction,
            resteAPayer: widget.resteAPayer,
            dejaPayer: widget.dejaPayer,
          );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
              left: BorderSide(
                  width: 8.r,
                  color: widget.isSanctionPayed == 0
                      ? AppColors.red
                      : AppColors.green),
            ),
          ),
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      // color: Colors.deepPurple,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            // flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(right: 15.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 7.h),
                                    child: Text(
                                      widget.isSanctionPayed == 1
                                          ? formatDateLiteral(
                                              widget.dateSanction)
                                          : formatCompareDateReturnWellValueSanctionRecent(
                                              widget.dateSanction),
                                      style: TextStyle(
                                        fontSize: 12.sp,
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
                                          fontSize: 14.sp,
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
                                    padding: EdgeInsets.only(bottom: 7.h),
                                    child: Text(
                                      "a_payer".tr(),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.blackBlueAccent1,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${formatMontantFrancais(double.parse(widget.montantSanction))} FCFA",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                    Container(
                      height: 2.h,
                      margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                      width: MediaQuery.of(context).size.width / 1.1,
                      color: widget.isSanctionPayed == 0
                          ? AppColors.red
                          : AppColors.green,
                    ),
                    widget.typeSaction == "1" && widget.isSanctionPayed == 0
                        ? Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    String msg =
                                        "Aide-moi à payer ma sanction de *${widget.motifSanction}* du montant  *${formatMontantFrancais(double.parse(widget.montantSanction))} FCFA* directement via le lien https://${widget.lienPaiement}.";
                                    String raisonComplete =
                                        "Paiement de la sanction".tr();
                                    String motif = "payer_vous_même".tr();
                                    String paiementProcheMsg =
                                        "partager_le_lien_de_paiement".tr();
                                    String msgAppBarPaiementPage =
                                        "${'Paiement de la sanction'.tr()} ${widget.motifSanction}";
                                    Modal().showModalActionPayement(
                                      context,
                                      msg,
                                      widget.lienPaiement,
                                      raisonComplete,
                                      motif,
                                      paiementProcheMsg,
                                      msgAppBarPaiementPage,
                                    );
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            "voulez_vous_payer?".tr(),
                                            style: TextStyle(
                                              color: AppColors.blackBlue,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          margin: EdgeInsets.only(right: 5.w),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 45.w,
                                          padding: EdgeInsets.only(
                                            // left: 2,
                                            // right: 2,
                                            top: 2.h,
                                            bottom: 2.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.colorButton,
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Text(
                                            "oui".tr(),
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 2.h),
                                        child: Text(
                                          "déjà_payé".tr(),
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: AppColors.blackBlueAccent1,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${formatMontantFrancais(double.parse(widget.montantPayeeSanction))} FCFA",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w900,
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
                                margin: EdgeInsets.only(bottom: 8.h),
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
                                            padding:
                                                EdgeInsets.only(bottom: 2.h),
                                            child: Text(
                                              "a_payer".tr(),
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color:
                                                    AppColors.blackBlueAccent1,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "${formatMontantFrancais(double.parse(widget.montantSanction))} FCFA",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w900,
                                                color: AppColors.green,
                                              ),
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
                                            padding:
                                                EdgeInsets.only(bottom: 2.h),
                                            child: Text(
                                              "déjà_payé".tr(),
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color:
                                                    AppColors.blackBlueAccent1,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "${formatMontantFrancais(double.parse(widget.montantPayeeSanction))} FCFA",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w900,
                                                color: AppColors.green,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(bottom: 8.h),
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Text(
                                              "${widget.objetSanction}",
                                              style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontSize: 12.sp),
                                            ),
                                            margin: EdgeInsets.only(
                                              right: 10.w,
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
        ),
      ),
    );
  }
}
