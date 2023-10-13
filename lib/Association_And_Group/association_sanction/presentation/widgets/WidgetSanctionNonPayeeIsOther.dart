import 'package:flutter/material.dart';

class WidgetSanctionNonPayeeIsOther extends StatefulWidget {
  WidgetSanctionNonPayeeIsOther({
    super.key,
    required this.heureSanction,
    required this.dateSanction,
    required this.motifSanction,
    required this.objetSanction,
  });
  String heureSanction;
  String dateSanction;
  String motifSanction;
  String objetSanction;


  @override
  State<WidgetSanctionNonPayeeIsOther> createState() =>
      _WidgetSanctionNonPayeeIsOtherState();
}

class _WidgetSanctionNonPayeeIsOtherState
    extends State<WidgetSanctionNonPayeeIsOther> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 8, color: Colors.red),
          ),
        ),
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    // color: Colors.deepPurple,
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          // flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 7),
                                  child: Text(
                                    "${widget.dateSanction} : ${widget.heureSanction}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(160, 20, 45, 99),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${widget.motifSanction}",
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            const Color.fromRGBO(20, 45, 99, 1),
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    width: MediaQuery.of(context).size.width / 1.1,
                    color: Colors.red,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Text("${widget.objetSanction}"),
                                margin: EdgeInsets.only(right: 10),
                              ),
                            ],
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
      ),
    );
  }
}
