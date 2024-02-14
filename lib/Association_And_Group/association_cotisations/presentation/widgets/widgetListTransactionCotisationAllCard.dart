import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class widgetListTransactionCotisationAllCard extends StatefulWidget {
  const widgetListTransactionCotisationAllCard({super.key});

  @override
  State<widgetListTransactionCotisationAllCard> createState() =>
      _widgetListTransactionCotisationAllCardState();
}

class _widgetListTransactionCotisationAllCardState
    extends State<widgetListTransactionCotisationAllCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(5.r),
      color: AppColors.white,
      child: Container(
        padding: EdgeInsets.only(
          top: 7.h,
          bottom: 5.h,
          left: 3.w,
          right: 3.w,
        ),
        decoration: BoxDecoration(
            color: AppColors.white,
            // borderRadius: BorderRadius.circular(7),
            border: Border(
                bottom: BorderSide(
              width: 0.5.r,
              color: Color.fromARGB(62, 20, 45, 99),
            ))),
        // margin: EdgeInsets.all(5),
        // padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 40.w,
                height: 40.w,
                child: Image.network(
                  "https://img.freepik.com/photos-gratuite/heureux-jeune-homme-portant-casquette-aide-ordinateur-portable_171337-17897.jpg?size=626&ext=jpg&uid=R103146264&ga=GA1.2.852592464.1694512378&semt=ais",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                // color: Colors.blueGrey,
                // alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // margin: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "KENGNE DJOUSSE Hulot",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackBlue,
                        ),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "${formatMontantFrancais(5000)} FCFA",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackBlueAccent1,
                        ),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "21/02/2024 à 12:30",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackBlueAccent1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(3.r),
                // decoration: BoxDecoration(
                //   color: AppColors.greenAccent
                //   borderRadius: BorderRadius.circular(50),
                // ),
                child: Icon(
                  Icons.call_received_outlined,
                  color: AppColors.green,
                  size: 14.sp,
                )),
          ],
        ),
      ),
    );
  }
}
