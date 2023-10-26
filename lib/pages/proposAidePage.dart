import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProposAidePage extends StatefulWidget {
  const ProposAidePage({super.key});

  @override
  State<ProposAidePage> createState() => _ProposAidePageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "a_propos_et_aide".tr(),
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: Text(
        "a_propos_et_aide".tr(),
      ),
      backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
      elevation: 0,
    ),
    body: child,
  );
}

class _ProposAidePageState extends State<ProposAidePage> {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(context: context, child: Container(
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
                    "utilisation_et_confidentialité".tr(),
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
                    "a_propos_de_l'application".tr(),
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
                    "centre_d'aide".tr(),
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
                    "nous_contacter".tr(),
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
      ),);
    
    
    // Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       "a_propos_et_aide".tr(),
    //       style: TextStyle(fontSize: 16),
    //     ),
    //     backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
    //     elevation: 0,
    //   ),
    //   body: 
    // );
  }
}
