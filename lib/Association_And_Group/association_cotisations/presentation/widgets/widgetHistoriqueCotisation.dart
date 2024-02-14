import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetHistoriqueCotisation extends StatefulWidget {
  WidgetHistoriqueCotisation({
    super.key,
    required this.photoProfil,
    required this.is_versement_finished,
    required this.montantVersee,
    required this.matricule,
    required this.nom,
    required this.prenom,
    required this.montantTotalAVerser,
  });
  String matricule;

  String montantVersee;

  String nom;

  String prenom;

  String photoProfil;
  String montantTotalAVerser;
  int is_versement_finished;

  @override
  State<WidgetHistoriqueCotisation> createState() =>
      _WidgetHistoriqueCotisationState();
}

class _WidgetHistoriqueCotisationState
    extends State<WidgetHistoriqueCotisation> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 5.w, right: 5.w),
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
                bottom: BorderSide(
              width: 1.r,
              color: Color.fromARGB(85, 9, 185, 255),
            ))),
        width: double.infinity,
        // height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(50.r)),
                      child: Image.network(
                        "${Variables.LienAIP}${widget.photoProfil}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.w),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15.h),
                          child: Text(
                            "${widget.nom} ${widget.prenom}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.blackBlue,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${widget.matricule}",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w800,
                              color: Color.fromRGBO(20, 45, 99, 0.349),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.montantTotalAVerser == widget.montantVersee &&
                widget.montantVersee == "0" &&
                widget.is_versement_finished == 0)
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              "${formatMontantFrancais(double.parse("${widget.montantVersee}"))} FCFA",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red,),
                            ),
                          ),
                          // Container(
                          //   child: Text(
                          //     "20/03/2023",
                          //     style: TextStyle(
                          //         fontSize: 10,
                          //         fontWeight: FontWeight.w800,
                          //         color: Color.fromRGBO(20, 45, 99, 0.349),),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1.r),
                      margin: EdgeInsets.only(left: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Color.fromARGB(40, 175, 76, 76),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            if (int.parse(widget.montantTotalAVerser) >=
                    int.parse(widget.montantVersee) &&
                widget.montantVersee != "0" &&
                widget.is_versement_finished == 0)
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              "${formatMontantFrancais(double.parse("${widget.montantVersee}"))} FCFA",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.orange),
                            ),
                          ),
                          // Container(
                          //   child: Text(
                          //     "20/03/2023",
                          //     style: TextStyle(
                          //         fontSize: 10,
                          //         fontWeight: FontWeight.w800,
                          //         color: Color.fromRGBO(20, 45, 99, 0.349),),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1.r),
                      margin: EdgeInsets.only(left: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Color.fromARGB(40, 175, 76, 76),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.orange,
                        size: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.is_versement_finished == 1)
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              "${formatMontantFrancais(double.parse("${widget.montantVersee}"))} FCFA",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.green,),
                            ),
                          ),
                          // Container(
                          //   child: Text(
                          //     "20/03/2023",
                          //     style: TextStyle(
                          //         fontSize: 10,
                          //         fontWeight: FontWeight.w800,
                          //         color: Color.fromRGBO(20, 45, 99, 0.349),),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1.r),
                      margin: EdgeInsets.only(left: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Color.fromARGB(40, 83, 175, 76),
                      ),
                      child: Icon(
                        Icons.done,
                        color: AppColors.green,
                        size: 10.sp,
                      ),
                    ),
                  ],
                ),
              )
          ],
        ));
  }
}
