import 'dart:io';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotistion.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotistionDetailPage.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetDetailCotisationCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetHistoriqueCotisation.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/screens/detailRencontrePage.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/contribution_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetContributionDetailPage.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/checkInternetConnectionPage.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:faroty_association_1/widget/button_rapport_widget.dart';
import 'package:faroty_association_1/widget/widgetListTransactionByEventCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailContributionPage extends StatefulWidget {
  var is_tontine;

  var source;

  var nomBeneficiaire;

  var rubrique;

  DetailContributionPage(
      {super.key,
      required this.montantCotisations,
      required this.motifCotisations,
      required this.dateCotisation,
      required this.heureCotisation,
      required this.soldeCotisation,
      required this.isPassed,
      required this.type,
      required this.lienDePaiement,
      required this.codeCotisation,
      required this.isPayed,
      // required this.rapportUrl,
      required this.is_passed,
      required this.is_tontine,
      required this.source,
      required this.nomBeneficiaire,
      required this.rubrique});
  int montantCotisations;
  String motifCotisations;
  String dateCotisation;
  String heureCotisation;
  String soldeCotisation;
  String type;
  String lienDePaiement;
  int isPassed;
  String codeCotisation;
  int isPayed;
  // String? rapportUrl;
  var is_passed;

  @override
  State<DetailContributionPage> createState() => _DetailContributionPageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.pageBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.backgroundAppBAr,
        middle: Text(
          "Detail de la tontine".tr(),
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.white,
              fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: BackButtonWidget(
            colorIcon: AppColors.white,
          ),
        ),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    appBar: AppBar(
      title: Text(
        "Detail de la tontine".tr(),
        style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.bold),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: BackButtonWidget(
          colorIcon: AppColors.white,
        ),
      ),
    ),
    body: child,
  );
}

