import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/presentation/widgets/widget_recent_event_cotisation.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/presentation/widgets/widget_recent_event_sanction.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/presentation/widgets/widget_recent_event_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/presentation/widget/pay_form_transfert.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransfertScreen extends StatefulWidget {
  final String publicRef;

  TransfertScreen({
    required this.publicRef,
  });
  @override
  State<TransfertScreen> createState() => _TransfertScreenState();
}

class _TransfertScreenState extends State<TransfertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: BackButtonWidget(
            colorIcon: AppColors.white,
          ),
        ),
        title: Text(
          "Choisir un événement",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
        elevation: 0,
      ),
      body: BlocBuilder<RecentEventCubit, RecentEventState>(
        builder: (context, state) {
          List<Widget> listWidgetCotisation;
          List<Widget> listWidgetTontine;

          if (state.isLoading == true || state.allRecentEvent == null)
            return Container(
              // margin:
              //     EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
              child: EasyLoader(
                backgroundColor: Color.fromARGB(0, 228, 228, 228),
                iconSize: 50.r,
                iconColor: AppColors.blackBlueAccent1,
                image: AssetImage(
                  "assets/images/AssoplusFinal.png",
                ),
              ),
            );

          final currentRecentEvent =
              context.read<RecentEventCubit>().state.allRecentEvent;

          final currentTontine = currentRecentEvent!["tontines"];
          final currentCotisation = currentRecentEvent!["cotisations"];
          final currentSanction = currentRecentEvent!["sanctions"];

          List listeTontine = currentTontine;
          List listeCotisation = currentCotisation;
          List listeSanction = currentSanction;

          listWidgetTontine = listeTontine
              .where((monObjet) =>
                  (monObjet["versement"]?["is_payed"] == 0) &&
                  (monObjet["is_passed"] == 0))
              .map((monObjet) {
            String nomBeneficiaire = '';

            if (monObjet['receivers'] != null &&
                monObjet['receivers'].isNotEmpty) {
              final receivers = monObjet['receivers'] as List<dynamic>;

              // Déboguer les données
              print('Receivers: $receivers');

              final namesList = receivers.map((receiver) {
                final membre = receiver['membre'];
                // Déboguer le membre
                print('Membre: $membre');

                if (membre != null) {
                  final firstName = membre['first_name'] ?? '';
                  final lastName = membre['last_name'] ?? '';
                  return '$firstName $lastName'.trim();
                }
                return '';
              }).toList();

              // Déboguer la liste des noms
              print('Names List: $namesList');

              nomBeneficiaire =
                  namesList.where((name) => name.isNotEmpty).join(', ');

              // Déboguer le résultat final
              print('Nom Beneficiaire: $nomBeneficiaire');
            } else {
              // Déboguer le cas où receivers est nul ou vide
              print('Receivers is null or empty');

              final membre = monObjet['membre'];
              nomBeneficiaire = (membre != null)
                  ? '${membre['first_name'] ?? ''} ${membre['last_name'] ?? ''}'
                      .trim()
                  : '';

              // Déboguer le nom du bénéficiaire
              print('Nom Beneficiaire (from main member): $nomBeneficiaire');
            }

            return PopupMenuButton(
              elevation: 5,
              shadowColor: AppColors.barrierColorModal,
              onSelected: (value) async {
                if (value == "mySelf") {
                  showTransferPopup(
                    context,
                    typeId: "3",
                    publicRef: widget.publicRef,
                    sourceCode: monObjet["cotisation_code"],
                    membreCode: AppCubitStorage().state.membreCode!,
                  );
                  // updateTrackingData(
                  //     "home.btnCotributionPayMySelf", "${DateTime.now()}", {});
                  print("value");
                  // launchWeb(
                  //   "https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode}",
                  // );
                } else if (value == "anotherPerson") {
                  // updateTrackingData("home.btnCotributionPayAnotherPerson",
                  //     "${DateTime.now()}", {});
                  context
                      .read<CotisationDetailCubit>()
                      .detailCotisationCubit(monObjet["cotisation_code"]);
                  Modal().showModalPayForAnotherWithTransfert(
                    context,
                    monObjet["cotisation_code"],
                    monObjet["cotisation_pay_link"],
                    monObjet["name"],
                    monObjet["amount"],
                    monObjet["type"] == "1" ? true : false,
                    nomBeneficiaire,
                    monObjet["seance"] == null
                        ? ''
                        : '${'rencontre'.tr()} ${monObjet["seance"]["matricule"] ?? ""} ${"du".tr()} ${formatDateTimeintegral(context.locale.toString() == "en_US" ? "en" : "fr", monObjet["seance"]["date_seance"] ?? "")}',
                    monObjet["end_date"],
                    "8",
                    widget.publicRef,
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.all(10.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5.w),
                          width: 11.r,
                          height: 11.r,
                          decoration: BoxDecoration(
                            color: monObjet["is_passed"] == 0
                                ? AppColors.colorButton
                                : AppColors.red,
                            borderRadius: BorderRadius.circular(360.r),
                          ),
                        ),
                        Text(
                          "${'tontine'.tr()}".toUpperCase(),
                          style: TextStyle(
                            color: AppColors.blackBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      monObjet["motif"] ?? "",
                      style: TextStyle(
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${"Bénéficiaire".tr()} : ",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackBlueAccent1,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              nomBeneficiaire,
                              style: TextStyle(
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${"montant".tr()}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackBlueAccent1,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              monObjet["type"] == "1"
                                  ? "volontaire".tr()
                                  :
                                  // : "type_fixe".tr(),
                                  "${formatMontantFrancais(double.parse("${monObjet["amount"]}"))} FCFA",
                              style: TextStyle(
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${"Date limite".tr()} : ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackBlueAccent1,
                          ),
                        ),
                        Container(
                          child: Text(
                            "${formatDateTimeintegral(
                              context.locale.toString() == "en_US"
                                  ? "en"
                                  : "fr",
                              monObjet["end_date"],
                            )} ${"à".tr()} ${formatHeurUnikLiteral(monObjet["end_date"])}",
                            // "${formatDateTimeintegral(
                            //   context.locale.toString() == "en_US"
                            //       ? "en"
                            //       : "fr",
                            //   widget.dateClose,
                            // )} ${'à'.tr()} ",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackBlueAccent1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                  //   // _showSimpleModalDialog(context);
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
            );

            // widgetRecentEventTontine(
            //   isPassed: monObjet["is_passed"] ?? 0,
            //   isPayed: monObjet["versement"]?["is_payed"] ?? 0,
            //   nomBeneficiaire: nomBeneficiaire,
            //   prenomBeneficiaire: "",
            //   dateOpen: monObjet["start_date"] ?? "",
            //   dateClose: monObjet["end_date"] ?? "",
            //   montantTontine: monObjet["amount"] ?? "",
            //   montantCollecte: monObjet["total_cotise"] ?? "",
            //   codeCotisation: monObjet["code"] ?? "",
            //   lienDePaiement: monObjet["tontine_pay_link"] ?? "",
            //   nomTontine: monObjet["matricule"] ?? "",
            //   motif: monObjet["motif"] ?? "",
            // );
          }).toList();

          listWidgetCotisation = listeCotisation
              .where((monObjet) =>
                  (monObjet["versement"]?["is_payed"] == 0) &&
                  (monObjet["is_passed"] == 0))
              .map((monObjet) {
            String nomBeneficiaire = '';

            if (monObjet['receivers'] != null &&
                monObjet['receivers'].isNotEmpty) {
              final receivers = monObjet['receivers'] as List<dynamic>;

              // Déboguer les données
              print('Receivers: $receivers');

              final namesList = receivers.map((receiver) {
                final membre = receiver['membre'];
                // Déboguer le membre
                print('Membre: $membre');

                if (membre != null) {
                  final firstName = membre['first_name'] ?? '';
                  final lastName = membre['last_name'] ?? '';
                  return '$firstName $lastName'.trim();
                }
                return '';
              }).toList();

              // Déboguer la liste des noms
              print('Names List: $namesList');

              nomBeneficiaire =
                  namesList.where((name) => name.isNotEmpty).join(', ');

              // Déboguer le résultat final
              print('Nom Beneficiaire: $nomBeneficiaire');
            } else {
              // Déboguer le cas où receivers est nul ou vide
              print('Receivers is null or empty');

              final membre = monObjet['membre'];
              nomBeneficiaire = (membre != null)
                  ? '${membre['first_name'] ?? ''} ${membre['last_name'] ?? ''}'
                      .trim()
                  : '';

              // Déboguer le nom du bénéficiaire
              print('Nom Beneficiaire (from main member): $nomBeneficiaire');
            }

            return PopupMenuButton(
              elevation: 5,
              shadowColor: AppColors.barrierColorModal,
              onSelected: (value) async {
                if (value == "mySelf") {
                  showTransferPopup(
                    context,
                    typeId: "3",
                    publicRef: widget.publicRef,
                    sourceCode: monObjet["cotisation_code"],
                    membreCode: AppCubitStorage().state.membreCode!,
                  );
                  // updateTrackingData(
                  //     "home.btnCotributionPayMySelf", "${DateTime.now()}", {});
                  print("value");
                  // launchWeb(
                  //   "https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode}",
                  // );
                } else if (value == "anotherPerson") {
                  // updateTrackingData("home.btnCotributionPayAnotherPerson",
                  //     "${DateTime.now()}", {});
                  context
                      .read<CotisationDetailCubit>()
                      .detailCotisationCubit(monObjet["cotisation_code"]);
                  Modal().showModalPayForAnotherWithTransfert(
                    context,
                    monObjet["cotisation_code"],
                    monObjet["cotisation_pay_link"],
                    monObjet["name"],
                    monObjet["amount"],
                    monObjet["type"] == "1" ? true : false,
                    nomBeneficiaire,
                    monObjet["seance"] == null
                        ? ''
                        : '${'rencontre'.tr()} ${monObjet["seance"]["matricule"] ?? ""} ${"du".tr()} ${formatDateTimeintegral(context.locale.toString() == "en_US" ? "en" : "fr", monObjet["seance"]["date_seance"] ?? "")}',
                    monObjet["end_date"],
                    "3",
                    widget.publicRef,
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.all(10.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5.w),
                          width: 11.r,
                          height: 11.r,
                          decoration: BoxDecoration(
                            color: monObjet["is_passed"] == 0
                                ? AppColors.colorButton
                                : AppColors.red,
                            borderRadius: BorderRadius.circular(360.r),
                          ),
                        ),
                        Text(
                          "${'cotisation_capital'.tr()} (${monObjet["ass_rubrique"] == null ? "" : ('${monObjet["ass_rubrique"]["name"] ?? ""}')})"
                              .toUpperCase(),
                          style: TextStyle(
                            color: AppColors.blackBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      monObjet["name"] ?? "",
                      style: TextStyle(
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${"Bénéficiaire".tr()} : ",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackBlueAccent1,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              nomBeneficiaire,
                              style: TextStyle(
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${"montant".tr()}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackBlueAccent1,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              monObjet["type"] == "1"
                                  ? "volontaire".tr()
                                  :
                                  // : "type_fixe".tr(),
                                  "${formatMontantFrancais(double.parse("${monObjet["amount"]}"))} FCFA",
                              style: TextStyle(
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${"Date limite".tr()} : ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackBlueAccent1,
                          ),
                        ),
                        Container(
                          child: Text(
                            "${formatDateTimeintegral(
                              context.locale.toString() == "en_US"
                                  ? "en"
                                  : "fr",
                              monObjet["end_date"],
                            )} ${"à".tr()} ${formatHeurUnikLiteral(monObjet["end_date"])}",
                            // "${formatDateTimeintegral(
                            //   context.locale.toString() == "en_US"
                            //       ? "en"
                            //       : "fr",
                            //   widget.dateClose,
                            // )} ${'à'.tr()} ",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackBlueAccent1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                  //   // _showSimpleModalDialog(context);
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
            );

            // widgetRecentEventCotisation(
            //   isPayed: monObjet["versement"]?["is_payed"] ?? false,
            //   rapportUrl: monObjet["rapport"] ?? "",
            //   rublique: monObjet["ass_rubrique"] == null
            //       ? ""
            //       : '(${monObjet["ass_rubrique"]["name"] ?? ""})',
            //   dateOpen: monObjet["end_date"] ?? "",
            //   dateClose: monObjet["end_date"] ?? "",
            //   montantCotisation: monObjet["amount"] ?? "",
            //   montantCollecte: monObjet["total_cotise"] ?? "",
            //   codeCotisation: monObjet["cotisation_code"] ?? "",
            //   lienDePaiement: monObjet["cotisation_pay_link"] ?? "",
            //   motif: monObjet["name"] ?? "",
            //   type: monObjet["type"] ?? "",
            //   isPassed: monObjet["is_passed"] ?? false,
            //   source: monObjet["seance"] == null
            //       ? ''
            //       : '${'rencontre'.tr()} ${monObjet["seance"]["matricule"] ?? ""} ${"du".tr()} ${formatDateTimeintegral(context.locale.toString() == "en_US" ? "en" : "fr", monObjet["seance"]["date_seance"] ?? "")}',
            //   nomBeneficiaire: nomBeneficiaire,
            //   is_tontine: monObjet["is_tontine"] ?? false,
            // );
          }).toList();

          List<Widget> listWidgetSanction = listeSanction.map((monObjet) {
            final currentDetailUser =
                context.read<AuthCubit>().state.detailUser;
            return InkWell(
              onTap: () {
                showTransferPopup(
                    context,
                    typeId: "2",
                    publicRef: widget.publicRef,
                    sourceCode: monObjet["sanction_code"],
                    membreCode: AppCubitStorage().state.membreCode!,
                  );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.all(10.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5.w),
                          width: 11.r,
                          height: 11.r,
                          decoration: BoxDecoration(
                            color: monObjet["is_passed"] == 0
                                ? AppColors.colorButton
                                : AppColors.red,
                            borderRadius: BorderRadius.circular(360.r),
                          ),
                        ),
                        Text(
                          "SANCTION".toUpperCase(),
                          style: TextStyle(
                            color: AppColors.blackBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      monObjet["motif"],
                      style: TextStyle(
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${"avance".tr()} : ",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackBlueAccent1,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "${formatMontantFrancais(double.parse("${monObjet["sanction_balance"]}"))} FCFA",
                              style: TextStyle(
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${"a_payer".tr()}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackBlueAccent1,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "${formatMontantFrancais(double.parse("${monObjet["amount_remaining"]}"))} FCFA",
                              style: TextStyle(
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Text(
                            "${formatCompareDateReturnWellValueSanctionRecent(monObjet["start_date"])}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackBlueAccent1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );

            // widgetRecentEventSanction(
            //   membreCode: AppCubitStorage().state.membreCode,
            //   nomProprietaire:
            //       "${currentDetailUser!["first_name"] == null ? "" : currentDetailUser["first_name"]} ${currentDetailUser["last_name"] == null ? "" : currentDetailUser["last_name"]}",
            //   resteAPayer: monObjet["amount_remaining"],
            //   motif: monObjet["motif"],
            //   dateOpen: monObjet["start_date"],
            //   montantSanction:
            //       monObjet["amount"] == null ? 0 : monObjet["amount"],
            //   libelleSanction:
            //       monObjet["libelle"] == null ? "" : monObjet["libelle"],
            //   montantCollecte: monObjet["sanction_balance"],
            //   codeCotisation: monObjet["sanction_code"],
            //   lienDePaiement: monObjet["sanction_pay_link"] == null
            //       ? ""
            //       : monObjet["sanction_pay_link"],
            //   type: monObjet["type"],
            //   versement: monObjet["versement"],
            // );
          }).toList();

          final List<Widget> listeWidgetFinale = [
            ...listWidgetTontine,
            ...listWidgetCotisation,
            ...listWidgetSanction,
            Container(
              margin: EdgeInsets.only(
                bottom: Platform.isIOS ? 70.h : 10.h,
              ),
            ),
          ];

          return listWidgetTontine.length > 0 ||
                  // listWidgetCotisation.length > 0 ||
                  listWidgetSanction.length > 0
              ? ListView.builder(
                  itemCount: listeWidgetFinale.length,
                  itemBuilder: (BuildContext context, int index) {
                    final itemEventRecent = listeWidgetFinale[index];
                    return Container(
                      margin: EdgeInsets.only(
                        top: 7.h,
                        left: 7.w,
                        right: 7.w,
                        bottom: 3.h,
                      ),
                      child: itemEventRecent,
                    );
                  },
                )
              : Container(
                  color: AppColors.pageBackground,
                  margin: EdgeInsets.only(top: 50.h),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Aucun_evenement_recent".tr(),
                          style: TextStyle(
                            color: Color.fromRGBO(20, 45, 99, 0.26),
                            fontWeight: FontWeight.w100,
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (!context
                            .read<AuthCubit>()
                            .state
                            .detailUser!["isMember"])
                          InkWell(
                            onTap: () async {
                              updateTrackingData(
                                  "transactions.btnAddContribution",
                                  "${DateTime.now()}", {});
                              launchWeb(
                                "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations?query=1&app_mode=mobile",
                              );
                            },
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2.w,
                                  color: AppColors.blackBlue.withOpacity(1),
                                ),
                                borderRadius: BorderRadius.circular(
                                  20.r,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 7.h,
                              ),
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Ajouter une cotisation".tr(),
                                    style: TextStyle(
                                      color: AppColors.blackBlue.withOpacity(1),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18.sp,
                                      letterSpacing: 0.2.w,
                                    ),
                                  ),
                                  Container(
                                    width: 20.w,
                                    height: 20.w,
                                    margin: EdgeInsets.only(left: 3.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(360),
                                      border: Border.all(
                                        width: 1.5.w,
                                        color:
                                            AppColors.blackBlue.withOpacity(1),
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/images/addIcon.svg",
                                      fit: BoxFit.scaleDown,
                                      color: AppColors.blackBlue.withOpacity(1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
        },
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
