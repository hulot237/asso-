import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class widgetRecentEventSanction extends StatefulWidget {
  widgetRecentEventSanction({
    super.key,
    required this.motif,
    required this.dateOpen,
    required this.montantSanction,
    required this.montantCollecte,
    required this.codeCotisation,
    required this.lienDePaiement,
    required this.libelleSanction,
    required this.type,
    required this.versement,
  });
  String motif;
  String dateOpen;
  String montantCollecte;
  int montantSanction;
  String codeCotisation;
  String lienDePaiement;
  String type;
  String libelleSanction;
  List versement;

  @override
  State<widgetRecentEventSanction> createState() =>
      _widgetRecentEventSanctionState();
}

class _widgetRecentEventSanctionState extends State<widgetRecentEventSanction> {
  Future<void> handleDetailCotisation(codeCotisation) async {
    final detailCotisation = await context
        .read<CotisationDetailCubit>()
        .detailCotisationCubit(codeCotisation);

    if (detailCotisation != null) {
    } else {
      print("userGroupDefault null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserGroupCubit, UserGroupState>(
        builder: (UserGroupcontext, UserGroupstate) {
      if (UserGroupstate.isLoadingChangeAss == true &&
          UserGroupstate.changeAssData == null) return Container();
      return GestureDetector(
        onTap: () {
          if (widget.type == "1")
            Modal().showModalTransactionByEvent(
                context, widget.versement, widget.montantSanction.toString());
        },
        child: Container(
          padding: EdgeInsets.all(10.r
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5.w),
                        width: 11.w,
                        height: 11.h,
                        decoration: BoxDecoration(
                            color: AppColors.colorButton,
                            borderRadius: BorderRadius.circular(360.r)),
                      ),
                      Text(
                        'sanction_capital'.tr(),
                        style: TextStyle(
                          color: AppColors.blackBlue,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  if (widget.type == "1")
                    GestureDetector(
                      onTap: () async {
                        String msg =
                            "Aide-moi à payer ma sanction de *${widget.motif}* du montant  *${formatMontantFrancais(double.parse(widget.montantSanction.toString()))} FCFA* directement via le lien https://${widget.lienDePaiement}.";
                        Modal().showModalActionPayement(
                          context,
                          msg,
                          widget.lienDePaiement,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 72.w,
                        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 5.w,),
                        decoration: BoxDecoration(
                          color: AppColors.colorButton,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Container(
                          child: Text(
                            "Payer".tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.motif}",
                  // 'Voir bebe de l"enfant de djousse',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackBlue,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.type == "1")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Avance".tr(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackBlueAccent1,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${formatMontantFrancais(double.parse("${widget.montantCollecte}"))} FCFA",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    Column(
                      crossAxisAlignment: widget.type == "0"
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Text(
                            "a_payer".tr(),
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackBlueAccent1,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.type == "1"
                                ? "${formatMontantFrancais(double.parse("${widget.montantSanction}"))} FCFA"
                                : "${widget.libelleSanction}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.blackBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.h),
                alignment: Alignment.bottomRight,
                child: Text(
                  "${formatCompareDateReturnWellValueSanctionRecent(widget.dateOpen)}",
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackBlueAccent1,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
