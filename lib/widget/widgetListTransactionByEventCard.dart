import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class widgetListTransactionByEventCard extends StatefulWidget {
  widgetListTransactionByEventCard(
      {super.key, required this.date, required this.montant});
  String date;
  String montant;

  @override
  State<widgetListTransactionByEventCard> createState() =>
      _widgetListTransactionByEventCardState();
}

class _widgetListTransactionByEventCardState
    extends State<widgetListTransactionByEventCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.only(top: 5.h),
      child: Container(
        padding: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
                bottom: BorderSide(
              width: 0.5.r,
              color: Color.fromARGB(62, 20, 45, 99),
            ))),
        // margin: EdgeInsets.only(top: 5, left: 7, right: 7),
        // padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5.h),
                    child: Text(
                      "Date",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.blackBlue,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5.h),
                    child: Text(
                      widget.date,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(5.r),
                    child: Text(
                      "montant".tr(),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.blackBlue,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5.h),
                    child: Text(
                      "${formatMontantFrancais(double.parse(widget.montant))} FCFA",
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.green),
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
