import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetCotisation extends StatefulWidget {
  WidgetCotisation({
    super.key,
    required this.montantCotisations,
    required this.motifCotisations,
    required this.dateCotisation,
    required this.heureCotisation,
    required this.soldeCotisation,
    required this.codeCotisation,
    required this.type,
    required this.lienDePaiement,
    required this.is_tontine,
    required this.is_passed,
    required this.source,
    required this.nomBeneficiaire,
    required this.rubrique,
    required this.isPayed,
    required this.screenSource,
    required this.rapportUrl,
  });
  int montantCotisations;
  String motifCotisations;
  String dateCotisation;
  String heureCotisation;
  String soldeCotisation;
  String codeCotisation;
  String type;
  String lienDePaiement;
  int is_tontine;
  int is_passed;
  String source;
  String nomBeneficiaire;
  String rubrique;
  int isPayed;
  String screenSource;
  String? rapportUrl;

  @override
  State<WidgetCotisation> createState() => _WidgetCotisationState();
}

class _WidgetCotisationState extends State<WidgetCotisation> {
  Future<void> handleDetailCotisation(codeCotisation) async {
    // final detailTournoiCourant = await context
    //     .read<DetailTournoiCourantCubit>()
    //     .detailTournoiCourantCubit();
    final detailCotisation = await context
        .read<CotisationDetailCubit>()
        .detailCotisationCubit(codeCotisation);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CotisationCubit, CotisationState>(
        builder: (CotisationContext, CotisationState) {
      return GestureDetector(
        onTap: () {
          updateTrackingData(
              "${widget.screenSource}.contribution", "${DateTime.now()}", {});
          handleDetailCotisation(widget.codeCotisation);
          print("${widget.codeCotisation}");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailCotisationPage(
                codeCotisation: widget.codeCotisation,
                lienDePaiement: widget.lienDePaiement,
                dateCotisation: widget.dateCotisation,
                heureCotisation: widget.heureCotisation,
                montantCotisations: widget.montantCotisations,
                motifCotisations: widget.motifCotisations,
                soldeCotisation: widget.soldeCotisation,
                type: widget.type,
                isPassed: widget.is_passed,
                isPayed: widget.isPayed,
                rapportUrl: widget.rapportUrl,
              ),
            ),
          );
        },
        child: Container(
          decoration: widget.is_passed == 0
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColors.white,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColors.whiteAccent,
                  border: Border.all(
                    width: 1.r,
                    color: AppColors.white,
                  ),
                ),
          padding:
              EdgeInsets.only(left: 10.w, top: 5.h, bottom: 10.h, right: 10.w),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 15.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (widget.rubrique != "")
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5.h),
                                      child: Text(
                                        '${widget.rubrique}'.toUpperCase(),
                                        style: TextStyle(
                                          color: AppColors.blackBlueAccent1,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 4.h),
                                        child: Text(
                                          widget.motifCotisations,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // margin: EdgeInsets.only(bottom: 7),
                                        child: Text(
                                          widget.source == ''
                                              ? "${(widget.nomBeneficiaire)}"
                                              : "${(widget.source)}",
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackBlueAccent1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          widget.isPayed == 0
                              ? Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        updateTrackingData(
                                            "${widget.screenSource}.btnContribution",
                                            "${DateTime.now()}", {});
                                        String msg =
                                            "Aide-moi à payer ma cotisation *${widget.motifCotisations}*.\nMontant: *${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode} pour valider";
                                        String raisonComplete =
                                            "Paiement de la cotisation".tr();
                                        String motif = "payer_vous_même".tr();
                                        String paiementProcheMsg =
                                            "partager_le_lien_de_paiement".tr();
                                        String msgAppBarPaiementPage =
                                            "${'Paiement de la cotisation'.tr()} ${widget.motifCotisations}";
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
                                        width: 72.w,
                                        margin: EdgeInsets.only(bottom: 2.h),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.colorButton,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
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
                                    if (widget.is_passed == 1)
                                      Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                        ),
                                        child: Container(
                                          child: Text(
                                            "expiré".tr(),
                                            style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 10.sp,
                                              color: AppColors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                              : Text(
                                  "payé".tr(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.green,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                        ],
                      ),
                    ),


                    Container(
                      margin: EdgeInsets.only(top: 7.h, bottom: 7.h),
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              widget.type == "1"
                                  ? "type_volontaire".tr()
                                  : "type_fixe".tr(),
                              style: TextStyle(
                                color: AppColors.blackBlue,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  child: Text(
                                    "montant".tr(),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blackBlue,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.h,),
                                Container(
                                  child: Text(
                                    "${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA",
                                    style: TextStyle(
                                      color: AppColors.blackBlue,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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
                        context
                            .read<AuthCubit>()
                            .state
                            .detailUser!["isMember"]))
                      Container(
                        // margin: EdgeInsets.only(bottom: 5),
                        // width: MediaQuery.of(context).size.width / 1.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.wallet_rounded,
                                      color: AppColors.blackBlue,
                                      size: 18.sp,
                                    ),
                                    margin: EdgeInsets.only(right: 5.w),
                                  ),
                                  Container(
                                      child: Text(
                                    "${formatMontantFrancais(double.parse(widget.soldeCotisation))} FCFA",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.green),
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              child: Text(
                                formatDateLiteral(widget.dateCotisation),
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.blackBlueAccent1,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
