import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetHistoriqueCotisation.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/presentation/widget/pay_form_transfert.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class PayAnotherPersonTransfert extends StatefulWidget {
  PayAnotherPersonTransfert({
    super.key,
    required this.imageProfil,
    required this.nom,
    required this.prenom,
    required this.is_versement_finished,
    required this.montantVersee,
    required this.amount_remaining,
    required this.date,
    required this.memberCode,
    required this.codeContribution,
    required this.codeUserContribution,
    required this.lienDePaiement,
    required this.nomTontine,
    required this.montantTontine,
    required this.isVolontaire,
    this.codeTontine,
    this.nomBeneficiaire,
    this.source,
    required this.isTontine,
    required this.sourceCode,
    required this.typeId,
    required this.publicRef,

  });

  String imageProfil;
  String nom;
  String prenom;
  int is_versement_finished;
  String montantVersee;
  String date;
  String amount_remaining;
  String memberCode;
  String codeContribution;
  String codeUserContribution;
  String? codeTontine;
  String lienDePaiement;
  var isTontine;
  var nomBeneficiaire;
  var source;
  var nomTontine;
  var montantTontine;
  var isVolontaire;
  String sourceCode;
  String typeId;
  String publicRef;

  @override
  State<PayAnotherPersonTransfert> createState() =>
      _PayAnotherPersonTransfertState();
}

class _PayAnotherPersonTransfertState extends State<PayAnotherPersonTransfert> {
  @override
  Widget build(BuildContext context) {
    String? jsonString = context.read<AuthCubit>().state.dataCookies;

    // Analyse de la réponse JSON
    Map<String, dynamic> data = jsonDecode(jsonString!);

    // Récupération du hash_id
    String hashId = data['user']['hash_id'];
    return InkWell(
      onTap: () {
        // launchWeb(
        //   "https://${widget.lienDePaiement}?code=${widget.memberCode}",
        // );

        showTransferPopup(context, typeId: widget.typeId , publicRef: widget.publicRef , sourceCode: widget.sourceCode, membreCode: widget.memberCode);
        // Navigator.pop(context);
      },
      child: Container(
        // margin: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.only(
            top: 7.h,
            bottom: 7.h,
            left: 10.w,
            right: 10.w,
          ),
          decoration: BoxDecoration(
            color: AppColors.blackBlueAccent2,
            borderRadius: BorderRadius.circular(7.r),
          ),
          // margin: EdgeInsets.all(5),
          // padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Modal().showFullPicture(
                      context,
                      widget.imageProfil == null
                          ? "https://services.faroty.com/images/avatar/avatar.png"
                          : "${Variables.LienAIP}${widget.imageProfil}",
                      "${widget.nom} ${widget.prenom}");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: Container(
                    width: 30.w,
                    height: 30.w,
                    child: Image.network(
                      "${Variables.LienAIP}${widget.imageProfil}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  // color: Colors.blueGrey,
                  // alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          "${widget.nom} ${widget.prenom}",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackBlue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2.h),
                        child: Text(
                          "${formatMontantFrancais(double.parse("${widget.montantVersee}"))} FCFA",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackBlueAccent1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  if (widget.isTontine == false) {
                    String message = "";

                    message +=
                        "🟢🟢 ${"Nouvelle cotisation en cours dans le groupe".tr()} *${"${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}".trimRight()}* ${"concernant".tr()} ${widget.source == '' ? '*${widget.nomBeneficiaire}*' : '*${widget.source}*'}\n\n ";

                    message +=
                        "👉🏽 ${(widget.source == '' ? "${"MEMBRE CONCERNÉ".tr()}" : "${"SEANCE CONCERNÉE".tr()}")} : ${widget.source == '' ? '*${widget.nomBeneficiaire}*' : '*${widget.source}*'}\n";
                    message +=
                        "👉🏽 ${"montant".tr().toUpperCase()} : ${widget.isVolontaire == true ? "*${"volontaire".tr()}*" : "*${formatMontantFrancais(double.parse(widget.montantTontine.toString()))} FCFA*"}\n";
                    message +=
                        "👉🏽 ${"Date limite".tr().toUpperCase()} : *${(widget.date)}*\n\n";

                    message +=
                        "${"Aide-moi à payer ma cotisation en suivant le lien".tr()} https://${widget.lienDePaiement}?code=${widget.memberCode}\n\n";

                    message += "*by ASSO+*";

                    Share.share(
                      message,
                    );
                  } else {
                    String message = "";

                    message +=
                        "🟢🟢 ${"Nouvelle session de la tontine".tr()} *${widget.nomTontine}* ${"en cours dans le groupe".tr()} *${"${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}".trimRight()}* ${"concernant".tr()} *${widget.nomBeneficiaire}*\n\n";

                    message +=
                        "👉🏽 ${"MEMBRE CONCERNÉ".tr()} : *${widget.nomBeneficiaire}*\n";
                    // message += "👉🏽 MOTIF : *${motif}*\n";
                    message +=
                        "👉🏽 ${"montant".tr().toUpperCase()} : ${"*${formatMontantFrancais(double.parse(widget.montantTontine.toString()))} FCFA*"}\n";
                    message +=
                        "👉🏽 ${"Date limite".tr().toUpperCase()} : *${widget.date}*\n\n";

                    message +=
                        "${"Aide-moi à payer ma tontine en suivant le lien".tr()} https://${widget.lienDePaiement}?code=${widget.memberCode}\n\n";

                    message += "*by ASSO+*";

                    Share.share(
                      message,
                    );
                  }
                },
                child: Container(
                  width: 15.w,
                  child: SvgPicture.asset(
                    "assets/images/shareSimpleIcon.svg",
                    // fit: BoxFit.scaleDown,
                    color: AppColors.blackBlue,
                  ),
                  margin: EdgeInsets.only(right: 10.w, left: 5.w),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showTransferPopup(
    BuildContext context, {
    required String typeId,
    required String publicRef,
    required String sourceCode,
    required String membreCode,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PayFormTransfert(
          publicRef: publicRef,
          typeId: typeId,
          sourceCode: sourceCode,
          membreCode: membreCode,
        );
      },
    );
  }
}
