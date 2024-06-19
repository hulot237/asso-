import 'package:easy_localization/easy_localization.dart';
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

class WidgetSanction extends StatefulWidget {
  WidgetSanction({
    super.key,
    required this.heureSanction,
    required this.dateSanction,
    required this.motifSanction,
    required this.montantSanction,
    required this.montantPayeeSanction,
    required this.lienPaiement,
    required this.versement,
    required this.isSanctionPayed,
    required this.typeSaction,
    required this.objetSanction,
    required this.resteAPayer,
    required this.dejaPayer,
    required this.screenSource,
    required this.isAdmin,
    required this.nomProprietaire,
    required this.membreCode,
    required this.sanction_code,
    required this.codeTournoi,
  });
  String heureSanction;
  String dateSanction;
  String motifSanction;
  String montantPayeeSanction;
  String montantSanction;
  String lienPaiement;
  List versement;
  int isSanctionPayed;
  String typeSaction;
  String objetSanction;
  String dejaPayer;
  String resteAPayer;
  String screenSource;
  bool isAdmin;
  String nomProprietaire;
  String membreCode;
  String sanction_code;
  String codeTournoi;

  @override
  State<WidgetSanction> createState() => _WidgetSanctionState();
}

class _WidgetSanctionState extends State<WidgetSanction> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.typeSaction == "1")
          Modal().showModalTransactionByEvent(
            context,
            widget.versement,
            widget.montantSanction,
            resteAPayer: widget.resteAPayer,
            dejaPayer: widget.dejaPayer,
          );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
              left: BorderSide(
                  width: 8.r,
                  color: widget.isSanctionPayed == 0
                      ? AppColors.red
                      : AppColors.green),
            ),
          ),
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      // color: Colors.deepPurple,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            // flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(right: 15.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(widget.isAdmin)
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5.h),
                                    child: Text(
                                      widget.nomProprietaire,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blackBlueAccent1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${widget.motifSanction}",
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.blackBlue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (widget.typeSaction == "1" &&
                              widget.isSanctionPayed == 0)
                            GestureDetector(
                              onTap: () async {
                                 launchWeb(
                                  "https://${widget.lienPaiement}?code=${AppCubitStorage().state.membreCode}",
                                );
                                // String msg =
                                //     "Aide-moi à payer ma sanction de *${widget.motifSanction}* du montant  *${formatMontantFrancais(double.parse(widget.montantSanction))} FCFA* directement via le lien https://${widget.lienPaiement}?code=${AppCubitStorage().state.membreCode}.";
                                // String raisonComplete =
                                //     "Paiement de la sanction".tr();
                                // String motif = "payer_vous_même".tr();
                                // String paiementProcheMsg =
                                //     "partager_le_lien_de_paiement".tr();
                                // String msgAppBarPaiementPage =
                                //     "${'Paiement de la sanction'.tr()} ${widget.motifSanction}";
                                //     String elementUrl = "https://groups.faroty.com/fond-caisse";
                                // Modal().showModalActionPayement(
                                //   context,
                                //   msg,
                                //   widget.lienPaiement,
                                //   raisonComplete,
                                //   motif,
                                //   paiementProcheMsg,
                                //   msgAppBarPaiementPage,
                                //   elementUrl,
                                // );
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 72.w,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 7.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.colorButton,
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
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
                                  ],
                                ),
                              ),
                            ),

                          // if (widget.typeSaction == "1" && widget.isSanctionPayed == 0)
                          //   Container(
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.end,
                          //       children: [
                          //         Container(
                          //           padding: EdgeInsets.only(bottom: 2.h),
                          //           child: Text(
                          //             "a_payer".tr(),
                          //             style: TextStyle(
                          //               fontSize: 12.sp,
                          //               color: AppColors.blackBlueAccent1,
                          //               fontWeight: FontWeight.w700,
                          //             ),
                          //           ),
                          //         ),
                          //         Container(
                          //           child: Text(
                          //             "${formatMontantFrancais(double.parse(widget.montantSanction))} FCFA",
                          //             style: TextStyle(
                          //               fontSize: 12.sp,
                          //               fontWeight: FontWeight.w900,
                          //               color: AppColors.red,
                          //             ),
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   )
                        ],
                      ),
                    ),
                    Container(
                      height: 2.h,
                      margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                      width: MediaQuery.of(context).size.width / 1.1,
                      color: widget.isSanctionPayed == 0
                          ? AppColors.red
                          : AppColors.green,
                    ),
                    widget.typeSaction == "1" && widget.isSanctionPayed == 0
                        ? Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (widget.typeSaction == "1" &&
                                    widget.isSanctionPayed == 0)
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 2.h),
                                          child: Text(
                                            "a_payer".tr(),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: AppColors.blackBlueAccent1,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "${formatMontantFrancais(double.parse(widget.montantSanction))} FCFA",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w900,
                                              color: AppColors.red,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 2.h),
                                        child: Text(
                                          "déjà_payé".tr(),
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: AppColors.blackBlueAccent1,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${formatMontantFrancais(double.parse(widget.montantPayeeSanction))} FCFA",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w900,
                                              color: AppColors.green),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : widget.typeSaction == "1" &&
                                widget.isSanctionPayed == 1
                            ? Container(
                                margin: EdgeInsets.only(bottom: 8.h),
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 2.h),
                                            child: Text(
                                              "a_payer".tr(),
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color:
                                                    AppColors.blackBlueAccent1,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "${formatMontantFrancais(double.parse(widget.montantSanction))} FCFA",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w900,
                                                color: AppColors.green,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 2.h),
                                            child: Text(
                                              "déjà_payé".tr(),
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color:
                                                    AppColors.blackBlueAccent1,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "${formatMontantFrancais(double.parse(widget.montantPayeeSanction))} FCFA",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w900,
                                                color: AppColors.green,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(bottom: 8.h),
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Text(
                                              "${widget.objetSanction}",
                                              style: TextStyle(
                                                  color: AppColors.blackBlue,
                                                  fontSize: 14.sp),
                                            ),
                                            margin: EdgeInsets.only(
                                              right: 10.w,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                    margin: EdgeInsets.only(bottom: 8.h),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      widget.isSanctionPayed == 1
                                          ? formatDateLiteral(
                                              widget.dateSanction)
                                          : formatCompareDateReturnWellValueSanctionRecent(
                                              widget.dateSanction),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blackBlueAccent1,
                                      ),
                                    ),
                                  ),
                                  if(widget.isSanctionPayed == 0)
                    Container(
                     
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
                            if (widget.isSanctionPayed == 0)
                              // if (widget.nomBeneficiaire != "")
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Modal().showModalPaySanction(context, widget.nomProprietaire, widget.resteAPayer, widget.sanction_code, AppCubitStorage().state.membreCode, widget.typeSaction =="1"? "1": "0", widget.objetSanction, widget.codeTournoi);
                                    print("object1");
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
                          //         // color: const Color.fromARGB(255, 0, 0, 0),
                          //         height: 20.h,
                          //         // width: 230,
                          //         child: SvgPicture.asset(
                          //           "assets/images/folderManageSimpleIcon.svg",
                          //           fit: BoxFit.scaleDown,
                          //           color: AppColors.blackBlue,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          if (widget.isSanctionPayed == 0 &&
                              widget.typeSaction == "1")
                            Expanded(
                              child: InkWell(
                                splashColor: AppColors.blackBlue,
                                onTap: () {
                                  print("object3");
                                  Share.share(context
                                          .read<AuthCubit>()
                                          .state
                                          .detailUser!["isMember"]
                                      ? "Aide-moi à payer ma sanction *${widget.motifSanction}*.\nMontant: *${formatMontantFrancais(double.parse(widget.montantSanction.toString()))} FCFA* .\nMerci de suivre le lien https://${widget.lienPaiement}?code=${AppCubitStorage().state.membreCode} pour valider"
                                      : "Nouvelle sanction créée dans le groupe *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* concernant ${widget.motifSanction} sur le membre *${widget.nomProprietaire}*.\nPayer la sanction ici : https://${widget.lienPaiement}?code=${widget.membreCode}");
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
        ),
      ),
    );
  }
}
