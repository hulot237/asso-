import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class widgetDetailCotisationCard extends StatefulWidget {
  widgetDetailCotisationCard({
    super.key,
    required this.montantCotisations,
    required this.motifCotisations,
    required this.dateCotisation,
    required this.heureCotisation,
    required this.soldeCotisation,
    // required this.montantSanctionCollectee,
    required this.isPassed,
    required this.type,
    required this.lienDePaiement,
    required this.isPayed,
    required this.codeCotisation,
  });
  int montantCotisations;
  String motifCotisations;
  String dateCotisation;
  String heureCotisation;
  String soldeCotisation;
  String type;
  String lienDePaiement;
  int isPayed;
  // String montantSanctionCollectee;
  int isPassed;
  String codeCotisation;

  @override
  State<widgetDetailCotisationCard> createState() =>
      _widgetDetailCotisationCardState();
}

class _widgetDetailCotisationCardState
    extends State<widgetDetailCotisationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
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
        alignment: Alignment.center,
        padding: EdgeInsets.all(15.r),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          // flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    widget.motifCotisations,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blackBlue,
                                    ),
                                  ),
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
                                        String msg =
                                            "Aide-moi à payer ma cotisation *${widget.motifCotisations}* .\nMontant: *${ widget.type == "1" ? "volontaire".tr() : "${formatMontantFrancais(double.parse(widget.montantCotisations.toString() ))} FCFA"} * .\nMerci de suivre le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode} pour valider";
                                        String raisonComplete =
                                            'Paiement de la cotisation'.tr();
                                        String motif = "payer_vous_même".tr();
                                        String paiementProcheMsg =
                                            "partager_le_lien_de_paiement".tr();
                                        String msgAppBarPaiementPage =
                                            "${'Paiement de la cotisation'.tr()} ${widget.motifCotisations}";
                                            String elementUrl = "https://groups.faroty.com/cotisations-details/${widget.codeCotisation}";
                                        Modal().showModalActionPayement(
                                          context,
                                          msg,
                                          widget.lienDePaiement,
                                          raisonComplete,
                                          motif,
                                          paiementProcheMsg,
                                          msgAppBarPaiementPage,
                                          elementUrl
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
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                        child: Text(
                                          "cotiser".tr(),
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp),
                                        ),
                                      )),
                                  if (widget.isPassed == 1)
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 2.h,
                                      ),
                                      child: Text(
                                        "expiré".tr(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8.sp,
                                          color: Color.fromARGB(255, 255, 0, 0),
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
                                    fontStyle: FontStyle.italic),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(7.r),
                          margin: EdgeInsets.only(
                            bottom: 1.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Color.fromARGB(20, 9, 185, 255),
                          ),
                          child: Container(
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
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5.h,
                            bottom: 8.h,
                          ),
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
                                  " ${formatDateLiteral(widget.dateCotisation)}",
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
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 7.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<CotisationDetailCubit,
                            CotisationDetailState>(
                          builder:
                              (CotisationDetailContext, CotisationDetailState) {
                            if (CotisationDetailState.isLoading == true ||
                                CotisationDetailState.detailCotisation == null)
                              return GestureDetector(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "vous_avez_cotisé".tr(),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                        margin: EdgeInsets.only(right: 5.w),
                                      ),
                                      Container(
                                        width: 12.w,
                                        height: 12.h,
                                        color: AppColors.white,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                           color: AppColors.green,
                                            strokeWidth: 0.5,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );

                            final currentDetailCotisation =
                                CotisationDetailContext.read<
                                        CotisationDetailCubit>()
                                    .state
                                    .detailCotisation;
                            print(
                                "currentDetailCotisationcurrentDetailCotisationcurrentDetailCotisation ${currentDetailCotisation}");
                            return currentDetailCotisation != null
                                ? Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // if (currentDetailCotisation!["versements"].length > 0)
                                          for (var itemDetailCotisation
                                              in currentDetailCotisation[
                                                  "membres"])
                                            if (itemDetailCotisation["membre"]
                                                    ["membre_code"] ==
                                                AppCubitStorage()
                                                    .state
                                                    .membreCode)
                                              Modal()
                                                  .showModalTransactionByEvent(
                                                context,
                                                itemDetailCotisation[
                                                    "payments"],
                                                '${widget.montantCotisations}',
                                                resteAPayer:
                                                    itemDetailCotisation[
                                                        "amount_remaining"],
                                                dejaPayer: itemDetailCotisation[
                                                    "balance"],
                                              );
                                        },
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  "vous_avez_cotisé".tr(),
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.blackBlue,
                                                  ),
                                                ),
                                                margin:
                                                    EdgeInsets.only(right: 5.w),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              for (var itemDetailCotisation
                                                  in currentDetailCotisation[
                                                      "membres"])
                                                if (itemDetailCotisation[
                                                            "membre"]
                                                        ["membre_code"] ==
                                                    AppCubitStorage()
                                                        .state
                                                        .membreCode)
                                                  Container(
                                                    child: Text(
                                                      "${formatMontantFrancais(double.parse("${itemDetailCotisation["balance"]}"))} FCFA",
                                                      // "${itemDetailCotisation["membre"]["versement"].length}",
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Color.fromARGB(
                                                          255,
                                                          20,
                                                          45,
                                                          99,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container();
                          },
                        ),
                        
                        
                        
                        checkTransparenceStatus(
                                context
                                    .read<UserGroupCubit>()
                                    .state
                                    .changeAssData!
                                    .user_group!
                                    .configs,
                                context
                                    .read<AuthCubit>()
                                    .state
                                    .detailUser!["isMember"])
                            ? GestureDetector(
                                // onTap: () {
                                //   Modal()
                                //       .showModalAllTransactionCotisation(context);
                                // },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Text(
                                          "solde".tr(),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Container(
                                        child: Text(
                                          "${formatMontantFrancais(double.parse(widget.soldeCotisation))} FCFA",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      // onTap: () {
                                      //   Modal().showModalPersonSanctionner(context, [], "");
                                      // },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 3.h),
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                "montant".tr(),
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: AppColors
                                                        .blackBlueAccent1,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                widget.type == "1"
                                                    ? Container(
                                                        child: Text(
                                                          " : Volontaire",
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      20,
                                                                      45,
                                                                      99),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )
                                                    : Container(
                                                        child: Text(
                                                          " : ${formatMontantFrancais(double.parse("${widget.montantCotisations}"))} FCFA",
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: AppColors
                                                                .blackBlue,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            // onTap: () {
                            //   Modal().showModalPersonSanctionner(context, [], "");
                            // },
                            child: Container(
                              // margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "montant".tr(),
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.blackBlueAccent1,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      widget.type == "1"
                                          ? Container(
                                              child: Text(
                                                " : Volontaire",
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColors.blackBlue,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              child: Text(
                                                " : ${formatMontantFrancais(double.parse("${widget.montantCotisations}"))} FCFA",
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
                                ],
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
  }
}
