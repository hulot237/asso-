import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/verificationPage.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/homePage.dart';
import 'package:faroty_association_1/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:integration_part_two/authentication/business_logic/auth_cubit.dart';
// import 'package:integration_part_two/pages/homeCoursier.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  TextEditingController countrycode = TextEditingController();

  final numeroPhoneController = TextEditingController();

  Future handleLogin() async {
    final numeroPhone = numeroPhoneController.text;

    final allCotisationAss =
        await context.read<AuthCubit>().loginFirstCubit(numeroPhone);

    if (allCotisationAss != null) {
      print("objec~~~~~~~~~~~~~~é~~  ${allCotisationAss}");
      print("# ${context.read<AuthCubit>().state.isTrueNomber}");
      if (context.read<AuthCubit>().state.isTrueNomber == false) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationPage(numeroPhone: numeroPhone),
          ),
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
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        // color: Colors.brown,
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        alignment: Alignment.center,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: Center(
                  child: Container(
                    // color: Colors.deepOrangeAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/Groupe_ou_Asso.png",
                          scale: 3,
                        ),
                        SizedBox(height: 70),
                        Text(
                          "Entrer votre numéro pour obtenir le code d'authentification",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackBlue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 25),
                        Container(
                          // padding: EdgeInsets.all(5),
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          // alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: AppColors.blackBlue,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // color: Colors.deepOrange,
                                alignment: Alignment.center,
                                // width: 90,
                                height: MediaQuery.of(context).size.height,
                                child: Text(
                                  "+237",
                                  style: TextStyle(
                                    color: Color.fromARGB(142, 20, 45, 99),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Container(
                                // color: AppColors.greenAccent,
                                width: MediaQuery.sizeOf(context).width / 1.5,
                                // margin: EdgeInsets.only(top: 12),
                                // alignment: Alignment.center,
                                child: TextField(
                                  controller: numeroPhoneController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: AppColors.blackBlue,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "numero_de_téléphone".tr(),
                                    hintStyle: TextStyle(
                                      color: AppColors.blackBlueAccent1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 25),
                        BlocBuilder<AuthCubit, AuthState>(
                            builder: (Authcontext, Authstate) {
                          if (Authstate.isTrueNomber == true)
                            return Container(
                              margin: EdgeInsets.only(
                                  top: 20, bottom: 10, left: 10, right: 10),
                              child: Text(
                                "Votre numéro est incorrect ou n'est pas lié à un groupe ou une association",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 255, 34, 18)),
                              ),
                            );
                          return Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                          );
                        }),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
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
                              onPressed: () {
                                // handleLogin();
                                handleLogin();
                              },
                              child: Text(
                                "vérification".tr(),
                                style: TextStyle(fontSize: 19, color: AppColors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.greenAssociation,
                                // primary: Color(0xFF6FA629),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "msg_condition_utilisation".tr(),
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.blackBlue,
                    ),
                    textAlign: TextAlign.center,
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
