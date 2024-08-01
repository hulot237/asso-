import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/push_notification.dart';
import 'package:faroty_association_1/Association_And_Group/association_webview/administration_webview.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/auth_repository.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/verificationPage.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_repository.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/network/localisation_phone/business_logic/localisation_phone_cubit.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import 'package:telephony/telephony.dart';

class LoginCreateGroupeScreen extends StatefulWidget {
  LoginCreateGroupeScreen({super.key, required this.isForCreate});
  var isForCreate;

  @override
  State<LoginCreateGroupeScreen> createState() =>
      _LoginCreateGroupeScreenState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.pageBackground,
      child: child,
    );
  }

  return Scaffold(
    // resizeToAvoidBottomInset: false,
    backgroundColor: AppColors.pageBackground,
    body: child,
  );
}

class _LoginCreateGroupeScreenState extends State<LoginCreateGroupeScreen> {
  // TextEditingController countrycode = TextEditingController();
  final numeroPhoneController = TextEditingController();
  final nameUserController = TextEditingController();
  String countryCodeController = '237';
  final telephony = Telephony.instance;

  String retirerPlus(String? indice) {
    print("countryCodeController1 $indice");
    if (indice!.startsWith('+')) {
      return indice.substring(1);
    }
    print("countryCodeController2 $indice");
    return indice;
  }

  bool loader = false;

  // Future handleLogin() async {
  //   final allCotisationAss = await context
  //       .read<AuthCubit>()
  //       .loginFirstCubit(numeroPhoneController.text, countryCodeController);

  //   if (context.read<AuthCubit>().state.isTrueNomber == false) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => VerificationPage(
  //           isForCreate: widget.isForCreate,
  //           numeroPhone: numeroPhoneController.text,
  //           countryCode: countryCodeController,
  //           nameUser: nameUserController.text,
  //         ),
  //       ),
  //     );
  //   }
  // }

  // Future<void> initPlatformState() async {
  //   final bool? result = await telephony.requestPhoneAndSmsPermissions;

  //   // if (result != null && result) {
  //   //   telephony.listenIncomingSms(
  //   //     onNewMessage: _onMessage,
  //   //     listenInBackground: false,
  //   //   );
  //   // }

  //   if (!mounted) return;
  // }

  @override
  @override
  void initState() {
    super.initState();
    // startTimer();
    // initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    // toastification.show(
    //   context: context,
    //   title: Text('Le nom est obligatoire'),
    //   autoCloseDuration: Duration(
    //     seconds: 5,
    //   ),
    //   type: ToastificationType.error,
    //   style: ToastificationStyle.flatColored,
    // );
    return PageScaffold(
      context: context,
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: Image.asset(
                opacity: AlwaysStoppedAnimation(.6),
                "assets/images/bgDechire.png",
                // width: 180.w,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
              margin: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: BackButtonWidget(
                        colorIcon: AppColors.blackBlue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 20.h),
                                  Container(
                                    width: 110.w,
                                    child: Image.asset(
                                      "assets/images/AssoplusFinal.png",
                                      scale: 1,
                                    ),
                                  ),
                                  SizedBox(height: 60.h),
                                  Text(
                                    "Indiquez votre nom, prénoms et N° de téléphone pour vous connecter."
                                        .tr(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.blackBlue,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 50.h),
                                  SizedBox(
                                    // height: 50.h,
                                    child: TextField(
                                      keyboardType: TextInputType.name,
                                      controller: nameUserController,
                                      style: TextStyle(
                                        color: AppColors.blackBlue,
                                        fontSize: 18.sp,
                                        letterSpacing: 2.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      cursorColor: AppColors.blackBlue,
                                      decoration: InputDecoration(
                                        hintText: "Nom et prénom".tr(),
                                        hintStyle: TextStyle(
                                            letterSpacing: 2.w,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackBlue
                                                .withOpacity(.3)),
                                        labelStyle: TextStyle(
                                          color: AppColors.blackBlueAccent1,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.colorButton,
                                            width: 2.w,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.colorButton,
                                            width: 2.w,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                        ),
                                      ),
                                      autofocus: true,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  SizedBox(
                                    // height: 50.h,
                                    child: TextField(
                                      keyboardType: TextInputType.phone,
                                      controller: numeroPhoneController,
                                      style: TextStyle(
                                        color: AppColors.blackBlue,
                                        fontSize: 18.sp,
                                        letterSpacing: 2.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      cursorColor: AppColors.blackBlue,
                                      decoration: InputDecoration(
                                        hintText: "677654321",
                                        hintStyle: TextStyle(
                                            letterSpacing: 2.w,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackBlue
                                                .withOpacity(.3)),
                                        labelStyle: TextStyle(
                                          color: AppColors.blackBlueAccent1,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.colorButton,
                                            width: 2.w,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.colorButton,
                                            width: 2.w,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                        ),
                                        prefixIcon: Container(
                                          margin: EdgeInsets.only(left: 10.w),
                                          height: 20,
                                          decoration: BoxDecoration(
                                              // color: AppColors.blackBlue.withOpacity(.1),
                                              borderRadius:
                                                  BorderRadius.circular(20.r)),
                                          child: CountryCodePicker(
                                            onInit: (value) {
                                              // This is called once during initialization
                                              var code = value!.dialCode;
                                              // Update countryCodeController without calling setState
                                              countryCodeController =
                                                  retirerPlus(code);
                                              print(
                                                  "countryCodeController initialized with $countryCodeController");
                                            },
                                            flagWidth: 25.sp,
                                            showDropDownButton: true,
                                            textStyle: TextStyle(
                                              color: AppColors.blackBlue,
                                              fontSize: 16.sp,
                                              letterSpacing: 2.w,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            padding: EdgeInsets.all(0),
                                            onChanged: (value) {
                                              var code = value!.dialCode;
                                              setState(() {
                                                countryCodeController =
                                                    retirerPlus(code);
                                                print(
                                                    "countryCodeController§ $countryCodeController");
                                              });
                                            },
                                            initialSelection: context
                                                        .read<
                                                            LocalisationPhoneCubit>()
                                                        .state
                                                        .localisationPhone ==
                                                    null
                                                ? '+237'
                                                : context
                                                    .read<
                                                        LocalisationPhoneCubit>()
                                                    .state
                                                    .localisationPhone!
                                                    .countryCallingCode,
                                            favorite: const ['+237', 'FR'],
                                            showFlagDialog: true,
                                          ),
                                        ),
                                      ),
                                      autofocus: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50.h,
                                    child: loader
                                        ? Container(
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.green,
                                              ),
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: () async {
                                              print("numeroPhoneController ${numeroPhoneController.text}");
                                              print("nameUserController ${nameUserController.text}");
                                              if(numeroPhoneController.text!="" &&
                                                nameUserController.text !=""){

                                              print("object2222");
                                              setState(() {
                                                loader = true;
                                              });
                                              await AuthRepository()
                                                  .LoginWebViewRepository(
                                                numeroPhoneController.text,
                                                nameUserController.text,
                                                retirerPlus(
                                                    countryCodeController),
                                                context,
                                                widget.isForCreate,
                                                true,
                                              );

                                              print(numeroPhoneController.text);
                                              print(countryCodeController);
                                              setState(() {
                                                loader = false;
                                              });
                                                }
                                            },
                                            child: Text(
                                              "Connexion".tr(),
                                              style: TextStyle(
                                                  fontSize: 19.sp,
                                                  color: AppColors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.greenAssociation,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
                              child:
                                  Image.asset("assets/images/FAroty_gris.png"),
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
