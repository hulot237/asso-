import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

//@RoutePage()
class SubscribeFormScreen extends StatefulWidget {
  SubscribeFormScreen({
    super.key,
    required this.urlcodeAss,
  });
  String urlcodeAss;

  @override
  State<SubscribeFormScreen> createState() => _SubscribeFormScreenState();
}

class _SubscribeFormScreenState extends State<SubscribeFormScreen> {
  Future<void> handleAllSeanceAss() async {
    await launchUrl(
      Uri.parse(
          'https://group.rush.faroty.com/subscribe?urlcode=${widget.urlcodeAss}'),
      mode: LaunchMode.externalApplication,
    );
  }

  final _formNomKey = GlobalKey<FormState>();
  final _formPrenomKey = GlobalKey<FormState>();
  final _formNumberKey = GlobalKey<FormState>();

  String retirerPlus(String indice) {
    if (indice.startsWith('+')) {
      return indice.substring(1);
    }
    return indice;
  }

  final countrycode = TextEditingController();
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  String numeroPhoneController = '';
  String countryCodeController = '237';

  // @override
  // void initState() async {
  //   // TODO: implement initState
  //   // await handleAllSeanceAss();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   systemOverlayStyle: SystemUiOverlayStyle(
        //     // Status bar color
        //     statusBarColor: Colors.transparent,
      
        //     // Status bar brightness (optional)
        //     // statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        //     // statusBarBrightness: Brightness.light, // For iOS (dark icons)
        //   ),
        // ),
        body: Container(
          color: AppColors.pageBackground,
          child: Stack(
            children: [
              
              Container(
                // transformAlignment: Alignment.centerRight,
                alignment: Alignment.topRight,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                // color: AppColors.blackBlue,
                child: Image.asset(
                  "assets/images/updateBulle.png",
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 25.h,
                  ),
                  color: AppColors.white.withOpacity(0.3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                            bottomLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r),
                          ),
                        ),
                        padding: EdgeInsets.only(
                          left: 25.w,
                          right: 25.w,
                          // top: 100.h,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: AppColors.colorButton.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Image.asset(
                                "assets/images/AssoplusFinalSquare.png",
                                width: 80.w,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Text(
                                    "Vous etes invité a rejoindre l'association :",
                                    style: TextStyle(
                                      color: AppColors.blackBlue,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${widget.urlcodeAss}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.blackBlue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    height: 60.h,
                                    child: TextFormField(
                                      key: _formNomKey,
                                      controller: nomController,
                                      textAlignVertical: TextAlignVertical.center,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.blackBlue,
                                      ),
                                      cursorColor: AppColors.blackBlue,
                                      cursorHeight: 25.h,
                                      cursorWidth: 1,
                                      decoration: InputDecoration(
                                        hintText: "nom".tr(),
                                        hintStyle: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.blackBlueAccent1,
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(left: 15.w),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: BorderSide(
                                            color: AppColors.colorButton,
                                            width: 1.w,
                                          ),
                                        ),
                                        // focusColor: Colors.blue,
                                        filled: true,
                                        fillColor: AppColors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.blackBlue,
                                              width: 2.w),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              height: 60.h,
                              child: TextFormField(
                                key: _formPrenomKey,
                                controller: prenomController,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.blackBlue,
                                ),
                                cursorColor: AppColors.blackBlue,
                                cursorHeight: 25.h,
                                cursorWidth: 1,
                                decoration: InputDecoration(
                                  hintText: "prénom".tr(),
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.blackBlueAccent1,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15.w),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: BorderSide(
                                      color: AppColors.colorButton,
                                      width: 1.w,
                                    ),
                                  ),
                                  // focusColor: Colors.blue,
                                  filled: true,
                                  fillColor: AppColors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.blackBlue, width: 2.w),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   "Password",
                                  //   style: TextStyle(
                                  //     color: AppColors.black,
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 12.sp,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
      
                                  SizedBox(
                                    height: 75.h,
                                    child: IntlPhoneField(
                                      key: _formNumberKey,
                                      validator: (value) {
                                        if (value!.number.isEmpty) {
                                          return "vide";
                                        } else
                                          return null;
                                      },
                                      cursorColor: AppColors.blackBlue,
                                      cursorWidth: 1,
                                      style: TextStyle(
                                        color: AppColors.blackBlue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                      ),
                                      dropdownTextStyle: TextStyle(
                                        color: AppColors.blackBlue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                      ),
                                      flagsButtonPadding: EdgeInsets.all(15.r),
                                      dropdownIconPosition: IconPosition.trailing,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: BorderSide(
                                            color: AppColors.colorButton,
                                            width: 1.w,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.all(15.r),
                                        // labelText: 'numero_de_téléphone'.tr(),
                                        labelStyle: TextStyle(
                                          color: AppColors.blackBlueAccent1,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.blackBlue,
                                              width: 2.w),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        counterStyle:
                                            TextStyle(color: AppColors.blackBlue),
                                      ),
                                      controller: countrycode,
                                      initialCountryCode: 'CM',
                                      onCountryChanged: (Country) {
                                        setState(() {
                                          countryCodeController =
                                              retirerPlus(Country.dialCode);
                                        });
                                        print(Country.dialCode);
                                      },
                                      onChanged: (phone) {
                                        setState(() {
                                          numeroPhoneController = phone.number;
                                          countryCodeController =
                                              retirerPlus(phone.countryCode);
                                        });
                                        print(numeroPhoneController);
                                        print(countryCodeController);
                                      },
                                    ),
                                  ),
      
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  SizedBox(
                                    height: 45.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.colorButton,
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (nomController.text.isEmpty) {
                                          print("validate");
                                          toastification.show(
                                            context: context,
                                            title: Text('Le nom est obligatoire'),
                                            autoCloseDuration: Duration(
                                              seconds: 5,
                                            ),
                                            type: ToastificationType.error,
                                            style:
                                                ToastificationStyle.flatColored,
                                          );
                                        }
                                        if (prenomController.text.isEmpty) {
                                          print("validate");
                                          toastification.show(
                                            context: context,
                                            title:
                                                Text('Le prenom est obligatoire'),
                                            autoCloseDuration: Duration(
                                              seconds: 5,
                                            ),
                                            type: ToastificationType.error,
                                            style:
                                                ToastificationStyle.flatColored,
                                          );
                                        }
                                        if (countrycode.text.isEmpty) {
                                          print("validate");
                                          toastification.show(
                                            context: context,
                                            title:
                                                Text('Le numero est obligatoire'),
                                            autoCloseDuration: Duration(
                                              seconds: 5,
                                            ),
                                            type: ToastificationType.error,
                                            style:
                                                ToastificationStyle.flatColored,
                                          );
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Rejoindre",
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
