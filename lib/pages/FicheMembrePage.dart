import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      body: Padding(
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
                              "https://img.freepik.com/photos-gratuite/confiant-entrepreneur-regardant-camera-bras-croises-souriant_1098-18840.jpg?size=626&ext=jpg&ga=GA1.1.852592464.1694512378&semt=ais",
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
                                "KENGNE DJOUSSE Hulot",
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
                              "Statut",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(127, 255, 255, 255),
                              ),
                            ),
                            Text(
                              "Membre",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.green,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Matricule",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(127, 255, 255, 255),
                              ),
                            ),
                            Text(
                              "ERI21",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
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
                            Text(
                              "Payé",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.green,
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
                              "Informations personnelles",
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
                                                  "kengnedjoussehulot@gmail.com",
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
                                                  "Téléphone",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          139, 20, 45, 99),
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  "680474835",
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
                              "Vos bénéficiaires",
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
                              itemCount: 3,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
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
                                                        "Nom",
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
                                                        "kengnedjoussehulot",
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
                                                        "Téléphone",
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
                                                        "680474835",
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
      ),
    );
  }
}
