import 'dart:io';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetDetailCotisationCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetHistoriqueCotisation.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/widgetListTransactionByEventCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCotisationPage extends StatefulWidget {
  DetailCotisationPage({
    super.key,
    required this.montantCotisations,
    required this.motifCotisations,
    required this.dateCotisation,
    required this.heureCotisation,
    required this.soldeCotisation,
    required this.isPassed,
    required this.type,
    required this.lienDePaiement,
    required this.codeCotisation,
  });
  int montantCotisations;
  String motifCotisations;
  String dateCotisation;
  String heureCotisation;
  String soldeCotisation;
  String type;
  String lienDePaiement;
  int isPassed;
  String codeCotisation;

  @override
  State<DetailCotisationPage> createState() => _DetailCotisationPageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.pageBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "detail_de_la_cotisations".tr(),
          style: TextStyle(
            fontSize: 16,
            color: AppColors.white,
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
        "detail_de_la_cotisations".tr(),
        style: TextStyle(
          fontSize: 16,
          color: AppColors.white,
        ),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: AppColors.white),
      ),
    ),
    body: child,
  );
}

class _DetailCotisationPageState extends State<DetailCotisationPage>
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

    if (detailCotisation != null) {
      print("objaaaaaaaaaaaaaaaaaa  ${detailCotisation}");
      print(
          "aaaaaaaaaaaaaaaaaaaaaqqqqq  ${context.read<CotisationDetailCubit>().state.detailCotisation}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllCotisationAssTournoi(codeTournoi) async {
    final allCotisationAss = await context
        .read<CotisationCubit>()
        .AllCotisationAssTournoiCubit(codeTournoi);

    if (allCotisationAss != null) {
      print("handleAllCotisationAss");
    } else {
      print("handleAllCotisationAss null");
    }
  }

  Future refresh() async {
    handleDetailCotisation(widget.codeCotisation);
  }

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);

    return PageScaffold(
      context: context,
      child: Container(
        margin: EdgeInsets.only(top: 0, left: 5, right: 5),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: widgetDetailCotisationCard(
                type: widget.type,
                dateCotisation: widget.dateCotisation,
                heureCotisation: widget.heureCotisation,
                montantCotisations: widget.montantCotisations,
                motifCotisations: widget.motifCotisations,
                soldeCotisation: widget.soldeCotisation,
                lienDePaiement: widget.lienDePaiement,
                isPassed: widget.isPassed,
              ),
            ),
            checkTransparenceStatus(
                    context
                        .read<UserGroupCubit>()
                        .state
                        .ChangeAssData!["user_group"]["configs"],
                    context.read<AuthCubit>().state.detailUser!["isMember"])
                ? Container(
                    // color: Colors.deepOrange,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "historique_des_cotisations".tr(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackBlue,
                      ),
                    ),
                  )
                : Container(
                    // color: Colors.deepOrange,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "liste_de_vos_transactions".tr(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackBlue,
                      ),
                    ),
                  ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              padding: EdgeInsets.only(top: 15, bottom: 15),
              color: Color.fromARGB(120, 226, 226, 226),
              alignment: Alignment.center,
              child: checkTransparenceStatus(
                      context
                          .read<UserGroupCubit>()
                          .state
                          .ChangeAssData!["user_group"]["configs"],
                      context.read<AuthCubit>().state.detailUser!["isMember"])
                  ? TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: AppColors.blackBlue,
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                      padding: EdgeInsets.all(0),
                      unselectedLabelStyle: TextStyle(
                        color: AppColors.blackBlueAccent1,
                        fontWeight: FontWeight.bold,
                      ),
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          color: AppColors.blackBlue,
                          width: 5.0,
                        ),
                        insets: EdgeInsets.symmetric(
                          horizontal: 36.0,
                        ),
                      ),
                      tabs: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                "${"cotisé".tr()}",
                              ),
                              BlocBuilder<CotisationDetailCubit,
                                      CotisationDetailState>(
                                  builder:
                                      (CotisationContext, CotisationState) {
                                if (CotisationState.isLoading == null ||
                                    CotisationState.isLoading == true ||
                                    CotisationState.detailCotisation == null)
                                  return Container(
                                    width: 10,
                                    height: 10,
                                    child: Center(
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 0.5,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    ),
                                  );
                                final currentDetailCotisation =
                                    CotisationContext.read<
                                            CotisationDetailCubit>()
                                        .state
                                        .detailCotisation;
                                return Text(
                                  "(${currentDetailCotisation!["versements"].length == null ? 0 : currentDetailCotisation!["versements"].length})",
                                  style: TextStyle(fontSize: 10),
                                );
                              }),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                'non_cotisé'.tr(),
                              ),
                              BlocBuilder<CotisationDetailCubit,
                                      CotisationDetailState>(
                                  builder:
                                      (CotisationContext, CotisationState) {
                                if (CotisationState.isLoading == null ||
                                    CotisationState.isLoading == true ||
                                    CotisationState.detailCotisation == null)
                                  return Container(
                                    width: 10,
                                    height: 10,
                                    child: Center(
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 0.5,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    ),
                                  );
                                final currentDetailCotisation =
                                    CotisationContext.read<
                                            CotisationDetailCubit>()
                                        .state
                                        .detailCotisation;
                                return Text(
                                  "(${currentDetailCotisation!["members"].length == null ? 0 : currentDetailCotisation!["members"].length})",
                                  style: TextStyle(fontSize: 10),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  "a_payer".tr(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.blackBlue,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  widget.type == "0"
                                      ? "${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA"
                                      : "Volontaire",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  "déjà_payé".tr(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.blackBlue,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              BlocBuilder<CotisationDetailCubit,
                                  CotisationDetailState>(
                                builder: (CotisationContext, CotisationState) {
                                  if (CotisationState.isLoading == null ||
                                      CotisationState.isLoading == true ||
                                      CotisationState.detailCotisation == null)
                                    return Container(
                                      width: 10,
                                      height: 10,
                                      child: Center(
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 0.5,
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                      ),
                                    );

                                  final currentDetailCotisation =
                                      CotisationContext.read<
                                              CotisationDetailCubit>()
                                          .state
                                          .detailCotisation;

                                  var detailCotisationMemberNoOkay =
                                      currentDetailCotisation!["members"]
                                          .firstWhere(
                                    (member) =>
                                        member['membre']['membre_code'] ==
                                        AppCubitStorage().state.membreCode,
                                    orElse: () => null,
                                  );

                                  var detailCotisationMemberIsOkay =
                                      currentDetailCotisation!["versements"]
                                          .firstWhere(
                                    (member) =>
                                        member['membre_code'] ==
                                        AppCubitStorage().state.membreCode,
                                    orElse: () => null,
                                  );

                                  if (currentDetailCotisation!["members"]
                                              .length >
                                          0 &&
                                      detailCotisationMemberNoOkay != null) {
                                    // print("memberWithCodeM79556memberWithCodeM79556memberWithCodeM79556memberWithCodeM79556memberWithCodeM79556 ${memberWithCodeM79556['membre']['versement'][0]['balance_after']}");
                                    return Container(
                                      child: Text(
                                        "${formatMontantFrancais(double.parse(detailCotisationMemberNoOkay['membre']['versement'].length > 0 ? detailCotisationMemberNoOkay['membre']['versement'][0]['balance_after'] : "0"))} FCFA",
                                        // "FCFA",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    );
                                  } else if (detailCotisationMemberIsOkay !=
                                          null &&
                                      detailCotisationMemberIsOkay!["versement"]
                                              .length >
                                          0) {
                                    return Container(
                                      child: Text(
                                        "${formatMontantFrancais(double.parse(detailCotisationMemberIsOkay['versement'].length > 0 != null ? detailCotisationMemberIsOkay['versement'][0]['balance_after'] : "0"))} FCFA",
                                        // "FCFA",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      child: Text(
                                        // "${formatMontantFrancais(double.parse(detailCotisationMemberIsOkay['versement'].length > 0 ? detailCotisationMemberIsOkay['versement'][0]['balance_remaining'] : "0"))} FCFA",
                                        "0 FCFA",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  "reste".tr(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.blackBlue,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              BlocBuilder<CotisationDetailCubit,
                                  CotisationDetailState>(
                                builder: (CotisationContext, CotisationState) {
                                  if (CotisationState.isLoading == null ||
                                      CotisationState.isLoading == true ||
                                      CotisationState.detailCotisation == null)
                                    return Container(
                                      width: 10,
                                      height: 10,
                                      child: Center(
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 0.5,
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                      ),
                                    );

                                  final currentDetailCotisation =
                                      CotisationContext.read<
                                              CotisationDetailCubit>()
                                          .state
                                          .detailCotisation;

                                  var detailCotisationMemberNoOkay =
                                      currentDetailCotisation!["members"]
                                          .firstWhere(
                                    (member) =>
                                        member['membre']['membre_code'] ==
                                        AppCubitStorage().state.membreCode,
                                    orElse: () => null,
                                  );

                                  var detailCotisationMemberIsOkay =
                                      currentDetailCotisation!["versements"]
                                          .firstWhere(
                                    (member) =>
                                        member['membre_code'] ==
                                        AppCubitStorage().state.membreCode,
                                    orElse: () => null,
                                  );

                                  if (currentDetailCotisation!["members"]
                                              .length >
                                          0 &&
                                      detailCotisationMemberNoOkay != null) {
                                    // print("memberWithCodeM79556memberWithCodeM79556memberWithCodeM79556memberWithCodeM79556memberWithCodeM79556 ${memberWithCodeM79556['membre']['versement'][0]['balance_after']}");
                                    return Container(
                                      child: Text(
                                        "${formatMontantFrancais(double.parse(detailCotisationMemberNoOkay['membre']['versement'].length > 0 ? detailCotisationMemberNoOkay['membre']['versement'][0]['balance_remaining'] : "${widget.montantCotisations}"))} FCFA",
                                        // "FCFA",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    );
                                  } else if (detailCotisationMemberIsOkay !=
                                          null &&
                                      detailCotisationMemberIsOkay!['versement']
                                              .length >
                                          0) {
                                    return Container(
                                      child: Text(
                                        "${formatMontantFrancais(double.parse(detailCotisationMemberIsOkay['versement'].length > 0 ? detailCotisationMemberIsOkay['versement'][0]['balance_remaining'] : "0"))} FCFA",
                                        // "FCFA",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      child: Text(
                                        // "${formatMontantFrancais(double.parse(detailCotisationMemberIsOkay['versement'].length > 0 ? detailCotisationMemberIsOkay['versement'][0]['balance_remaining'] : "0"))} FCFA",
                                        "0 FCFA",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
            Expanded(
              child: checkTransparenceStatus(
                      context
                          .read<UserGroupCubit>()
                          .state
                          .ChangeAssData!["user_group"]["configs"],
                      context.read<AuthCubit>().state.detailUser!["isMember"])
                  ? TabBarView(
                      controller: _tabController,
                      children: [
                        BlocBuilder<CotisationDetailCubit,
                            CotisationDetailState>(
                          builder:
                              (CotisationDetailcontext, CotisationDetailstate) {
                            if (CotisationDetailstate.isLoading == null ||
                                CotisationDetailstate.isLoading == true ||
                                CotisationDetailstate.detailCotisation == null)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color:           AppColors.bleuLight,
                                  ),
                                ),
                              );
                            final currentDetailCotisation =
                                CotisationDetailcontext.read<
                                        CotisationDetailCubit>()
                                    .state
                                    .detailCotisation;
                            return currentDetailCotisation!["versements"]
                                        .length >
                                    0
                                ? RefreshIndicator(
                                    onRefresh: refresh,
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      itemCount:
                                          currentDetailCotisation!["versements"]
                                              .length,
                                      itemBuilder: (context, index) {
                                        final currentDetailPersonCotis =
                                            currentDetailCotisation![
                                                "versements"];

                                        return WidgetHistoriqueCotisation(
                                          is_versement_finished:
                                              currentDetailPersonCotis[index]
                                                              ["versement"]
                                                          .length ==
                                                      0
                                                  ? 0
                                                  : currentDetailPersonCotis[
                                                          index]["versement"][0]
                                                      ["is_versement_finished"],
                                          matricule: currentDetailPersonCotis[
                                                      index]["matricule"] ==
                                                  null
                                              ? ""
                                              : currentDetailPersonCotis[index]
                                                  ["matricule"],
                                          montantTotalAVerser:
                                              currentDetailPersonCotis[index]
                                                              ["versement"]
                                                          .length ==
                                                      0
                                                  ? "0"
                                                  : currentDetailPersonCotis[
                                                          index]["versement"][0]
                                                      ["source_amount"],
                                          montantVersee:
                                              currentDetailPersonCotis[index]
                                                              ["versement"]
                                                          .length ==
                                                      0
                                                  ? "0"
                                                  : currentDetailPersonCotis[
                                                          index]["versement"][0]
                                                      ["balance_after"],
                                          nom: currentDetailPersonCotis[index]
                                                      ["first_name"] ==
                                                  null
                                              ? ""
                                              : currentDetailPersonCotis[index]
                                                  ["first_name"],
                                          photoProfil: currentDetailPersonCotis[
                                                      index]["photo_profil"] ==
                                                  null
                                              ? ""
                                              : currentDetailPersonCotis[index]
                                                  ["photo_profil"],
                                          prenom: currentDetailPersonCotis[
                                                      index]["last_name"] ==
                                                  null
                                              ? ""
                                              : currentDetailPersonCotis[index]
                                                  ["last_name"],
                                        );
                                      },
                                    ),
                                  )
                                : RefreshIndicator(
                                    onRefresh: refresh,
                                    child: ListView.builder(
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          padding: EdgeInsets.only(top: 100),
                                          alignment: Alignment.topCenter,
                                          child: Icon(
                                            Icons.playlist_remove,
                                            size: 100,
                                            color: Color.fromRGBO(
                                                20, 45, 99, 0.26),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                          },
                        ),
                        BlocBuilder<CotisationDetailCubit,
                            CotisationDetailState>(
                          builder:
                              (CotisationDetailcontext, CotisationDetailstate) {
                            if (CotisationDetailstate.isLoading == null ||
                                CotisationDetailstate.isLoading == true)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.bleuLight,
                                  ),
                                ),
                              );
                            final currentDetailCotisation =
                                CotisationDetailcontext.read<
                                        CotisationDetailCubit>()
                                    .state
                                    .detailCotisation;

                            return currentDetailCotisation!["members"].length >
                                    0
                                ? RefreshIndicator(
                                    onRefresh: refresh,
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      itemCount:
                                          currentDetailCotisation!["members"]
                                              .length,
                                      itemBuilder: (context, index) {
                                        final currentDetailPersonNonCotis =
                                            currentDetailCotisation!["members"]
                                                [index];

                                        return WidgetHistoriqueCotisation(
                                          is_versement_finished:
                                              currentDetailPersonNonCotis[
                                                                  "membre"]
                                                              ["versement"]
                                                          .length ==
                                                      0
                                                  ? 0
                                                  : currentDetailPersonNonCotis[
                                                              "membre"]
                                                          ["versement"][0]
                                                      ["is_versement_finished"],
                                          matricule:
                                              currentDetailPersonNonCotis[
                                                              "membre"]
                                                          ["matricule"] ==
                                                      null
                                                  ? ""
                                                  : currentDetailPersonNonCotis[
                                                      "membre"]["matricule"],
                                          montantTotalAVerser:
                                              currentDetailPersonNonCotis[
                                                                  "membre"]
                                                              ["versement"]
                                                          .length ==
                                                      0
                                                  ? "0"
                                                  : currentDetailPersonNonCotis[
                                                          "membre"]["versement"]
                                                      [0]["source_amount"],
                                          montantVersee:
                                              currentDetailPersonNonCotis[
                                                                  "membre"]
                                                              ["versement"]
                                                          .length ==
                                                      0
                                                  ? "0"
                                                  : currentDetailPersonNonCotis[
                                                          "membre"]["versement"]
                                                      [0]["balance_after"],
                                          nom: currentDetailPersonNonCotis[
                                                      "membre"]["first_name"] ==
                                                  null
                                              ? ""
                                              : currentDetailPersonNonCotis[
                                                  "membre"]["first_name"],
                                          photoProfil:
                                              currentDetailPersonNonCotis[
                                                              "membre"]
                                                          ["photo_profil"] ==
                                                      null
                                                  ? ""
                                                  : currentDetailPersonNonCotis[
                                                      "membre"]["photo_profil"],
                                          prenom: currentDetailPersonNonCotis[
                                                      "membre"]["last_name"] ==
                                                  null
                                              ? ""
                                              : currentDetailPersonNonCotis[
                                                  "membre"]["last_name"],
                                        );
                                      },
                                    ),
                                  )
                                : RefreshIndicator(
                                    onRefresh: refresh,
                                    child: ListView.builder(
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          padding: EdgeInsets.only(top: 100),
                                          alignment: Alignment.topCenter,
                                          child: Icon(
                                            Icons.playlist_add_check,
                                            size: 100,
                                            color: Color.fromRGBO(
                                                20, 45, 99, 0.26),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                          },
                        ),
                      ],
                    )
                  : BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
                      builder: (CotisationContext, CotisationState) {
                      if (CotisationState.isLoading == null ||
                          CotisationState.isLoading == true ||
                          CotisationState.detailCotisation == null)
                        return Container(
                          // width: 10,
                          // height: 10,
                          child: Center(
                            child: Container(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: AppColors.bleuLight,
                                  // strokeWidth: 0.5,
                                  // color:
                                  //     AppColors.blackBlue,
                                  ),
                            ),
                          ),
                        );

                      final currentDetailCotisation =
                          CotisationContext.read<CotisationDetailCubit>()
                              .state
                              .detailCotisation;

                      var detailCotisationMemberNoOkay =
                          currentDetailCotisation!["members"].firstWhere(
                        (member) =>
                            member['membre']['membre_code'] ==
                            AppCubitStorage().state.membreCode,
                        orElse: () => null,
                      );

                      var detailCotisationMemberIsOkay =
                          currentDetailCotisation!["versements"].firstWhere(
                        (member) =>
                            member['membre_code'] ==
                            AppCubitStorage().state.membreCode,
                        orElse: () => null,
                      );
                      return Container(
                        padding: EdgeInsets.only(right: 7, left: 7),
                        color: AppColors.white,
                        child: Column(
                          children: [
                            Expanded(
                                child: RefreshIndicator(
                              onRefresh: refresh,
                              child: detailCotisationMemberNoOkay != null &&
                                      detailCotisationMemberNoOkay['membre']
                                                  ['versement']
                                              .length >
                                          0
                                  ? ListView.builder(
                                      itemCount:
                                          detailCotisationMemberNoOkay['membre']
                                                      ['versement'][0]
                                                  ["transanctions"]
                                              .length,
                                      itemBuilder: (context, index) {
                                        final detailVersement =
                                            detailCotisationMemberNoOkay[
                                                    'membre']['versement'][0]
                                                ["transanctions"][index];

                                        return Container(
                                            child:
                                                widgetListTransactionByEventCard(
                                          date: AppCubitStorage()
                                                      .state
                                                      .Language ==
                                                  "fr"
                                              ? formatDateToFrench(
                                                  detailVersement["created_at"])
                                              : formatDateToEnglish(
                                                  detailVersement[
                                                      "created_at"]),
                                          //  formatDateString(
                                          // detailVersement["created_at"]),
                                          montant: detailVersement["amount"],
                                        ));
                                      },
                                    )
                                  : detailCotisationMemberIsOkay != null &&
                                          detailCotisationMemberIsOkay[
                                                  'versement'] !=
                                              null
                                      ? ListView.builder(
                                          itemCount:
                                              detailCotisationMemberIsOkay[
                                                          'versement'][0]
                                                      ["transanctions"]
                                                  .length,
                                          itemBuilder: (context, index) {
                                            final detailVersement =
                                                detailCotisationMemberIsOkay[
                                                        'versement'][0]
                                                    ["transanctions"][index];

                                            return Container(
                                                child:
                                                    widgetListTransactionByEventCard(
                                              date: AppCubitStorage()
                                                          .state
                                                          .Language ==
                                                      "fr"
                                                  ? formatDateToFrench(
                                                      detailVersement[
                                                          "created_at"])
                                                  : formatDateToEnglish(
                                                      detailVersement[
                                                          "created_at"]),
                                              //  formatDateString(
                                              // detailVersement["created_at"]),
                                              montant:
                                                  detailVersement["amount"],
                                            ));
                                          },
                                        )
                                      : ListView.builder(
                                          itemCount: 1,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              padding:
                                                  EdgeInsets.only(top: 200),
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                "aucune_transaction".tr(),
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        20, 45, 99, 0.26),
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 20),
                                              ),
                                            );
                                          }),
                            ))
                          ],
                        ),
                      );
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
