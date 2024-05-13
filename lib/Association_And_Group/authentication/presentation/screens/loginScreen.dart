import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/push_notification.dart';
import 'package:faroty_association_1/Association_And_Group/association_webview/administration_webview.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/verificationPage.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_repository.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:toastification/toastification.dart';
import 'package:telephony/telephony.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
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

class _LoginPageState extends State<LoginPage> {
  // TextEditingController countrycode = TextEditingController();
  final countrycode = TextEditingController();
  String numeroPhoneController = '';
  String countryCodeController = '237';
  final telephony = Telephony.instance;

  String retirerPlus(String indice) {
    if (indice.startsWith('+')) {
      return indice.substring(1);
    }
    return indice;
  }

  Future handleLogin() async {
    final allCotisationAss = await context
        .read<AuthCubit>()
        .loginFirstCubit(numeroPhoneController, countryCodeController);

    if (allCotisationAss != null) {
      if (context.read<AuthCubit>().state.isTrueNomber == false) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerificationPage(
                  numeroPhone: numeroPhoneController,
                  countryCode: countryCodeController)),
        );
      }
    } else {
      print("handleLogin");
    }
  }

  Future<void> initPlatformState() async {
    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    // if (result != null && result) {
    //   telephony.listenIncomingSms(
    //     onNewMessage: _onMessage,
    //     listenInBackground: false,
    //   );
    // }

    if (!mounted) return;
  }

  @override
  @override
  void initState() {
    super.initState();
    // startTimer();
    initPlatformState();
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
                                  SizedBox(height: 40.h),
                                  Container(
                                    width: 130.w,
                                    child: Image.asset(
                                      "assets/images/AssoplusFinal.png",
                                      scale: 1,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    "Connexion".tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 27.sp,
                                      color: AppColors.blackBlue,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 50.h),
                                  Text(
                                    "Entrer votre numéro pour obtenir le code d'authentification"
                                        .tr(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.blackBlue,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20.h),
                                  SizedBox(
                                    height: 82.h,
                                    child: IntlPhoneField(
                                      autofocus: true,
                                      cursorColor: AppColors.blackBlue,
                                      style: TextStyle(
                                        color: AppColors.blackBlue,
                                        fontSize: 18.sp,
                                        letterSpacing: 3.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      dropdownIcon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        color: AppColors.colorButton,
                                      ),
                                      dropdownTextStyle: TextStyle(
                                        color: AppColors.blackBlue,
                                        fontSize: 18.sp,
                                        letterSpacing: 1.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      flagsButtonPadding:
                                          EdgeInsets.only(left: 8.r),
                                      dropdownIconPosition:
                                          IconPosition.trailing,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.colorButton,
                                              width: 2.w),
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                        ),
                                        contentPadding: EdgeInsets.all(8.r),
                                        hintText: "677777777",
                                        hintStyle: TextStyle(
                                          letterSpacing: 1.w,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        labelStyle: TextStyle(
                                          color: AppColors.blackBlueAccent1,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                          borderSide: BorderSide(width: 3.w),
                                        ),
                                        counterStyle: TextStyle(
                                            color: AppColors.blackBlue),
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
                                  BlocBuilder<AuthCubit, AuthState>(
                                    builder: (context, Authstate) {
                                      if (Authstate.isTrueNomber == true) {
                                        // Déclencher la fonction toastification.show()
                                        Future.delayed(Duration.zero, () {
                                          // Déclencher la fonction toastification.show() après le rendu initial
                                          toastification.show(
                                            context: context,
                                            title: Text(
                                              "Votre numéro est incorrect ou n'est pas lié à un groupe ou une association"
                                                  .tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            autoCloseDuration:
                                                Duration(seconds: 15),
                                            type: ToastificationType.error,
                                            style:
                                                ToastificationStyle.flatColored,
                                          );
                                        });

                                        return SizedBox(
                                          width: double.infinity,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              // border: Border.all(
                                              //   width: 1.w,
                                              //   color: AppColors.red,
                                              // ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20.r,
                                              ),
                                            ),
                                            padding: EdgeInsets.only(
                                              top: 20.h,
                                              bottom: 20.h,
                                              // left: 10.w,
                                              // right: 10.w,
                                            ),
                                            margin: EdgeInsets.only(
                                              top: 10.h,
                                              bottom: 30.h,
                                              // left: 10.w,
                                              // right: 10.w,
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Votre pouvez créer votre propre groupe ASSO+"
                                                      .tr(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.blackBlue,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                SizedBox(
                                                    width: 250.w,
                                                    height: 30.h,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                AdministrationPageWebview(
                                                              forAdmin: false,
                                                              urlPage:
                                                                  'https://business.faroty.com/groups',
                                                              // urlPage: 'https://business.rush.faroty.com/',
                                                              forFirstPage:
                                                                  true,
                                                            ),
                                                          ),
                                                        );

                                                        print("object");
                                                        // await PushNotifications()
                                                        //     .getTokenNotification();
                                                        handleLogin();
                                                        print(
                                                            numeroPhoneController);
                                                        print(
                                                            countryCodeController);
                                                      },
                                                      child: Text(
                                                        "Créer un groupe ASSO+"
                                                            .tr(),
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor: AppColors
                                                            .greenAssociation,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            20.r,
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                      // Si Authstate.isTrueNomber n'est pas true, retourner un Container vide
                                      return Container(
                                        // height: 100.h,
                                        margin: EdgeInsets.only(
                                            top: 10.h, bottom: 10.h),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50.h,
                                    child: BlocBuilder<AuthCubit, AuthState>(
                                        builder: (Authcontext, Authstate) {
                                      if (Authstate.isLoading == null ||
                                          Authstate.isLoading == true)
                                        return Container(
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.greenAssociation,
                                            ),
                                          ),
                                        );
                                      return ElevatedButton(
                                        onPressed: () async {
                                          print("object");
                                          // await PushNotifications()
                                          //     .getTokenNotification();
                                          handleLogin();
                                          print(numeroPhoneController);
                                          print(countryCodeController);
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
                                      );
                                    }),
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
                            Text(
                              "By",
                              style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900),
                              textAlign: TextAlign.center,
                            ),
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
