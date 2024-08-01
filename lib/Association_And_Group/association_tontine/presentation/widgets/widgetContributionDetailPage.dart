import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/contribution_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/screens/detailContributionPage.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WidgetContributionDetailPage extends StatefulWidget {
  WidgetContributionDetailPage({
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
    required this.isCotisation,
    // required this.rapportUrl,
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
  bool isCotisation;
  // String? rapportUrl;

  @override
  State<WidgetContributionDetailPage> createState() =>
      _WidgetContributionDetailPageState();
}

class _WidgetContributionDetailPageState
    extends State<WidgetContributionDetailPage> {
  Future<void> handleDetailContributionTontine(codeContribution) async {
    final detailCotisation = await context
        .read<DetailContributionCubit>()
        .detailContributionTontineCubit(codeContribution);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailContributionCubit, ContributionState>(
        builder: (DetailContributionContext, DetailContributionState) {
      return Container(
        decoration:
            //widget.is_passed == 0 ?
            BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.white,
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
            EdgeInsets.only(left: 10.w, top: 5.h, bottom: 3.h, right: 10.w),
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
                                  Row(
                                    children: [
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
                                      if (widget.isPayed == 1) PayeWidget(),
                                      if (widget.isPayed == 0) NonpayeWidget()
                                      // Container(
                                      //   margin: EdgeInsets.only(
                                      //       bottom: 5.h, left: 5.w),
                                      //   child: Text(
                                      //     "payé".tr(),
                                      //     style: TextStyle(
                                      //       fontSize: 12.sp,
                                      //       color: AppColors.green,
                                      //       fontWeight: FontWeight.w600,
                                      //       fontStyle: FontStyle.italic,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    if (widget.source != '' &&
                                        widget.nomBeneficiaire != '')
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
                        if (widget.is_passed == 0)
                        Column(
                          children: [
                            if (widget.isPayed == 1)
                              InkWell(
                                onTap: () {
                                  handleDetailContributionTontine(
                                    widget.codeCotisation,
                                  );
                                  Modal().showModalPayForAnotherPersonTontine(
                                      context,
                                      widget.codeCotisation,
                                      widget.lienDePaiement,
                                      widget.rubrique,
                                      widget.montantCotisations,
                                      widget.dateCotisation,
                                      widget.nomBeneficiaire);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  // width: 72.w,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.colorButton,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Container(
                                    child: Text(
                                      "Tontiner un ami".tr(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            if (widget.isPayed == 0)
                              PopupMenuButton(
                                elevation: 5,
                                shadowColor: AppColors.barrierColorModal,
                                onSelected: (value) async {
                                  if (value == "mySelf") {
                                    print("value");
                                    launchWeb(
                                      "https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode}",
                                    );
                                  } else if (value == "anotherPerson") {
                                    handleDetailContributionTontine(
                                      widget.codeCotisation,
                                    );
                                    Modal().showModalPayForAnotherPersonTontine(
                                        context,
                                        widget.codeCotisation,
                                        widget.lienDePaiement,
                                        widget.rubrique,
                                        widget.montantCotisations,
                                        widget.dateCotisation,
                                        widget.nomBeneficiaire);

                                    // handleDetailCotisation(widget.codeCotisation);

                                    // Modal()
                                    //     .showModalPayForAnotherPersonCotisation(
                                    //   context,
                                    //   widget.codeCotisation,
                                    //   widget.lienDePaiement,
                                    //   widget.motifCotisations,
                                    //   widget.montantCotisations,
                                    //   widget.type == "1" ? true : false,
                                    //   widget.nomBeneficiaire,
                                    //   widget.source,
                                    //    widget.dateCotisation
                                    // );
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  // width: 72.w,
                                  margin: EdgeInsets.only(bottom: 2.h),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.colorButton,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Container(
                                    child: Text(
                                      "Tontiner".tr(),
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
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            height: 22.h,
                                            width: 22.w,
                                            child: SvgPicture.asset(
                                              "assets/images/person.svg",
                                              fit: BoxFit.cover,
                                              color: AppColors.blackBlueAccent1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Payer pour moi'.tr(),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.bold,
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
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            height: 22.h,
                                            width: 22.w,
                                            child: SvgPicture.asset(
                                              "assets/images/friendsTalking.svg",
                                              fit: BoxFit.cover,
                                              color: AppColors.blackBlueAccent1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Payer pour quelqu'un".tr(),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            // if (widget.is_passed == 1)
                            //   Container(
                            //     alignment: Alignment.center,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(7.r),
                            //     ),
                            //     child: Container(
                            //       child: Text(
                            //         "expiré".tr(),
                            //         style: TextStyle(
                            //           // fontWeight: FontWeight.bold,
                            //           fontSize: 10.sp,
                            //           color: AppColors.red,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                          ],
                        )
                        // :
                        // Text(
                        //     "payé".tr(),
                        //     style: TextStyle(
                        //       fontSize: 14.sp,
                        //       color: AppColors.green,
                        //       fontWeight: FontWeight.w600,
                        //       fontStyle: FontStyle.italic,
                        //     ),
                        //   ),
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
                              // Container(
                              //   child: Text(
                              //     "${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA",
                              //     style: TextStyle(
                              //       color: AppColors.blackBlue,
                              //       fontSize: 13.sp,
                              //     ),
                              //   ),
                              // ),

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
                      context.read<AuthCubit>().state.detailUser!["isMember"]))
                    Container(
                      // margin: EdgeInsets.only(bottom: 5),
                      // width: MediaQuery.of(context).size.width / 1.1,
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

                              // BlocBuilder<CotisationDetailCubit,
                              //     CotisationDetailState>(
                              //   builder: (CotisationDetailContext,
                              //       CotisationDetailState) {
                              //     if (CotisationDetailState.isLoading == true ||
                              //         CotisationDetailState.detailCotisation ==
                              //             null)
                              //       return GestureDetector(
                              //         child: Container(
                              //           margin: EdgeInsets.only(
                              //             top: 2.h,
                              //           ),
                              //           alignment: Alignment.centerLeft,
                              //           child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.center,
                              //             children: [
                              //               Container(
                              //                 child: Text(
                              //                   "vous_avez_cotisé".tr(),
                              //                   style: TextStyle(
                              //                     fontSize: 12.sp,
                              //                     fontWeight: FontWeight.bold,
                              //                     color: AppColors.blackBlue,
                              //                   ),
                              //                 ),
                              //                 margin:
                              //                     EdgeInsets.only(right: 5.w),
                              //               ),
                              //               Container(
                              //                 width: 12.w,
                              //                 height: 12.h,
                              //                 color: AppColors.white,
                              //                 child: Center(
                              //                   child:
                              //                       CircularProgressIndicator(
                              //                     color: AppColors.green,
                              //                     strokeWidth: 0.5,
                              //                   ),
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //       );

                              //     final currentDetailCotisation = CotisationDetailContext.read<DetailContributionCubit>().state.detailContributionTontine;

                              //     print(
                              //         "detailContributionTontinedetailContributionTontine ${currentDetailCotisation}");
                              //     return currentDetailCotisation != null
                              //         ? Column(
                              //             children: [
                              //               GestureDetector(
                              //                 onTap: () {
                              //                   // if (currentDetailCotisation!["versements"].length > 0)
                              //                   for (var itemDetailCotisation
                              //                       in currentDetailCotisation[
                              //                           "membres"])
                              //                     if (itemDetailCotisation[
                              //                                 "membre"]
                              //                             ["membre_code"] ==
                              //                         AppCubitStorage()
                              //                             .state
                              //                             .membreCode)
                              //                       Modal()
                              //                           .showModalTransactionByEvent(
                              //                         context,
                              //                         itemDetailCotisation[
                              //                             "payments"],
                              //                         '${widget.montantCotisations}',
                              //                         resteAPayer:
                              //                             itemDetailCotisation[
                              //                                 "amount_remaining"],
                              //                         dejaPayer:
                              //                             itemDetailCotisation[
                              //                                 "balance"],
                              //                       );
                              //                 },
                              //                 child: Container(
                              //                   margin: EdgeInsets.only(
                              //                     top: 2.h,
                              //                   ),
                              //                   alignment: Alignment.centerLeft,
                              //                   child: Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: [
                              //                       Container(
                              //                         child: Text(
                              //                           "vous_avez_cotisé".tr(),
                              //                           style: TextStyle(
                              //                             fontSize: 12.sp,
                              //                             fontWeight:
                              //                                 FontWeight.bold,
                              //                             color: AppColors
                              //                                 .blackBlue,
                              //                           ),
                              //                         ),
                              //                         margin: EdgeInsets.only(
                              //                             right: 5.w),
                              //                       ),
                              //                       SizedBox(
                              //                         height: 2.h,
                              //                       ),
                              //                       for (var itemDetailCotisation
                              //                           in currentDetailCotisation[
                              //                               "membres"])
                              //                         if (itemDetailCotisation[
                              //                                     "membre"]
                              //                                 ["membre_code"] ==
                              //                             AppCubitStorage()
                              //                                 .state
                              //                                 .membreCode)
                              //                           Container(
                              //                             child: Text(
                              //                               "${formatMontantFrancais(double.parse("${itemDetailCotisation["balance"]}"))} FCFA",
                              //                               // "${itemDetailCotisation["membre"]["versement"].length}",
                              //                               style: TextStyle(
                              //                                 fontSize: 13.sp,
                              //                                 // fontWeight:
                              //                                 //     FontWeight.w800,
                              //                                 color: Color
                              //                                     .fromARGB(
                              //                                   255,
                              //                                   20,
                              //                                   45,
                              //                                   99,
                              //                                 ),
                              //                               ),
                              //                             ),
                              //                           ),
                              //                     ],
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           )
                              //         : Container();
                              //   },
                              // ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
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
                              if (widget.is_passed == 1)
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.amberAccent,
                                      borderRadius: BorderRadius.circular(3.r)),
                                  margin: EdgeInsets.only(
                                      bottom: 5.h, left: 5.w, top: 2.h),
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
                              if (widget.is_passed == 0) EncoursWidget(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 8.h,
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
                                        "home.btnwithdrawnFundsContribution",
                                        "${DateTime.now()}", {});
                                    launchWeb(
                                      "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/tontine-details/${widget.codeCotisation}?query=1&app_mode=mobile",
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 20.h,
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
                                  updateTrackingData("home.btnAdminister",
                                      "${DateTime.now()}", {});
                                  launchWeb(
                                    "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/tontine-details/${widget.codeCotisation}&app_mode=mobile",
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      // color: const Color.fromARGB(255, 0, 0, 0),
                                      height: 20.h,
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
                          ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                final currentDetailCotisation = context
                                    .read<DetailContributionCubit>()
                                    .state
                                    .detailContributionTontine;

                                List listeOkayCotisation =
                                    currentDetailCotisation![
                                        "contribution_membres"];

                                String originalString = widget.rubrique;

                                String result = originalString.replaceFirst(
                                    "Tontine : ", "");
                                print("oresult $result");

                                partagerContributionTontine(
                                  nomGroupe:
                                      '${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}'
                                          .trimRight(),
                                  // source:
                                  //     '${widget.source == '' ? '*${(widget.nomBeneficiaire.trimRight())}*' : "*${(widget.source.trimRight())}*"}'
                                  //         .trimRight(),
                                  nomBeneficiaire:
                                      '${(widget.nomBeneficiaire)}'.trimRight(),
                                  dateCotisation: '${widget.dateCotisation}',
                                  montantCotisations:
                                      '${widget.montantCotisations}',
                                  lienDePaiement: '${widget.lienDePaiement}',
                                  // type: '${widget.type}',
                                  listeOkayCotisation: listeOkayCotisation,
                                  context: context,
                                  nomTontine: result.trimLeft(),
                                  motif: widget.motifCotisations,
                                );

                                // String message;

                                // message =
                                //     "🟢🟢 Nouvelle cotisation en cours dans le groupe *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* concernant ${widget.source == '' ? '*${(widget.nomBeneficiaire)}*' : "*${(widget.source)}*"}\n\n";

                                // message +=
                                //     "👉🏽 ${(widget.source == '' ? "MEMBRE CONCERNÉ" : "SEANCE CONCERNEE")} : ${widget.source == '' ? '*${(widget.nomBeneficiaire)}*' : '*${(widget.source)}*'}\n";
                                // message +=
                                //     "👉🏽 MONTANT : ${widget.type == "1" ? "*${"volontaire".tr()}*" : "*${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA*"}\n";
                                // message +=
                                //     "👉🏽 DATE DE FIN : *${(formatDateLiteral(widget.dateCotisation))}*\n\n";

                                // message +=
                                //     "Soyez le premier à contribuer ici :  https://${widget.lienDePaiement}\n\n";

                                // message += "*Récapitulatif :*\n";
                                // // Calcul du total et ajout des détails par membre
                                // double totalCotisations = 0;
                                // for (var element in listeOkayCotisation) {
                                //   String firstName =
                                //       element["membre"]["first_name"];
                                //   String lastName =
                                //       element["membre"]["last_name"];
                                //   double balance = double.parse(element[
                                //       "balance"]); // Conversion de la balance en nombre

                                //   // Formater la balance pour enlever les décimales et ajouter des séparateurs de milliers
                                //   String formattedBalance =
                                //       NumberFormat.decimalPattern()
                                //           .format(balance.toInt());

                                //   message +=
                                //       "- $firstName $lastName -> $formattedBalance F ${element["statut"] == "2" ? "✅" : "❌"}\n";
                                //   totalCotisations += balance;
                                // }

                                // // Formater le total des cotisations pour enlever les décimales et ajouter des séparateurs de milliers
                                // String formattedTotal =
                                //     NumberFormat.decimalPattern()
                                //         .format(totalCotisations.toInt());

                                // message += "\n*TOTAL -> $formattedTotal F*\n\n";

                                // message += "*by ASSO+*";

                                // Share.share(message);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 20.h,
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
