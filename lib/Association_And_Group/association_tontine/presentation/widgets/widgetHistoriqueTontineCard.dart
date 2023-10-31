import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:flutter/material.dart';

class widgetHistoriqueTontineCard extends StatefulWidget {
  widgetHistoriqueTontineCard({
    super.key,
    required this.imageProfil,
    required this.nom,
    required this.prenom,
    required this.is_versement_finished,
    required this.montantVersee,
    required this.date,
  });

  String imageProfil;
  String nom;
  String prenom;
  int is_versement_finished;
  String montantVersee;
  String date;

  @override
  State<widgetHistoriqueTontineCard> createState() =>
      _widgetHistoriqueTontineCardState();
}

class _widgetHistoriqueTontineCardState
    extends State<widgetHistoriqueTontineCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        // margin: EdgeInsets.all(5),
        // padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 40,
                height: 40,
                child: Image.network(
                  "${Variables.LienAIP}${widget.imageProfil}",
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
                      // margin: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "${widget.nom} ${widget.prenom}",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 20, 45, 99),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Text(
                        "${formatMontantFrancais(double.parse("${widget.montantVersee}"))} FCFA",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(164, 20, 45, 99)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(widget.is_versement_finished == 1)
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Text(
                "${widget.date}",
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(164, 20, 45, 99)),
              ),
            ),
            widget.is_versement_finished == 0
                ? Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(48, 213, 0, 0),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.done,
                      color: Color.fromARGB(255, 213, 0, 0),
                      size: 11,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(125, 76, 175, 79),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Color.fromARGB(255, 0, 126, 4),
                      size: 11,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
