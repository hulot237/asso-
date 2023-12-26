import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/pages/homePage.dart';
import 'package:flutter/material.dart';

class checkInternetConnectionPage extends StatefulWidget {
  const checkInternetConnectionPage({super.key});

  @override
  State<checkInternetConnectionPage> createState() =>
      _checkInternetConnectionPageState();
}

class _checkInternetConnectionPageState
    extends State<checkInternetConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color.fromARGB(255, 189, 215, 230),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  // color: Color.fromARGB(255, 111, 87, 123),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: 0.16,
                        child: Image.asset(
                          "assets/images/Groupe_ou_Asso.png",
                          scale: 2.3,
                        ),
                      ),
                      Opacity(
                        opacity: 0.16,
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text(
                            'Groups & Associations',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: AppColors.blackBlue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.greenAssociation,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      "Pas  d'internet",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Text(
                            "Verifier votre connexion internet et réessayer a nouveau",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (BuildContext context) => HomePage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: 50,
                          margin: EdgeInsets.only(
                            left: 8,
                            right: 8,
                            top: 5,
                            bottom: 15,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Réessayer",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.greenAssociation,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: Icon(
                                  Icons.refresh,
                                  size: 17,
                                  color: AppColors.greenAssociation,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
