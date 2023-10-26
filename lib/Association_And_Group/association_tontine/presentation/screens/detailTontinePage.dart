import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetDetailHistoriqueTontineCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetDetailTontineCard.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailTontinePage extends StatefulWidget {
  DetailTontinePage({
    super.key,
    required this.dateCreaTontine,
    required this.nomTontine,
    required this.montantTontine,
    required this.positionBeneficiaire,
    required this.nbrMembreTontine,
    required this.listMembre,
  });
  String dateCreaTontine;
  String nomTontine;
  String montantTontine;
  String positionBeneficiaire;
  String nbrMembreTontine;
  List listMembre;
  @override
  State<DetailTontinePage> createState() => _DetailTontinePageState();
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
          "Detail de la tontine",
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
        "Detail de la tontine",
        style: TextStyle(fontSize: 16),
      ),
      backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
      elevation: 0,
    ),
    body: child,
  );
}







class _DetailTontinePageState extends State<DetailTontinePage>
    with TickerProviderStateMixin {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, false, true];
  int _index = 0;
  int i = 0;

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);
    return PageScaffold(context: context, 
    child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, top: 10),
              child: WidgetDetailTontineCard(
                dateCreaTontine: widget.dateCreaTontine,
                nomTontine: widget.nomTontine,
                montantTontine: widget.montantTontine,
                positionBeneficiaire: widget.positionBeneficiaire,
                nbrMembreTontine: widget.nbrMembreTontine,
              ),
            ),
            Container(
              // color: Colors.blueGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 7, left: 5, right: 5),
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "ordre_de_passage".tr(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(20, 45, 99, 1),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var itemListMembre in widget.listMembre)
                              Container(
                                // color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 3),
                                      width: 70,
                                      child: Text(
                                        "${itemListMembre["membre"]["first_name"] == null ? "" : itemListMembre["membre"]["first_name"]} ${itemListMembre["membre"]["last_name"] == null ? "" : itemListMembre["membre"]["last_name"]}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w800,
                                          color: Color.fromRGBO(20, 45, 99, 1),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(360),
                                              color: itemListMembre["is_passed"]==0? Color.fromRGBO(
                                                  20, 45, 99, 0.24) : Color.fromRGBO(15, 190, 24, 0.658),
                                            ),
                                            width: 15,
                                            height: 15,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: 
                                              itemListMembre["is_passed"]==0? Text(
                                                "${itemListMembre["order"]}",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromRGBO(
                                                      20, 45, 99, 1),
                                                ),
                                              ) : Icon(Icons.check, size: 10, color: Colors.white,)
                                              
                                            ),
                                          ),
                                          Container(
                                            color: itemListMembre["is_passed"]==0? Color.fromRGBO(
                                                  20, 45, 99, 0.24) : Color.fromRGBO(15, 190, 24, 0.658),
                                            width: 80,
                                            height: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //   margin: EdgeInsets.only(top: 3),
                                    //   child: Text(
                                    //     "21/02/2024",
                                    //     style: TextStyle(
                                    //       fontSize: 8,
                                    //       fontWeight: FontWeight.w600,
                                    //       color: Color.fromRGBO(20, 45, 99, 1),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 5),
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "Historique de la tontine",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(20, 45, 99, 1),
                ),
              ),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 0, left: 5, right: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 1,
                    color: Color.fromARGB(85, 9, 185, 255),
                  )),
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: Tab.length,
                    itemBuilder: (context, index) {
                      bool valeurBool = Tab[index];

                      return GestureDetector(
                        onTap: () {
                          Modal().showBottomSheetHistTontine(
                              context, _tabController);
                        },
                        child: Container(
                            margin: EdgeInsets.all(5),
                            child: widgetDetailHistoriqueTontineCard()),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),);    
    
    
    // Scaffold(
    //   backgroundColor: Color(0xFFEFEFEF),
    //   appBar: AppBar(
    //     title: Text(
    //       "Detail de la tontine",
    //       style: TextStyle(fontSize: 16),
    //     ),
    //     backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
    //     elevation: 0,
    //   ),
    //   body: 
    // );
  }
}
