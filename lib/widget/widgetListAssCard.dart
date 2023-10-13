import 'package:faroty_association_1/Modals/variable.dart';
import 'package:flutter/material.dart';

class widgetListAssCard extends StatefulWidget {
  const widgetListAssCard({
    super.key,
    required this.nomAssociation,
    required this.nbreEventPending,
    required this.phofilAssociation,
  });

  final String nomAssociation;
  final int nbreEventPending;
  final String phofilAssociation;

  @override
  State<widgetListAssCard> createState() => _widgetListAssCardState();
}

class _widgetListAssCardState extends State<widgetListAssCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Color.fromARGB(20, 20, 45, 99),
            borderRadius: BorderRadius.circular(7)),
        margin: EdgeInsets.all(5),
        // padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 50,
                height: 50,
                child: Image.network(
                  "${widget.phofilAssociation}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  widget.nomAssociation,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(164, 20, 45, 99)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Color.fromARGB(221, 20, 45, 99),
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                widget.nbreEventPending.toString(),
                style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
