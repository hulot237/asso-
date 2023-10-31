import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}


Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFEFEFEF),
      
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: Color(0xFFEFEFEF),
    
    body: child,
  );
}



class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final currentDetailUser = context.read<AuthCubit>().state.detailUser;
    print(currentDetailUser);
    return PageScaffold(context: context, 
    child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                color: Color.fromARGB(255, 20, 45, 99),
              ),
              height: 160,
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            width: 70,
                            height: 70,
                            child: Image.network(
                              "${Variables.LienAIP}${currentDetailUser!["photo_profil"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(left: 5, right: 5, top: 5),
                              child: Text(
                                "${currentDetailUser["first_name"] == null ? "" : currentDetailUser["first_name"]} ${currentDetailUser["last_name"] == null ? "" : currentDetailUser["last_name"]}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "statut".tr(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(127, 255, 255, 255),
                              ),
                            ),
                            Text(
                              "${currentDetailUser["type"] == "2" ? "Fondateur" : currentDetailUser["type"] == "3" ? "Membre" : "Super Admin"}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "matricule".tr(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(127, 255, 255, 255),
                              ),
                            ),
                            Text(
                              "${currentDetailUser["matricule"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Inscription",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(127, 255, 255, 255),
                              ),
                            ),
                            currentDetailUser
                                        ["is_inscription_payed"] ==
                                    1
                                ? Text(
                                    "payé".tr(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      Modal().showModalActionPayement(context, currentDetailUser["inscription_pay_link"]);
                                      // final url = currentDetailUser["inscription_pay_link"];
                                      // if (await canLaunch(url)) {
                                      //   await launch(url);
                                      // } else {
                                      //   throw 'Impossible d\'ouvrir le lien $url';
                                      // }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "non_payé".tr(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 2),
                                            child: Icon(
                                              Icons.open_in_new,
                                              color: Colors.red,
                                              size: 10,
                                            ))
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "informations_personnelles".tr(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(141, 20, 45, 99),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(19, 20, 45, 99),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                


                                Container(
                                  // margin: EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 7, bottom: 20),
                                            child: Icon(
                                              Icons.phone_android_outlined,
                                              color: Color.fromARGB(
                                                  255, 20, 45, 99),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  "téléphone".tr(),
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          139, 20, 45, 99),
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  
                                                  "${currentDetailUser["first_phone"] }",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 20, 45, 99),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                               
                               
                               Container(
                                  // margin: EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              right: 7,
                                              bottom: 20,
                                            ),
                                            child: Icon(
                                              Icons.email_outlined,
                                              color: Color.fromARGB(
                                                255,
                                                20,
                                                45,
                                                99,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  "Email",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          139, 20, 45, 99),
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  currentDetailUser["email"]==null? "" : currentDetailUser["email"],
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 20, 45, 99),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Container(
                                //   // margin: EdgeInsets.only(bottom: 5),
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       Row(
                                //         children: [
                                //           Container(
                                //             margin: EdgeInsets.only(
                                //               right: 7,
                                //               bottom: 20,
                                //             ),
                                //             child: Icon(
                                //               Icons.cake_outlined,
                                //               color: Color.fromARGB(
                                //                   255, 20, 45, 99),
                                //             ),
                                //           ),
                                //           Column(
                                //             crossAxisAlignment:
                                //                 CrossAxisAlignment.start,
                                //             children: [
                                //               Container(
                                //                 child: Text(
                                //                   "Date de naissance",
                                //                   style: TextStyle(
                                //                     color: Color.fromARGB(
                                //                         139, 20, 45, 99),
                                //                     fontWeight: FontWeight.w800,
                                //                   ),
                                //                 ),
                                //               ),
                                //               Container(
                                //                 child: Text(
                                //                   "21/02/2003",
                                //                   style: TextStyle(
                                //                     color: Color.fromARGB(
                                //                         255, 20, 45, 99),
                                //                     fontWeight: FontWeight.w500,
                                //                   ),
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ],
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "vos_bénéficiaires".tr(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(141, 20, 45, 99),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(19, 20, 45, 99),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: currentDetailUser["beneficiary"].length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final itemCurrentDetailUser = currentDetailUser["beneficiary"][index];
                                // print("ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd ${currentDetailUser["current_membre"]["beneficiary"]}");
                                if (currentDetailUser["beneficiary"].length!=0) {
                                  
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 0.5,
                                        color: Color.fromARGB(76, 20, 45, 99),
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(bottom: 2, top: 3),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    right: 7,
                                                    bottom: 20,
                                                  ),
                                                  child: Icon(
                                                    Icons.person,
                                                    color: Color.fromARGB(
                                                      255,
                                                      20,
                                                      45,
                                                      99,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "nom_complete".tr(),
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    139,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "${itemCurrentDetailUser["first_name"]==null? "" : itemCurrentDetailUser["first_name"]} ${itemCurrentDetailUser["last_name"]==null? "" : itemCurrentDetailUser["last_name"]}",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    right: 7,
                                                    bottom: 20,
                                                  ),
                                                  child: Icon(
                                                    Icons
                                                        .phone_android_outlined,
                                                    color: Color.fromARGB(
                                                        255, 20, 45, 99),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "téléphone".tr(),
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    139,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "${itemCurrentDetailUser["first_phone"]}",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   // alignment: Alignment.centerLeft,
                    //   margin: EdgeInsets.only(left: 10, right: 10),
                    //   child: Column(
                    //     children: [
                    //       Container(
                    //         margin: EdgeInsets.only(top: 20, bottom: 5),
                    //         width: MediaQuery.of(context).size.width,
                    //         child: Text(
                    //           "Informations supplementaires",
                    //           style: TextStyle(
                    //             fontSize: 15,
                    //             fontWeight: FontWeight.w500,
                    //             color: Color.fromARGB(141, 20, 45, 99),
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: MediaQuery.of(context).size.width,
                    //         padding: EdgeInsets.all(10),
                    //         decoration: BoxDecoration(
                    //             color: Color.fromARGB(19, 20, 45, 99),
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               margin: EdgeInsets.only(bottom: 5),
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Row(
                    //                     children: [
                    //                       Container(
                    //                         margin: EdgeInsets.only(
                    //                           right: 7,
                    //                           bottom: 20,
                    //                         ),
                    //                         child: Icon(
                    //                           Icons.email_outlined,
                    //                           color: Color.fromARGB(
                    //                             255,
                    //                             20,
                    //                             45,
                    //                             99,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: [
                    //                           Container(
                    //                             child: Text(
                    //                               "Email",
                    //                               style: TextStyle(
                    //                                   color: Color.fromARGB(
                    //                                       139, 20, 45, 99),
                    //                                   fontWeight:
                    //                                       FontWeight.w800),
                    //                             ),
                    //                           ),
                    //                           Container(
                    //                             child: Text(
                    //                               "kengnedjoussehulot@gmail.com",
                    //                               style: TextStyle(
                    //                                   color: Color.fromARGB(
                    //                                       255, 20, 45, 99),
                    //                                   fontWeight:
                    //                                       FontWeight.w500),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             Container(
                    //               margin: EdgeInsets.only(bottom: 5),
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Row(
                    //                     children: [
                    //                       Container(
                    //                         margin: EdgeInsets.only(
                    //                             right: 7, bottom: 20),
                    //                         child: Icon(
                    //                           Icons.phone_android_outlined,
                    //                           color: Color.fromARGB(
                    //                               255, 20, 45, 99),
                    //                         ),
                    //                       ),
                    //                       Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: [
                    //                           Container(
                    //                             child: Text(
                    //                               "Téléphone",
                    //                               style: TextStyle(
                    //                                   color: Color.fromARGB(
                    //                                       139, 20, 45, 99),
                    //                                   fontWeight:
                    //                                       FontWeight.w800),
                    //                             ),
                    //                           ),
                    //                           Container(
                    //                             child: Text(
                    //                               "680474835",
                    //                               style: TextStyle(
                    //                                   color: Color.fromARGB(
                    //                                       255, 20, 45, 99),
                    //                                   fontWeight:
                    //                                       FontWeight.w500),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             Container(
                    //               // margin: EdgeInsets.only(bottom: 5),
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Row(
                    //                     children: [
                    //                       Container(
                    //                         margin: EdgeInsets.only(
                    //                             right: 7, bottom: 20),
                    //                         child: Icon(
                    //                           Icons.email_outlined,
                    //                           color: Color.fromARGB(
                    //                               255, 20, 45, 99),
                    //                         ),
                    //                       ),
                    //                       Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: [
                    //                           Container(
                    //                             child: Text(
                    //                               "Date de naissance",
                    //                               style: TextStyle(
                    //                                   color: Color.fromARGB(
                    //                                       139, 20, 45, 99),
                    //                                   fontWeight:
                    //                                       FontWeight.w800),
                    //                             ),
                    //                           ),
                    //                           Container(
                    //                             child: Text(
                    //                               "21/02/",
                    //                               style: TextStyle(
                    //                                   color: Color.fromARGB(
                    //                                       255, 20, 45, 99),
                    //                                   fontWeight:
                    //                                       FontWeight.w500),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),);
    
    

  }
}
