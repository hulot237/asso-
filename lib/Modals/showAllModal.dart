import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetListTransactionCotisationAllCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetHistoriqueTontineCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_update_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/homePage.dart';
import 'package:faroty_association_1/pages/paiementPage.dart';
import 'package:faroty_association_1/widget/widgetListAssCard.dart';
import 'package:faroty_association_1/widget/widgetListTransactionByEventCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Modal {
  void showBottomSheetListAss(BuildContext context, List? listAllAss) {
    Future handleChangeAss(codeAss) async {
      final ChangeAss =
          await context.read<UserGroupCubit>().ChangeAssCubit(codeAss);

      if (ChangeAss != null) {
        await AppCubitStorage().updateCodeAssDefaul(codeAss);

        await AppCubitStorage().updatemembreCode(context
            .read<UserGroupCubit>()
            .state
            .ChangeAssData!["membre"]["membre_code"]);

        await AppCubitStorage().updateCodeTournoisDefault(context
            .read<UserGroupCubit>()
            .state
            .ChangeAssData!["user_group"]["tournois"][0]["tournois_code"]);
      } else {
        print("userGroupDefault null");
      }
                            Navigator.pop(context);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
        (route) => false,
      );
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(7),
                  topLeft: Radius.circular(7),
                ),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 55,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 20, 45, 99),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "vos_associations".tr(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(164, 20, 45, 99),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listAllAss!.length,
                      itemBuilder: (context, index) {
                        final currentItemAssociationList = listAllAss[index];

                        return GestureDetector(
                          onTap: () {
                            // print("${currentItemAssociationList.urlcode!}");

                            handleChangeAss(
                                currentItemAssociationList["urlcode"]!);
                          },
                          child: Column(
                            children: [
                              widgetListAssCard(
                                urlcodeAss:
                                    currentItemAssociationList["urlcode"],
                                nomAssociation:
                                    currentItemAssociationList["name"],
                                nbreEventPending: 5,
                                phofilAssociation:
                                    "${Variables.LienAIP}${currentItemAssociationList["profile_photo"] == null ? "" : currentItemAssociationList["profile_photo"]}",
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<UserGroupCubit, UserGroupState>(
                builder: (UserGroupContext, UserGroupState) {
              if (UserGroupState.isLoading == null ||
                  UserGroupState.isLoading == true)
                  
                return Container(
                  color: Color.fromARGB(91, 0, 0, 0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
                
              return Container();
            }),
          ],
        );
      },
    );
  }

  void showBottomSheetListTournoi(
      BuildContext context, List currentInfoAssociationCourant) {
    // .state.userGroupDefault
    Color? colorSelect(tournois_code) {
      if (tournois_code == AppCubitStorage().state.codeTournois) {
        return Color.fromRGBO(0, 162, 255, 0.915);
      } else {
        return Color.fromARGB(23, 20, 45, 99);
      }
      // Aucune correspondance trouvée, retourne null.
      return null;
    }

    Color? colorSelectText(tournois_code) {
      if (tournois_code == AppCubitStorage().state.codeTournois) {
        return Colors.white;
      } else {
        return Color.fromARGB(139, 20, 45, 99);
      }
      // Aucune correspondance trouvée, retourne null.
      return null;
    }

    Future handleChangeTournoi(codeTournoi) async {
      final allCotisationAss = await context
          .read<DetailTournoiCourantCubit>()
          .changeTournoiCubit(
              codeTournoi, AppCubitStorage().state.codeAssDefaul);

      await AppCubitStorage().updateCodeTournoisDefault(codeTournoi);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
        (route) => false,
      );

      print(
          "2222222222222222222222222222222222222222é ${AppCubitStorage().state.codeAssDefaul}");

      if (allCotisationAss != null) {
        print("objec~~~~~~~~ttt  ${allCotisationAss}");
        print(
            "éé22222~~~~~~~~  ${context.read<DetailTournoiCourantCubit>().state.changeTournoi}");
      } else {
        print("userGroupDefault null");
      }
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 10),
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(7),
              topLeft: Radius.circular(7),
            ),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 55,
                decoration: BoxDecoration(
                    // if (item["tournois_code"] == AppCubitStorage().state.codeTournois)
                    color: Color.fromARGB(255, 20, 45, 99),
                    borderRadius: BorderRadius.circular(50)),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "vos_tournois".tr(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 20, 45, 99),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: currentInfoAssociationCourant.length,
                  itemBuilder: (context, index) {
                    final currentItemAssociationList =
                        currentInfoAssociationCourant[index];
                    print(
                        "aaaaaaaaaaaaaaaaaaaaaaaa ${currentInfoAssociationCourant[index]}");

                    return GestureDetector(
                      onTap: () {
                        handleChangeTournoi(
                            currentItemAssociationList["tournois_code"]);
                      },
                      child: Container(
                        // margin: EdgeInsets.only(bottom: 10, right: 5, left: 5),
                        // padding: EdgeInsets.all(10),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 15, bottom: 15, left: 15),
                          decoration: BoxDecoration(
                            color: colorSelect(
                                currentItemAssociationList["tournois_code"]),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          margin: EdgeInsets.all(5),
                          child: Text(
                            '${"tournoi".tr()} #${currentItemAssociationList["matricule"]}',
                            style: TextStyle(
                                color: colorSelectText(
                                    currentItemAssociationList[
                                        "tournois_code"]),
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void showBottomSheetHistTontine(BuildContext context, _tabController) {
    final currentDetailCotisation =
        context.read<CotisationDetailCubit>().state.detailCotisation;

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          // height: 500,
          padding: EdgeInsets.only(top: 10),
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(7),
              topLeft: Radius.circular(7),
            ),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 55,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 20, 45, 99),
                    borderRadius: BorderRadius.circular(50)),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Historique de la tontine",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(164, 20, 45, 99),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    color: Color.fromARGB(120, 226, 226, 226),
                    alignment: Alignment.center,
                    child: TabBar(
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
                      // indicatorWeight: 0,
                      controller: _tabController,
                      tabs: [
                        Tab(
                          child: Row(
                            children: [
                              Container(
                                child: Text("Tontiné"),
                              ),
                              BlocBuilder<CotisationDetailCubit,
                                  CotisationDetailState>(
                                builder: (context, state) {
                                  if (state.isLoading == null ||
                                      state.isLoading == true)
                                    return Container(
                                      width: 10,
                                      height: 10,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 0.3,
                                        ),
                                      ),
                                    );

                                  final okayTontine = context
                                      .read<CotisationDetailCubit>()
                                      .state
                                      .detailCotisation!["versements"];
                                  return Container(
                                    child: Text(
                                      " (${okayTontine.length})",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            children: [
                              Container(
                                child: Text("Non tontiné"),
                              ),
                              BlocBuilder<CotisationDetailCubit,
                                  CotisationDetailState>(
                                builder: (context, state) {
                                  if (state.isLoading == null ||
                                      state.isLoading == true)
                                    return Container(
                                      // color: Colors.white,
                                      // margin: EdgeInsets.only(top: 15),
                                      width: 10,
                                      height: 10,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 0.3,
                                        ),
                                      ),
                                    );
                                  final nonTontine = context
                                      .read<CotisationDetailCubit>()
                                      .state
                                      .detailCotisation!["members"];
                                  return Container(
                                    child: Text(
                                      " (${nonTontine.length})",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
                  builder: (context, state) {
                if (state.isLoading == null || state.isLoading == true)
                  return Container(
                    // color: Colors.white,
                    margin: EdgeInsets.only(top: 15),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                final nonTontine = context
                    .read<CotisationDetailCubit>()
                    .state
                    .detailCotisation!["members"];

                final okayTontine = context
                    .read<CotisationDetailCubit>()
                    .state
                    .detailCotisation!["versements"];
                return Expanded(
                  child: Container(
                    color: Color.fromARGB(120, 226, 226, 226),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          itemCount: okayTontine.length,
                          itemBuilder: (context, index) {
                            final currentDetailPersonCotis = okayTontine[index];
                            return Container(
                              child: widgetHistoriqueTontineCard(
                                date: AppCubitStorage().state.Language == "fr"
                                    ? formatDateToFrench(
                                        currentDetailPersonCotis["updated_at"])
                                    : formatDateToEnglish(
                                        currentDetailPersonCotis["updated_at"]),
                                imageProfil: currentDetailPersonCotis[
                                            "photo_profil"] ==
                                        null
                                    ? ""
                                    : currentDetailPersonCotis["photo_profil"],
                                is_versement_finished:
                                    currentDetailPersonCotis["versement"][0]
                                        ["is_versement_finished"],
                                montantVersee:
                                    currentDetailPersonCotis["versement"][0]
                                        ["balance_after"],
                                nom: currentDetailPersonCotis["first_name"] ==
                                        null
                                    ? ""
                                    : currentDetailPersonCotis["first_name"],
                                prenom: currentDetailPersonCotis["last_name"] ==
                                        null
                                    ? ""
                                    : currentDetailPersonCotis["last_name"],
                              ),
                              margin: EdgeInsets.only(
                                  top: 3, bottom: 7, left: 10, right: 10),
                            );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          itemCount: nonTontine.length,
                          itemBuilder: (context, index) {
                            final currentDetailPersonNonCotis =
                                nonTontine![index];
                            return Container(
                              margin: EdgeInsets.only(
                                  top: 3, bottom: 7, left: 10, right: 10),
                              child: widgetHistoriqueTontineCard(
                                date: AppCubitStorage().state.Language == "fr"
                                    ? formatDateToFrench(
                                        currentDetailPersonNonCotis[
                                            "updated_at"])
                                    : formatDateToEnglish(
                                        currentDetailPersonNonCotis[
                                            "updated_at"]),
                                imageProfil:
                                    currentDetailPersonNonCotis["membre"]
                                                ["photo_profil"] ==
                                            null
                                        ? ""
                                        : currentDetailPersonNonCotis["membre"]
                                            ["photo_profil"],
                                is_versement_finished:
                                    currentDetailPersonNonCotis["membre"]
                                                    ["versement"]
                                                .length ==
                                            0
                                        ? 0
                                        : currentDetailPersonNonCotis["membre"]
                                                ["versement"][0]
                                            ["is_versement_finished"],
                                montantVersee:
                                    currentDetailPersonNonCotis["membre"]
                                                    ["versement"]
                                                .length ==
                                            0
                                        ? "0"
                                        : currentDetailPersonNonCotis["membre"]
                                            ["versement"][0]["balance_after"],
                                nom: currentDetailPersonNonCotis["membre"]
                                            ["first_name"] ==
                                        null
                                    ? ""
                                    : currentDetailPersonNonCotis["membre"]
                                        ["first_name"],
                                prenom: currentDetailPersonNonCotis["membre"]
                                            ["last_name"] ==
                                        null
                                    ? ""
                                    : currentDetailPersonNonCotis["membre"]
                                        ["last_name"],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        );
      },
    );
  }

  void showModalTransactionByEvent(context, versement, montantAPayer) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.only(top: 0),
        title: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Text(
                "liste_de_vos_transactions".tr(),
                style: TextStyle(
                  color: Color.fromARGB(255, 20, 45, 99),
                ),
              ),
              padding: EdgeInsets.only(top: 15),
            ),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 15, bottom: 10, left: 2, right: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  width: 0.5,
                  color: Color.fromARGB(255, 20, 45, 99),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "a_payer".tr(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            // color: Color.fromARGB(255, 20, 45, 99),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${formatMontantFrancais(double.parse(montantAPayer))} FCFA",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 20, 45, 99),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "déjà_payé".tr(),
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.green,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${formatMontantFrancais(double.parse(versement.length > 0 ? versement[0]["balance_after"] : "0"))} FCFA",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "reste".tr(),
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${formatMontantFrancais(double.parse(versement.length > 0 ? versement[0]["balance_remaining"] : "0"))} FCFA",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        content: versement.length > 0
            ? Container(
                // color: Colors.white,
                color: Color.fromARGB(120, 226, 226, 226),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // padding: EdgeInsets.only(top: 10),
                // margin: EdgeInsets.only(bottom: 1, left: 1, right: 1),
                child: Container(
                  margin: EdgeInsets.only(top: 7, right: 5, left: 5),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: versement[0]["transanctions"].length,
                          itemBuilder: (context, index) {
                            final detailVersement =
                                versement[0]["transanctions"][index];
                            return Container(
                                child: widgetListTransactionByEventCard(
                              date: AppCubitStorage().state.Language == "fr"
                                  ? formatDateToFrench(
                                      detailVersement["created_at"])
                                  : formatDateToEnglish(
                                      detailVersement["created_at"]),
                              //  formatDateString(
                              // detailVersement["created_at"]),
                              montant: detailVersement["amount"],
                            ));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container(
                child: Center(
                  child: Text("aucune_transaction".tr()),
                ),
              ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              'fermer'.tr(),
              style: TextStyle(color: Color.fromARGB(255, 20, 45, 99)),
            ),
          ),
        ],
      ),
    );
  }

  void showModalAllTransactionCotisation(context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.only(top: 0),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Text(
                'les_transactions_sur_la_cotisation'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 20, 45, 99),
                ),
              ),
              padding: EdgeInsets.only(top: 15),
            ),
          ],
        ),
        content: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(120, 226, 226, 226),
          // padding: EdgeInsets.only(top: 10),
          // margin: EdgeInsets.only(bottom: 1, left: 1, right: 1),
          child: Container(
            padding: EdgeInsets.only(top: 7),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: widgetListTransactionCotisationAllCard(),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              'fermer'.tr(),
              style: TextStyle(color: Color.fromARGB(255, 20, 45, 99)),
            ),
          ),
        ],
      ),
    );
  }

  void showModalPersonSanctionner(context, var listSanction) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.only(top: 0),
        title: Container(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          alignment: Alignment.center,
          child: Text(
            'les_personnes_sanctionnées'.tr(),
            style: TextStyle(
              color: Color.fromARGB(255, 20, 45, 99),
            ),
          ),
        ),
        content: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.only(top: 10),
          color: Color.fromARGB(120, 226, 226, 226),
          padding: EdgeInsets.only(top: 5),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: listSanction.length,
                  itemBuilder: (context, index) {
                    final itemLListSanction = listSanction[index];

                    print("@@@@@@@@@@@@@ ${itemLListSanction}");
                    return Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: WidgetPersonSanctionner(
                          motif: itemLListSanction["motif"],
                          nom: itemLListSanction["membre"]["first_name"] == null
                              ? ""
                              : itemLListSanction["membre"]["first_name"],
                          outilSanction: itemLListSanction["amount"]
                                      .toString() ==
                                  "null"
                              ? itemLListSanction["libelle"]
                              : "${formatMontantFrancais(double.parse(itemLListSanction["amount"].toString()))} FCFA",
                          photoProfil: itemLListSanction["membre"]
                                      ["photo_profil"] ==
                                  null
                              ? ""
                              : itemLListSanction["membre"]["photo_profil"],
                          prenom:
                              itemLListSanction["membre"]["last_name"] == null
                                  ? ""
                                  : itemLListSanction["membre"]["last_name"],
                        ));
                  },
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              'fermer'.tr(),
              style: TextStyle(color: Color.fromARGB(255, 20, 45, 99)),
            ),
          ),
        ],
      ),
    );
  }

  void showModalPersonPresent(
      context, tabController, var listAbs, var listPrsent) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.only(top: 0),
        title: Container(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          alignment: Alignment.center,
          child: Text(
            'liste_de_presence'.tr(),
            style: TextStyle(
              color: Color.fromARGB(255, 20, 45, 99),
            ),
          ),
        ),
        content: Container(
          child: Column(
            children: [
              Container(
                color: Color.fromARGB(120, 226, 226, 226),
                alignment: Alignment.center,
                child: TabBar(
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
                  // indicatorWeight: 0,
                  controller: tabController,
                  tabs: [
                    Tab(
                      child: Row(
                        children: [
                          Container(
                            child: Text("présents".tr()),
                          ),
                          Container(
                            child: Text(
                              "(${listPrsent.length})",
                              style: TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Container(
                            child: Text("absents".tr()),
                          ),
                          Container(
                            child: Text(
                              "(${listAbs.length})",
                              style: TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(120, 226, 226, 226),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                      top: 2,
                      bottom: 3,
                      left: 5,
                      right: 5,
                    ),
                    margin: EdgeInsets.only(
                      top: 2,
                      left: 5,
                      right: 5,
                    ),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          itemCount: listPrsent.length,
                          itemBuilder: (context, index) {
                            final currentListPrsent = listPrsent[index];
                            return Container(
                              padding: EdgeInsets.all(5),
                              child: widgetListPresenceCard(
                                imageProfil:
                                    currentListPrsent["photo_profil"] == null
                                        ? ""
                                        : currentListPrsent['photo_profil'],
                                nom: currentListPrsent['first_name'] == null
                                    ? ""
                                    : currentListPrsent['first_name'],
                                prenom: currentListPrsent['last_name'] == null
                                    ? ""
                                    : currentListPrsent['last_name'],
                                presence: '1',
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          itemCount: listAbs.length,
                          itemBuilder: (context, index) {
                            final currentListAbs = listAbs[index];

                            return Container(
                              padding: EdgeInsets.all(5),
                              child: widgetListPresenceCard(
                                imageProfil:
                                    currentListAbs["photo_profil"] == null
                                        ? ""
                                        : currentListAbs['photo_profil'],
                                nom: currentListAbs['first_name'] == null
                                    ? " "
                                    : currentListAbs['first_name'],
                                prenom: currentListAbs['last_name'] == null
                                    ? " "
                                    : currentListAbs['last_name'],
                                presence: '0',
                              ),
                            );
                          },
                        ),
                        //  Text("2"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              'fermer'.tr(),
              style: TextStyle(color: Color.fromARGB(255, 20, 45, 99)),
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheetEditProfilPhoto(BuildContext context, key, _pickImage) {
    TextEditingController infoUserController = TextEditingController();
    Future<void> handleDetailUser(userCode) async {
      final allCotisationAss =
          await context.read<AuthCubit>().detailAuthCubit(userCode);

      if (allCotisationAss != null) {
        print("objec===============ttt  ${allCotisationAss}");
      } else {
        print("userGroupDefault null");
      }
    }

    Future<void> handleUpdateInfoUser(
        key, value, partner_urlcode, membre_code) async {
      final allCotisationAss = await context
          .read<AuthUpdateCubit>()
          .UpdateInfoUserCubit(key, value, partner_urlcode, membre_code);

      if (allCotisationAss != null) {
        print("objec===============ttt  ${allCotisationAss}");
        print(
            "éé22==============ssssssssssssssssssssssssss=222  ${context.read<AuthCubit>().state.detailUser}");
      } else {
        print("userGroupDefault null");
      }
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // isScrollControlled: true,
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 5,
                    width: 55,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 20, 45, 99),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pickImage;
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      padding: EdgeInsets.only(left: 25),
                      // height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Color.fromARGB(15, 20, 45, 99),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            color: Color.fromARGB(255, 20, 45, 99),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Camera",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 20, 45, 99),
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    padding: EdgeInsets.only(left: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color.fromARGB(15, 20, 45, 99),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Color.fromARGB(255, 20, 45, 99),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Galerie",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 20, 45, 99),
                                fontWeight: FontWeight.w400),
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
      },
    );
  }

  void showBottomSheetEditProfil(BuildContext context, hintText, key) {
    TextEditingController infoUserController = TextEditingController();
    Future<void> handleDetailUser(userCode) async {
      final allCotisationAss =
          await context.read<AuthCubit>().detailAuthCubit(userCode);

      if (allCotisationAss != null) {
        print("objec===============ttt  ${allCotisationAss}");
      } else {
        print("userGroupDefault null");
      }
    }

    Future<void> handleUpdateInfoUser(
        key, value, partner_urlcode, membre_code) async {
      final allCotisationAss = await context
          .read<AuthUpdateCubit>()
          .UpdateInfoUserCubit(key, value, partner_urlcode, membre_code);

      if (allCotisationAss != null) {
        print("objec===============ttt  ${allCotisationAss}");
        print(
            "éé22==============ssssssssssssssssssssssssss=222  ${context.read<AuthCubit>().state.detailUser}");
      } else {
        print("userGroupDefault null");
      }
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // isScrollControlled: true,
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 5,
                    width: 55,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 20, 45, 99),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "entrer_la_nouvelle_valeur".tr(),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(164, 20, 45, 99),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    padding: EdgeInsets.only(left: 15),
                    // height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color.fromARGB(15, 20, 45, 99),
                    ),
                    child: TextField(
                      controller: infoUserController,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "${hintText}",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      handleUpdateInfoUser(
                          key,
                          infoUserController.text,
                          AppCubitStorage().state.codeAssDefaul,
                          AppCubitStorage().state.membreCode);
                      handleDetailUser(AppCubitStorage().state.membreCode);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                          top: 10,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        "confirmer".tr(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showModalActionPayement(BuildContext context, msg, lienDePaiement) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(3),
        contentPadding: EdgeInsets.only(top: 0),
        title: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                'effectuer_le_paiement'.tr(),
                style: TextStyle(
                  color: Color.fromARGB(255, 185, 200, 233),
                ),
              ),
              padding: EdgeInsets.only(top: 15),
            ),
          ],
        ),
        content: Container(
          // color: Color.fromARGB(120, 226, 226, 226),
          // width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 73,
          margin: EdgeInsets.only(top: 7, right: 5, left: 5, bottom: 22),
          // color: const Color.fromARGB(255, 255, 2, 2),

          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.pop(
                    context,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaiementPage(
                        lienDePaiement: lienDePaiement,
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 11),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 162, 255, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "payer_vous_même".tr(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                  Share.share("${msg}");
                },
                child: Container(
                  alignment: Alignment.center,

                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color.fromRGBO(0, 162, 255, 1),
                      )),
                  // height: 20,
                  child: Text(
                    "partager_le_lien_de_paiement".tr(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 162, 255, 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class widgetListPresenceCard extends StatelessWidget {
  widgetListPresenceCard({
    required this.nom,
    required this.prenom,
    required this.presence,
    required this.imageProfil,
    super.key,
  });
  String nom;

  String prenom;

  String presence;

  String imageProfil;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Color.fromARGB(34, 20, 45, 99),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 25,
              height: 25,
              child: Image.network(
                "${Variables.LienAIP}${imageProfil}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Container(
                child: Text(
                  "${nom} ${prenom}",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 20, 45, 99),
                  ),
                ),
              ),
            ),
          ),
          presence == "0"
              ? Container(
                  padding: EdgeInsets.all(3),
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 14,
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(3),
                  child: Icon(
                    Icons.check,
                    color: Color.fromARGB(255, 0, 126, 4),
                    size: 14,
                  ),
                ),
        ],
      ),
    );
  }
}

class WidgetPersonSanctionner extends StatelessWidget {
  WidgetPersonSanctionner({
    required this.photoProfil,
    required this.nom,
    required this.prenom,
    required this.outilSanction,
    required this.motif,
    super.key,
  });
  String photoProfil;
  String nom;
  String prenom;
  String outilSanction;
  String motif;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.only(top: 2, bottom: 5, left: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Color.fromARGB(88, 20, 45, 99),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 40,
                height: 40,
                child: Image.network(
                  '${Variables.LienAIP}${photoProfil}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                // color: Colors.blueGrey,
                // alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "${nom} ${prenom}",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 20, 45, 99),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Text(
                        "${motif}",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(164, 20, 45, 99)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Row(
                        children: [
                          Text(
                            "${outilSanction}",
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(113, 244, 67, 54),
                            ),
                          ),
                        ],
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
  }
}
