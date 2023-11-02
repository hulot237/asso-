import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_update_cubit.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfilPersonnelPage extends StatefulWidget {
  const ProfilPersonnelPage({super.key});

  @override
  State<ProfilPersonnelPage> createState() => _ProfilPersonnelPageState();
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
          "votre_profil".tr(),
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
      title: Text("votre_profil".tr()),
      backgroundColor: Color.fromRGBO(0, 162, 255, 0.815),
      elevation: 0,
    ),
    body: child,
  );
}

class _ProfilPersonnelPageState extends State<ProfilPersonnelPage> {
  File? imageFile;

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

  Future<void> handleUpdateInfoUser({
      key, value, partner_urlcode, membre_code}) async {
    final allCotisationAss = await context
        .read<AuthUpdateCubit>()
        .UpdateInfoUserCubit(key, value, partner_urlcode, membre_code);

    if (allCotisationAss != null) {
      print("objec===============ttt  ${allCotisationAss}");
      print(
          "éé22==============ssssssssssssssssssssssssss=222  ${context.read<AuthCubit>().state.detailUser}");
    } else {
      print("userGroupDefault null");
    }
  }

  Future<dynamic> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });

      handleUpdateInfoUser(
       key: "photo_profil",
       value: pickedImage,
       partner_urlcode: AppCubitStorage().state.codeAssDefaul,
        membre_code:AppCubitStorage().state.membreCode
      );
      handleDetailUser(
        AppCubitStorage().state.membreCode,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // handleDetailUser(AppCubitStorage().state.membreCode);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      context: context,
      child:
          BlocBuilder<AuthCubit, AuthState>(builder: (authContext, authState) {
        if (authState.isLoading == null ||
            authState.isLoading == true ||
            authState.detailUser == null)
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        final currentDetailUser =
            authContext.read<AuthCubit>().state.detailUser;
        return Container(
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
                        GestureDetector(
                          onTap: () {
                            _pickImage();
                            // _cropImage();
                            // Modal().showBottomSheetEditProfilPhoto(
                            //     context, "key", _pickImage());
                          },
                          child: Stack(
                            children: [
                              Container(
                                // color: Colors.deepOrange,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(top: 15, bottom: 5),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              0, 162, 255, 0.815),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                          width: 110,
                                          height: 110,
                                          child: imageFile == null
                                              ? Image.network(
                                                  "${Variables.LienAIP}${currentDetailUser!["photo_profil"]}",
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(imageFile!),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 115,
                                top: 20,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(360),
                                  ),
                                  padding: EdgeInsets.all(2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 162, 255, 1),
                                      borderRadius: BorderRadius.circular(360),
                                    ),
                                    width: 30,
                                    height: 30,
                                    child: Icon(Icons.mode_edit_rounded,
                                        color: Colors.white, size: 14),
                                  ),
                                ),
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
                                      currentDetailUser!["first_name"] == null
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
                                                      "nom".tr(),
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
                                                      "${currentDetailUser!["first_name"] == null ? "" : currentDetailUser["first_name"]}",
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
                                                      "prénom".tr(),
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
                                                      "numéro_de_téléphone"
                                                          .tr(),
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
                                                      "adresse_email".tr(),
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
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     color: Color.fromARGB(45, 255, 82, 82),
                        //   ),
                        //   width: MediaQuery.of(context).size.width / 2.2,
                        //   margin: EdgeInsets.all(50),
                        //   padding: EdgeInsets.all(10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //         margin: EdgeInsets.only(right: 10),
                        //         // color: Color.fromARGB(185, 255, 214, 64),
                        //         child:
                        //             Icon(Icons.lock_outline, color: Colors.red),
                        //       ),
                        //       Container(
                        //         // color: Colors.greenAccent,
                        //         child: Text(
                        //           "Changer de PIN",
                        //           style: TextStyle(
                        //               fontSize: 15,
                        //               color: Colors.red,
                        //               fontWeight: FontWeight.w600),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
