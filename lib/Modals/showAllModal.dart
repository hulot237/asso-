import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetListTransactionCotisationAllCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetHistoriqueTontineCard.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/widget/widgetListAssCard.dart';
import 'package:faroty_association_1/widget/widgetListTransactionByEventCard.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Modal {
  void showBottomSheetListAss(context, List? listAllAss) {
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
                    color: Color.fromARGB(255, 20, 45, 99),
                    borderRadius: BorderRadius.circular(50)),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Vos associations",
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

                    return Column(
                      children: [
                        widgetListAssCard(
                          nomAssociation: currentItemAssociationList.name!,
                          nbreEventPending: 5,
                          phofilAssociation:
                              "${Variables.LienAIP}${currentItemAssociationList.profile_photo}",
                        ),
                      ],
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

  void showBottomSheetListTournoi(context, List currentInfoAssociationCourant) {
    // .state.userGroupDefault

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
                    color: Color.fromARGB(255, 20, 45, 99),
                    borderRadius: BorderRadius.circular(50)),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Vos tournois",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(164, 20, 45, 99),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: currentInfoAssociationCourant.length,
                  itemBuilder: (context, index) {
                    final currentItemAssociationList =
                        currentInfoAssociationCourant[index];

                    return Container(
                      // margin: EdgeInsets.only(bottom: 10, right: 5, left: 5),
                      // padding: EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(20, 20, 45, 99),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        margin: EdgeInsets.all(5),
                        child: Text(
                          'Tournoi #${currentItemAssociationList["reference"]}',
                          style: TextStyle(
                              color: Color.fromARGB(164, 20, 45, 99),
                              fontWeight: FontWeight.w800),
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

  void showBottomSheetHistTontine(context, _tabController) {
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
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Historique de la tontine",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(164, 20, 45, 99),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 7),
                    child: Text(
                      "21/02/2024",
                      style: TextStyle(
                        fontSize: 15,
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
                              Container(
                                child: Text(
                                  "(10)",
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
                                child: Text("Non tontiné"),
                              ),
                              Container(
                                child: Text(
                                  "(2)",
                                  style: TextStyle(fontSize: 10),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(120, 226, 226, 226),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            child: widgetHistoriqueTontineCard(),
                            margin: EdgeInsets.only(
                                top: 3, bottom: 7, left: 10, right: 10),
                          );
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(
                                  top: 3, bottom: 7, left: 10, right: 10),
                              child: widgetHistoriqueTontineCard());
                        },
                      ),
                      //  Text("2"),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void showModalTransactionByEvent(context) {
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
              child: const Text(
                'Liste de vos transactions',
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
                          "Cotisation",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            // color: Color.fromARGB(255, 20, 45, 99),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${formatMontantFrancais(1200)} FCFA",
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
                          "Versé",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.green,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${formatMontantFrancais(2000)} FCFA",
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
                          "Reste",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${formatMontantFrancais(1000)} FCFA",
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
        content: Container(
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
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Container(
                          child: widgetListTransactionByEventCard());
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
            child: const Text(
              'Fermer',
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
              child: const Text(
                'Les transactions sur la cotisation',
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
            child: const Text(
              'Fermer',
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
          child: const Text(
            'Les personnes sanctionnées',
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
                          nom: itemLListSanction["membre"]["first_name"] ==null? "" : itemLListSanction["membre"]["first_name"],
                          outilSanction: itemLListSanction["amount"].toString() =="null"? itemLListSanction["libelle"] : "${formatMontantFrancais(double.parse(itemLListSanction["amount"].toString()) )} FCFA",
                          photoProfil: itemLListSanction["membre"]["photo_profil"]==null? "" : itemLListSanction["membre"]["photo_profil"],
                          prenom: itemLListSanction["membre"]["last_name"] ==null? "" : itemLListSanction["membre"]["last_name"],
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
            child: const Text(
              'Fermer',
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
          child: const Text(
            'Liste de presence',
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
                            child: Text("Présents"),
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
                            child: Text("Absent"),
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
                                    currentListPrsent["photo_profil"] == "null"
                                        ? ""
                                        : currentListPrsent['photo_profil'],
                                nom: currentListPrsent['first_name'] == "null"
                                    ? ""
                                    : currentListPrsent['first_name'],
                                prenom: currentListPrsent['last_name'] == "null"
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
            child: const Text(
              'Fermer',
              style: TextStyle(color: Color.fromARGB(255, 20, 45, 99)),
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheetEditProfil(context) {
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
                      "Entrer la nouvelle valeur",
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
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "kengnedjoussehulot@gmail.com",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(
                        top: 10,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      "Confirmer",
                      style: TextStyle(
                        color: Colors.white,
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

  void showModalActionPayement(context, lienDePaiement) {
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
                'Effectuer le paiement',
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
                  final url = lienDePaiement;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Impossible d\'ouvrir le lien $url';
                  }
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
                    "Payer vous même",
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
                  Share.share(lienDePaiement);
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
                    "partager le lien de paiement",
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