class _DetailContributionPageState extends State<DetailContributionPage>
    with TickerProviderStateMixin {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, false, true];

  Future<void> handleDetailCotisation(codeCotisation) async {
    // final detailTournoiCourant = await context
    //     .read<DetailTournoiCourantCubit>()
    //     .detailTournoiCourantCubit();
    final detailCotisation = await context
        .read<CotisationDetailCubit>()
        .detailCotisationCubit(codeCotisation);
  }

  // Future<void> handleAllCotisationAssTournoi(codeTournoi, codeMembre) async {
  //   final allCotisationAss = await context
  //       .read<CotisationCubit>()
  //       .AllCotisationAssTournoiCubit(codeTournoi, codeMembre);

  //   if (allCotisationAss != null) {
  //   } else {}
  // }

  Future refresh() async {
    handleDetailCotisation(widget.codeCotisation);
  }

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);

    return PageScaffold(
      context: context,
      child: Material(
        type: MaterialType.transparency,
        child: BlocBuilder<DetailContributionCubit, ContributionState>(
            builder: (CotiDetailcontext, CotiDetailstate) {
          if (CotiDetailstate.errorLoadDetailCotis == true)
            return checkInternetConnectionPage(
              functionToCall: () =>
                  handleDetailCotisation(widget.codeCotisation),
            );
          return Container(
            margin: EdgeInsets.only(top: 0, left: 5.w, right: 5.w),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: WidgetContributionDetailPage(
                    // rapportUrl: widget.rapportUrl,
                    isCotisation: false,
                    screenSource: "meeting",
                    isPayed: widget.isPayed,
                    montantCotisations: widget.montantCotisations,
                    motifCotisations: widget.motifCotisations,
                    dateCotisation: widget.dateCotisation,
                    heureCotisation: widget.heureCotisation,
                    soldeCotisation: widget.soldeCotisation,
                    codeCotisation: widget.codeCotisation,
                    type: widget.type,
                    lienDePaiement: widget.lienDePaiement,
                    // ItemDetailCotisation["cotisation_pay_link"] == null ? "le lien n'a pas été généré" : ItemDetailCotisation["cotisation_pay_link"],
                    is_passed: widget.isPassed,
                    is_tontine: widget.is_tontine,
                    source: widget.source,
                    nomBeneficiaire: widget.nomBeneficiaire,
                    rubrique: widget.rubrique,
                  ),
                  // widgetDetailCotisationCard(
                  //   type: widget.type,
                  //   dateCotisation: widget.dateCotisation,
                  //   heureCotisation: widget.heureCotisation,
                  //   montantCotisations: widget.montantCotisations,
                  //   motifCotisations: widget.motifCotisations,
                  //   soldeCotisation: widget.soldeCotisation,
                  //   lienDePaiement: widget.lienDePaiement,
                  //   isPassed: widget.isPassed,
                  //   isPayed: widget.isPayed,
                  //   codeCotisation: widget.codeCotisation,
                  // ),
                ),
                // if (widget.rapportUrl != null)
                //   ButtonRapport(
                //     nomElement:
                //         "${"Cotisation".tr()} ${widget.motifCotisations}",
                //     rapportUrl: "${widget.rapportUrl}",
                //   ),
                Container(
                  // color: Colors.deepOrange,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                  child: Text(
                    checkTransparenceStatus(
                            context
                                .read<UserGroupCubit>()
                                .state
                                .changeAssData!
                                .user_group!
                                .configs,
                            context
                                .read<AuthCubit>()
                                .state
                                .detailUser!["isMember"])
                        ? "historique_des_cotisations".tr()
                        : "liste_de_vos_transactions".tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackBlue,
                    ),
                  ),
                ),
                BlocBuilder<DetailContributionCubit, ContributionState>(
                  builder: (CotisationDetailcontext, CotisationDetailstate) {
                    if (CotisationDetailstate.isLoadingContibutionTontine ==
                            true &&
                        CotisationDetailstate.detailContributionTontine == null)
                      return Expanded(
                        child: Center(
                          child: EasyLoader(
                            backgroundColor: Color.fromARGB(0, 255, 255, 255),
                            iconSize: 50.r,
                            iconColor: AppColors.blackBlueAccent1,
                            image: AssetImage(
                              "assets/images/AssoplusFinal.png",
                            ),
                          ),
                        ),
                      );

                    final currentDetailCotisation =
                        CotisationDetailcontext.read<DetailContributionCubit>()
                            .state
                            .detailContributionTontine;

                    List listeOkayCotisation =
                        currentDetailCotisation!["membres"];

                    List<Widget> listWidgetCotis = listeOkayCotisation.map(
                      (monObjet) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              print("membre_codew ${monObjet["code"]}");
                            },
                            child: WidgetHistoriqueCotisation(
                              isCotisation: false,
                              // codeTontine: widget.codeTontine,
                              codeUserContribution: monObjet["code"],
                              codeMembre: monObjet["membre"]["membre_code"],
                              versement_status: monObjet["statut"],
                              matricule: monObjet["membre"]["matricule"],
                              montantTotalAVerser: monObjet["amount_to_pay"],
                              montantVersee: monObjet["balance"],
                              resteAPayer: monObjet["amount_remaining"],
                              codeCotisation: widget.codeCotisation,
                              nom: monObjet["membre"]["first_name"] == null
                                  ? ""
                                  : monObjet["membre"]["first_name"],
                              photoProfil:
                                  monObjet["membre"]["photo_profil"] == null
                                      ? ""
                                      : monObjet["membre"]["photo_profil"],
                              prenom: monObjet["membre"]["last_name"] == null
                                  ? ""
                                  : monObjet["membre"]["last_name"],
                            ),
                          ),
                        );
                      },
                    ).toList();

                    return Expanded(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: checkTransparenceStatus(
                              context
                                  .read<UserGroupCubit>()
                                  .state
                                  .changeAssData!
                                  .user_group!
                                  .configs,
                              context
                                  .read<AuthCubit>()
                                  .state
                                  .detailUser!["isMember"],
                            )
                                ? Column(
                                    children: listWidgetCotis,
                                  )
                                : Column(
                                    children: [
                                      for (var itemDetailCotisation
                                          in currentDetailCotisation["membres"])
                                        if (itemDetailCotisation["membre"]
                                                ["membre_code"] ==
                                            AppCubitStorage().state.membreCode)
                                          for (var item in itemDetailCotisation[
                                              "payments"])
                                            Container(
                                              child:
                                                  widgetListTransactionByEventCard(
                                                date: AppCubitStorage()
                                                            .state
                                                            .Language ==
                                                        "fr"
                                                    ? formatDateToFrench(
                                                        item["created_at"])
                                                    : formatDateToEnglish(
                                                        item["created_at"]),
                                                montant: item["amount"],
                                              ),
                                            ),
                                      for (var itemDetailCotisation
                                          in currentDetailCotisation["membres"])
                                        if (itemDetailCotisation["membre"]
                                                ["membre_code"] ==
                                            AppCubitStorage().state.membreCode)
                                          if (itemDetailCotisation["payments"]
                                                  .length ==
                                              0)
                                            Container(
                                              padding:
                                                  EdgeInsets.only(top: 200.h),
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                "aucune_transaction".tr(),
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      20, 45, 99, 0.26),
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 20.sp,
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
                          ),
                          if (CotisationDetailstate
                                      .isLoadingContibutionTontine ==
                                  true &&
                              CotisationDetailstate.detailContributionTontine !=
                                  null)
                            Center(
                              child: EasyLoader(
                                backgroundColor:
                                    Color.fromARGB(0, 255, 255, 255),
                                iconSize: 50.r,
                                iconColor: AppColors.blackBlueAccent1,
                                image: AssetImage(
                                  "assets/images/AssoplusFinal.png",
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
