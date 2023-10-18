import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationExpireInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationExpireInProgress.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInFIxed.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotisationInProgress.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/WidgetSanctionNonPayeeIsOther.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionNonPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsMoney.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanctionPayeeIsOther.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetTontineHistoriqueCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/screens/detailTontinePage.dart';
import 'package:faroty_association_1/widget/WidgetActionAppBArChangeAss.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/presentation/widgets/widgetCompteCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({super.key});

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
  var tabs = [true, false, false, true, false, true];

  Future<void> handleAllCotisationAss(codeAssociation) async {
    final allCotisationAss = await context
        .read<CotisationCubit>()
        .AllCotisationAssCubit(codeAssociation);

    if (allCotisationAss != null) {
      print("objec~~~~~~~~ttt  ${allCotisationAss}");
      print(
          "éé22222~~~~~~~~  ${context.read<CotisationCubit>().state.allCotisationAss}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllCompteAss(codeAssociation) async {
    final allCotisationAss = await context
        .read<CompteCubit>().AllCompteAssCubit(codeAssociation);

    if (allCotisationAss != null) {
      print("obj}===}}}}ttt  ${allCotisationAss}");
      print(
          "éé22222~===}}}}}}}}}}  ${context.read<CompteCubit>().state.allCompteAss}");
    } else {
      print("userGroupDefault null");
    }
  }

  Map<String, dynamic>? get currentInfoAssociationCourant {
    return context.read<UserGroupCubit>().state.userGroupDefault;
  }

  Map<String, dynamic>? get currentDetailtournoiCourant {
    return context.read<DetailTournoiCourantCubit>().state.detailtournoiCourant;
  }

  Future<void> handleDetailUser(userCode) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode);

    if (allCotisationAss != null) {
      print("objec===============ttt  ${allCotisationAss}");
      print(
          "éé22===============222  ${context.read<AuthCubit>().state.detailUser}");
    } else {
      print("userGroupDefault null");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleAllCotisationAss(AppCubitStorage().state.codeAssDefaul);
    handleDetailUser(Variables.codeMembre);
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
  }

  @override
  Widget build(BuildContext context) {
    final currentAllCotisationAss =
        context.read<CotisationCubit>().state.allCotisationAss;
    final currentDetailUser = context.read<AuthCubit>().state.detailUser;
    final currentCompteAss =context.read<CompteCubit>().state.allCompteAss;

    return DefaultTabController(
      length: currentInfoAssociationCourant!['is_tontine'] ? 5 : 4,
      child: Scaffold(
        backgroundColor: Color(0xFFEFEFEF),
        appBar: AppBar(
          title: Text(
            "Historiques",
            style: TextStyle(fontSize: 16),
          ),
          actions: [WidgetActionAppBArChangeAss()],
          elevation: 0,
          backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
          leading: Icon(Icons.arrow_back),
          bottom: TabBar(
              isScrollable: true,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              unselectedLabelStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              padding: EdgeInsets.all(0),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 5.0,
                ),
                insets: EdgeInsets.symmetric(horizontal: 36.0),
              ),
              indicatorWeight: 0,
              tabs: [
                Tab(
                  text: "Rencontres",
                ),
                if (currentInfoAssociationCourant!['is_tontine'])
                  Tab(
                    text: "Tontines",
                  ),
                Tab(
                  text: "Cotisations",
                ),
                Tab(
                  text: "Sanctions",
                ),
                Tab(
                  text: "Comptes",
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 1.5,
                left: 1.5,
                // bottom: 10,
                right: 1.5,
              ),
              width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(
              //   color: Color.fromARGB(255, 226, 226, 226),
              // ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10, left: 5, bottom: 15),
                    child: Text(
                      "Toutes les rencontres",
                      style: TextStyle(
                        color: const Color.fromRGBO(20, 45, 99, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,

// for (var itemSeance in currentDetailtournoiCourant!["tournois"]
//                   ["seance"])
//                 if (itemSeance["status"] == 1)
//                   SliverPersistentHeader(
//                     pinned: false,
//                     floating: false,
//                     delegate: FixedHeaderBar(
//                       matriculeRencontre: itemSeance["matricule"],
//                       nomRecepteurRencontre: itemSeance["membre"]["first_name"],
//                       prenomRecepteurRencontre: itemSeance["membre"]
//                           ["last_name"],
//                       dateRencontre: itemSeance["date_seance"],
//                       // descriptionRencontre: itemSeance["zzzzzzzzzzzzzzz"],
//                       heureRencontre: itemSeance["heure_debut"],
//                       lieuRencontre: itemSeance["localisation"],
//                       maxExtent: 210,
//                       minExtent: 210,
//                     ),
//                   ),
                        itemCount: currentDetailtournoiCourant!["tournois"]
                                ["seance"]
                            .length,
                        itemBuilder: (context, index) {
                          final itemSeance =
                              currentDetailtournoiCourant!["tournois"]["seance"]
                                  [index];
                          return Container(
                            margin: EdgeInsets.only(
                                left: 7, right: 7, top: 3, bottom: 7),
                            child: WidgetRencontreCard(
                              codeSeance: itemSeance["seance_code"],
                              photoProfilRecepteur: itemSeance["membre"]
                                  ["photo_profil"],
                              dateRencontre:
                                  formatDate(itemSeance["date_seance"]),
                              descriptionRencontre:
                                  'Le rencontre du ${formatDate(itemSeance["date_seance"])} se tiendra à ${itemSeance["heure_debut"]}',
                              heureRencontre: itemSeance["heure_debut"],
                              identifiantRencontre: itemSeance["matricule"],
                              lieuRencontre: itemSeance["localisation"],
                              nomRecepteurRencontre: itemSeance["membre"]
                                  ["first_name"],
                              isActiveRencontre: itemSeance["status"],
                              prenomRecepteurRencontre:
                                  itemSeance["membre"]["last_name"] == null
                                      ? ""
                                      : itemSeance["membre"]["last_name"],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (currentInfoAssociationCourant!['is_tontine'])
              Container(
                padding: EdgeInsets.only(
                  top: 1.5,
                  left: 1.5,
                  // bottom: 10,
                  right: 1.5,
                ),
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //   color: Color.fromARGB(255, 226, 226, 226),
                // ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 10, left: 5, bottom: 15),
                      child: Text(
                        "Toutes vos tontines",
                        style: TextStyle(
                            color: const Color.fromRGBO(20, 45, 99, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 0.2),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: tabs.length,
                          itemBuilder: (context, index) {
                            // Vérifiez la valeur du booléen à l'index actuel
                            bool valeurBool = tabs[index];

                            if (valeurBool) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailTontinePage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 7, right: 7, top: 3, bottom: 7),
                                  child: widgetTontineHistoriqueCard(
                                    dateCreaTontine: '23/12/2023',
                                    montantTontine: '30000',
                                    nbrMembreTontine: '10',
                                    nomTontine: 'Tontine du bureau AMI',
                                    positionBeneficiaire: '2',
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              padding: EdgeInsets.only(
                top: 1.5,
                left: 1.5,
                // bottom: 10,
                right: 1.5,
              ),
              width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(
              //   color: Color.fromARGB(255, 226, 226, 226),
              // ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10, left: 5, bottom: 15),
                    child: Text(
                      "Toutes vos cotisations",
                      style: TextStyle(
                          color: const Color.fromRGBO(20, 45, 99, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: currentAllCotisationAss!.length,
                          itemBuilder: (context, index) {
                            // Vérifiez la valeur du booléen à l'index actuel
                            final currentDetail =
                                currentAllCotisationAss[index];

                            // bool valeurBool = tabs[index];

                            // final currentDetail =
                            //     currentDetailSeance!["cotisation"][index];

                            if (currentDetail["is_tontine"] == 0 &&
                                currentDetail["type"] == "0" &&
                                currentDetail["is_passed"] == 0) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 7, right: 7, top: 3, bottom: 7),
                                  child: WidgetCotisationInFixed(
                                    contributionOneUser: '2000',
                                    codeCotisation:
                                        currentDetail["cotisation_code"],
                                    heureCotisation:
                                        formatTime(currentDetail["start_date"]),
                                    dateCotisation:
                                        formatDate(currentDetail["start_date"]),
                                    montantCotisations: currentDetail["amount"],
                                    motifCotisations: currentDetail["name"],
                                    nbreParticipant: 5,
                                    soldeCotisation:
                                        currentDetail["cotisation_balance"],
                                    nbreParticipantCotisationOK: 4,

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
                                  codeCotisation:
                                      currentDetail["cotisation_code"],
                                  contributionOneUser: '2000',
                                  heureCotisation:
                                      formatTime(currentDetail["start_date"]),
                                  dateCotisation:
                                      formatDate(currentDetail["start_date"]),
                                  montantCotisations: currentDetail["amount"],
                                  motifCotisations: currentDetail["name"],
                                  nbreParticipant: 24,
                                  soldeCotisation:
                                      currentDetail["cotisation_balance"],
                                  nbreParticipantCotisationOK: 7,
                                  montantSanctionCollectee: '1500',
                                  isActive: 1,
                                  montantMin: "200",
                                ),
                              );
                            } else if (currentDetail["is_tontine"] == 0 &&
                                currentDetail["type"] == "0" &&
                                currentDetail["is_passed"] == 1) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: 7, right: 7, top: 3, bottom: 7),
                                child: WidgetCotisationExpireInFixed(
                                  codeCotisation:
                                      currentDetail["cotisation_code"],
                                  contributionOneUser: '1500',
                                  motifCotisations: currentDetail["name"],
                                  dateCotisation:
                                      formatDate(currentDetail["start_date"]),
                                  montantCotisations: currentDetail["amount"],
                                  heureCotisation:
                                      formatTime(currentDetail["start_date"]),
                                  // montantSanctionCollectee: '1500',
                                  nbreParticipantCotisationOK: 10,
                                  nbreParticipant: 12,
                                  soldeCotisation:
                                      currentDetail["cotisation_balance"],
                                  isActive: 0,
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
                                      formatDate(currentDetail["start_date"]),
                                  montantCotisations: currentDetail["amount"],
                                  heureCotisation:
                                      formatTime(currentDetail["start_date"]),
                                  // montantSanctionCollectee: currentDetail["amount_sanction"] ,
                                  nbreParticipantCotisationOK: 10,
                                  nbreParticipant: 12,
                                  soldeCotisation:
                                      currentDetail["cotisation_balance"],
                                  isActive: 1,
                                  codeCotisation:
                                      currentDetail["cotisation_code"],
                                ),
                              );
                            }

                            // Ajoutez ici le widget que vous souhaitez afficher pour true
                          },
                        )),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 1.5, left: 1.5, right: 1.5),
              width: MediaQuery.of(context).size.width,
              // decoration:
              //     BoxDecoration(color: Color.fromARGB(255, 203, 45, 45)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10, left: 5, bottom: 15),
                    child: Text(
                      "Toutes vos sanctions",
                      style: TextStyle(
                          color: const Color.fromRGBO(20, 45, 99, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: currentDetailUser!["current_membre"]
                                ["sanctions"]
                            .length,
                        itemBuilder: (context, index) {
                          final ItemDetailUserSanction =
                              currentDetailUser["current_membre"]["sanctions"]
                                  [index];

                          if (ItemDetailUserSanction["type"] == "1" &&
                              ItemDetailUserSanction["is_sanction_payed"] ==
                                  0) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetSanctionNonPayeeIsMoney(
                                dateSanction: formatDate(
                                    ItemDetailUserSanction["start_date"]),
                                heureSanction: formatTime(
                                    ItemDetailUserSanction["start_date"]),
                                montantPayeeSanction:
                                    ItemDetailUserSanction["sanction_balance"],
                                montantSanction:
                                    ItemDetailUserSanction["amount"].toString(),
                                motifSanction: ItemDetailUserSanction["motif"],
                                lienPaiement: ItemDetailUserSanction[
                                            "sanction_pay_link"] ==
                                        null
                                    ? " "
                                    : ItemDetailUserSanction[
                                        "sanction_pay_link"],
                              ),
                            );
                          } else if (ItemDetailUserSanction["type"] == "0" &&
                              ItemDetailUserSanction["is_sanction_payed"] ==
                                  0) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetSanctionNonPayeeIsOther(
                                dateSanction: formatDate(
                                    ItemDetailUserSanction["start_date"]),
                                heureSanction: formatTime(
                                    ItemDetailUserSanction["start_date"]),
                                objetSanction:
                                    ItemDetailUserSanction["libelle"],
                                motifSanction: ItemDetailUserSanction["motif"],
                              ),
                            );
                          } else if (ItemDetailUserSanction["type"] == "1" &&
                              ItemDetailUserSanction["is_sanction_payed"] ==
                                  1) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetSanctionPayeeIsMoney(
                                dateSanction: formatDate(
                                    ItemDetailUserSanction["start_date"]),
                                heureSanction: formatTime(
                                    ItemDetailUserSanction["start_date"]),
                                montantPayeeSanction:
                                    ItemDetailUserSanction["sanction_balance"],
                                montantSanction:
                                    ItemDetailUserSanction["amount"].toString(),
                                motifSanction: ItemDetailUserSanction["motif"],
                              ),
                            );
                          } else if (ItemDetailUserSanction["type"] == "0" &&
                              ItemDetailUserSanction["is_sanction_payed"] ==
                                  1) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 7, right: 7, top: 3, bottom: 7),
                              child: WidgetSanctionPayeeIsOther(
                                dateSanction: formatDate(
                                    ItemDetailUserSanction["start_date"]),
                                heureSanction: formatTime(
                                    ItemDetailUserSanction["start_date"]),
                                motifSanction: ItemDetailUserSanction["motif"],
                                objetSanction:
                                    ItemDetailUserSanction["libelle"],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 1.5, left: 1.5, right: 1.5),
              width: MediaQuery.of(context).size.width,
              // decoration:
              // BoxDecoration(color: Color.fromARGB(255, 240, 35, 35),),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10, left: 5, bottom: 15),
                    child: Text(
                      "Les comptes de l'association",
                      style: TextStyle(
                          color: const Color.fromRGBO(20, 45, 99, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            
                            for (var item in currentCompteAss!)
                            // int montant = int.parse(item["balance"]) + int.parse(item["foroti_balance"]);
                            
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 7,
                                  right: 5,
                                  top: 5,
                                  left: 5,
                                ),
                                child: WidgetCompteCard(
                                  montantCompte: "${int.parse(item["balance"]) + int.parse(item["foroti_balance"])}",
                                  nomCompte: item["name"],
                                  numeroCompte: item["id"].toString(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
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
