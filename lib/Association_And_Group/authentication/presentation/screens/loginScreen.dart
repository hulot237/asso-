import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/push_notification.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/verificationPage.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_repository.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
      backgroundColor: AppColors.pageBackground,
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    body: child,
  );
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController countrycode = TextEditingController();
  final countrycode = TextEditingController();
  String numeroPhoneController = '';
  String countryCodeController = '237';

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

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      context: context,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: 40.w,
                  transformAlignment: Alignment.centerLeft,
                  child: Icon(
                    Platform.isAndroid
                        ? Icons.arrow_back_outlined
                        : Icons.arrow_back_ios,
                    color: AppColors.blackBlue,
                    size: 16.sp,
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
                              Container(
                                width: 130.w,
                                child: Image.asset(
                                  "assets/images/AssoplusFinal.png",
                                  scale: 1,
                                ),
                              ),
                              SizedBox(height: 70.h),
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
                              SizedBox(height: 50.h),
                              IntlPhoneField(
                                // autofocus: true,
                                style: TextStyle(
                                  color: AppColors.blackBlue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.sp,
                                ),
                                dropdownTextStyle: TextStyle(
                                  color: AppColors.blackBlue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp,
                                ),
                                flagsButtonPadding: EdgeInsets.all(8.r),
                                dropdownIconPosition: IconPosition.trailing,
                                decoration: InputDecoration(
                                  labelText: 'numero_de_téléphone'.tr(),
                                  labelStyle: TextStyle(
                                    color: AppColors.blackBlueAccent1,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: BorderSide(width: 2.w),
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
                              BlocBuilder<AuthCubit, AuthState>(
                                  builder: (Authcontext, Authstate) {
                                if (Authstate.isTrueNomber == true)
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.redAccent,
                                      border: Border.all(
                                        width: 1.w,
                                        color: AppColors.red,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(5.r),
                                    margin: EdgeInsets.only(
                                      top: 20.h,
                                      bottom: 20.h,
                                      left: 10.w,
                                      right: 10.w,
                                    ),
                                    child: Text(
                                      "Votre numéro est incorrect ou n'est pas lié à un groupe ou une association"
                                          .tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromARGB(255, 255, 34, 18)),
                                    ),
                                  );
                                return Container(
                                  margin:
                                      EdgeInsets.only(top: 10.h, bottom: 10.h),
                                );
                              }),
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
                                      handleLogin();
                                      print(numeroPhoneController);
                                      print(countryCodeController);
                                      await PushNotifications()
                                          .getTokenNotification();
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
                                            BorderRadius.circular(10.r),
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
                        "By".tr(),
                        style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: 40.r,
                        child: Image.asset("assets/images/FAroty_gris.png"),
                      ),
                      Text(
                        "Version ${Variables.version}".tr(),
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
      ),
    );
  }
}
