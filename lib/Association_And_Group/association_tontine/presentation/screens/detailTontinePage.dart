import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetDetailHistoriqueTontineCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetDetailTontineCard.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetDetailCotisationCard.dart';
import 'package:flutter/material.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';

class DetailTontinePage extends StatefulWidget {
  const DetailTontinePage({super.key});

  @override
  State<DetailTontinePage> createState() => _DetailTontinePageState();
}

class _DetailTontinePageState extends State<DetailTontinePage>
    with TickerProviderStateMixin {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, false, true];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text("Detail de la tontine", style: TextStyle(fontSize: 16),),
        backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, top: 10),
              child: WidgetDetailTontineCard(),
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 7, left: 5, right: 5),
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Ordre de passage",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(20, 45, 99, 1),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: Row(
                      children: [
                        for (var i = 0; i < 15; i++)
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
                                    "KENGNE DJOUSSE Hulot",
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
                                          color:
                                              Color.fromRGBO(20, 45, 99, 0.24),
                                        ),
                                        width: 15,
                                        height: 15,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${i}",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  Color.fromRGBO(20, 45, 99, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Color.fromRGBO(20, 45, 99, 0.24),
                                        width: 80,
                                        height: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  child: Text(
                                    "21/02/2024",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(20, 45, 99, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              ],
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
      ),
    );
  }
}
