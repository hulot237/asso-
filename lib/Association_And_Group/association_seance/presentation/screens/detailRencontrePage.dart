import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotistion.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/WidgetSanctionNonPayeeIsOther.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionNonPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsOther.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetDetailRencontreCard.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
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
    required this.codeSeance,
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
  String codeSeance;
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

  Future<void> handleDefaultSeance(codeSeance) async {
    final detailSeance =
        await context.read<SeanceCubit>().detailSeanceCubit(codeSeance);

    if (detailSeance != null) {
      print("objectttttttttttttttttttttttttt  ${detailSeance}");
      print(
          "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq  ${context.read<SeanceCubit>().state.detailSeance}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future refresh() async {
    handleDefaultSeance(widget.codeSeance);
  }

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);
    // final currentDetailSeance =

    // return BlocBuilder<SeanceCubit, SeanceState>(builder: (context, state) {
    //   if (state.isLoading == null || state.isLoading == true)
    //     return Container(
    //       color: Colors.white,
    //       child: Center(
    //         child: CircularProgressIndicator(),
    //       ),
    //     );
    // final currentDetailSeance =
    //     context.read<SeanceCubit>().state.detailSeance;
    return PageScaffold(
      context: context,
      child: Container(
        margin: EdgeInsets.only(top: 0, left: 5, right: 5),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: widgetDetailRencontreCard(
                codeSeance: widget.codeSeance,
                nbrPresence: ("000"),
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
                  BlocBuilder<SeanceCubit, SeanceState>(
                      builder: (context, state) {
                    if (state.isLoading == null || state.isLoading == true)
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    final currentDetailSeance =
                        context.read<SeanceCubit>().state.detailSeance;
                    List<dynamic> objetCotisationUniquement =
                        currentDetailSeance!["cotisation"]
                            .where((objet) => objet["is_tontine"] == 0)
                            .toList();
                    return objetCotisationUniquement.length > 0
                        ? RefreshIndicator(
                            onRefresh: refresh,
                            child: ListView.builder(
                              itemCount: objetCotisationUniquement.length,
                              padding: EdgeInsets.all(0),
                              itemBuilder: (BuildContext context, int index) {
                                final ItemDetailCotisation =
                                    objetCotisationUniquement[index];
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 7, right: 7, top: 3, bottom: 7),
                                  child: WidgetCotisation(
                                    montantCotisations:
                                        ItemDetailCotisation["amount"],
                                    motifCotisations:
                                        ItemDetailCotisation["name"],
                                    dateCotisation: AppCubitStorage()
                                                .state
                                                .Language ==
                                            "fr"
                                        ? formatDateToFrench(
                                            ItemDetailCotisation["start_date"])
                                        : formatDateToEnglish(
                                            ItemDetailCotisation["start_date"]),
                                    heureCotisation: AppCubitStorage()
                                                .state
                                                .Language ==
                                            "fr"
                                        ? formatTimeToFrench(
                                            ItemDetailCotisation["start_date"])
                                        : formatTimeToEnglish(
                                            ItemDetailCotisation["start_date"]),
                                    soldeCotisation: ItemDetailCotisation[
                                        "cotisation_balance"],
                                    contributionOneUser: "2",
                                    nbreParticipant: 23,
                                    nbreParticipantCotisationOK: 11,
                                    codeCotisation:
                                        ItemDetailCotisation["cotisation_code"],
                                    type: ItemDetailCotisation["type"],
                                    lienDePaiement: ItemDetailCotisation[
                                                "cotisation_pay_link"] ==
                                            null
                                        ? "le lien n'a pas été généré"
                                        : ItemDetailCotisation[
                                            "cotisation_pay_link"],
                                    is_passed:
                                        ItemDetailCotisation["is_passed"],
                                    is_tontine:
                                        ItemDetailCotisation["is_tontine"],
                                  ),
                                );
                              },
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: refresh,
                            child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: EdgeInsets.only(top: 100),
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "aucune_cotisation".tr(),
                                    style: TextStyle(
                                        color: Color.fromRGBO(20, 45, 99, 0.26),
                                        fontWeight: FontWeight.w100,
                                        fontSize: 20),
                                  ),
                                );
                              },
                            ),
                          );
                  }),
                  BlocBuilder<SeanceCubit, SeanceState>(
                    builder: (context, state) {
                      if (state.isLoading == null || state.isLoading == true)
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      final currentDetailSeance =
                          context.read<SeanceCubit>().state.detailSeance;
                      return Column(
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
