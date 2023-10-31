import 'dart:io';
import 'dart:math';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationExpireInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationExpireInProgress.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInProgress.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/WidgetSanctionNonPayeeIsOther.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionNonPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsOther.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetDetailRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetTontineRencontreCard.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class detailRencontrePage extends StatefulWidget {
  detailRencontrePage({
    super.key,
    required this.nomRecepteurRencontre,
    required this.identifiantRencontre,
    required this.isActiveRencontre,
    required this.descriptionRencontre,
    required this.lieuRencontre,
    required this.dateRencontre,
    required this.heureRencontre,
    required this.prenomRecepteurRencontre,
    required this.photoProfilRecepteur,
  });

  String nomRecepteurRencontre;
  String identifiantRencontre;
  int isActiveRencontre;
  String descriptionRencontre;
  String lieuRencontre;
  String dateRencontre;
  String heureRencontre;
  String prenomRecepteurRencontre;
  String photoProfilRecepteur;
  @override
  State<detailRencontrePage> createState() => _detailRencontrePageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFEFEFEF),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "detail_de_la_rencontre".tr(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: Color(0xFFEFEFEF),
    appBar: AppBar(
      title: Text(
        "detail_de_la_rencontre".tr(),
        style: TextStyle(fontSize: 16),
      ),
      backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
      elevation: 0,
    ),
    body: child,
  );
}

