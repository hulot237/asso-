import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetCompteCard extends StatefulWidget {
  const WidgetCompteCard({super.key,
    required this.montantCompte,
    required this.nomCompte,
    required this.numeroCompte,
    required this.couleur,
  });

  final String montantCompte;
  final String nomCompte;
  final String numeroCompte;
  final String couleur;

  @override
  State<WidgetCompteCard> createState() => _WidgetCompteCardState();
}

class _WidgetCompteCardState extends State<WidgetCompteCard> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.15,
      padding: EdgeInsets.all(5.r),
      margin: EdgeInsets.all(5.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
        // boxShadow: [
        //   BoxShadow(
        //       color: Color.fromARGB(120, 180, 180, 180),
        //       spreadRadius: 1,
        //       blurRadius: 1)
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 150.w,
            width: 150.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                // color: Colors.cyanAccent,
                border: Border.all(
                  width: 4.w,
                  color: Color(int.parse('${widget.couleur}'.replaceAll('#', '0xff')))
                  // color: widget.couleur,
                )),
            margin: EdgeInsets.only(top: 5.h),
            child: Container(
              padding: EdgeInsets.all(5.r),
              alignment: Alignment.center,
              child: Text(
                "${formatMontantFrancais(double.parse(widget.montantCompte))} FCFA",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: Color(int.parse('${widget.couleur}'.replaceAll('#', '0xff'))),

                  // color: widget.couleur,
                ),
              ),
            ),
            // child: CircularPercentIndicator(
            //   animation: true,
            //   animationDuration: 2000,
            //   radius: 70,
            //   lineWidth: 10,
            //   percent: 0.35,
            //   center: Text(
            //     "12 000 000 FCFA",
            //     style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.w300,
            //       color: Color.fromRGBO(0, 162, 255, 1),
            //     ),
            //   ),
            //   backgroundColor: Color.fromRGBO(0, 162, 255, 0.24),
            //   progressColor: Color.fromRGBO(0, 162, 255, 1),
            //   circularStrokeCap: CircularStrokeCap.round,
            // ),
          ),
          Column(
            children: [
              // Container(
              //   alignment: Alignment.center,
              //   margin: EdgeInsets.only(bottom: 5),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         margin: EdgeInsets.only(top: 5),
              //         child: Text(
              //           "compte".tr(),
              //           style: TextStyle(
              //             fontWeight: FontWeight.w400,
              //             fontSize: 12,
              //             color: AppColors.blackBlue,
              //           ),
              //         ),
              //       ),
              //       Container(
              //         margin: EdgeInsets.only(top: 5),
              //         child: Text(
              //           " ${widget.numeroCompte}",
              //           style: TextStyle(
              //             fontWeight: FontWeight.w600,
              //             fontSize: 12,
              //             color: AppColors.blackBlue,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom:5.h, top: 10.h),
                child: Text(
                  widget.nomCompte.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.blackBlue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
