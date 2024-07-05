import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetHistoriqueTontineCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widget_pay_another_person.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class widgetRecentEventCotisation extends StatefulWidget {
  var is_tontine;

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
    required this.rapportUrl,
    required this.is_tontine,
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
  String? rapportUrl;

  @override
  State<widgetRecentEventCotisation> createState() =>
      _widgetRecentEventCotisationState();
}

class _widgetRecentEventCotisationState
    extends State<widgetRecentEventCotisation> {
  Future<void> handleDetailCotisation(codeCotisation) async {
    final detailCotisation = await context
        .read<CotisationDetailCubit>()
        .detailCotisationCubit(codeCotisation);
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
          updateTrackingData("home.contribution", "${DateTime.now()}", {
            "type": 'contribution',
            "contribution_id": "${widget.codeCotisation}"
          });
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
              widget.rapportUrl,
              0,
              widget.source,
              widget.nomBeneficiaire,
              widget.rublique,
              widget.is_tontine,
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ListMeetingScreen(),
            //   ),
            // );
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
                  rapportUrl: widget.rapportUrl,
                  is_passed: widget.isPassed,
                  source: widget.source,
                  is_tontine: widget.is_tontine,
                  nomBeneficiaire: widget.nomBeneficiaire,
                  rubrique: widget.rublique,
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
              padding: EdgeInsets.only(
                top: 10.h,
                bottom: 7.h,
                left: 10.w,
                right: 10.w,
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
                            handleDetailCotisation(widget.codeCotisation);
                            Modal().showModalPayForAnotherPersonCotisation(
                              context,
                              widget.codeCotisation,
                              widget.lienDePaiement,
                              widget.motif,
                              widget.montantCotisation,
                              widget.type == "1" ? true:false,
                            );
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          // width: 75.w,
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
                              "cotiser".tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
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
                        SizedBox(
                          height: 1.h,
                        ),
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
                                  SizedBox(
                                    height: 2.h,
                                  ),
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
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              child: Text(
                                widget.type == "1"
                                    ? "volontaire".tr()
                                    :
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
                                    "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations-details/${widget.codeCotisation}?query=1&app_mode=mobile",
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
                            onTap: () async{
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
                                      '${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}'.trimRight(),
                                  source:
                                      '${widget.source == '' ? '*${(widget.nomBeneficiaire.trimRight())}*' : "*${(widget.source.trimRight())}*"}',
                                  nomBeneficiaire:
                                      '${(widget.nomBeneficiaire.trimRight())}',
                                  dateCotisation: '${widget.dateClose}',
                                  montantCotisations:
                                      '${widget.montantCotisation}',
                                  lienDePaiement: '${widget.lienDePaiement}',
                                  type: '${widget.type}',
                                  listeOkayCotisation: listeOkayCotisation,
                                  context: context,
                                );
                              print("object3");
                              // Share.share(context
                              //         .read<AuthCubit>()
                              //         .state
                              //         .detailUser!["isMember"]
                              //     ? "Aide-moi à payer ma cotisation *${widget.motif}*.\nMontant: *${ widget.type == "1" ? "volontaire".tr() : "${formatMontantFrancais(double.parse(widget.montantCotisation.toString() ))} FCFA"} * .\nMerci de suivre le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode} pour valider"
                              //     : "Nouvelle cotisation créée dans le groupe *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* concernant ${widget.source == '' ? "*${(widget.nomBeneficiaire)}*" : "*${(widget.source)}*"}.\nSoyez le premier à contribuer ici : https://${widget.lienDePaiement}");
                            },
                            child: Column(
                              children: [
                                BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
                                      builder: (CotisationDetailcontext, CotisationDetailstate) {
                                    return CotisationDetailstate.isLoading == true ? Container(
                                      width: 15.r,
                                      height: 15.r,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.w,
                                        color: AppColors.blackBlueAccent1,
                                      ),
                                    ): Container(
                                      height: 17.h,
                                      child: SvgPicture.asset(
                                        "assets/images/shareSimpleIcon.svg",
                                        fit: BoxFit.scaleDown,
                                        color: AppColors.blackBlueAccent1,
                                      ),
                                    );
                                  }
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
            // Container(),
          ],
        ),
      );
    });
  }



}
