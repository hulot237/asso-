import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetListTransactionCotisationAllCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/contribution_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetHistoriqueTontineCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/tournoi_model.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_update_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/homePage.dart';
import 'package:faroty_association_1/pages/paiementPage.dart';
import 'package:faroty_association_1/widget/widgetListAssCard.dart';
import 'package:faroty_association_1/widget/widgetListTransactionByEventCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class Modal {
  void showBottomSheetListAss(BuildContext context, List? listAllAss) {
    bool isLoading = false;

    Future handleChangeAss(codeAss) async {
      final ChangeAss =
          await context.read<UserGroupCubit>().ChangeAssCubit(codeAss);

      await AppCubitStorage().updateCodeAssDefaul(codeAss);

      await AppCubitStorage().updatemembreCode(
        context
            .read<UserGroupCubit>()
            .state
            .changeAssData!
            .membre!
            .membre_code!,
        // .ChangeAssData!["membre"]["membre_code"],
      );

      await AppCubitStorage().updateCodeTournoisDefault(context
          .read<UserGroupCubit>()
          .state
          .changeAssData!
          .user_group!
          .tournois![0]
          .tournois_code!);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
        (route) => false,
      );
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
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
                          color: AppColors.blackBlue,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "vos_associations".tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.blackBlueAccent1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listAllAss!.length,
                        itemBuilder: (context, index) {
                          final currentItemAssociationList = listAllAss[index];

                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });

                              await handleChangeAss(
                                  currentItemAssociationList["urlcode"]!);

                              setState(() {
                                isLoading = false;
                              });
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
                  return Center(
                    child: EasyLoader(
                      backgroundColor: Color.fromARGB(0, 255, 255, 255),
                      iconSize: 50,
                      iconColor: AppColors.blackBlueAccent1,
                      image: AssetImage(
                        'assets/images/Groupe_ou_Asso.png',
                      ),
                    ),
                  );

                return isLoading
                    ? Center(
                        child: EasyLoader(
                          backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          iconSize: 50,
                          iconColor: AppColors.blackBlueAccent1,
                          image: AssetImage(
                            'assets/images/Groupe_ou_Asso.png',
                          ),
                        ),
                      )
                    : Container();
              }),
            ],
          );
        });
      },
    );
  }

  void showBottomSheetListTournoi(
      BuildContext context, List<TournoiModel>? currentInfoAssociationCourant) {
    // .state.userGroupDefault
    Color? colorSelect(tournois_code) {
      if (tournois_code == AppCubitStorage().state.codeTournois) {
        return AppColors.colorButton;
      } else {
        return Color.fromARGB(23, 20, 45, 99);
      }
      // Aucune correspondance trouvée, retourne null.
      // return null;
    }

    Color? colorSelectText(tournois_code) {
      if (tournois_code == AppCubitStorage().state.codeTournois) {
        return AppColors.white;
      } else {
        return Color.fromARGB(139, 20, 45, 99);
      }
      // Aucune correspondance trouvée, retourne null.
      // return null;
    }

    bool isLoading = false;

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

      if (allCotisationAss != null) {
      } else {
        print("userGroupDefault null");
      }
    }

    showModalBottomSheet(
      barrierColor: AppColors.barrierColorModal,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
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
                          // if (item["tournois_code"] == AppCubitStorage().state.codeTournois)
                          color: AppColors.blackBlue,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "vos_tournois".tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.blackBlue,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: currentInfoAssociationCourant!.length,
                        itemBuilder: (context, index) {
                          final currentItemAssociationList =
                              currentInfoAssociationCourant[index];
                          print(
                              "aaaaaaaaaaaaaaaaaaaaaaaa ${currentInfoAssociationCourant[index]}");

                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await handleChangeTournoi(
                                  currentItemAssociationList.tournois_code);
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: Container(
                              // margin: EdgeInsets.only(bottom: 10, right: 5, left: 5),
                              // padding: EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 15, bottom: 15, left: 15),
                                decoration: BoxDecoration(
                                  color: colorSelect(
                                      currentItemAssociationList.tournois_code),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  '${"tournoi".tr()} #${currentItemAssociationList.matricule}',
                                  style: TextStyle(
                                      color: colorSelectText(
                                          currentItemAssociationList
                                              .tournois_code),
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
              ),
              BlocBuilder<DetailTournoiCourantCubit, DetailTournoiCourantState>(
                  builder:
                      (DetailTournoiCouranContext, DetailTournoiCouranState) {
                if (DetailTournoiCouranState.isLoading == null ||
                    DetailTournoiCouranState.isLoading == true)
                  return Center(
                    child: EasyLoader(
                      backgroundColor: Color.fromARGB(0, 255, 255, 255),
                      iconSize: 50,
                      iconColor: AppColors.blackBlueAccent1,
                      image: AssetImage(
                        'assets/images/Groupe_ou_Asso.png',
                      ),
                    ),
                  );

                return isLoading
                    ? Center(
                        child: EasyLoader(
                          backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          iconSize: 50,
                          iconColor: AppColors.blackBlueAccent1,
                          image: AssetImage(
                            'assets/images/Groupe_ou_Asso.png',
                          ),
                        ),
                      )
                    : Container();
              }),
            ],
          );
        });
      },
    );
  }

  void showBottomSheetHistTontine(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.barrierColorModal,
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
                    color: AppColors.blackBlue,
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
                        color: AppColors.blackBlueAccent1,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    color: AppColors.blackBlueAccent2,
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Contributions ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.blackBlue,
                            ),
                          ),
                        ),
                        BlocBuilder<DetailContributionCubit, ContributionState>(
                          builder: (DetailContributionContext,
                              DetailContributionState) {
                            if (DetailContributionState
                                        .isLoadingContibutionTontine ==
                                    null ||
                                DetailContributionState
                                        .isLoadingContibutionTontine ==
                                    true)
                              return Container(
                                width: 10,
                                height: 10,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.bleuLight,
                                    strokeWidth: 0.3,
                                  ),
                                ),
                              );

                            final okayTontine = DetailContributionContext.read<
                                    DetailContributionCubit>()
                                .state
                                .detailContributionTontine!["versements"];
                            final nonTontine = DetailContributionContext.read<
                                    DetailContributionCubit>()
                                .state
                                .detailContributionTontine!["members"];
                            return Container(
                              child: Text(
                                "(${okayTontine.length}/${nonTontine.length + okayTontine.length})",
                                style: TextStyle(
                                    fontSize: 10, color: AppColors.blackBlue),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              BlocBuilder<DetailContributionCubit, ContributionState>(builder:
                  (DetailContributionContext, DetailContributionState) {
                if (DetailContributionState.isLoadingContibutionTontine ==
                        null ||
                    DetailContributionState.isLoadingContibutionTontine == true)
                  return Expanded(
                    child: Center(
                      child: Container(
                        child: EasyLoader(
                          backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          iconSize: 50,
                          iconColor: AppColors.blackBlueAccent1,
                          image: AssetImage(
                            'assets/images/Groupe_ou_Asso.png',
                          ),
                        ),
                      ),
                    ),
                  );
                final nonTontine =
                    DetailContributionContext.read<DetailContributionCubit>()
                        .state
                        .detailContributionTontine!["members"];

                final okayTontine =
                    DetailContributionContext.read<DetailContributionCubit>()
                        .state
                        .detailContributionTontine!["versements"];

                List listeOkayTontine = okayTontine;
                List listeNonTontine = nonTontine;

                List<Widget> listWidgetOkayTontine =
                    listeOkayTontine.map((monObjet) {
                  return Card(
                    margin:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: widgetHistoriqueTontineCard(
                      date: formatDateLiteral(monObjet["updated_at"]),
                      imageProfil: monObjet["photo_profil"] == null
                          ? ""
                          : monObjet["photo_profil"],
                      is_versement_finished: monObjet["versements"][0]
                          ["is_versement_finished"],
                      montantVersee: monObjet["versements"][0]["balance_after"],
                      nom: monObjet["membre"]["first_name"] == null
                          ? ""
                          : monObjet["membre"]["first_name"],
                      prenom: monObjet["membre"]["last_name"] == null
                          ? ""
                          : monObjet["membre"]["last_name"],
                    ),
                  );
                }).toList();

                List<Widget> listWidgetNonTontine =
                    listeNonTontine.map((monObj) {
                  return Card(
                    margin:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: widgetHistoriqueTontineCard(
                      date: AppCubitStorage().state.Language == "fr"
                          ? formatDateToFrench(monObj["updated_at"])
                          : formatDateToEnglish(monObj["updated_at"]),
                      imageProfil: monObj["membre"]["photo_profil"] == null
                          ? ""
                          : monObj["membre"]["photo_profil"],
                      is_versement_finished: monObj["versements"].length == 0
                          ? 0
                          : monObj["versements"][0]["is_versement_finished"],
                      montantVersee: monObj["versements"].length == 0
                          ? "0"
                          : monObj["versements"][0]["balance_after"],
                      nom: monObj["membre"]["first_name"] == null
                          ? ""
                          : monObj["membre"]["first_name"],
                      prenom: monObj["membre"]["last_name"] == null
                          ? ""
                          : monObj["membre"]["last_name"],
                    ),
                  );
                }).toList();

                final listeFinale = [
                  ...listWidgetOkayTontine,
                  ...listWidgetNonTontine
                ];

                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: listeFinale,
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

  void showBottomSheetHistCotisation(
      BuildContext context,
      codeCotisation,
      lienDePaiement,
      dateCotisation,
      heureCotisation,
      montantCotisations,
      motifCotisations,
      soldeCotisation,
      type,
      is_passed,
      isPayed) {
    Future<void> handleDetailCotisation(codeCotisation) async {
      final detailCotisation = await context
          .read<CotisationDetailCubit>()
          .detailCotisationCubit(codeCotisation);
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.barrierColorModal,
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
                    color: AppColors.blackBlue,
                    borderRadius: BorderRadius.circular(50)),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Historique de la cotisation".tr(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.blackBlueAccent1,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    color: AppColors.blackBlueAccent2,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Contributions ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.blackBlue,
                                ),
                              ),
                            ),
                            BlocBuilder<CotisationDetailCubit,
                                CotisationDetailState>(
                              builder: (detailCotisationContext,
                                  detailCotisationState) {
                                if (detailCotisationState.detailCotisation ==
                                        null ||
                                    detailCotisationState.isLoading == true)
                                  return Container(
                                    width: 10,
                                    height: 10,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.bleuLight,
                                        strokeWidth: 0.3,
                                      ),
                                    ),
                                  );

                                final okayTontine = detailCotisationContext
                                    .read<CotisationDetailCubit>()
                                    .state
                                    .detailCotisation!["versements"];
                                final nonTontine = detailCotisationContext
                                    .read<CotisationDetailCubit>()
                                    .state
                                    .detailCotisation!["members"];
                                return Container(
                                  child: Text(
                                    "(${okayTontine.length}/${nonTontine.length + okayTontine.length})",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.blackBlue),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                        BlocBuilder<CotisationDetailCubit,
                                CotisationDetailState>(
                            builder: (detailCotisationContext,
                                detailCotisationState) {
                          if (detailCotisationState.detailCotisation == null ||
                              detailCotisationState.isLoading == true)
                            return Container(
                              padding: EdgeInsets.all(10),
                              width: 10,
                              height: 10,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.bleuLight,
                                  strokeWidth: 0.3,
                                ),
                              ),
                            );
                          return GestureDetector(
                              onTap: () {
                                handleDetailCotisation(codeCotisation);

                                Navigator.pop(context);
                                
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailCotisationPage(
                                      codeCotisation: codeCotisation,
                                      lienDePaiement: lienDePaiement,
                                      dateCotisation: dateCotisation,
                                      heureCotisation: heureCotisation,
                                      montantCotisations: montantCotisations,
                                      motifCotisations: motifCotisations,
                                      soldeCotisation: soldeCotisation,
                                      type: type,
                                      isPassed: is_passed,
                                      isPayed: isPayed,
                                    ),
                                  ),
                                );

                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.info_outline,
                                  color: AppColors.blackBlue,
                                  size: 18,
                                ),
                              ));
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
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
                  List listeNonCotisation = currentDetailCotisation["members"];

                  List<Widget> listWidgetOkayCotis =
                      listeOkayCotisation.map((monObjet) {
                    return Card(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: widgetHistoriqueTontineCard(
                        date: formatDateLiteral(monObjet["updated_at"]),
                        imageProfil: monObjet["photo_profil"] == null
                            ? ""
                            : monObjet["photo_profil"],
                        is_versement_finished: monObjet["versement"][0]
                            ["is_versement_finished"],
                        montantVersee: monObjet["versement"].length == 0
                            ? "0"
                            : monObjet["versement"][0]["balance_after"],
                        nom: monObjet["first_name"] == null
                            ? ""
                            : monObjet["first_name"],
                        prenom: monObjet["last_name"] == null
                            ? ""
                            : monObjet["last_name"],
                      ),
                    );
                  }).toList();

                  List<Widget> listWidgetNonCotis =
                      listeNonCotisation.map((monObj) {
                    return Card(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: widgetHistoriqueTontineCard(
                        date: AppCubitStorage().state.Language == "fr"
                            ? formatDateToFrench(monObj["updated_at"])
                            : formatDateToEnglish(monObj["updated_at"]),
                        imageProfil: monObj["membre"]["photo_profil"] == null
                            ? ""
                            : monObj["membre"]["photo_profil"],
                        is_versement_finished:
                            monObj["membre"]["versement"].length == 0
                                ? 0
                                : monObj["membre"]["versement"][0]
                                    ["is_versement_finished"],
                        montantVersee: monObj["membre"]["versement"].length == 0
                            ? "0"
                            : monObj["membre"]["versement"][0]["balance_after"],
                        nom: monObj["membre"]["first_name"] == null
                            ? ""
                            : monObj["membre"]["first_name"],
                        prenom: monObj["membre"]["last_name"] == null
                            ? ""
                            : monObj["membre"]["last_name"],
                      ),
                    );
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
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showModalTransactionByEvent(context, versement, montantAPayer) {
    showDialog<String>(
      context: context,
      barrierColor: AppColors.barrierColorModal,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.only(top: 0),
        content: Container(
          // padding: EdgeInsets.only(left: 20, right: 20),
          height: 450,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Text(
                      "liste_de_vos_transactions".tr(),
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.blackBlue,
                      ),
                    ),
                    padding: EdgeInsets.only(top: 15),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin:
                        EdgeInsets.only(top: 15, bottom: 10, left: 2, right: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        width: 0.5,
                        color: AppColors.blackBlue,
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
                                  // color: AppColors.blackBlue,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${formatMontantFrancais(double.parse(montantAPayer))} FCFA",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackBlue,
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
                                    color: AppColors.green,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${formatMontantFrancais(double.parse(versement.length > 0 ? versement[0]["balance_after"] : "0"))} FCFA",
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.green),
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
                                    color: AppColors.red,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${formatMontantFrancais(double.parse(versement.length > 0 ? versement[0]["balance_remaining"] : "0"))} FCFA",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              versement.length > 0
                  ? Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(120, 226, 226, 226),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 7, right: 5, left: 5, bottom: 7),
                          color: AppColors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      versement[0]["transanctions"].length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final detailVersement =
                                        versement[0]["transanctions"][index];
                                    return Container(
                                        child: widgetListTransactionByEventCard(
                                      date: formatDateLiteral(
                                          detailVersement["created_at"]),
                                      montant: detailVersement["amount"],
                                    ));
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      // height: 350,
                      child: Center(
                        child: Text("aucune_transaction".tr()),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void showModalAllTransactionCotisation(context) {
    showDialog<String>(
      barrierColor: AppColors.barrierColorModal,
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
                  color: AppColors.blackBlue,
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
              style: TextStyle(
                color: AppColors.blackBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showModalPersonSanctionner(context, var listSanction) {
    showDialog<String>(
      context: context,
      barrierColor: AppColors.barrierColorModal,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.only(top: 0),
        content: Container(
          height: 450,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          // height: 450,
          // width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.only(top: 10),
          // color: Color.fromARGB(120, 226, 226, 226),
          padding: EdgeInsets.only(top: 5),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                alignment: Alignment.center,
                child: Text(
                  'les_personnes_sanctionnées'.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.blackBlue,
                  ),
                ),
              ),
              Expanded(
                child: listSanction.length > 0
                    ? ListView.builder(
                        itemCount: listSanction.length,
                        itemBuilder: (context, index) {
                          final itemLListSanction = listSanction[index];

                          return Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: WidgetPersonSanctionner(
                              motif: itemLListSanction["motif"],
                              nom: itemLListSanction["membre"]["first_name"] ==
                                      null
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
                              prenom: itemLListSanction["membre"]
                                          ["last_name"] ==
                                      null
                                  ? ""
                                  : itemLListSanction["membre"]["last_name"],
                            ),
                          );
                        },
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 200),
                        alignment: Alignment.topCenter,
                        child: Text(
                          "aucune_sanction".tr(),
                          style: TextStyle(
                              color: Color.fromRGBO(20, 45, 99, 0.26),
                              fontWeight: FontWeight.w100,
                              fontSize: 20),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showModalPersonPresent(
    context,
    tabController,
    var listAbs,
    var listPrsent,
  ) {
    showDialog<String>(
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.only(top: 0),
        content: Container(
          height: 550,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                alignment: Alignment.center,
                child: Text(
                  'liste_de_presence'.tr(),
                  style: TextStyle(color: AppColors.blackBlue, fontSize: 18),
                ),
              ),
              Container(
                color: AppColors.blackBlueAccent2,
                child: TabBar(
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: AppColors.blackBlueAccent2,
                  ),
                  padding: EdgeInsets.only(bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: AppColors.white,
                    ),
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
                        listPrsent.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                itemCount: listPrsent.length,
                                itemBuilder: (context, index) {
                                  final currentListPrsent = listPrsent[index];
                                  return Container(
                                    padding: EdgeInsets.all(5),
                                    child: widgetListPresenceCard(
                                      imageProfil: currentListPrsent[
                                                  "photo_profil"] ==
                                              null
                                          ? ""
                                          : currentListPrsent['photo_profil'],
                                      nom: currentListPrsent['first_name'] ==
                                              null
                                          ? ""
                                          : currentListPrsent['first_name'],
                                      prenom:
                                          currentListPrsent['last_name'] == null
                                              ? ""
                                              : currentListPrsent['last_name'],
                                      presence: '1',
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.only(top: 100),
                                    alignment: Alignment.topCenter,
                                    child: Icon(
                                      Icons.playlist_remove,
                                      size: 100,
                                      color: Color.fromRGBO(20, 45, 99, 0.26),
                                    ),
                                  );
                                },
                              ),
                        listAbs.length > 0
                            ? ListView.builder(
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
                                      prenom:
                                          currentListAbs['last_name'] == null
                                              ? " "
                                              : currentListAbs['last_name'],
                                      presence: '0',
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.only(top: 100),
                                    alignment: Alignment.topCenter,
                                    child: Icon(
                                      Icons.playlist_add_check,
                                      size: 100,
                                      color: Color.fromRGBO(20, 45, 99, 0.26),
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
      ),
    );
  }

  void showBottomSheetEditProfilPhoto(BuildContext context, key, _pickImage) {
    TextEditingController infoUserController = TextEditingController();
    Future<void> handleDetailUser(userCode, codeTournoi) async {
      final allCotisationAss = await context
          .read<AuthCubit>()
          .detailAuthCubit(userCode, codeTournoi);


    }

    Future<void> handleUpdateInfoUser(
        key, value, partner_urlcode, membre_code) async {
      final allCotisationAss = await context
          .read<AuthUpdateCubit>()
          .UpdateInfoUserCubit(key, value, partner_urlcode, membre_code);

      if (allCotisationAss != null) {
      } else {
        print("userGroupDefault null");
      }
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // isScrollControlled: true,
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            color: AppColors.white,
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
                      color: AppColors.blackBlue,
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
                            color: AppColors.blackBlue,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Camera",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.blackBlue,
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
                          color: AppColors.blackBlue,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Galerie",
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.blackBlue,
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
    TextEditingController infoUserController =
        TextEditingController(text: "${hintText}");

    Future<void> handleDetailUser(userCode, codeTournoi) async {
      final allCotisationAss = await context
          .read<AuthCubit>()
          .detailAuthCubit(userCode, codeTournoi);

    }

    Future<void> handleUpdateInfoUser(
        key, value, partner_urlcode, membre_code) async {
      final allCotisationAss = await context
          .read<AuthUpdateCubit>()
          .UpdateInfoUserCubit(key, value, partner_urlcode, membre_code);

      if (allCotisationAss != null) {
      } else {
        print("userGroupDefault null");
      }
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.barrierColorModal,
      // isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: AppColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 5,
                    width: 55,
                    decoration: BoxDecoration(
                        color: AppColors.blackBlue,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "entrer_la_nouvelle_valeur".tr(),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackBlueAccent1,
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
                      autofocus: true,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await handleUpdateInfoUser(
                          key,
                          infoUserController.text,
                          AppCubitStorage().state.codeAssDefaul,
                          AppCubitStorage().state.membreCode);
                      await handleDetailUser(AppCubitStorage().state.membreCode,
                          AppCubitStorage().state.codeTournois);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                          top: 10,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      decoration: BoxDecoration(
                        color: AppColors.colorButton,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        "confirmer".tr(),
                        style: TextStyle(
                          color: AppColors.white,
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
      barrierColor: AppColors.barrierColorModal,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.only(top: 0),
        content: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 150,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  'effectuer_le_paiement'.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.blackBlue,
                  ),
                ),
                padding: EdgeInsets.only(top: 15),
              ),
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
                    color: AppColors.colorButton,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "payer_vous_même".tr(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
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
                        color: AppColors.colorButton,
                      )),
                  // height: 20,
                  child: Text(
                    "partager_le_lien_de_paiement".tr(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorButton,
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
                    color: AppColors.blackBlue,
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
                    color: AppColors.green,
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
      color: AppColors.white,
      padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.only(top: 2, bottom: 5, left: 5),
        decoration: BoxDecoration(
          color: AppColors.white,
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
                          color: AppColors.blackBlue,
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
                            color: AppColors.blackBlueAccent1),
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
