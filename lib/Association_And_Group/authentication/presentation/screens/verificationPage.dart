import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/localStorage/appStorageModel.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:integration_part_two/authentication/business_logic/auth_cubit.dart';
// import 'package:integration_part_two/pages/homeCoursier.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({super.key, required this.numeroPhone});
  String numeroPhone;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFEFEFEF),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: Color(0xFFEFEFEF),
    body: child,
  );
}

class _VerificationPageState extends State<VerificationPage> {
  int _secondsLeft = 30;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void resetTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
    setState(() {
      _secondsLeft = 30;
    });
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future handleLogin() async {
    final numeroPhone = widget.numeroPhone;

    final allCotisationAss =
        await context.read<AuthCubit>().loginFirstCubit(numeroPhone);

    if (allCotisationAss != null) {
      print("objec~~~~~~~~~~~~~~é~~  ${allCotisationAss}");
      print("# ${context.read<AuthCubit>().state.isTrueNomber}");
    } else {
      print("handleLogin");
    }
  }

  TextEditingController countrycode = TextEditingController();

  final codeController = TextEditingController();

  bool isLoading = false;

  Future<void> handleConfirmation() async {
    final codeConfirmation = codeController.text;

    final success =
        await context.read<AuthCubit>().ConfirmationCubit(codeConfirmation);
    // print("# ${context.read<AuthCubit>().state.loginInfo}");

    if (success &&
        context.read<AuthCubit>().state.loginInfo != null &&
        context.read<AuthCubit>().state.loginInfo!["error"] == false) {
      var loginInfo = context.read<AuthCubit>().state.loginInfo;

      await AppCubitStorage().updateCodeAssDefaul(loginInfo!["data"]["user_groups"][0]["urlcode"]);
      await AppCubitStorage().updateTokenUser(loginInfo!["data"]["token"]);
      await AppCubitStorage().updatemembreCode(loginInfo["data"]["membre"]["membre_code"]);
      await AppCubitStorage().updateCodeTournoisDefault(
          loginInfo["data"]["tournois"]["tournois_code"]);

      if (AppCubitStorage().state.codeAssDefaul != null && 
          AppCubitStorage().state.tokenUser != null) {
        Navigator.pop(context);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(),
          ),
          (route) => false,
        );
      }

      print("success login");
      print(
          "success loginnnnZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ   ${context.read<AuthCubit>().state.loginInfo}");
      print("success urlcode   ${AppCubitStorage().state.codeAssDefaul}");
      print("success token   ${AppCubitStorage().state.tokenUser}");
      print("success membre_code   ${AppCubitStorage().state.membreCode}");
      print("success tournoi_code   ${AppCubitStorage().state.codeTournois}");

      print(success);
    } else {
      print("####");
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
                // flex: 7,
                child: Center(
                  child: Container(
                    // color: Colors.deepOrangeAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/Groupe_ou_Asso.png",
                          scale: 4,
                        ),
                        SizedBox(height: 30),
                        Text(
                          "vérification".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 27,
                            color: Color.fromARGB(255, 20, 45, 99),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            print("${AppCubitStorage().state.isLoading}");
                          },
                          child: Container(
                            child: Text(
                              "${"veuillez_saisir_le_code_que_vous_avez_reçu_par_SMS_au_+237".tr()} ${widget.numeroPhone}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 20, 45, 99),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(12),
                          // alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 20, 45, 99),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width / 1.23,
                                margin: EdgeInsets.only(top: 12),
                                alignment: Alignment.center,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: codeController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 20, 45, 99),
                                  ),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "code_à_5_chiffres".tr(),
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(122, 20, 45, 99),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: BlocBuilder<AuthCubit, AuthState>(
                            builder: (Authcontext, Authstate) {
                              if (Authstate.isLoading == null ||
                                  Authstate.isLoading == true ||
                                  Authstate.isLoadingDetailUser == true ||
                                  Authstate.isLoading == null)
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF9bc43f),
                                    ),
                                  ),
                                );

                              return isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xFF9bc43f),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          isLoading =
                                              true; // Démarre l'indicateur de chargement
                                        });
                                        await handleConfirmation();
                                        setState(() {
                                          isLoading =
                                              false; // Arrête l'indicateur de chargement
                                        });
                                      },
                                      child: Text(
                                        "vérifier".tr(),
                                        style: TextStyle(fontSize: 19),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF9bc43f),
                                        // primary: Color(0xFF6FA629),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${"vous_n'avez_pas_reçu_le_code?".tr()} ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 20, 45, 99),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              _secondsLeft == 0
                                  ? GestureDetector(
                                      onTap: () {
                                        resetTimer();
                                        handleLogin();
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "${"renvoyer".tr()} ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: Color(0xFF9bc43f),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Icon(
                                            Icons.double_arrow_outlined,
                                            size: 8,
                                            color: Color(0xFF9bc43f),
                                          )
                                        ],
                                      ),
                                    )
                                  : Text(
                                      "00: $_secondsLeft",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 20, 45, 99),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
