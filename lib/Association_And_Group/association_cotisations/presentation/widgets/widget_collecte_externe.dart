import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detail_collecte_screen.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/encours_widget.dart';
import 'package:faroty_association_1/widget/nonPaye_widget.dart';
import 'package:faroty_association_1/widget/paye_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WidgetCollecteExterne extends StatefulWidget {
  WidgetCollecteExterne({
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
    required this.description,
    required this.rubrique,
    required this.isPayed,
    required this.screenSource,
    required this.photoCol,
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
  String description;
  String rubrique;
  int isPayed;
  String screenSource;
  String photoCol;

  @override
  State<WidgetCollecteExterne> createState() => _WidgetCollecteExterneState();
}

class _WidgetCollecteExterneState extends State<WidgetCollecteExterne> {
  Future<void> handleParticipantCollecte(codeCollecte) async {
    await context
        .read<CotisationDetailCubit>()
        .getParticipantCollecte(codeCollecte);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CotisationCubit, CotisationState>(
        builder: (CotisationContext, CotisationState) {
      return Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
        child: InkWell(
          onTap: () {
            updateTrackingData(
                "${widget.screenSource}.contribution", "${DateTime.now()}", {});
            handleParticipantCollecte(widget.codeCotisation);
            print("${widget.codeCotisation}");

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailCollectePage(
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
                  rapportUrl: "",
                  is_passed: widget.is_passed,
                  source: "widget.source",
                  rubrique: widget.rubrique,
                  nomBeneficiaire: "",
                  is_tontine: widget.is_tontine,
                  photoCol: widget.photoCol,
                  description: widget.description,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top: 20.h, right: 10.w),
                        height: 100.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                ("${Variables.LienAIP}${widget.photoCol}"),
                              ),
                              fit: BoxFit.cover),
                          color: AppColors.redAccent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4.r),
                                  bottomRight: Radius.circular(4.r),
                                ),
                                color: AppColors.white,
                              ),
                              padding: EdgeInsets.only(
                                  top: 4.h, right: 3.w, left: 5.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (widget.rubrique != "")
                                    Container(
                                      child: Text(
                                        '${widget.rubrique}'.toUpperCase(),
                                        style: TextStyle(
                                          color: AppColors.blackBlueAccent1,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  if (widget.isPayed == 1) PayeWidget(),
                                  if (widget.isPayed == 0) NonpayeWidget(),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.is_passed == 0)
                                  InkWell(
                                    onTap: () {
                                      launchWeb(
                                        "https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode}",
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 4.h,
                                      ),
                                      margin: EdgeInsets.only(bottom: 2.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.colorButton,
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ),
                                        border: Border.all(
                                          color: AppColors.white,
                                          width: .5.r,
                                        ),
                                      ),
                                      child: Container(
                                        child: Text(
                                          "Ouvrir".tr(),
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10.w, top: 5.h, bottom: 4.h, right: 10.w),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 10.h,
                              ),
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 4.h,
                                                ),
                                                child: Text(
                                                  "${widget.motifCotisations}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.blackBlue,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 5.h),
                                                child: Text(
                                                  "${(widget.description)}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .blackBlueAccent1,
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
                            Container(
                              margin: EdgeInsets.only(top: 7.h, bottom: 7.h),
                              width: MediaQuery.of(context).size.width / 1.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.r),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                            widget.type == "1"
                                                ? "volontaire".tr()
                                                :
                                                // : "type_fixe".tr(),
                                                "${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: AppColors.blackBlue,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.wallet_rounded,
                                                  color: AppColors.blackBlue,
                                                  size: 18.sp,
                                                ),
                                                margin:
                                                    EdgeInsets.only(right: 5.w),
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
                                      Column(
                                        children: [
                                          Container(
                                            child: Text(
                                              formatDateLiteral(
                                                  widget.dateCotisation),
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color:
                                                    AppColors.blackBlueAccent1,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (widget.is_passed == 1)
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.amberAccent,
                                        borderRadius:
                                            BorderRadius.circular(3.r)),
                                    margin:
                                        EdgeInsets.only(bottom: 5.h, left: 5.w),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.h, horizontal: 2.w),
                                    child: Text(
                                      "expiré".tr(),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: AppColors.blackBlue,
                                        fontWeight: FontWeight.w600,
                                        // fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                if (widget.is_passed == 0) EncoursWidget()
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 2.h,
                              ),
                              padding: EdgeInsets.only(
                                top: 7.h,
                                bottom: 4.h,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (!context
                                      .read<AuthCubit>()
                                      .state
                                      .detailUser!["isMember"])
                                    if (widget.soldeCotisation != "0")
                                      Expanded(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () async {
                                              updateTrackingData(
                                                  "${widget.screenSource}.btnwithdrawnFundsCollecte",
                                                  "${DateTime.now()}", {});
                                              launchWeb(
                                                "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/details-collecte/${widget.codeCotisation}?query=1&app_mode=mobile",
                                              );
                                              print("object1");
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 17.h,
                                                  child: SvgPicture.asset(
                                                    "assets/images/withdrawIcon.svg",
                                                    fit: BoxFit.scaleDown,
                                                    color: AppColors
                                                        .blackBlueAccent1,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                Text(
                                                  "Retrait des fonds".tr(),
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .blackBlueAccent1,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () async {
                                            updateTrackingData(
                                                "${widget.screenSource}.btnAdministerCollecte",
                                                "${DateTime.now()}", {});
                                            launchWeb(
                                                "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/details-collecte/${widget.codeCotisation}&app_mode=mobile");
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 17.h,
                                                child: SvgPicture.asset(
                                                  "assets/images/folderManageSimpleIcon.svg",
                                                  fit: BoxFit.scaleDown,
                                                  color: AppColors
                                                      .blackBlueAccent1,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Text(
                                                "Gerer".tr(),
                                                style: TextStyle(
                                                  color: AppColors
                                                      .blackBlueAccent1,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  Expanded(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: AppColors.blackBlue,
                                        onTap: () async {
                                          updateTrackingData(
                                              "${widget.screenSource}.btnShareCollection",
                                              "${DateTime.now()}", {});
                                          String message = "";
                                          message +=
                                              "🟢🟢 Une collecte a été créer pour : *${widget.motifCotisations}*\n\n";
                                          message +=
                                              "${widget.description}\n\n";
                                          // message +=
                                          //     "👉🏽 Montant de la participation: *${widget.type == "1" ? "volontaire".tr() : "${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA"}*\n";
                                          message +=
                                              "👉🏽 Cliquez ici pour participer: https://${widget.lienDePaiement}\n\n";
                                          message +=
                                              "📈 Montant total collecté: *${formatMontantFrancais(double.parse(widget.soldeCotisation))} FCFA*\n";
                                          message +=
                                              "🕐 Date de fin: *${formatMontantFrancais(double.parse(widget.soldeCotisation))} FCFA*\n\n";

                                          message += "*by ASSO+*";

                                          Share.share(
                                            message,
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            BlocBuilder<CotisationDetailCubit,
                                                    CotisationDetailState>(
                                                builder:
                                                    (CotisationDetailcontext,
                                                        CotisationDetailstate) {
                                              return CotisationDetailstate
                                                          .isLoading ==
                                                      true
                                                  ? Container(
                                                      width: 15.r,
                                                      height: 15.r,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 1.w,
                                                        color: AppColors
                                                            .blackBlueAccent1,
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 17.h,
                                                      child: SvgPicture.asset(
                                                        "assets/images/shareSimpleIcon.svg",
                                                        fit: BoxFit.scaleDown,
                                                        color: AppColors
                                                            .blackBlueAccent1,
                                                      ),
                                                    );
                                            }),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Text(
                                              "Partager".tr(),
                                              style: TextStyle(
                                                color:
                                                    AppColors.blackBlueAccent1,
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
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
