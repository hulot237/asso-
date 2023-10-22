import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class widgetDetailRencontreCard extends StatefulWidget {
  widgetDetailRencontreCard({
    super.key,
    required this.nomRecepteurRencontre,
    required this.prenomRecepteurRencontre,
    required this.identifiantRencontre,
    required this.isActiveRencontre,
    required this.descriptionRencontre,
    required this.lieuRencontre,
    required this.dateRencontre,
    required this.heureRencontre,
    required this.nbrPresence,
  });

  String nomRecepteurRencontre;
  String prenomRecepteurRencontre;
  String identifiantRencontre;
  int isActiveRencontre;
  String descriptionRencontre;
  String lieuRencontre;
  String dateRencontre;
  String heureRencontre;
  String nbrPresence;

  @override
  State<widgetDetailRencontreCard> createState() =>
      _widgetDetailRencontreCardState();
}

class _widgetDetailRencontreCardState extends State<widgetDetailRencontreCard>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final TabController _tabController2 = TabController(length: 2, vsync: this);
    final currentDetailSeanceSanction = context.read<SeanceCubit>().state.detailSeance!["sanctions"];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(69, 0, 0, 0),
              spreadRadius: 0.5,
              blurRadius: 2),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(7),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          // margin: EdgeInsets.only(right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "rencontre".tr(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                          color: Color.fromRGBO(20, 45, 99, 1),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        " ${widget.identifiantRencontre}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
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
                      ),
                      widget.isActiveRencontre == 1
                          ? Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(43, 0, 212, 7),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Container(
                                padding: EdgeInsets.all(1),
                                child: Text(
                                  "en_cours".tr(),
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(24, 212, 0, 0),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Container(
                                padding: EdgeInsets.all(1),
                                child: Text(
                                  "terminé".tr(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "recepteur".tr(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(125, 20, 45, 99),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        child: Text(
                          "${widget.nomRecepteurRencontre} ${widget.prenomRecepteurRencontre}",
                          style: TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 20, 45, 99)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // width: MediaQuery.of(context).size.width / 1.1,
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "lieu_de_la_réception".tr(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(125, 20, 45, 99),
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 3),
                                      child: Text(
                                        widget.lieuRencontre,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color.fromARGB(255, 20, 45, 99),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Icon(
                                      Icons.maps_home_work_rounded,
                                      size: 13,
                                      color: Color.fromARGB(255, 20, 45, 99),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                "dateheure".tr(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(125, 20, 45, 99),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                "${widget.dateRencontre} : ${widget.heureRencontre}",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(14, 20, 45, 99),
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Modal().showModalPersonSanctionner(context, currentDetailSeanceSanction);
                          },
                          child: Container(
                            color: Colors.transparent,
                            // alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "Sanctions",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromARGB(171, 20, 45, 99),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${currentDetailSeanceSanction.length}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: Color.fromARGB(255, 20, 45, 99)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Modal().showModalPersonPresent(
                                context,
                                _tabController2,
                                context
                                    .read<SeanceCubit>()
                                    .state
                                    .detailSeance!["abs"],
                                context
                                    .read<SeanceCubit>()
                                    .state
                                    .detailSeance!["presents"]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    "présence".tr(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromARGB(171, 20, 45, 99),
                                    ),
                                  ),
                                  // margin: EdgeInsets.only(right: 5),
                                ),
                                Container(
                                  child: Text(
                                    widget.nbrPresence,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: Color.fromARGB(255, 20, 45, 99)),
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
        ],
      ),
    );
  }
}
