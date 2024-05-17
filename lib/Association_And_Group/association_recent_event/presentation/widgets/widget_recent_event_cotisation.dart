import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/appStorageModel.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class widgetRecentEventCotisation extends StatefulWidget {
  widgetRecentEventCotisation({
    super.key,
    required this.dateOpen,
    required this.dateClose,
    required this.montantCotisation,
    required this.montantCollecte,
    required this.codeCotisation,
    required this.lienDePaiement,
    required this.motif,
    required this.type,
    required this.isPassed,
    required this.source,
    required this.nomBeneficiaire,
    required this.rublique,
  });
  String dateClose;
  String dateOpen;
  String montantCollecte;
  int montantCotisation;
  String codeCotisation;
  String lienDePaiement;
  String motif;
  String type;
  int isPassed;
  String source;
  String nomBeneficiaire;
  String rublique;

  @override
  State<widgetRecentEventCotisation> createState() =>
      _widgetRecentEventCotisationState();
}

class _widgetRecentEventCotisationState extends State<widgetRecentEventCotisation> {
  Future<void> handleDetailCotisation(codeCotisation) async {
    final detailCotisation = await context.read<CotisationDetailCubit>().detailCotisationCubit(codeCotisation);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserGroupCubit, UserGroupState>(
        builder: (UserGroupcontext, UserGroupstate) {
      if (UserGroupstate.isLoadingChangeAss == true &&
          UserGroupstate.changeAssData == null)
        return Container(
          child: EasyLoader(
            backgroundColor: Color.fromARGB(0, 255, 255, 255),
            iconSize: 50.r,
            iconColor: AppColors.blackBlueAccent1,
            image: AssetImage(
              "assets/images/AssoplusFinal.png",
            ),
          ),
        );
      return GestureDetector(
        onTap: () {
          updateTrackingData("home.contribution", "${DateTime.now()}", {"type": 'contribution', "contribution_id": "${widget.codeCotisation}"});
          if (checkTransparenceStatus(
              context
                  .read<UserGroupCubit>()
                  .state
                  .changeAssData!
                  .user_group!
                  .configs,
              context.read<AuthCubit>().state.detailUser!["isMember"])) {
            handleDetailCotisation(widget.codeCotisation);

            Modal().showBottomSheetHistCotisation(
                context,
                widget.codeCotisation,
                widget.lienDePaiement,
                widget.dateOpen,
                widget.dateOpen,
                widget.montantCotisation,
                widget.motif,
                widget.montantCollecte,
                widget.type,
                widget.isPassed,
                0);
          } else {
            handleDetailCotisation(widget.codeCotisation);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailCotisationPage(
                  codeCotisation: widget.codeCotisation,
                  lienDePaiement: widget.lienDePaiement,
                  dateCotisation: widget.dateOpen,
                  heureCotisation: widget.dateOpen,
                  montantCotisations: widget.montantCotisation,
                  motifCotisations: widget.motif,
                  soldeCotisation: widget.montantCollecte,
                  type: widget.type,
                  isPassed: widget.isPassed,
                  isPayed: 0,
                ),
              ),
            );
          }
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: widget.isPassed == 0
                    ? AppColors.white
                    : Color.fromARGB(255, 255, 247, 247),
                // borderRadius: BorderRadius.circular(15),
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                  color: widget.isPassed == 0 ? AppColors.white : AppColors.red,
                  width: 0.5.r,
                ),
              ),
              padding: EdgeInsets.all(10.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5.w),
                            width: 11.r,
                            height: 11.r,
                            decoration: BoxDecoration(
                              color: widget.isPassed == 0
                                  ? AppColors.colorButton
                                  : AppColors.red,
                              borderRadius: BorderRadius.circular(360.r),
                            ),
                          ),
                          Text(
                            "${'cotisation_capital'.tr()} ${widget.rublique}"
                                .toUpperCase(),
                            style: TextStyle(
                              color: AppColors.blackBlue,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          updateTrackingData("home.btnContribution", "${DateTime.now()}", {"type": 'contribution', "contribution_id": "${widget.codeCotisation}"});
                          String msg =
                              "Aide-moi à payer ma cotisation *${widget.motif}*.\nMontant: *${formatMontantFrancais(double.parse(widget.montantCotisation.toString()))} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode} pour valider";

                          String raisonComplete =
                              'Paiement de la cotisation'.tr();
                          String motif = "payer_vous_même".tr();
                          String paiementProcheMsg =
                              "partager_le_lien_de_paiement".tr();
                          String msgAppBarPaiementPage =
                              "${'Paiement de la cotisation'.tr()}  ${widget.motif}";
                          Modal().showModalActionPayement(
                            context,
                            msg,
                            widget.lienDePaiement,
                            raisonComplete,
                            motif,
                            paiementProcheMsg,
                            msgAppBarPaiementPage,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 75.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.colorButton,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Container(
                            child: Text(
                              "cotiser".tr(),
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
                    margin: EdgeInsets.only(top: 7.h),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "${widget.motif}",
                            // 'Voir bebe de l"enfant de djousse',
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blackBlue,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        SizedBox(height: 1.h,),
                        Text(
                          widget.source == ''
                              ? "(${(widget.nomBeneficiaire)})"
                              : "(${(widget.source)})",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackBlueAccent1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 7.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!checkTransparenceStatus(
                            context
                                .read<UserGroupCubit>()
                                .state
                                .changeAssData!
                                .user_group!
                                .configs,
                            context
                                .read<AuthCubit>()
                                .state
                                .detailUser!["isMember"]))
                          Container(
                            margin: EdgeInsetsDirectional.only(
                              top: 5.h,
                            ),
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "${formatCompareDateReturnWellValue(widget.dateClose)}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackBlueAccent1,
                              ),
                            ),
                          ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (checkTransparenceStatus(
                                context
                                    .read<UserGroupCubit>()
                                    .state
                                    .changeAssData!
                                    .user_group!
                                    .configs,
                                context
                                    .read<AuthCubit>()
                                    .state
                                    .detailUser!["isMember"]))
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "montant_collecté".tr(),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackBlueAccent1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 2.h,),
                                  Container(
                                    child: Text(
                                      "${formatMontantFrancais(
                                        double.parse(
                                            "${widget.montantCollecte}"),
                                      )} FCFA",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: AppColors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                "montant".tr(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackBlueAccent1,
                                ),
                              ),
                            ),
                            SizedBox(height: 2.h,),
                            Container(
                              child: Text(
                                widget.type == "1"
                                  ? "volontaire".tr():
                                  // : "type_fixe".tr(),
                                "${formatMontantFrancais(double.parse("${widget.montantCotisation}"))} FCFA",
                                style: TextStyle(
                                  fontSize: 13.sp,
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
                  if (checkTransparenceStatus(
                      context
                          .read<UserGroupCubit>()
                          .state
                          .changeAssData!
                          .user_group!
                          .configs,
                      context.read<AuthCubit>().state.detailUser!["isMember"]))
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 7.h),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "${formatCompareDateReturnWellValue(widget.dateClose)}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackBlueAccent1,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Container(),
          ],
        ),
      );
    });
  }
}
