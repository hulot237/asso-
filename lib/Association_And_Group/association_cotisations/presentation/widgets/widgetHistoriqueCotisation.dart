import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetHistoriqueCotisation extends StatefulWidget {
  WidgetHistoriqueCotisation({
    super.key,
    required this.photoProfil,
    required this.versement_status,
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
  String versement_status;

  @override
  State<WidgetHistoriqueCotisation> createState() =>
      _WidgetHistoriqueCotisationState();
}

class _WidgetHistoriqueCotisationState
    extends State<WidgetHistoriqueCotisation> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.only(top: 10.h, bottom: 10.h, left: 5.w, right: 5.w),
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
                  InkWell(
                    onTap: () {
                      Modal().showFullPicture(
                    context,
                    widget.photoProfil == null
                        ? "https://services.faroty.com/images/avatar/avatar.png"
                        : "${Variables.LienAIP}${widget.photoProfil}",
                    "${widget.nom} ${widget.prenom}");
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Container(
                        height: 50.r,
                        width: 50.r,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(50.r)),
                        child: Image.network(
                          "${Variables.LienAIP}${widget.photoProfil}",
                          fit: BoxFit.cover,
                        ),
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
                              color: widget.versement_status=="0"? Colors.red : widget.versement_status=="1"? Colors.orange :  Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(1.r),
                    margin: EdgeInsets.only(left: 5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: widget.versement_status=="0"? Color.fromARGB(40, 175, 76, 76) : widget.versement_status=="1"? Color.fromARGB(40, 175, 139, 76): Color.fromARGB(40, 83, 175, 76),
                    ),
                    child: Icon(
                     widget.versement_status=="0" ? Icons.close : widget.versement_status=="1" ? Icons.close : Icons.done,
                      color: widget.versement_status=="0"? Colors.red : widget.versement_status=="1"? Colors.orange :  Colors.green,
                      size: 10.sp,
                    ),
                  ),
                ],
              ),
            ),


          ],
        ));
  }
}
