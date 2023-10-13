import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProposAidePage extends StatefulWidget {
  const ProposAidePage({super.key});

  @override
  State<ProposAidePage> createState() => _ProposAidePageState();
}

class _ProposAidePageState extends State<ProposAidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A propos et aide", style: TextStyle(fontSize: 16),),
                backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
        elevation: 0,
      ),
      body: Container(
        // color: Colors.blueAccent,
        margin: EdgeInsets.only(left: 20),
        width: MediaQuery.of(context).size.width / 1.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Utilisation et confidentialité",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 20, 45, 99),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "A propos de l'application",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 20, 45, 99),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "Centre d'aide",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 20, 45, 99),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "Nous contacter",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 20, 45, 99),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
