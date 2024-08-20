import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
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
    final detailCotisation = await context
        .read<CotisationDetailCubit>()
        .detailCotisationCubit(codeCotisation);
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
                  is_passed: widget.is_passed,
                  source: widget.source,
                  rubrique: widget.rubrique,
                  nomBeneficiaire: widget.nomBeneficiaire,
                  is_tontine: widget.is_tontine,
                ),
              ),
            );
          },
          child: Container(
            // decoration: widget.is_passed == 0
            //     ?
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              // color: AppColors.white,
            ),
            // : BoxDecoration(
            //     borderRadius: BorderRadius.circular(15.r),
            //     color: AppColors.whiteAccent,
            //     border: Border.all(
            //       width: 1.r,
            //       color: AppColors.white,
            //     ),
            //   ),
            padding:
                EdgeInsets.only(left: 10.w, top: 5.h, bottom: 4.h, right: 10.w),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 15.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Row(
                                        children: [
                                    if (widget.rubrique != "")
                                          Container(
                                            margin:
                                                EdgeInsets.only(bottom: 5.h),
                                            child: Text(
                                              '${widget.rubrique}'
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color:
                                                    AppColors.blackBlueAccent1,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ),
                                          if (widget.isPayed == 1) PayeWidget(),
                                          if (widget.isPayed == 0)
                                            NonpayeWidget(),
                                          // if (widget.isPayed == 1)
                                          //   Container(
                                          //     decoration: BoxDecoration(
                                          //         color: AppColors.colorButton,
                                          //         borderRadius:
                                          //             BorderRadius.circular(3.r)),
                                          //     margin: EdgeInsets.only(
                                          //         bottom: 5.h, left: 5.w),
                                          //     padding: EdgeInsets.symmetric(
                                          //         vertical: 1.h, horizontal: 2.w),
                                          //     child: Text(
                                          //       "payé".tr(),
                                          //       style: TextStyle(
                                          //         fontSize: 10.sp,
                                          //         color: AppColors.white,
                                          //         fontWeight: FontWeight.w600,
                                          //         // fontStyle: FontStyle.italic,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // if (widget.isPayed == 0)
                                          //   Container(
                                          //     decoration: BoxDecoration(
                                          //         color: AppColors.red,
                                          //         borderRadius:
                                          //             BorderRadius.circular(3.r)),
                                          //     margin: EdgeInsets.only(
                                          //         bottom: 5.h, left: 5.w),
                                          //     padding: EdgeInsets.symmetric(
                                          //         vertical: 1.h, horizontal: 2.w),
                                          //     child: Text(
                                          //       "non payé".tr(),
                                          //       style: TextStyle(
                                          //         fontSize: 10.sp,
                                          //         color: AppColors.white,
                                          //         fontWeight: FontWeight.w600,
                                          //         // fontStyle: FontStyle.italic,
                                          //       ),
                                          //     ),
                                          //   ),
                                        ],
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
                            // widget.isPayed == 0
                            //     ?
                            Column(
                              children: [
                                if (widget.is_passed == 0)
                                  (widget.type == "0" && widget.isPayed == 1)
                                      ? InkWell(
                                          onTap: () {
                                            handleDetailCotisation(
                                                widget.codeCotisation);

                                            Modal()
                                                .showModalPayForAnotherPersonCotisation(
                                              context,
                                              widget.codeCotisation,
                                              widget.lienDePaiement,
                                              widget.motifCotisations,
                                              widget.montantCotisations,
                                              widget.type == "1" ? true : false,
                                              widget.nomBeneficiaire,
                                              widget.source,
                                              widget.dateCotisation,
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 4.h,
                                            ),
                                            margin:
                                                EdgeInsets.only(bottom: 2.h),
                                            // padding: EdgeInsets.symmetric(
                                            //   horizontal: 5.w,
                                            //   vertical: 4.h,
                                            // ),
                                            decoration: BoxDecoration(
                                              color: AppColors.colorButton,
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            child: Container(
                                              child: Text(
                                                "Cotiser un ami".tr(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : PopupMenuButton(
                                          elevation: 5,
                                          shadowColor:
                                              AppColors.barrierColorModal,
                                          onSelected: (value) async {
                                            if (value == "mySelf") {
                                              print("value");
                                              launchWeb(
                                                "https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode}",
                                              );
                                            } else if (value ==
                                                "anotherPerson") {
                                              handleDetailCotisation(
                                                  widget.codeCotisation);

                                              Modal()
                                                  .showModalPayForAnotherPersonCotisation(
                                                      context,
                                                      widget.codeCotisation,
                                                      widget.lienDePaiement,
                                                      widget.motifCotisations,
                                                      widget.montantCotisations,
                                                      widget.type == "1"
                                                          ? true
                                                          : false,
                                                      widget.nomBeneficiaire,
                                                      widget.source,
                                                      widget.dateCotisation);
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 4.h,
                                            ),
                                            margin:
                                                EdgeInsets.only(bottom: 2.h),
                                            // padding: EdgeInsets.symmetric(
                                            //   horizontal: 5.w,
                                            //   vertical: 4.h,
                                            // ),
                                            decoration: BoxDecoration(
                                              color: AppColors.colorButton,
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            child: Container(
                                              child: Text(
                                                widget.isPayed == 1 &&
                                                        widget.type == "1"
                                                    ? "Cotiser à nouveau".tr()
                                                    : "cotiser".tr(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry>[
                                            PopupMenuItem(
                                              value: "mySelf",
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8.0),
                                                    child: Container(
                                                      height: 22.h,
                                                      width: 22.w,
                                                      child: SvgPicture.asset(
                                                        "assets/images/person.svg",
                                                        fit: BoxFit.cover,
                                                        color: AppColors
                                                            .blackBlueAccent1,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Payer pour moi'.tr(),
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color:
                                                          AppColors.blackBlue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: "anotherPerson",
                                              // onTap: () {
                                              //   _showSimpleModalDialog(context);
                                              // },
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8.0),
                                                    child: Container(
                                                      height: 22.h,
                                                      width: 22.w,
                                                      child: SvgPicture.asset(
                                                        "assets/images/friendsTalking.svg",
                                                        fit: BoxFit.cover,
                                                        color: AppColors
                                                            .blackBlueAccent1,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Payer pour quelqu'un".tr(),
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color:
                                                          AppColors.blackBlue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                              ],
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              // margin: EdgeInsets.only(bottom: 5),
                              // width: MediaQuery.of(context).size.width / 1.1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          formatDateLiteral(
                                              widget.dateCotisation),
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
                                ],
                              ),
                            ),
                            if (widget.is_passed == 1)
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.amberAccent,
                                    borderRadius: BorderRadius.circular(3.r)),
                                margin: EdgeInsets.only(bottom: 5.h, left: 5.w),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (!context
                                .read<AuthCubit>()
                                .state
                                .detailUser!["isMember"])
                              if (widget.nomBeneficiaire != "")
                                Expanded(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        updateTrackingData(
                                            "${widget.screenSource}.btnwithdrawnFundsContribution",
                                            "${DateTime.now()}", {});
                                        launchWeb(
                                          "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations-details/${widget.codeCotisation}?query=1&app_mode=mobile",
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
                                          "${widget.screenSource}.btnAdministerContribution",
                                          "${DateTime.now()}", {});
                                      // print("https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations-details/${widget.codeCotisation}&app_mode=mobile");
                                      launchWeb(
                                          "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations-details/${widget.codeCotisation}&app_mode=mobile");
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 17.h,
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
                              ),
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: AppColors.blackBlue,
                                  onTap: () async {
                                    print("object3");
                                    updateTrackingData(
                                        "${widget.screenSource}.btnShareContribution",
                                        "${DateTime.now()}", {});

                                    await handleDetailCotisation(
                                        widget.codeCotisation);

                                    final currentDetailCotisation = context
                                        .read<CotisationDetailCubit>()
                                        .state
                                        .detailCotisation;

                                    List listeOkayCotisation =
                                        currentDetailCotisation!["membres"];

                                    partagerCotisation(
                                      nomGroupe:
                                          '${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}'
                                              .trimRight(),
                                      source:
                                          '*${(widget.source.trimRight())}*'
                                              .trimRight(),
                                      nomBeneficiaire: '*${(widget.nomBeneficiaire.trimRight())}*',
                                          //     .trimRight(),
                                          // '*${(widget.nomBeneficiaire)}*'
                                          //     .trimRight(),
                                      dateCotisation:
                                          '${widget.dateCotisation}',
                                      montantCotisations:
                                          '${widget.montantCotisations}',
                                      lienDePaiement:
                                          '${widget.lienDePaiement}',
                                      type: '${widget.type}',
                                      listeOkayCotisation: listeOkayCotisation,
                                      context: context,
                                    );

                                    //         Container(
                                    //   child: Text(
                                    //     widget.type == "1" ? "volontaire".tr() :
                                    //         // : "type_fixe".tr(),
                                    //         "${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA",
                                    //     style: TextStyle(
                                    //       fontSize: 13.sp,
                                    //       color: AppColors.blackBlue,
                                    //       fontWeight: FontWeight.w600,
                                    //     ),
                                    //   ),
                                    // ),

                                    // Share.share(context
                                    //         .read<AuthCubit>()
                                    //         .state
                                    //         .detailUser!["isMember"]
                                    //     ? "Aide-moi à payer ma cotisation *${widget.motifCotisations}*.\nMontant: *${widget.type == "1" ? "volontaire".tr() : "${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA"}* .\nMerci de suivre le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode} pour valider"
                                    //     : "Nouvelle cotisation créée dans le groupe *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* concernant ${widget.source == '' ? "*${(widget.nomBeneficiaire)}*" : "*${(widget.source)}*"}.\nSoyez le premier à contribuer ici : https://${widget.lienDePaiement}");
                                  },
                                  child: Column(
                                    children: [
                                      BlocBuilder<CotisationDetailCubit,
                                              CotisationDetailState>(
                                          builder: (CotisationDetailcontext,
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
                      )
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
