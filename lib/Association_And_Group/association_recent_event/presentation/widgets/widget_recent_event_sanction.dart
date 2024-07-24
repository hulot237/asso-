import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
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

class widgetRecentEventSanction extends StatefulWidget {
  var membreCode;

  var nomProprietaire;

  var resteAPayer;

  widgetRecentEventSanction(
      {super.key,
      required this.motif,
      required this.dateOpen,
      required this.montantSanction,
      required this.montantCollecte,
      required this.codeCotisation,
      required this.lienDePaiement,
      required this.libelleSanction,
      required this.type,
      required this.versement,
      required this.membreCode,
      required this.nomProprietaire,
      required this.resteAPayer});
  String motif;
  String dateOpen;
  String montantCollecte;
  int montantSanction;
  String codeCotisation;
  String lienDePaiement;
  String type;
  String libelleSanction;
  List versement;

  @override
  State<widgetRecentEventSanction> createState() =>
      _widgetRecentEventSanctionState();
}

class _widgetRecentEventSanctionState extends State<widgetRecentEventSanction> {
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
          UserGroupstate.changeAssData == null) return Container();
      return Material(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.white,
        child: InkWell(
          onTap: () {
            updateTrackingData("home.sanction", "${DateTime.now()}", {
              "type": 'sanction',
              "sanction_id": "${widget.codeCotisation}"
            });
            if (widget.type == "1")
              Modal().showModalTransactionByEvent(
                  context, widget.versement, widget.montantSanction.toString());
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 10.h,
              left: 10.w,
              right: 10.w,
              bottom: 0.h,
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
                            color: AppColors.colorButton,
                            borderRadius: BorderRadius.circular(360.r),
                          ),
                        ),
                        Text(
                          'sanction_capital'.tr(),
                          style: TextStyle(
                            color: AppColors.blackBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                    if (widget.type == "1")
                      Material(
                        color: AppColors.colorButton,
                        borderRadius: BorderRadius.circular(15.r),
                        child: InkWell(
                          splashColor: AppColors.blackBlue,
                          onTap: () async {
                            launchWeb(
                              "https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode}",
                            );
                            // updateTrackingData("home.btnSanction", "${DateTime.now()}", {"type": 'sanction', "sanction_id": "${widget.codeCotisation}"});
                            // String msg =
                            //     "Aide-moi à payer ma sanction de *${widget.motif}* du montant  *${formatMontantFrancais(double.parse(widget.montantSanction.toString()))} FCFA* directement via le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode}.";
                            // String raisonComplete =
                            //                     "Paiement de la sanction".tr();
                            //                 String motif = "payer_vous_même".tr();
                            //                 String paiementProcheMsg =
                            //                     "partager_le_lien_de_paiement".tr();
                            //                 String msgAppBarPaiementPage =
                            //                     "${'Paiement de la sanction'.tr()} ${widget.motif}";
                            //                     String elementUrl = "https://groups.faroty.com/sanctions";
                            //                 Modal().showModalActionPayement(
                            //                   context,
                            //                   msg,
                            //                   widget.lienDePaiement,
                            //                   raisonComplete,
                            //                   motif,
                            //                   paiementProcheMsg,
                            //                   msgAppBarPaiementPage,
                            //                   elementUrl,
                            //                 );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 72.w,
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.w,
                              vertical: 5.h,
                            ),
                            // decoration: BoxDecoration(
                            //   color: AppColors.colorButton,
                            //   borderRadius: BorderRadius.circular(15.r),
                            // ),
                            child: Container(
                              child: Text(
                                "Payer".tr(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: AppColors.white,
                                ),
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
                    "${widget.motif}",
                    // 'Voir bebe de l"enfant de djousse',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackBlue,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.type == "1")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Avance".tr(),
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
                      Column(
                        crossAxisAlignment: widget.type == "0"
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              "a_payer".tr(),
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
                                  ? "${formatMontantFrancais(double.parse("${widget.montantSanction}"))} FCFA"
                                  : "${widget.libelleSanction}",
                              overflow: TextOverflow.ellipsis,
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
                  margin: EdgeInsets.only(top: 7.h),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "${formatCompareDateReturnWellValueSanctionRecent(widget.dateOpen)}",
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
                    bottom: 8.h,
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
                        // if (widget.isSanctionPayed == 0)
                        // if (widget.nomBeneficiaire != "")
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Modal().showModalPaySanction(
                                    context,
                                    widget.nomProprietaire,
                                    widget.resteAPayer,
                                    widget.codeCotisation,
                                    widget.membreCode,
                                    widget.type,
                                    widget.libelleSanction,
                                    AppCubitStorage().state.codeTournois);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    // color: AppColors.colorButton,
                                    height: 17.h,
                                    // width: 230,
                                    child: SvgPicture.asset(
                                      "assets/images/walletPayIcon.svg",
                                      fit: BoxFit.scaleDown,
                                      color: AppColors.blackBlueAccent1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    "Payer via l'admin".tr(),
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
                      // if (!context
                      //     .read<AuthCubit>()
                      //     .state
                      //     .detailUser!["isMember"])
                      //   Expanded(
                      //     child: InkWell(
                      //       onTap: () async {
                      //         // updateTrackingData("home.btnAdminister",
                      //         //     "${DateTime.now()}", {});
                      //         // await launchWeb(
                      //         //   "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations-details/${widget.codeCotisation}&app_mode=mobile",
                      //         //   mode: LaunchMode.platformDefault,
                      //         // );
                      //       },
                      //       child: Container(
                      //         height: 20.h,
                      //         child: SvgPicture.asset(
                      //           "assets/images/folderManageSimpleIcon.svg",
                      //           fit: BoxFit.scaleDown,
                      //           color: AppColors.blackBlue,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      if (widget.type == "1")
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                print("object3");
                                Share.share(context
                                        .read<AuthCubit>()
                                        .state
                                        .detailUser!["isMember"]
                                    ? "Aide-moi à payer ma sanction *${widget.motif}*.\nMontant: *${formatMontantFrancais(double.parse(widget.montantSanction.toString()))} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode} pour valider"
                                    : "Nouvelle sanction créée dans le groupe *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* concernant ${widget.motif} sur le membre XXX..\nSoyez le premier à contribuer ici : https://${widget.lienDePaiement}");
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
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