class _detailRencontrePageState extends State<detailRencontrePage>
    with TickerProviderStateMixin {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, "end", "end"];

  // Map<String, dynamic>? get currentInfoAssociationCourant {
  //   return context.read<UserGroupCubit>().state.userGroupDefault;
  // }

  Map<String, dynamic>? get currentDetailSeance {
    return context.read<SeanceCubit>().state.detailSeance;
  }

  Map<String, dynamic>? get currentAssCourant {
    return context.read<UserGroupCubit>().state.ChangeAssData;
  }

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);
    // final currentDetailSeance =

    return BlocBuilder<SeanceCubit, SeanceState>(builder: (context, state) {
      if (state.isLoading == null || state.isLoading == true)
        return Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      return PageScaffold(
        context: context,
        child: Container(
          margin: EdgeInsets.only(top: 0, left: 5, right: 5),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: widgetDetailRencontreCard(
                  nbrPresence:
                      ("${currentDetailSeance!["abs"].length + currentDetailSeance!["presents"].length}"),
                  dateRencontre: widget.dateRencontre,
                  descriptionRencontre: widget.descriptionRencontre,
                  heureRencontre: widget.heureRencontre,
                  identifiantRencontre: widget.identifiantRencontre,
                  isActiveRencontre: widget.isActiveRencontre,
                  lieuRencontre: widget.lieuRencontre,
                  nomRecepteurRencontre: widget.nomRecepteurRencontre,
                  prenomRecepteurRencontre: widget.prenomRecepteurRencontre,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                padding: EdgeInsets.only(top: 15, bottom: 15),
                color: Color.fromARGB(120, 226, 226, 226),
                alignment: Alignment.center,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Color.fromARGB(255, 20, 45, 99),
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  padding: EdgeInsets.all(0),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 20, 45, 99),
                      width: 5.0,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 36.0),
                  ),
                  tabs: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text("Cotisations"),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text("Sanctions"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: currentDetailSeance!["cotisation"].length,
                      itemBuilder: (context, index) {
                        final currentDetail =
                            currentDetailSeance!["cotisation"][index];
                        print("####### ${index}");

                        if (currentDetail["is_tontine"] == 0 &&
                            currentDetail["type"] == "0" &&
                            currentDetail["is_passed"] == 0) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetCotisationInFixed(
                                lienDePaiement: currentDetail["cotisation_pay_link"]==null? "Le lien n'a pas été généré": currentDetail["cotisation_pay_link"],
                                contributionOneUser: '2000',
                                codeCotisation:
                                    currentDetail["cotisation_code"],
                                heureCotisation:
                                    AppCubitStorage().state.Language == "fr"
                                        ? formatTimeToFrench(
                                            currentDetail["start_date"])
                                        : formatTimeToEnglish(
                                            currentDetail["start_date"]),

                                dateCotisation:
                                    AppCubitStorage().state.Language == "fr"
                                        ? formatDateToFrench(
                                            currentDetail["start_date"])
                                        : formatDateToEnglish(
                                            currentDetail["start_date"]),
                                montantCotisations: currentDetail["amount"],
                                motifCotisations: currentDetail["name"],
                                nbreParticipant: 5,
                                soldeCotisation:
                                    currentDetail["cotisation_balance"],
                                nbreParticipantCotisationOK: 4,
                                type: currentDetail["type"],

                                // montantSanctionCollectee: currentDetail["amount_sanction"],
                                isActive: 1,
                              ),
                            ),
                          );
                        } else if (currentDetail["is_tontine"] == 0 &&
                            currentDetail["type"] == "1" &&
                            currentDetail["is_passed"] == 0) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 7, right: 7, top: 3, bottom: 7),
                            child: WidgetCotisationInProgress(
                              lienDePaiement: currentDetail["cotisation_pay_link"]==null? "Le lien n'a pas été généré": currentDetail["cotisation_pay_link"],
                              codeCotisation: currentDetail["cotisation_code"],
                              contributionOneUser: '2000',
                              // AppCubitStorage().state.Language=="fr"? formatTimeToFrench (currentDetail["start_date"]) : formatTimeToEnglish (currentDetail["start_date"])
                              heureCotisation:
                                  AppCubitStorage().state.Language == "fr"
                                      ? formatTimeToFrench(
                                          currentDetail["start_date"])
                                      : formatTimeToEnglish(
                                          currentDetail["start_date"]),
                              dateCotisation:
                                  AppCubitStorage().state.Language == "fr"
                                      ? formatDateToFrench(
                                          currentDetail["start_date"])
                                      : formatDateToEnglish(
                                          currentDetail["start_date"]),
                              montantCotisations: currentDetail["amount"],
                              motifCotisations: currentDetail["name"],
                              nbreParticipant: 24,
                              soldeCotisation:
                                  currentDetail["cotisation_balance"],
                              nbreParticipantCotisationOK: 7,
                              montantSanctionCollectee: '1500',
                              isActive: 1,
                              montantMin: "200",
                              type: currentDetail["type"],
                            ),
                          );
                        } else if (currentDetail["is_tontine"] == 0 &&
                            currentDetail["type"] == "0" &&
                            currentDetail["is_passed"] == 1) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 7, right: 7, top: 3, bottom: 7),
                            child: WidgetCotisationExpireInFixed(
                              codeCotisation: currentDetail["cotisation_code"],
                              contributionOneUser: '1500',
                              motifCotisations: currentDetail["name"],
                              dateCotisation:
                                  AppCubitStorage().state.Language == "fr"
                                      ? formatDateToFrench(
                                          currentDetail["start_date"])
                                      : formatDateToEnglish(
                                          currentDetail["start_date"]),
                              montantCotisations: currentDetail["amount"],
                              heureCotisation:
                                  AppCubitStorage().state.Language == "fr"
                                      ? formatTimeToFrench(
                                          currentDetail["start_date"])
                                      : formatTimeToEnglish(
                                          currentDetail["start_date"]),
                              // montantSanctionCollectee: '1500',
                              nbreParticipantCotisationOK: 10,
                              nbreParticipant: 12,
                              soldeCotisation:
                                  currentDetail["cotisation_balance"],
                              isActive: 0,
                              type: currentDetail["type"],
                            ),
                          );
                        } else if (currentDetail["is_tontine"] == 0 &&
                            currentDetail["type"] == "1" &&
                            currentDetail["is_passed"] == 1) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 7, right: 7, top: 3, bottom: 7),
                            child: WidgetCotisationExpireInProgress(
                              contributionOneUser: '1500',
                              motifCotisations: currentDetail["name"],
                              dateCotisation:
                                  AppCubitStorage().state.Language == "fr"
                                      ? formatDateToFrench(
                                          currentDetail["start_date"])
                                      : formatDateToEnglish(
                                          currentDetail["start_date"]),
                              montantCotisations: currentDetail["amount"],
                              heureCotisation:
                                  AppCubitStorage().state.Language == "fr"
                                      ? formatTimeToFrench(
                                          currentDetail["start_date"])
                                      : formatTimeToEnglish(
                                          currentDetail["start_date"]),
                              // montantSanctionCollectee: currentDetail["amount_sanction"] ,
                              nbreParticipantCotisationOK: 10,
                              nbreParticipant: 12,
                              soldeCotisation:
                                  currentDetail["cotisation_balance"],
                              isActive: 0,
                              codeCotisation: currentDetail["cotisation_code"],
                              type: currentDetail["type"],
                            ),
                          );
                        }
                      },
                    ),

                    Column(
                      children: [
                        for (var currentDetail
                            in currentDetailSeance!["sanctions"])
                          if (currentDetail["type"] == "1" &&
                              currentDetail["membre"]["membre_code"] ==
                                  AppCubitStorage().state.membreCode &&
                              currentDetail["is_sanction_payed"] == 0)
                            Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetSanctionNonPayeeIsMoney(
                                dateSanction:
                                    AppCubitStorage().state.Language == "fr"
                                        ? formatDateToFrench(
                                            currentDetail["start_date"])
                                        : formatDateToEnglish(
                                            currentDetail["start_date"]),
                                versement: currentDetail["versement"],
                                heureSanction:
                                    AppCubitStorage().state.Language == "fr"
                                        ? formatTimeToFrench(
                                            currentDetail["start_date"])
                                        : formatTimeToEnglish(
                                            currentDetail["start_date"]),
                                montantPayeeSanction:
                                    currentDetail["sanction_balance"],
                                montantSanction:
                                    currentDetail["amount"].toString(),
                                motifSanction: currentDetail["motif"],
                                lienPaiement:
                                    currentDetail["sanction_pay_link"] == null
                                        ? " "
                                        : currentDetail["sanction_pay_link"],
                              ),
                            ),
                        for (var currentDetail
                            in currentDetailSeance!["sanctions"])
                          if (currentDetail["type"] == "0" &&
                              currentDetail["membre"]["membre_code"] ==
                                  AppCubitStorage().state.membreCode &&
                              currentDetail["is_sanction_payed"] == 0)
                            Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetSanctionNonPayeeIsOther(
                                dateSanction:
                                    AppCubitStorage().state.Language == "fr"
                                        ? formatDateToFrench(
                                            currentDetail["start_date"])
                                        : formatDateToEnglish(
                                            currentDetail["start_date"]),
                                heureSanction:
                                    AppCubitStorage().state.Language == "fr"
                                        ? formatTimeToFrench(
                                            currentDetail["start_date"])
                                        : formatTimeToEnglish(
                                            currentDetail["start_date"]),
                                objetSanction: currentDetail["libelle"],
                                motifSanction: currentDetail["motif"],
                              ),
                            ),
                        for (var currentDetail
                            in currentDetailSeance!["sanctions"])
                          if (currentDetail["type"] == "1" &&
                              currentDetail["is_sanction_payed"] == 1 &&
                              currentDetail["membre"]["membre_code"] ==
                                  Variables().codeMembre)
                            Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetSanctionPayeeIsMoney(
                                versement: currentDetail["versement"],
                                dateSanction:
                                    AppCubitStorage().state.Language == "fr"
                                        ? formatDateToFrench(
                                            currentDetail["start_date"])
                                        : formatDateToEnglish(
                                            currentDetail["start_date"]),
                                heureSanction:
                                    AppCubitStorage().state.Language == "fr"
                                        ? formatTimeToFrench(
                                            currentDetail["start_date"])
                                        : formatTimeToEnglish(
                                            currentDetail["start_date"]),
                                montantPayeeSanction:
                                    currentDetail["sanction_balance"],
                                montantSanction:
                                    currentDetail["amount"].toString(),
                                motifSanction: currentDetail["motif"],
                              ),
                            ),
                        for (var currentDetail
                            in currentDetailSeance!["sanctions"])
                          if (currentDetail["type"] == "0" &&
                              currentDetail["is_sanction_payed"] == 1 &&
                              currentDetail["membre"]["membre_code"] ==
                                  Variables().codeMembre)
                            Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetSanctionPayeeIsOther(
                                dateSanction:
                                    AppCubitStorage().state.Language == "fr"
                                        ? formatDateToFrench(
                                            currentDetail["start_date"])
                                        : formatDateToEnglish(
                                            currentDetail["start_date"]),
                                heureSanction:
                                    AppCubitStorage().state.Language == "fr"
                                        ? formatTimeToFrench(
                                            currentDetail["start_date"])
                                        : formatTimeToEnglish(
                                            currentDetail["start_date"]),
                                motifSanction: currentDetail["motif"],
                                objetSanction: currentDetail["libelle"],
                              ),
                            )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
