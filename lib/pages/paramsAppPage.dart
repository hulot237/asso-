import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/localStorage/appStorageModel.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParamsAppPage extends StatefulWidget {
  const ParamsAppPage({super.key});

  @override
  State<ParamsAppPage> createState() => _ParamsAppPageState();
}

class _ParamsAppPageState extends State<ParamsAppPage> {
  int _pageIndex = 0;
  bool _customIconLangue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final dataBloc = context.read<AppCubitStorage>();
    print("dddddddddddddddddddd ${AppCubitStorage().state}");
  }

  // Map<String, dynamic>? get dataLanguage {
  //   return context.read<UserGroupCubit>().state.userGroupDefault;
  // }

  @override
  Widget build(BuildContext context) {
    final dataLanguage = context.read<AppCubitStorage>();

    return BlocBuilder<AppCubitStorage, AppStorageModel>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Paramètres",
            style: TextStyle(fontSize: 16),
          ),
          backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              child: ExpansionTile(
                childrenPadding: EdgeInsets.all(0),
                shape: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color.fromARGB(12, 0, 0, 0),
                  ),
                ),
                collapsedShape: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color.fromARGB(12, 0, 0, 0),
                  ),
                ),
                title: Container(
                  child: Text(
                    "Langue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 20, 45, 99),
                    ),
                  ),
                ),
                trailing: Icon(
                  color: Color.fromARGB(255, 20, 45, 99),
                  size: 12,
                  _customIconLangue
                      ? Icons.keyboard_double_arrow_down
                      : Icons.double_arrow,
                ),
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        context.setLocale(
                          Locale("fr", "FR"),
                        );
                      });
                      // AppCubitStorage().updateLanguage("fr");
                      dataLanguage.updateLanguage('fr');
                    },
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: AppCubitStorage().state.Language == "fr"
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(0, 162, 255, 0.815),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color.fromRGBO(0, 162, 255, 0.815),
                              ),
                            ),
                      child: Text(
                        "Francais ${AppCubitStorage().state.Language}",
                        style: AppCubitStorage().state.Language == "fr"
                            ? TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              )
                            : TextStyle(
                                color: Color.fromRGBO(0, 162, 255, 0.815),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        context.setLocale(
                          Locale("en", "US"),
                        );
                      });
                      AppCubitStorage().updateLanguage("en");
                      // dataLanguage.updateLanguage("en");
                      // // AppCubitStorage().updateValtest("valtes");
                      // // AppCubitStorage()
                      // //     .updateCodeTournoisDefault("TournoisDefault");
                      // dataLanguage.updateCodeTournoisDefault("AZER");
                      // dataLanguage.updateValtest("vatest");
                    },
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: AppCubitStorage().state.Language == "en"
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(0, 162, 255, 0.815),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color.fromRGBO(0, 162, 255, 0.815),
                              ),
                            ),
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Anglais",
                        style: AppCubitStorage().state.Language == "en"
                            ? TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              )
                            : TextStyle(
                                color: Color.fromRGBO(0, 162, 255, 0.815),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                      ),
                    ),
                  ),
                ],
                onExpansionChanged: (e) {
                  setState(() {
                    // print(e);
                    _customIconLangue = e;
                    print(_customIconLangue);
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Mode d'affichage",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 20, 45, 99),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    child: CustomSlidingSegmentedControl<int>(
                      onValueChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                          print(_pageIndex);
                        });
                      },
                      // padding: 10,
                      // height: 25,
                      initialValue: _pageIndex,
                      children: {
                        0: Row(
                          children: [
                            Text(
                              'Jours',
                              style: TextStyle(
                                color: Color.fromARGB(255, 20, 45, 99),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 3),
                              child: Icon(
                                Icons.light_mode_outlined,
                                size: 15,
                                color: Color.fromARGB(255, 20, 45, 99),
                              ),
                            ),
                          ],
                        ),
                        1: Row(
                          children: [
                            Text(
                              'Nuit',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 20, 45, 99),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 3),
                              child: Icon(
                                Icons.dark_mode_outlined,
                                size: 15,
                                color: Color.fromARGB(255, 20, 45, 99),
                              ),
                            ),
                          ],
                        ),
                      },
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black),
                        color: Color.fromARGB(27, 36, 36, 36),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      thumbDecoration: BoxDecoration(
                        // Color.fromARGB(255, 9, 185, 255),
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(97, 0, 0, 0),
                            blurRadius: 1.0,
                            spreadRadius: 0.1,
                            // offset: Offset(
                            //   0.0,
                            //   2.0,
                            // ),
                          ),
                        ],
                      ),
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 0.5, color: Colors.black12))),
              child: Column(
                children: [
                  Container(
                    // alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Notification",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 20, 45, 99),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Son",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 20, 45, 99),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 30,
                                  child: CustomSlidingSegmentedControl<int>(
                                    // padding: 10,
                                    // height: 25,
                                    initialValue: 0,
                                    children: {
                                      0: Row(
                                        children: [
                                          Text(
                                            'Oui',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 20, 45, 99),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 3),
                                            child: Icon(
                                              Icons.volume_up_outlined,
                                              size: 15,
                                              color: Color.fromARGB(
                                                  255, 20, 45, 99),
                                            ),
                                          ),
                                        ],
                                      ),
                                      1: Row(
                                        children: [
                                          Text(
                                            'Non',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 20, 45, 99),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 3),
                                            child: Icon(
                                              Icons.volume_mute_outlined,
                                              size: 15,
                                              color: Color.fromARGB(
                                                  255, 20, 45, 99),
                                            ),
                                          ),
                                        ],
                                      ),
                                    },
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.black),
                                      color: Color.fromARGB(27, 36, 36, 36),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    thumbDecoration: BoxDecoration(
                                      // Color.fromARGB(255, 9, 185, 255),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(97, 0, 0, 0),
                                          blurRadius: 1.0,
                                          spreadRadius: 0.1,
                                          // offset: Offset(
                                          //   0.0,
                                          //   2.0,
                                          // ),
                                        ),
                                      ],
                                    ),
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                    onValueChanged: (index) {
                                      setState(() {
                                        _pageIndex = index;
                                        print(_pageIndex);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Vibration",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 20, 45, 99),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 30,
                                  child: CustomSlidingSegmentedControl<int>(
                                    // padding: 10,
                                    // height: 25,
                                    initialValue: 0,
                                    children: {
                                      0: Row(
                                        children: [
                                          Text(
                                            'Oui',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 20, 45, 99),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 3),
                                            child: Icon(
                                              Icons.vibration_outlined,
                                              size: 15,
                                              color: Color.fromARGB(
                                                  255, 20, 45, 99),
                                            ),
                                          ),
                                        ],
                                      ),
                                      1: Row(
                                        children: [
                                          Text(
                                            'Non',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 20, 45, 99),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 3),
                                            child: Icon(
                                              Icons.dangerous,
                                              size: 15,
                                              color: Color.fromARGB(
                                                  255, 20, 45, 99),
                                            ),
                                          ),
                                        ],
                                      ),
                                    },
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.black),
                                      color: Color.fromARGB(27, 36, 36, 36),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    thumbDecoration: BoxDecoration(
                                      // Color.fromARGB(255, 9, 185, 255),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(97, 0, 0, 0),
                                          blurRadius: 1.0,
                                          spreadRadius: 0.1,
                                          // offset: Offset(
                                          //   0.0,
                                          //   2.0,
                                          // ),
                                        ),
                                      ],
                                    ),
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                    onValueChanged: (index) {
                                      setState(
                                        () {
                                          _pageIndex = index;
                                          print(_pageIndex);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // width: MediaQuery.sizeOf(context).width,
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 20),
                // color: Colors.amber,
                child: Text(
                  "Version 1.0.2",
                  style: TextStyle(
                      color: Color.fromARGB(52, 20, 45, 99),
                      fontSize: 10,
                      fontWeight: FontWeight.w900),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
