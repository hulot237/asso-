import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetDetailTontineCard extends StatefulWidget {
  WidgetDetailTontineCard({
    super.key,
    required this.nomTontine,
    required this.montantTontine,
    required this.positionBeneficiaire,
    required this.nbrMembreTontine,
    required this.dateCreaTontine,
    required this.isActive,
  });

  String dateCreaTontine;
  String nomTontine;
  String montantTontine;
  String positionBeneficiaire;
  String nbrMembreTontine;
  int isActive;

  @override
  State<WidgetDetailTontineCard> createState() =>
      _WidgetDetailTontineCardState();
}

class _WidgetDetailTontineCardState extends State<WidgetDetailTontineCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(69, 0, 0, 0),
            spreadRadius: 0.5,
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(15.r),
      ),

      // decoration: BoxDecoration(
      //   color: Color.fromARGB(255, 255, 255, 255),
      //   borderRadius: BorderRadius.circular(7),
      //   boxShadow: [
      //     BoxShadow(
      //         color: Color.fromARGB(69, 0, 0, 0),
      //         spreadRadius: 1,
      //         blurRadius: 5),
      //   ],
      // ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 12.w, bottom: 5.h, right: 12.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.h, bottom: 7.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        // flex: 1,
                        child: Container(
                          // margin: EdgeInsets.only(right: 15),
                          child: Container(
                            child: Text(
                              widget.nomTontine,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackBlue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      widget.isActive == 1
                          ? Container(
                              padding: EdgeInsets.all(5.r),
                              decoration: BoxDecoration(
                                color: AppColors.green.withOpacity(.2),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text(
                                "en_cours".tr(),
                                style: TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                ),
                              ),
                            )
                          : Text(
                              "terminé".tr(),
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "ouverture".tr(),
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.blackBlueAccent1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          " ${formatDateLiteral(widget.dateCreaTontine)}",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.blackBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "${"bénéficiaires".tr()} (${widget.positionBeneficiaire}/${widget.nbrMembreTontine})",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackBlueAccent1,
                                ),
                              ),
                              margin: EdgeInsets.only(right: 5.w),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                "montant".tr(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackBlueAccent1,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              child: Text(
                                "${formatMontantFrancais(double.parse(widget.montantTontine))} FCFA",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.blackBlue,
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
          ),
        ],
      ),
    );
  }
}
