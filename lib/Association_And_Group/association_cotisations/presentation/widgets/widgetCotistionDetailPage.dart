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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WidgetCotistionDetailPage extends StatefulWidget {
  WidgetCotistionDetailPage({
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
  State<WidgetCotistionDetailPage> createState() =>
      _WidgetCotistionDetailPageState();
}

class _WidgetCotistionDetailPageState extends State<WidgetCotistionDetailPage> {
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
                                          handleDetailCotisation(
                                              widget.codeCotisation);

                                         Modal().showModalPayForAnotherPersonCotisation(
                                            context,
                                            widget.codeCotisation,
                                            widget.lienDePaiement,
                                            widget.motifCotisations,
                                            widget.montantCotisations,
                                            widget.type == "1" ? true:false,
                                          );
                                        }
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
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry>[
                                        PopupMenuItem(
                                          value: "mySelf",
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8.0),
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
                                                padding:
                                                    EdgeInsets.only(right: 8.0),
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
                                                  color: AppColors.blackBlue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                  BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
                    builder:
                        (CotisationDetailContext, CotisationDetailState) {
                      if (CotisationDetailState.isLoading == true ||
                          CotisationDetailState.detailCotisation == null)
                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 7.h,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
      
                      final currentDetailCotisation = CotisationDetailContext
                              .read<CotisationDetailCubit>()
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
                                        in currentDetailCotisation["membres"])
                                      if (itemDetailCotisation["membre"]
                                              ["membre_code"] ==
                                          AppCubitStorage().state.membreCode)
                                        Modal().showModalTransactionByEvent(
                                          context,
                                          itemDetailCotisation["payments"],
                                          '${widget.montantCotisations}',
                                          resteAPayer: itemDetailCotisation[
                                              "amount_remaining"],
                                          dejaPayer:
                                              itemDetailCotisation["balance"],
                                        );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 7.h,
                                    ),
                                    alignment: Alignment.centerLeft,
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
                                          margin: EdgeInsets.only(right: 5.w),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        for (var itemDetailCotisation
                                            in currentDetailCotisation[
                                                "membres"])
                                          if (itemDetailCotisation["membre"]
                                                  ["membre_code"] ==
                                              AppCubitStorage()
                                                  .state
                                                  .membreCode)
                                            Container(
                                              child: Text(
                                                "${formatMontantFrancais(double.parse("${itemDetailCotisation["balance"]}"))} FCFA",
                                                // "${itemDetailCotisation["membre"]["versement"].length}",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  // fontWeight:
                                                  //     FontWeight.w800,
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
                              child: InkWell(
                                onTap: () async{
                                  updateTrackingData(
                                      "${widget.screenSource}.btnwithdrawnFundsContribution",
                                      "${DateTime.now()}", {});
                                   launchWeb(
                                    "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations-details/${widget.codeCotisation}?query=1&app_mode=mobile",
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
                                updateTrackingData("home.btnAdminister",
                                    "${DateTime.now()}", {});
                                 launchWeb(
                                  "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations-details/${widget.codeCotisation}&app_mode=mobile",
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
                        Expanded(
                          child: InkWell(
                            splashColor: AppColors.blackBlue,
                            onTap: () {
                              print("object3");
                              Share.share(context
                                      .read<AuthCubit>()
                                      .state
                                      .detailUser!["isMember"]
                                  ? "Aide-moi à payer ma cotisation *${widget.motifCotisations}*.\nMontant: *${ widget.type == "1" ? "volontaire".tr() : "${formatMontantFrancais(double.parse(widget.montantCotisations.toString() ))} FCFA"} *.\nMerci de suivre le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode} pour valider"
                                  : "Nouvelle cotisation créée dans le groupe *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* concernant ${widget.source == '' ? "*${(widget.nomBeneficiaire)}*" : "*${(widget.source)}*"}.\nSoyez le premier à contribuer ici : https://${widget.lienDePaiement}");
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
