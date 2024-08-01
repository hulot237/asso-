import 'dart:convert';
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
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      backgroundColor: AppColors.pageBackground,
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text(
      //     "votre_profil".tr(),
      //     style: TextStyle(
      //         fontSize: 16.sp,
      //         color: AppColors.white,
      //         fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: AppColors.backgroundAppBAr,
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: BackButtonWidget(colorIcon: AppColors.white),
      //   ),
      // ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    // AppBar(
    //   // title: Text(
    //   //   "votre_profil".tr(),
    //   //   style: TextStyle(
    //   //       fontSize: 16.sp,
    //   //       color: AppColors.white,
    //   //       fontWeight: FontWeight.bold),
    //   // ),
    //   // backgroundColor: AppColors.backgroundAppBAr,
    //   // elevation: 0,
    //   // leading: InkWell(
    //   //   onTap: () {
    //   //     Navigator.pop(context);
    //   //   },
    //   //   child: BackButtonWidget(colorIcon: AppColors.white),
    //   // ),
    // ),
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
        membre_code: AppCubitStorage().state.membreCode,
      );
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

  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      context: context,
      child: Material(
        color: Colors.transparent,
        child: BlocBuilder<AuthCubit, AuthState>(
            builder: (authContext, authState) {
          if (authState.isLoading == true && authState.detailUser == null)
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
          return Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180.h,
                        child: Image.asset(
                          "assets/images/BG2.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80.h,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        tileMode: TileMode.clamp,
                        end: Alignment.topCenter,
                        colors: [
                          Color.fromARGB(0, 187, 255, 0),
                          Color.fromARGB(0, 0, 0, 0),
                          const Color.fromARGB(0, 0, 0, 0),
                          const Color.fromARGB(0, 0, 0, 0),
                          const Color.fromARGB(0, 0, 0, 0),
                          Color.fromARGB(59, 150, 191, 53),
                          Color.fromARGB(135, 150, 191, 53)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 10.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // color: AppColors.colorButton,
                          width: 120.w,
                          height: 115.w,

                          transformAlignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Modal().showFullPicture(
                                  context,
                                  "${Variables.LienAIP}${currentDetailUser!["photo_profil"]}",
                                  "Photo de profil".tr());
                              // _pickImage();
                              // _cropImage();
                              // Modal().showBottomShreetEditProfilPhoto(
                              //     context, "key", _pickImage());
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  // margin: EdgeInsets.only(
                                  //   top: 15.h,
                                  //   bottom: 10.h,
                                  // ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5.r),
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(360)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(360),
                                          child: Container(
                                            width: 100.w,
                                            height: 100.w,
                                            child: imageFile == null
                                                ? Image.network(
                                                    "${Variables.LienAIP}${currentDetailUser!["photo_profil"]}",
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.file(
                                                    imageFile!,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "${currentDetailUser!["first_name"]} ${currentDetailUser["last_name"] == null ? "" : currentDetailUser["last_name"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.blackBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                _uploadImage();
                              },
                              child: Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: AppColors.blackBlue.withOpacity(.08),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 7.h,
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Editer",
                                      style: TextStyle(
                                        color: AppColors.blackBlue,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Icon(
                                      Icons.image,
                                      color: AppColors.blackBlue,
                                      size: 14.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SafeArea(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        // color: AppColors.blackBlue.withOpacity(.1),
                        margin: REdgeInsets.all(10.r),
                        padding: EdgeInsets.all(10.r),
                        child: BackButtonWidget(colorIcon: AppColors.blackBlue),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0.r),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        // Container(
                        //     child: Image.asset("assets/images/BG2.png")),

                        // GestureDetector(
                        //   onTap: () {
                        //     Modal().showFullPicture(
                        //         context,
                        //         "${Variables.LienAIP}${currentDetailUser!["photo_profil"]}",
                        //         "Photo de profil".tr());
                        //     // _pickImage();
                        //     // _cropImage();
                        //     // Modal().showBottomShreetEditProfilPhoto(
                        //     //     context, "key", _pickImage());
                        //   },
                        //   child: Stack(
                        //     children: [
                        //       Container(
                        //         width: MediaQuery.of(context).size.width,
                        //         margin: EdgeInsets.only(
                        //           top: 15.h,
                        //           bottom: 10.h,
                        //         ),
                        //         child: Column(
                        //           children: [
                        //             Container(
                        //               padding: EdgeInsets.all(4.r),
                        //               decoration: BoxDecoration(
                        //                   color: AppColors.colorButton,
                        //                   borderRadius:
                        //                       BorderRadius.circular(360)),
                        //               child: ClipRRect(
                        //                 borderRadius:
                        //                     BorderRadius.circular(360),
                        //                 child: Container(
                        //                   width: 110.w,
                        //                   height: 110.w,
                        //                   child: imageFile == null
                        //                       ? Image.network(
                        //                           "${Variables.LienAIP}${currentDetailUser!["photo_profil"]}",
                        //                           fit: BoxFit.cover,
                        //                         )
                        //                       : Image.file(imageFile!),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        // Container(
                        //   width: 150.w,
                        //   decoration: BoxDecoration(
                        //     color: AppColors.blackBlue.withOpacity(.08),
                        //     borderRadius: BorderRadius.circular(10.r),
                        //   ),
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: 10.w,
                        //     vertical: 7.h,
                        //   ),
                        //   alignment: Alignment.center,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         "Editer",
                        //         style: TextStyle(
                        //           color: AppColors.blackBlue,
                        //           fontSize: 14.sp,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //       Icon(
                        //         Icons.mode_edit_rounded,
                        //         color: AppColors.blackBlue,
                        //         size: 14.sp,
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            // color: Color.fromRGBO(0, 162, 255, 0.055),
                          ),
                          // margin: EdgeInsets.only(top: 15.h),
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
                                    top: 15.h,
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
                                      color: AppColors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Container(
                                    padding: EdgeInsets.all(5.r),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5.r),
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.blackBlueAccent2,
                                                borderRadius:
                                                    BorderRadius.circular(360),
                                              ),
                                              child: Icon(
                                                Icons.person,
                                                color:
                                                    AppColors.blackBlueAccent1,
                                              ),
                                              margin:
                                                  EdgeInsets.only(right: 10.w),
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
                                                          color: Color.fromARGB(
                                                              130, 20, 45, 99),
                                                          fontWeight:
                                                              FontWeight.w900),
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
                                    top: 15.h,
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
                                      color: AppColors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Container(
                                    padding: EdgeInsets.all(5.r),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5.r),
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.blackBlueAccent2,
                                                borderRadius:
                                                    BorderRadius.circular(360),
                                              ),
                                              child: Icon(
                                                Icons.person,
                                                color:
                                                    AppColors.blackBlueAccent1,
                                              ),
                                              margin:
                                                  EdgeInsets.only(right: 10.w),
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
                                                          color: Color.fromARGB(
                                                              130, 20, 45, 99),
                                                          fontWeight:
                                                              FontWeight.w900),
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
                                    top: 15.h,
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
                                      color: AppColors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Container(
                                    padding: EdgeInsets.all(5.r),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5.r),
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.blackBlueAccent2,
                                                borderRadius:
                                                    BorderRadius.circular(360),
                                              ),
                                              child: Icon(
                                                Icons.phone_android_rounded,
                                                color:
                                                    AppColors.blackBlueAccent1,
                                              ),
                                              margin:
                                                  EdgeInsets.only(right: 10.w),
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
                                                          color: Color.fromARGB(
                                                              120, 20, 45, 99),
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5.h),
                                                    child: Text(
                                                      "${currentDetailUser["first_phone"] == null ? "" : currentDetailUser["first_phone"]}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15.sp,
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
                                    top: 15.h,
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
                                      color: AppColors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Container(
                                    padding: EdgeInsets.all(5.r),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5.r),
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.blackBlueAccent2,
                                                borderRadius:
                                                    BorderRadius.circular(360),
                                              ),
                                              child: Icon(
                                                Icons.email,
                                                color:
                                                    AppColors.blackBlueAccent1,
                                              ),
                                              margin:
                                                  EdgeInsets.only(right: 10.w),
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
                                                          color: Color.fromARGB(
                                                              120, 20, 45, 99),
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5.h),
                                                    child: Text(
                                                      "${currentDetailUser["email"] == null ? "" : currentDetailUser["email"]}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15.sp,
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
              Container(
                margin: EdgeInsets.only(bottom: 5.h),
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40.r,
                          child: Image.asset("assets/images/FAroty_gris.png"),
                        ),
                        Text(
                          "Version ${Variables.version}",
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
    _cropImage();
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.backgroundAppBAr,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: AppColors.colorButton,
            backgroundColor: AppColors.blackBlue,
            statusBarColor: AppColors.backgroundAppBAr,
            initAspectRatio: CropAspectRatioPreset.original,
            // dimmedLayerColor: const Color.fromARGB(255, 41, 73, 143),
            cropFrameColor: AppColors.red,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        List<int> imageBytes = await File(croppedFile.path).readAsBytes();

        // Convertir les bytes en base64
        String base64Image = base64Encode(imageBytes);

        print("base64Image $base64Image");

        setState(() {
          imageFile = File(croppedFile.path);
          print("object");
        });

        await handleUpdateInfoUser(
          key: "photo_profil_mobile",
          value: base64Image,
          partner_urlcode: AppCubitStorage().state.codeAssDefaul,
          membre_code: AppCubitStorage().state.membreCode,
        );

        await handleDetailUser(AppCubitStorage().state.membreCode,
            AppCubitStorage().state.codeTournois);
      }
    }
  }
}
