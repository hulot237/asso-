import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class widgetHistoriqueTontineCard extends StatefulWidget {
  widgetHistoriqueTontineCard({
    super.key,
    required this.imageProfil,
    required this.nom,
    required this.prenom,
    required this.is_versement_finished,
    required this.montantVersee,
    required this.date,
  });

  String imageProfil;
  String nom;
  String prenom;
  int is_versement_finished;
  String montantVersee;
  String date;

  @override
  State<widgetHistoriqueTontineCard> createState() =>
      _widgetHistoriqueTontineCardState();
}

class _widgetHistoriqueTontineCardState
    extends State<widgetHistoriqueTontineCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
          color: AppColors.blackBlueAccent2,
          borderRadius: BorderRadius.circular(7),
        ),
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
                  "${Variables.LienAIP}${widget.imageProfil}",
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
                        "${widget.nom} ${widget.prenom}",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackBlue,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2.h),
                      child: Text(
                        "${formatMontantFrancais(double.parse("${widget.montantVersee}"))} FCFA",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackBlueAccent1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.is_versement_finished == 1)
              Container(
                margin: EdgeInsets.only(right: 10.w),
                child: Text(
                  "${widget.date}",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackBlueAccent1),
                ),
              ),
            widget.is_versement_finished == 0
                ? Container(
                    padding: EdgeInsets.all(2.r),
                    decoration: BoxDecoration(
                      color: AppColors.redAccent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.close,
                      color: AppColors.red,
                      size: 11.sp,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(2.r),
                    decoration: BoxDecoration(
                      color: AppColors.greenAccent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 11.sp,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
