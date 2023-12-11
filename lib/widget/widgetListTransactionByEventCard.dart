import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';

class widgetListTransactionByEventCard extends StatefulWidget {
   widgetListTransactionByEventCard({super.key, required this.date, required this.montant });
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
      margin: EdgeInsets.only(top: 5),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Color.fromARGB(62, 20, 45, 99),
            )
          )
        ),
        // margin: EdgeInsets.only(top: 5, left: 7, right: 7),
        // padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      "Date",
                      style: TextStyle(
                          fontSize: 11, color: AppColors.blackBlue,),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      widget.date,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackBlue,),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      "montant".tr(),
                      style: TextStyle(
                          fontSize: 11, color: AppColors.blackBlue,),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "${formatMontantFrancais(double.parse(widget.montant))} FCFA",
                      style: TextStyle(
                          fontSize: 11,
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
