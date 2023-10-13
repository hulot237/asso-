import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:flutter/material.dart';

class WidgetHistoriqueCotisation extends StatefulWidget {
  const WidgetHistoriqueCotisation({super.key});

  @override
  State<WidgetHistoriqueCotisation> createState() =>
      _WidgetHistoriqueCotisationState();
}

class _WidgetHistoriqueCotisationState
    extends State<WidgetHistoriqueCotisation> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10,bottom: 10, left: 5, right: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
              width: 1,
              color: Color.fromARGB(85, 9, 185, 255),
            ))),
        width: double.infinity,
        // height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(50)),
                      child: Image.network(
                        "https://img.freepik.com/photos-gratuite/hotesse-air-coup-moyen-posant_23-2150312701.jpg?size=626&ext=jpg&ga=GA1.1.852592464.1694512378&semt=ais",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "KENGNE DJOUSSE Hulot",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Color.fromRGBO(20, 45, 99, 1),),
                          ),
                        ),
                        Container(
                          child: Text("JUI23",style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: Color.fromRGBO(20, 45, 99, 0.349),),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "${formatMontantFrancais(5000)} FCFA",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.green),
                          ),
                        ),
                        Container(
                          child: Text(
                            "20/03/2023",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: Color.fromRGBO(20, 45, 99, 0.349),),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(1),
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromARGB(40, 76, 175, 79),
                    ),
                    child: Icon(
                      Icons.done,
                      color: Colors.green,
                      size: 10,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
