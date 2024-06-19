import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
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

class widgetDetailHistoriqueTontineCard extends StatefulWidget {
  widgetDetailHistoriqueTontineCard({
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
    required this.isPayed,
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
  int isPayed;

  @override
  State<widgetDetailHistoriqueTontineCard> createState() =>
      _widgetDetailHistoriqueTontineCardState();
}

class _widgetDetailHistoriqueTontineCardState
    extends State<widgetDetailHistoriqueTontineCard> {
  Future<void> handleDetailCotisation(codeCotisation) async {
    final detailCotisation = await context
        .read<CotisationDetailCubit>()
        .detailCotisationCubit(codeCotisation);
  }

    Future<void> handleDetailContributionTontine(codeContribution) async {
    final detailCotisation = await context
        .read<DetailContributionCubit>()
        .detailContributionTontineCubit(codeContribution);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          // margin: EdgeInsets.only(right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "${"Bénéficiaire".tr()} :",
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
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "${widget.nomBeneficiaire}",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      widget.isPayed == 0
                          ? 
                          // GestureDetector(
                          //     onTap: () async {
                          //        launchWeb(
                          //         "https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode}",
                          //       );
                          //     },
                          //     child: Container(
                          //       alignment: Alignment.center,
                          //       width: 72.w,
                          //       padding: EdgeInsets.symmetric(
                          //         horizontal: 8.w,
                          //         vertical: 5.h,
                          //       ),
                          //       decoration: BoxDecoration(
                          //         color: AppColors.colorButton,
                          //         borderRadius: BorderRadius.circular(15.r),
                          //       ),
                          //       child: Container(
                          //         child: Text(
                          //           "Tontiner",
                          //           style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 12.sp,
                          //             color: AppColors.white,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   )

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
                              widget.nomTontine,
                              widget.montantTontine,
                            );
                          }
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
                  margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 3.h),
                        child: Text(
                          formatDateLiteral(widget.dateOpen),
                          style: TextStyle(
                              fontSize: 12.sp,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(123, 20, 45, 99)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // width: MediaQuery.of(context).size.width / 1.1,
                  margin: EdgeInsets.only(bottom: 7.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 3.h),
                                      child: Text(
                                        "${formatMontantFrancais(double.parse("${widget.montantTontine}"))} FCFA",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: AppColors.blackBlue,
                                          fontWeight: FontWeight.w600,
                                        ),
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
                          context
                              .read<AuthCubit>()
                              .state
                              .detailUser!["isMember"]))
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  "montant_collecté".tr(),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackBlueAccent1,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3.h),
                                child: Text(
                                  "${formatMontantFrancais(double.parse("${widget.montantCollecte}"))} FCFA",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppColors.green,
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
  }
}
