import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class widgetRecentEventTontine extends StatefulWidget {
  widgetRecentEventTontine({
    super.key,
    required this.nomBeneficiaire,
    required this.prenomBeneficiaire,
    required this.dateOpen,
    required this.dateClose,
    required this.montantTontine,
    required this.montantCollecte,
    required this.codeCotisation,
    required this.lienDePaiement,
    required this.nomTontine,
  });
  String nomBeneficiaire;
  String dateClose;
  String dateOpen;
  String montantCollecte;
  int montantTontine;
  String prenomBeneficiaire;
  String codeCotisation;
  String lienDePaiement;
  String nomTontine;

  @override
  State<widgetRecentEventTontine> createState() =>
      _widgetRecentEventTontineState();
}

class _widgetRecentEventTontineState extends State<widgetRecentEventTontine>
    with TickerProviderStateMixin {
  Future<void> handleDetailContributionTontine(codeContribution) async {
    final detailCotisation = await context
        .read<DetailContributionCubit>()
        .detailContributionTontineCubit(codeContribution);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserGroupCubit, UserGroupState>(
        builder: (UserGroupcontext, UserGroupstate) {
      if (UserGroupstate.isLoadingChangeAss == true &&
          UserGroupstate.changeAssData == null) return Container();
      return GestureDetector(
        onTap: () {
          updateTrackingData("home.tontine", "${DateTime.now()}",
              {"type": 'tontine', "tontine_id": "${widget.codeCotisation}"});
          if (checkTransparenceStatus(
              context
                  .read<UserGroupCubit>()
                  .state
                  .changeAssData!
                  .user_group!
                  .configs,
              context.read<AuthCubit>().state.detailUser!["isMember"])) {
            handleDetailContributionTontine(
              widget.codeCotisation,
            );

            Modal().showBottomSheetHistTontine(context, widget.codeCotisation);
          }
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isPasseDate(widget.dateClose)
                    ? Color.fromARGB(255, 255, 247, 247)
                    : AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                border: Border.all(
                  color: isPasseDate(widget.dateClose)
                      ? Color.fromARGB(255, 243, 1, 1)
                      : AppColors.white,
                  width: 0.5.r,
                ),
              ),
              padding: EdgeInsets.only(
                top: 10.h,
                left: 10.w,
                right: 10.w,
                bottom: 7.h,
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
                            width: 11.r,
                            height: 11.r,
                            decoration: BoxDecoration(
                                color: !isPasseDate(widget.dateClose)
                                    ? AppColors.colorButton
                                    : AppColors.red,
                                borderRadius: BorderRadius.circular(360.r)),
                          ),
                          Text(
                            'TONTINE'.tr(),
                            style: TextStyle(
                              color: AppColors.blackBlue,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                           launchWeb(
                    "https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode}",
                  );
                          // updateTrackingData(
                          //     "home.btnTontine", "${DateTime.now()}", {
                          //   "type": 'tontine',
                          //   "tontine_id": "${widget.codeCotisation}"
                          // });
                          // String msg =
                          //     "Aide-moi à payer ma tontine *${widget.nomTontine}* .\nMontant: *${formatMontantFrancais(widget.montantTontine.toDouble())} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode} pour valider";
                          // String raisonComplete = "Paiement de la tontine".tr();
                          // String motif = "payer_vous_même".tr();
                          // String paiementProcheMsg =
                          //     "partager_le_lien_de_paiement".tr();
                          // String msgAppBarPaiementPage =
                          //     "${'Paiement de la tontine'.tr()} ${widget.nomTontine}";
                          // String elementUrl =
                          //     "https://groups.faroty.com/details-tournois/${AppCubitStorage().state.codeTournois}";
                          // Modal().showModalActionPayement(
                          //     context,
                          //     msg,
                          //     widget.lienDePaiement,
                          //     raisonComplete,
                          //     motif,
                          //     paiementProcheMsg,
                          //     msgAppBarPaiementPage,
                          //     elementUrl);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 72.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.colorButton,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Container(
                            child: Text(
                              "Tontiner",
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
                    child: Text(
                      "${widget.nomTontine}",
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "${"Bénéficiaire".tr()} :",
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
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              child: Text(
                                "${widget.nomBeneficiaire}",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackBlue,
                                ),
                              ),
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
                            Container(
                              child: Text(
                                "${formatMontantFrancais(double.parse("${widget.montantTontine}"))} FCFA",
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
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                child: Text(
                                  "${formatMontantFrancais(
                                    double.parse("${widget.montantCollecte}"),
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
                        Container(
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
                  Container(
                    margin: EdgeInsets.only(
                      top: 8.h,
                    ),
                    padding: EdgeInsets.only(
                      top: 8.h,
                      bottom: 0.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: .5.r,
                          color: AppColors.blackBlueAccent2,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (!context
                            .read<AuthCubit>()
                            .state
                            .detailUser!["isMember"])
                          if (widget.nomBeneficiaire != "")
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  updateTrackingData(
                                      "home.btnwithdrawnFundsContribution",
                                      "${DateTime.now()}", {});
                                   launchWeb(
                                    "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/tontine-details/${widget.codeCotisation}?query=1&app_mode=mobile",
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 17.h,
                                      child: SvgPicture.asset(
                                        "assets/images/withdrawIcon.svg",
                                        fit: BoxFit.scaleDown,
                                        color: AppColors.blackBlueAccent1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      "Retrait des fonds".tr(),
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
                        // if (!context
                        //     .read<AuthCubit>()
                        //     .state
                        //     .detailUser!["isMember"])
                        // https://groups.faroty.com/cotisation-details/code
                        if (!context
                            .read<AuthCubit>()
                            .state
                            .detailUser!["isMember"])
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                updateTrackingData("home.btnAdministerTontine",
                                    "${DateTime.now()}", {});
                                 launchWeb(
                                  "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/tontine-details/${widget.codeCotisation}&app_mode=mobile",
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    // color: const Color.fromARGB(255, 0, 0, 0),
                                    height: 17.h,
                                    // width: 230,
                                    child: SvgPicture.asset(
                                      "assets/images/folderManageSimpleIcon.svg",
                                      fit: BoxFit.scaleDown,
                                      color: AppColors.blackBlueAccent1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    "Gerer".tr(),
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
                        Expanded(
                          child: InkWell(
                            splashColor: AppColors.blackBlue,
                            onTap: () {
                              print("object3");
                              Share.share(context
                                      .read<AuthCubit>()
                                      .state
                                      .detailUser!["isMember"]
                                  ? "Aide-moi à payer ma tontine *${widget.nomTontine}*.\nMontant: *${formatMontantFrancais(double.parse(widget.montantTontine.toString()))} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode} pour valider"
                                  : "Nouvelle tontine créée dans le groupe *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* concernant  *${(widget.nomBeneficiaire)}* .\nSoyez le premier à contribuer ici : https://${widget.lienDePaiement}");
                            },
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
                      ],
                    ),
                  )
                
                
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
