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
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class widgetHistoriqueTontineCard extends StatefulWidget {
  widgetHistoriqueTontineCard({
    super.key,
    required this.imageProfil,
    required this.nom,
    required this.prenom,
    required this.is_versement_finished,
    required this.montantVersee,
    required this.amount_remaining,
    required this.montantTotal,
    required this.memberCode,
    required this.codeContribution,
    required this.codeUserContribution,
    this.codeTontine,
  });

  String imageProfil;
  String nom;
  String prenom;
  int is_versement_finished;
  String montantVersee;
  String montantTotal;
  String amount_remaining;
  String memberCode;
  String codeContribution;
  String codeUserContribution;
  String? codeTontine;

  @override
  State<widgetHistoriqueTontineCard> createState() =>
      _widgetHistoriqueTontineCardState();
}

class _widgetHistoriqueTontineCardState
    extends State<widgetHistoriqueTontineCard> {
  @override
  Widget build(BuildContext context) {
    String? jsonString = context.read<AuthCubit>().state.dataCookies;

    // Analyse de la réponse JSON
    Map<String, dynamic> data = jsonDecode(jsonString!);

    // Récupération du hash_id
    String hashId = data['user']['hash_id'];
    return Container(
      // margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.only(
          top: 10.h,
          bottom: 10.h,
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
                  width: 40.w,
                  height: 40.w,
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
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackBlue,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2.h),
                      child: Text(
                        "${formatMontantFrancais(double.parse("${widget.montantVersee}"))} FCFA / ${formatMontantFrancais(double.parse("${widget.montantTotal}"))} FCFA",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackBlueAccent1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // if (widget.is_versement_finished == 1)
            // Container(
            //   margin: EdgeInsets.only(right: 10.w),
            //   child: Text(
            //     "${widget.codeContribution}",
            //     overflow: TextOverflow.clip,
            //     style: TextStyle(
            //         fontSize: 10.sp,
            //         fontWeight: FontWeight.w500,
            //         color: AppColors.blackBlueAccent1),
            //   ),
            // ),
            if (context.read<AuthCubit>().state.detailUser!["isMember"])
              widget.is_versement_finished == 0
                  ? Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        color: AppColors.redAccent,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Icon(
                        Icons.close,
                        color: AppColors.red,
                        size: 11.sp,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        color: AppColors.greenAccent,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 11.sp,
                      ),
                    ),
            if (!context.read<AuthCubit>().state.detailUser!["isMember"])
              widget.is_versement_finished == 0
                  ?
                  // widget.versement_status != "2"
                  //     ?
                  InkWell(
                      onTap: () {
                        _showSimpleModalDialog(
                          context,
                          widget.nom,
                          widget.amount_remaining,
                          widget.codeContribution,
                          widget.memberCode,
                          hashId,
                          widget.codeUserContribution,
                          widget.codeTontine,
                        );
                        print("object");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 32.r,
                        height: 32.r,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.r,
                          vertical: 8.r,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.colorButton,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: SvgPicture.asset(
                          "assets/images/walletPayIcon.svg",
                          fit: BoxFit.scaleDown,
                          color: AppColors.white,
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        color: AppColors.greenAccent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 11.sp,
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}

_showSimpleModalDialog(
  context,
  nom,
  resteAPayer,
  codeCotisation,
  codeMembre,
  hashId,
  codeUserContribution,
  codeTontine,
) {
  showDialog(
      context: context,
      barrierColor: AppColors.barrierColorModal,
      builder: (BuildContext context) {
        Future<void> handleDetailCotisation(codeCotisation) async {
          // final detailTournoiCourant = await context
          //     .read<DetailTournoiCourantCubit>()
          //     .detailTournoiCourantCubit();
          final detailCotisation = await context
              .read<CotisationDetailCubit>()
              .detailCotisationCubit(codeCotisation);
        }

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          child: Container(
            constraints: BoxConstraints(maxHeight: 250.h),
            child: paiementWidgetTontine(
              nom: nom,
              codeCotisation: codeCotisation,
              codeMembre: codeMembre,
              hashId: hashId,
              resteAPayer: resteAPayer,
              codeUserContribution: codeUserContribution,
              codeTontine: codeTontine,
            ),
          ),
        );
      });
}

class paiementWidgetTontine extends StatefulWidget {
  var nom;

  var codeCotisation;

  var codeMembre;

  var hashId;
  var resteAPayer;
  var codeUserContribution;
  var codeTontine;

  paiementWidgetTontine({
    super.key,
    // required this.infoUserController,
    required this.nom,
    required this.codeCotisation,
    required this.codeMembre,
    required this.hashId,
    required this.resteAPayer,
    required this.codeUserContribution,
    required this.codeTontine,
  });

  @override
  State<paiementWidgetTontine> createState() => _paiementWidgetTontineState();
}

class _paiementWidgetTontineState extends State<paiementWidgetTontine> {
  bool load = false;

  late TextEditingController infoUserController;

  @override
  void initState() {
    super.initState();
    infoUserController = TextEditingController(text: "${widget.resteAPayer}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.blackBlue,
              ),
              text: 'Vous avez reçu un paiement de '.tr(),
              children: <InlineSpan>[
                TextSpan(
                  text: '${widget.nom}',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackBlue),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 60.h,
            child: TextField(
              controller: infoUserController,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: TextStyle(fontSize: 20.sp),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.w,
                      color: AppColors.blackBlue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.w,
                      color: AppColors.blackBlue,
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          InkWell(
            // async {
            //   print(load);
            //   CotisationRepository().PayOneCotisation(
            //     widget.codeCotisation,
            //     infoUserController.text,
            //     widget.codeMembre,
            //     AppCubitStorage().state.codeAssDefaul,
            //     widget.hashId,
            //     3,
            //   );
            //   context.read<CotisationDetailCubit>().updateStateAmountPayTontine(
            //         widget.codeMembre,
            //         infoUserController.text,
            //       );
            //   await Future.delayed(Duration(milliseconds: 1000));

            //   handleAllCotisationAssTournoi(
            //     AppCubitStorage().state.codeTournoisHist,
            //     AppCubitStorage().state.membreCode,
            //   );

            //   print(load);
            //   Navigator.pop(context);
            // },
            onTap: () async {
              // setState(() {
              //   load = true;
              // });
              print(load);
              CotisationRepository().PayOneCotisation(
                widget.codeCotisation,
                infoUserController.text,
                widget.codeMembre,
                AppCubitStorage().state.codeAssDefaul,
                widget.hashId,
                widget.codeUserContribution == "" ? 3 : 8,
                // 8,
                contribution_code: widget.codeUserContribution,
              );
              context
                  .read<DetailContributionCubit>()
                  .updateStateAmountPayTontine(
                    widget.codeUserContribution,
                    infoUserController.text,
                  );

              await Future.delayed(
                Duration(
                  milliseconds: 1000,
                ),
              );

              context
                  .read<DetailContributionCubit>()
                  .detailContributionTontineCubit(
                    widget.codeCotisation,
                  );

              if (widget.codeTontine != null) {
                context.read<TontineCubit>().detailTontineCubit(
                      AppCubitStorage().state.codeTournois,
                      widget.codeTontine,
                    );
              }
              context.read<RecentEventCubit>().AllRecentEventCubit(
                    AppCubitStorage().state.membreCode,
                  );

              context.read<CotisationDetailCubit>().detailCotisationCubit(
                    widget.codeCotisation,
                  );
              // setState(() {
              //   load = false;
              // });
              print(load);
              Navigator.pop(context);
            },
            child: load == true
                ? CircularProgressIndicator(
                    color: const Color.fromARGB(255, 191, 53, 83),
                  )
                : Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: AppColors.colorButton,
                        borderRadius: BorderRadius.circular(10.r)),
                    alignment: Alignment.center,
                    child: Text(
                      "Confirmer",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
