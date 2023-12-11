import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Theming/color.dart';
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
      backgroundColor: AppColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "a_propos_et_aide".tr(),
          style: TextStyle(fontSize: 16, color : AppColors.white),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.white,
    appBar: AppBar(
      title: Text(
        "a_propos_et_aide".tr(),
        style: TextStyle(fontSize: 16, color : AppColors.white),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: AppColors.white),
      ),
    ),
    body: child,
  );
}

class _ProposAidePageState extends State<ProposAidePage> {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      context: context,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        width: MediaQuery.of(context).size.width / 1.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {},
              title: Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: AppColors.blackBlue,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "utilisation_et_confidentialité".tr(),
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              title: Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: AppColors.blackBlue,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      "a_propos_de_l'application".tr(),
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              onTap: () {},
              title: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: AppColors.blackBlue,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "centre_d'aide".tr(),
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.blackBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            ),


            ListTile(
              onTap: () {},
              title: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: AppColors.blackBlue,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "nous_contacter".tr(),
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.blackBlue,
                      fontWeight: FontWeight.w500,
                    ),
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
