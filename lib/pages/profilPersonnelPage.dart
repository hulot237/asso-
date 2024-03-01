import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_update_cubit.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      backgroundColor: AppColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "votre_profil".tr(),
          style: TextStyle(fontSize: 16.sp, color: AppColors.white),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.white,
            size: 20.sp,
          ),
        ),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.white,
    appBar: AppBar(
      title: Text(
        "votre_profil".tr(),
        style: TextStyle(fontSize: 16.sp, color: AppColors.white),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: AppColors.white,
          size: 16.sp,
        ),
      ),
    ),
    body: child,
  );
}

class _ProfilPersonnelPageState extends State<ProfilPersonnelPage> {
  File? imageFile;

  Future<void> handleDetailUser(userCode, codeTournoi) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode, codeTournoi);
  }

  Future<void> handleUpdateInfoUser(
      {key, value, partner_urlcode, membre_code}) async {
    final allCotisationAss = await context
        .read<AuthUpdateCubit>()
        .UpdateInfoUserCubit(key, value, partner_urlcode, membre_code);

    if (allCotisationAss != null) {
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
          membre_code: AppCubitStorage().state.membreCode);
      handleDetailUser(AppCubitStorage().state.membreCode,
          AppCubitStorage().state.codeTournois);
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
      child: Material(
        child: BlocBuilder<AuthCubit, AuthState>(
            builder: (authContext, authState) {
          if (authState.isLoading == null ||
              authState.isLoading == true ||
              authState.detailUser == null)
            return Container(
              child: EasyLoader(
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                iconSize: 50.r,
                iconColor: AppColors.blackBlueAccent1,
                image: AssetImage(
                  "assets/images/AssoplusFinal.png",
                ),
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
                    padding: EdgeInsets.all(5.r),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            // onTap: () {
                            //   _pickImage();
                            //   // _cropImage();
                            //   // Modal().showBottomShreetEditProfilPhoto(
                            //   //     context, "key", _pickImage());
                            // },
                            child: Stack(
                              children: [
                                Container(
                                  // color: Colors.deepOrange,
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      EdgeInsets.only(top: 15.h, bottom: 5.h),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4.r),
                                        decoration: BoxDecoration(
                                            color: AppColors.colorButton,
                                            borderRadius:
                                                BorderRadius.circular(360)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(360),
                                          child: Container(
                                            width: 110.w,
                                            height: 110.w,
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
                                // Positioned(
                                //   right: 115,
                                //   top: 20,
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       color: AppColors.white,
                                //       borderRadius: BorderRadius.circular(360),
                                //     ),
                                //     padding: EdgeInsets.all(2),
                                //     child: Container(
                                //       decoration: BoxDecoration(
                                //         color: AppColors.bleuLight,
                                //         borderRadius: BorderRadius.circular(360),
                                //       ),
                                //       width: 30,
                                //       height: 30,
                                //       child: Icon(Icons.mode_edit_rounded,
                                //           color: AppColors.white, size: 14),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Color.fromRGBO(0, 162, 255, 0.055),
                            ),
                            margin: EdgeInsets.only(top: 15.h),
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
                                    padding: EdgeInsets.only(
                                      top: 10.h,
                                      left: 10.w,
                                      right: 10.w,
                                      bottom: 15.h,
                                    ),
                                    margin: EdgeInsets.only(
                                      left: 10.w,
                                      right: 10.w,
                                      top: 20.h,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1.r,
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
                                                padding: EdgeInsets.all(5.r),
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      36, 20, 45, 99),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360),
                                                ),
                                                child: Icon(
                                                  Icons.person_outlined,
                                                  color: Colors.blue,
                                                ),
                                                margin: EdgeInsets.only(
                                                    right: 10.w),
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
                                                            fontSize: 12.sp,
                                                            color:
                                                                Color.fromARGB(
                                                                    130,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5.h),
                                                      child: Text(
                                                        "${currentDetailUser!["first_name"] == null ? "" : currentDetailUser["first_name"]}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15.sp,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.mode_edit_rounded,
                                            color: AppColors.blackBlue,
                                            size: 14.sp,
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
                                        currentDetailUser["last_name"] == null
                                            ? ""
                                            : currentDetailUser["last_name"],
                                        "last_name");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 10.h,
                                      left: 10.w,
                                      right: 10.w,
                                      bottom: 15.h,
                                    ),
                                    margin: EdgeInsets.only(
                                      left: 10.w,
                                      right: 10.w,
                                      top: 20.h,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1.r,
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
                                                padding: EdgeInsets.all(5.r),
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      36, 20, 45, 99),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360),
                                                ),
                                                child: Icon(
                                                  Icons.person_outlined,
                                                  color: Colors.brown,
                                                ),
                                                margin: EdgeInsets.only(
                                                    right: 10.w),
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
                                                            fontSize: 12.sp,
                                                            color:
                                                                Color.fromARGB(
                                                                    130,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5.h),
                                                      child: Text(
                                                        "${currentDetailUser["last_name"] == null ? "" : currentDetailUser["last_name"]}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15.sp,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.mode_edit_rounded,
                                            color: AppColors.blackBlue,
                                            size: 14.sp,
                                          ),
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
                                      top: 10.h,
                                      left: 10.w,
                                      right: 10.w,
                                      bottom: 15.h,
                                    ),
                                    margin: EdgeInsets.only(
                                      left: 10.w,
                                      right: 10.w,
                                      top: 20.h,
                                    ),
                                    // margin: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      // color: Colors.black12,
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.r,
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
                                                padding: EdgeInsets.all(5.r),
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      36, 20, 45, 99),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360),
                                                ),
                                                child: Icon(
                                                  Icons.phone_android_outlined,
                                                  color: Colors.deepPurple,
                                                ),
                                                margin: EdgeInsets.only(
                                                    right: 10.w),
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
                                                            fontSize: 12.sp,
                                                            color:
                                                                Color.fromARGB(
                                                                    120,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "${currentDetailUser["first_phone"] == null ? "" : currentDetailUser["first_phone"]}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15.sp,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
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
                                      top: 10.h,
                                      left: 10.w,
                                      right: 10.w,
                                      bottom: 15.h,
                                    ),
                                    margin: EdgeInsets.only(
                                      left: 10.w,
                                      right: 10.w,
                                      top: 20.h,
                                    ),
                                    // margin: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      // color: Colors.black12,
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.r,
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
                                                padding: EdgeInsets.all(5.r),
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      36, 20, 45, 99),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360),
                                                ),
                                                child: Icon(
                                                  Icons.email_outlined,
                                                  color: Colors.red,
                                                ),
                                                margin: EdgeInsets.only(
                                                    right: 10.w),
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
                                                            fontSize: 12.sp,
                                                            color:
                                                                Color.fromARGB(
                                                                    120,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "${currentDetailUser["email"] == null ? "" : currentDetailUser["email"]}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15.sp,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(Icons.mode_edit_rounded,
                                              color: AppColors.blackBlue,
                                              size: 14.sp),
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
                          //         // color: AppColors.greenAccent,
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
      ),
    );
  }
}
