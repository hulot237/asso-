import 'dart:io';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:easy_loader/easy_loader.dart';
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

    if (detailCotisation != null) {} else {
    }
  }

  Future<void> handleAllCotisationAssTournoi(codeTournoi) async {
    final allCotisationAss = await context
        .read<CotisationCubit>()
        .AllCotisationAssTournoiCubit(codeTournoi);

    if (allCotisationAss != null) {
    } else {
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
                        .state.changeAssData!.user_group!.configs,
                    context.read<AuthCubit>().state.detailUser!["isMember"])
                ? Container(
                    // color: Colors.deepOrange,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 20, bottom: 10),
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
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      "liste_de_vos_transactions".tr(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackBlue,
                      ),
                    ),
                  ),
            // Container(
            //   margin: EdgeInsets.only(top: 15, bottom: 15),
            //   padding: EdgeInsets.only(top: 15, bottom: 15),
            //   color: Color.fromARGB(120, 226, 226, 226),
            //   alignment: Alignment.center,
            //   child: checkTransparenceStatus(
            //           context
            //               .read<UserGroupCubit>()
            //               .state
            //               .ChangeAssData!["user_group"]["configs"],
            //           context.read<AuthCubit>().state.detailUser!["isMember"])
            //       ? TabBar(
            //           controller: _tabController,
            //           isScrollable: true,
            //           labelColor: AppColors.blackBlue,
            //           labelStyle:
            //               TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            //           padding: EdgeInsets.all(0),
            //           unselectedLabelStyle: TextStyle(
            //             color: AppColors.blackBlueAccent1,
            //             fontWeight: FontWeight.bold,
            //           ),
            //           indicator: UnderlineTabIndicator(
            //             borderSide: BorderSide(
            //               color: AppColors.blackBlue,
            //               width: 5.0,
            //             ),
            //             insets: EdgeInsets.symmetric(
            //               horizontal: 36.0,
            //             ),
            //           ),
            //           tabs: [
            //             Container(
            //               margin: EdgeInsets.only(bottom: 5),
            //               child: Row(
            //                 children: [
            //                   Text(
            //                     "${"cotisé".tr()}",
            //                   ),
            //                   BlocBuilder<CotisationDetailCubit,
            //                           CotisationDetailState>(
            //                       builder:
            //                           (CotisationContext, CotisationState) {
            //                     if (CotisationState.isLoading == null ||
            //                         CotisationState.isLoading == true ||
            //                         CotisationState.detailCotisation == null)
            //                       return Container(
            //                         width: 10,
            //                         height: 10,
            //                         child: Center(
            //                           child: Container(
            //                             width: 10,
            //                             height: 10,
            //                             child: CircularProgressIndicator(
            //                               strokeWidth: 0.5,
            //                               color: AppColors.blackBlue,
            //                             ),
            //                           ),
            //                         ),
            //                       );
            //                     final currentDetailCotisation =
            //                         CotisationContext.read<
            //                                 CotisationDetailCubit>()
            //                             .state
            //                             .detailCotisation;
            //                     return Text(
            //                       "(${currentDetailCotisation!["versements"].length == null ? 0 : currentDetailCotisation!["versements"].length})",
            //                       style: TextStyle(fontSize: 10),
            //                     );
            //                   }),
            //                 ],
            //               ),
            //             ),
            //             Container(
            //               margin: EdgeInsets.only(bottom: 5),
            //               child: Row(
            //                 children: [
            //                   Text(
            //                     'non_cotisé'.tr(),
            //                   ),
            //                   BlocBuilder<CotisationDetailCubit,
            //                           CotisationDetailState>(
            //                       builder:
            //                           (CotisationContext, CotisationState) {
            //                     if (CotisationState.isLoading == null ||
            //                         CotisationState.isLoading == true ||
            //                         CotisationState.detailCotisation == null)
            //                       return Container(
            //                         width: 10,
            //                         height: 10,
            //                         child: Center(
            //                           child: Container(
            //                             width: 10,
            //                             height: 10,
            //                             child: CircularProgressIndicator(
            //                               strokeWidth: 0.5,
            //                               color: AppColors.blackBlue,
            //                             ),
            //                           ),
            //                         ),
            //                       );
            //                     final currentDetailCotisation =
            //                         CotisationContext.read<
            //                                 CotisationDetailCubit>()
            //                             .state
            //                             .detailCotisation;
            //                     return Text(
            //                       "(${currentDetailCotisation!["members"].length == null ? 0 : currentDetailCotisation!["members"].length})",
            //                       style: TextStyle(fontSize: 10),
            //                     );
            //                   }),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         )
            //       : Container(
            //           margin: EdgeInsets.only(left: 5, right: 5),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Column(
            //                 children: [
            //                   Container(
            //                     margin: EdgeInsets.only(bottom: 2),
            //                     child: Text(
            //                       "a_payer".tr(),
            //                       style: TextStyle(
            //                         fontSize: 12,
            //                         fontWeight: FontWeight.w300,
            //                         color: AppColors.blackBlue,
            //                       ),
            //                     ),
            //                   ),
            //                   Container(
            //                     child: Text(
            //                       widget.type == "0"
            //                           ? "${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA"
            //                           : "Volontaire",
            //                       style: TextStyle(
            //                         fontSize: 10,
            //                         fontWeight: FontWeight.w500,
            //                         color: AppColors.blackBlue,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Column(
            //                 children: [
            //                   Container(
            //                     margin: EdgeInsets.only(bottom: 2),
            //                     child: Text(
            //                       "déjà_payé".tr(),
            //                       style: TextStyle(
            //                           fontSize: 12,
            //                           color: AppColors.blackBlue,
            //                           fontWeight: FontWeight.w300),
            //                     ),
            //                   ),
            //                   BlocBuilder<CotisationDetailCubit,
            //                       CotisationDetailState>(
            //                     builder: (CotisationContext, CotisationState) {
            //                       if (CotisationState.isLoading == null ||
            //                           CotisationState.isLoading == true ||
            //                           CotisationState.detailCotisation == null)
            //                         return Container(
            //                           width: 10,
            //                           height: 10,
            //                           child: Center(
            //                             child: Container(
            //                               width: 10,
            //                               height: 10,
            //                               child: CircularProgressIndicator(
            //                                 strokeWidth: 0.5,
            //                                 color: AppColors.blackBlue,
            //                               ),
            //                             ),
            //                           ),
            //                         );

            //                       final currentDetailCotisation =
            //                           CotisationContext.read<
            //                                   CotisationDetailCubit>()
            //                               .state
            //                               .detailCotisation;

            //                       var detailCotisationMemberNoOkay =
            //                           currentDetailCotisation!["members"]
            //                               .firstWhere(
            //                         (member) =>
            //                             member['membre']['membre_code'] ==
            //                             AppCubitStorage().state.membreCode,
            //                         orElse: () => null,
            //                       );

            //                       var detailCotisationMemberIsOkay =
            //                           currentDetailCotisation!["versements"]
            //                               .firstWhere(
            //                         (member) =>
            //                             member['membre_code'] ==
            //                             AppCubitStorage().state.membreCode,
            //                         orElse: () => null,
            //                       );

            //                       if (currentDetailCotisation!["members"]
            //                                   .length >
            //                               0 &&
            //                           detailCotisationMemberNoOkay != null) {
            //                         // print("memberWithCodeM79556memberWithCodeM79556memberWithCodeM79556memberWithCodeM79556memberWithCodeM79556 ${memberWithCodeM79556['membre']['versement'][0]['balance_after']}");
            //                         return Container(
            //                           child: Text(
            //                             "${formatMontantFrancais(double.parse(detailCotisationMemberNoOkay['membre']['versement'].length > 0 ? detailCotisationMemberNoOkay['membre']['versement'][0]['balance_after'] : "0"))} FCFA",
            //                             // "FCFA",
            //                             style: TextStyle(
            //                               fontSize: 10,
            //                               fontWeight: FontWeight.w500,
            //                               color: AppColors.blackBlue,
            //                             ),
            //                           ),
            //                         );
            //                       } else if (detailCotisationMemberIsOkay !=
            //                               null &&
            //                           detailCotisationMemberIsOkay!["versement"]
            //                                   .length >
            //                               0) {
            //                         return Container(
            //                           child: Text(
            //                             "${formatMontantFrancais(double.parse(detailCotisationMemberIsOkay['versement'].length > 0 != null ? detailCotisationMemberIsOkay['versement'][0]['balance_after'] : "0"))} FCFA",
            //                             // "FCFA",
            //                             style: TextStyle(
            //                               fontSize: 10,
            //                               fontWeight: FontWeight.w500,
            //                               color: AppColors.blackBlue,
            //                             ),
            //                           ),
            //                         );
            //                       } else {
            //                         return Container(
            //                           child: Text(
            //                             // "${formatMontantFrancais(double.parse(detailCotisationMemberIsOkay['versement'].length > 0 ? detailCotisationMemberIsOkay['versement'][0]['balance_remaining'] : "0"))} FCFA",
            //                             "0 FCFA",
            //                             style: TextStyle(
            //                               fontSize: 10,
            //                               fontWeight: FontWeight.w500,
            //                               color: AppColors.blackBlue,
            //                             ),
            //                           ),
            //                         );
            //                       }
            //                     },
            //                   ),
            //                 ],
            //               ),
            //               Column(
            //                 children: [
            //                   Container(
            //                     margin: EdgeInsets.only(bottom: 2),
            //                     child: Text(
            //                       "reste".tr(),
            //                       style: TextStyle(
            //                         fontSize: 12,
            //                         color: AppColors.blackBlue,
            //                         fontWeight: FontWeight.w300,
            //                       ),
            //                     ),
            //                   ),
            //                   BlocBuilder<CotisationDetailCubit,
            //                       CotisationDetailState>(
            //                     builder: (CotisationContext, CotisationState) {
            //                       if (CotisationState.isLoading == null ||
            //                           CotisationState.isLoading == true ||
            //                           CotisationState.detailCotisation == null)
            //                         return Container(
            //                           width: 10,
            //                           height: 10,
            //                           child: Center(
            //                             child: Container(
            //                               width: 10,
            //                               height: 10,
            //                               child: CircularProgressIndicator(
            //                                 strokeWidth: 0.5,
            //                                 color: AppColors.blackBlue,
            //                               ),
            //                             ),
            //                           ),
            //                         );

            //                       final currentDetailCotisation =
            //                           CotisationContext.read<
            //                                   CotisationDetailCubit>()
            //                               .state
            //                               .detailCotisation;

            //                       var detailCotisationMemberNoOkay =
            //                           currentDetailCotisation!["members"]
            //                               .firstWhere(
            //                         (member) =>
            //                             member['membre']['membre_code'] ==
            //                             AppCubitStorage().state.membreCode,
            //                         orElse: () => null,
            //                       );

            //                       var detailCotisationMemberIsOkay =
            //                           currentDetailCotisation!["versements"]
            //                               .firstWhere(
            //                         (member) =>
            //                             member['membre_code'] ==
            //                             AppCubitStorage().state.membreCode,
            //                         orElse: () => null,
            //                       );

            //                       if (currentDetailCotisation!["members"]
            //                                   .length >
            //                               0 &&
            //                           detailCotisationMemberNoOkay != null) {
            //                         // print("memberWithCodeM79556memberWithCodeM79556memberWithCodeM79556memberWithCodeM79556memberWithCodeM79556 ${memberWithCodeM79556['membre']['versement'][0]['balance_after']}");
            //                         return Container(
            //                           child: Text(
            //                             "${formatMontantFrancais(double.parse(detailCotisationMemberNoOkay['membre']['versement'].length > 0 ? detailCotisationMemberNoOkay['membre']['versement'][0]['balance_remaining'] : "${widget.montantCotisations}"))} FCFA",
            //                             // "FCFA",
            //                             style: TextStyle(
            //                               fontSize: 10,
            //                               fontWeight: FontWeight.w500,
            //                               color: AppColors.blackBlue,
            //                             ),
            //                           ),
            //                         );
            //                       } else if (detailCotisationMemberIsOkay !=
            //                               null &&
            //                           detailCotisationMemberIsOkay!['versement']
            //                                   .length >
            //                               0) {
            //                         return Container(
            //                           child: Text(
            //                             "${formatMontantFrancais(double.parse(detailCotisationMemberIsOkay['versement'].length > 0 ? detailCotisationMemberIsOkay['versement'][0]['balance_remaining'] : "0"))} FCFA",
            //                             // "FCFA",
            //                             style: TextStyle(
            //                               fontSize: 10,
            //                               fontWeight: FontWeight.w500,
            //                               color: AppColors.blackBlue,
            //                             ),
            //                           ),
            //                         );
            //                       } else {
            //                         return Container(
            //                           child: Text(
            //                             // "${formatMontantFrancais(double.parse(detailCotisationMemberIsOkay['versement'].length > 0 ? detailCotisationMemberIsOkay['versement'][0]['balance_remaining'] : "0"))} FCFA",
            //                             "0 FCFA",
            //                             style: TextStyle(
            //                               fontSize: 10,
            //                               fontWeight: FontWeight.w500,
            //                               color: AppColors.blackBlue,
            //                             ),
            //                           ),
            //                         );
            //                       }
            //                     },
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            // ),
            checkTransparenceStatus(
                    context
                        .read<UserGroupCubit>()
                        .state.changeAssData!.user_group!.configs,
                    context.read<AuthCubit>().state.detailUser!["isMember"])
                ? BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
                    builder: (CotisationDetailcontext, CotisationDetailstate) {
                      if (CotisationDetailstate.isLoading == null ||
                          CotisationDetailstate.isLoading == true ||
                          CotisationDetailstate.detailCotisation == null)
                        return Expanded(
                          child: Center(
                            child: EasyLoader(
                              backgroundColor: Color.fromARGB(0, 255, 255, 255),
                              iconSize: 50,
                              iconColor: AppColors.blackBlueAccent1,
                              image: AssetImage(
                                'assets/images/Groupe_ou_Asso.png',
                              ),
                            ),
                          ),
                        );

                      final currentDetailCotisation =
                          CotisationDetailcontext.read<CotisationDetailCubit>()
                              .state
                              .detailCotisation;

                      List listeOkayCotisation =
                          currentDetailCotisation!["versements"];
                      List listeNonCotisation =
                          currentDetailCotisation["members"];

                      List<Widget> listWidgetOkayCotis =
                          listeOkayCotisation.map((monObjet) {
                        return Card(
                          child: WidgetHistoriqueCotisation(
                            is_versement_finished:
                                monObjet["versement"].length == 0
                                    ? 0
                                    : monObjet["versement"][0]
                                        ["is_versement_finished"],
                            matricule: monObjet["matricule"] == null
                                ? ""
                                : monObjet["matricule"],
                            montantTotalAVerser:
                                monObjet["versement"].length == 0
                                    ? "0"
                                    : monObjet["versement"][0]["source_amount"],
                            montantVersee: monObjet["versement"].length == 0
                                ? "0"
                                : monObjet["versement"][0]["balance_after"],
                            nom: monObjet["first_name"] == null
                                ? ""
                                : monObjet["first_name"],
                            photoProfil: monObjet["photo_profil"] == null
                                ? ""
                                : monObjet["photo_profil"],
                            prenom: monObjet["last_name"] == null
                                ? ""
                                : monObjet["last_name"],
                          ),
                        );
                      }).toList();

                      List<Widget> listWidgetNonCotis =
                          listeNonCotisation.map((monObjet) {
                        return Card(
                            // margin:
                            // EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            child: WidgetHistoriqueCotisation(
                          is_versement_finished:
                              monObjet["membre"]["versement"].length == 0
                                  ? 0
                                  : monObjet["membre"]["versement"][0]
                                      ["is_versement_finished"],
                          matricule: monObjet["membre"]["matricule"] == null
                              ? ""
                              : monObjet["membre"]["matricule"],
                          montantTotalAVerser:
                              monObjet["membre"]["versement"].length == 0
                                  ? "0"
                                  : monObjet["membre"]["versement"][0]
                                      ["source_amount"],
                          montantVersee:
                              monObjet["membre"]["versement"].length == 0
                                  ? "0"
                                  : monObjet["membre"]["versement"][0]
                                      ["balance_after"],
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
                        ));
                      }).toList();

                      final listeFinale = [
                        ...listWidgetOkayCotis,
                        ...listWidgetNonCotis
                      ];

                      return Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: listeFinale,
                        ),
                      ));
                    },
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
                                          detailCotisationMemberNoOkay['membre']
                                                  ['versement'][0]
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
                                                detailVersement["created_at"]),
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
                                        itemCount: detailCotisationMemberIsOkay[
                                                'versement'][0]["transanctions"]
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
                                            montant: detailVersement["amount"],
                                          ));
                                        },
                                      )
                                    : ListView.builder(
                                        itemCount: 1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            padding: EdgeInsets.only(top: 200),
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
          ],
        ),
      ),
    );
  }
}
