import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/widget/encours_widget.dart';
import 'package:faroty_association_1/widget/termine_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class WidgetDetailTontineCard extends StatefulWidget {
  WidgetDetailTontineCard({
    super.key,
    required this.nomTontine,
    required this.montantTontine,
    required this.positionBeneficiaire,
    required this.nbrMembreTontine,
    required this.dateCreaTontine,
    required this.isActive,
    required this.listMembre,
  });

  String dateCreaTontine;
  String nomTontine;
  String montantTontine;
  String positionBeneficiaire;
  String nbrMembreTontine;
  int isActive;
  var listMembre;

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
                          ? EncoursWidget()
                          : TermineWidget()
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
                   Material(
                              color: Colors.transparent,
                     child: InkWell(
                                   onTap: ()     {
                      String message;
                      String text = "la tontine".tr();
                      String capitalizedText =
                          text.replaceFirst(text[0], text[0].toUpperCase());
                      // 🟢🟢 La tontine *Staff* qui a debuté le *16 Feb 2024 at 11:00* dans le groupe *Dev Opps* compte a la date du now 3 beneficiaire sur 10
                      message =
                          "🟢🟢 ${"$capitalizedText"} *${widget.nomTontine}* ${"qui a debuté le".tr()} *${formatDateLiteral(widget.dateCreaTontine)}* ${"dans le groupe".tr()} *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* ${"compte a la date du".tr()} *${formatDateLiteral(DateTime.now().toString())}* *${widget.positionBeneficiaire}* ${"beneficiaire sur".tr()} *${widget.nbrMembreTontine}*\n\n";
                      message += "*Récapitulatif :*\n";
                      for (var element in widget.listMembre) {
                        String firstName = element["membre"]["first_name"];
                        String lastName = element["membre"]["last_name"] ?? "";
                     
                        message +=
                            "- ${firstName} ${lastName} ${element["is_passed"] == 0 ? "❌" : "✅"}\n";
                      }
                      message +=
                          "\n${"Merci de consulter ici".tr()}  : faroty.com/dl/groups\n\n";
                     
                      message += "*by ASSO+*";
                     
                      Share.share(message);
                                       },
                                       child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 1.w,
                                  color: AppColors.blackBlueAccent2))),
                      // color: AppColors.colorButton,
                      padding: EdgeInsets.only(top: 5.h),
                      margin: EdgeInsets.only(top: 5.h),
                      child: Column(
                        children: [
                          Container(
                            height: 17.h,
                            child: SvgPicture.asset(
                              "assets/images/shareSimpleIcon.svg",
                              fit: BoxFit.scaleDown,
                              color: AppColors.blackBlueAccent1,
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            "Partager".tr(),
                            style: TextStyle(
                              color: AppColors.blackBlueAccent1,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                                       ),
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
