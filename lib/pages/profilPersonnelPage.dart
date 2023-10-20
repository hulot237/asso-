import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilPersonnelPage extends StatefulWidget {
  const ProfilPersonnelPage({super.key});

  @override
  State<ProfilPersonnelPage> createState() => _ProfilPersonnelPageState();
}

class _ProfilPersonnelPageState extends State<ProfilPersonnelPage> {
  Future<void> handleDetailUser(userCode) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode);

    if (allCotisationAss != null) {
      print("objec===============ttt  ${allCotisationAss}");
      print(
          "éé22==============ssssssssssssssssssssssssss=222  ${context.read<AuthCubit>().state.detailUser}");
    } else {
      print("userGroupDefault null");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleDetailUser(AppCubitStorage().state.membreCode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (authContext, authState) {
      final currentDetailUser = context.read<AuthCubit>().state.detailUser;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Votre profil"),
          backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
          elevation: 0,
        ),
        body: Container(
          // padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(5),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 5),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(0, 162, 255, 0.815),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        width: 110,
                                        height: 110,
                                        child: Image.network(
                                          "${Variables.LienAIP}${currentDetailUser!["photo_profil"]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 2,
                                    top: 12,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 162, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(360)),
                                      width: 20,
                                      height: 20,
                                      child: Icon(Icons.mode_edit_rounded,
                                          color: Colors.white, size: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Color.fromRGBO(0, 162, 255, 0.055),
                          ),
                          margin: EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Modal().showBottomSheetEditProfil(
                                      context,
                                      currentDetailUser["first_name"] == null
                                          ? ""
                                          : currentDetailUser["first_name"],
                                      "first_name");
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    left: 10,
                                    right: 10,
                                    bottom: 15,
                                  ),
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 20,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(12, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      36, 20, 45, 99),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360)),
                                              child: Icon(
                                                Icons.person_outlined,
                                                color: Colors.blue,
                                              ),
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "Nom",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              130, 20, 45, 99),
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "${currentDetailUser["first_name"] == null ? "" : currentDetailUser["first_name"]}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255, 20, 45, 99),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.mode_edit_rounded,
                                            color:
                                                Color.fromARGB(255, 20, 45, 99),
                                            size: 14),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  Modal().showBottomSheetEditProfil(
                                      context,
                                      currentDetailUser["last_name"] == null
                                          ? ""
                                          : currentDetailUser["last_name"],
                                      "last_name");
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    left: 10,
                                    right: 10,
                                    bottom: 15,
                                  ),
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 20,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(12, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      36, 20, 45, 99),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360)),
                                              child: Icon(
                                                Icons.person_outlined,
                                                color: Colors.brown,
                                              ),
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "Prénom",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              130, 20, 45, 99),
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "${currentDetailUser["last_name"] == null ? "" : currentDetailUser["last_name"]}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255, 20, 45, 99),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.mode_edit_rounded,
                                            color:
                                                Color.fromARGB(255, 20, 45, 99),
                                            size: 14),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // GestureDetector(
                              //   onTap: () {
                              //     Modal().showBottomSheetEditProfil(context);
                              //   },
                              //   child: Container(
                              //     padding: EdgeInsets.only(
                              //         top: 10, left: 10, right: 10, bottom: 15),
                              //     margin: EdgeInsets.only(
                              //         left: 10, right: 10, top: 20),
                              //     // margin: EdgeInsets.all(12),
                              //     decoration: BoxDecoration(
                              //       // color: Colors.black12,
                              //       border: Border(
                              //         bottom: BorderSide(
                              //             width: 1,
                              //             color: Color.fromARGB(12, 0, 0, 0)),
                              //       ),
                              //     ),
                              //     child: Container(
                              //       child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Row(
                              //             children: [
                              //               Container(
                              //                 padding: EdgeInsets.all(5),
                              //                 decoration: BoxDecoration(
                              //                     color: Color.fromARGB(
                              //                         36, 20, 45, 99),
                              //                     borderRadius:
                              //                         BorderRadius.circular(360)),
                              //                 child: Icon(
                              //                   Icons.cake_outlined,
                              //                   color: Colors.green,
                              //                 ),
                              //                 margin: EdgeInsets.only(right: 10),
                              //               ),
                              //               Container(
                              //                 child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: [
                              //                     Container(
                              //                       child: Text(
                              //                         "Date de naissance",
                              //                         textAlign: TextAlign.center,
                              //                         style: TextStyle(
                              //                             fontSize: 12,
                              //                             color: Color.fromARGB(
                              //                                 120, 20, 45, 99),
                              //                             fontWeight:
                              //                                 FontWeight.w900),
                              //                       ),
                              //                     ),
                              //                     Container(
                              //                       child: Text(
                              //                         "21/02/2003",
                              //                         textAlign: TextAlign.center,
                              //                         style: TextStyle(
                              //                             fontSize: 15,
                              //                             color: Color.fromARGB(
                              //                                 255, 20, 45, 99),
                              //                             fontWeight:
                              //                                 FontWeight.w400),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //           Icon(Icons.mode_edit_rounded,
                              //               color:
                              //                   Color.fromARGB(255, 20, 45, 99),
                              //               size: 14),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              GestureDetector(
                                // onTap: () {
                                //   Modal().showBottomSheetEditProfil(context, currentDetailUser["first_phone"] == null ? "" : currentDetailUser["first_phone"]);
                                // },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 15),
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 20),
                                  // margin: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    // color: Colors.black12,
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(12, 0, 0, 0)),
                                    ),
                                  ),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      36, 20, 45, 99),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360)),
                                              child: Icon(
                                                Icons.phone_android_outlined,
                                                color: Colors.deepPurple,
                                              ),
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "Numéro de téléphone",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              120, 20, 45, 99),
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "${currentDetailUser["first_phone"] == null ? "" : currentDetailUser["first_phone"]}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255, 20, 45, 99),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Modal().showBottomSheetEditProfil(
                                      context,
                                      currentDetailUser["email"] == null
                                          ? ""
                                          : currentDetailUser["email"],
                                      "email");
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 15),
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 20),
                                  // margin: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    // color: Colors.black12,
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(12, 0, 0, 0)),
                                    ),
                                  ),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      36, 20, 45, 99),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360)),
                                              child: Icon(
                                                Icons.email_outlined,
                                                color: Colors.red,
                                              ),
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "Adresse Email",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromARGB(
                                                              120, 20, 45, 99),
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "${currentDetailUser["email"] == null ? "" : currentDetailUser["email"]}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255, 20, 45, 99),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.mode_edit_rounded,
                                            color:
                                                Color.fromARGB(255, 20, 45, 99),
                                            size: 14),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(45, 255, 82, 82),
                          ),
                          width: MediaQuery.of(context).size.width / 2.2,
                          margin: EdgeInsets.all(50),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                // color: Color.fromARGB(185, 255, 214, 64),
                                child:
                                    Icon(Icons.lock_outline, color: Colors.red),
                              ),
                              Container(
                                // color: Colors.greenAccent,
                                child: Text(
                                  "Changer de PIN",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
