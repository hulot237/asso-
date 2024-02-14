import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/appStorageModel.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:integration_part_two/authentication/business_logic/auth_cubit.dart';
// import 'package:integration_part_two/pages/homeCoursier.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage(
      {super.key, required this.numeroPhone, required this.countryCode});
  String numeroPhone;
  String countryCode;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
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
    final countryCode = widget.countryCode;

    final allCotisationAss = await context
        .read<AuthCubit>()
        .loginFirstCubit(numeroPhone, countryCode);

    if (allCotisationAss != null) {
    } else {
      print("handleLogin");
    }
  }

  // TextEditingController countrycode = TextEditingController();

  final codeController = TextEditingController();

  bool isLoading = false;

  Future<void> handleConfirmation() async {
    context.read<AuthCubit>().confirmationCubit(codeController.text);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      context: context,
      child: Material(
        type: MaterialType.transparency,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state.successLoading) {
              setState(() {
                isLoading = true; // Démarre l'indicateur de chargement
              });
              var loginInfo = context.read<AuthCubit>().state.loginInfo;

              await AppCubitStorage()
                  .updateCodeAssDefaul(loginInfo!.userGroup!.first.urlcode!);
              context
                  .read<UserGroupCubit>()
                  .AllUserGroupOfUserCubit(loginInfo.token);
              await AppCubitStorage().updateTokenUser(loginInfo.token!);
              await AppCubitStorage()
                  .updatemembreCode(loginInfo.user!.membre_code!);
              await AppCubitStorage()
                  .updateCodeTournoisDefault(loginInfo.tournoi!.tournois_code!);

              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                ),
                (route) => false,
              );
              setState(() {
                isLoading = false; // Arrête l'indicateur de chargement
              });
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
              margin: EdgeInsets.only(left: 20.w, right: 20.w),
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/Groupe_ou_Asso.png",
                        scale: 4,
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        "vérification".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 27.sp,
                          color: AppColors.blackBlue,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      GestureDetector(
                        child: Container(
                          child: Text(
                            "${"veuillez_saisir_le_code_que_vous_avez_reçu_par_SMS_au".tr()} \n+${widget.countryCode} ${formatMontantFrancais(double.parse(widget.numeroPhone))}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackBlue,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        child: Container(
                          height: 55.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.r,
                              color: AppColors.blackBlue,
                            ),
                            borderRadius: BorderRadius.circular(
                              10.r,
                            ),
                          ),
                          child: TextField(
                            autofocus: true,
                            textAlign: TextAlign.center,
                            controller: codeController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: AppColors.blackBlue,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "code_à_5_chiffres".tr(),
                              hintStyle: TextStyle(
                                color: AppColors.blackBlueAccent1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (Authcontext, Authstate) {
                            if (Authstate.isLoading == null ||
                                Authstate.isLoading == true ||
                                Authstate.isLoadingDetailUser == true ||
                                Authstate.isLoading == null)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.greenAssociation,
                                  ),
                                ),
                              );

                            return isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.greenAssociation,
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () async {
                                      await handleConfirmation();
                                    },
                                    child: Text(
                                      "Confirmer".tr(),
                                      style: TextStyle(
                                        fontSize: 19.sp,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.greenAssociation,
                                      // primary: Color(0xFF6FA629),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 15.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${"vous_n'avez_pas_reçu_le_code?".tr()} ",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackBlue,
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
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.greenAssociation,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Icon(
                                          Icons.double_arrow_outlined,
                                          size: 8.sp,
                                          color: AppColors.greenAssociation,
                                        )
                                      ],
                                    ),
                                  )
                                : Text(
                                    "00: $_secondsLeft",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.blackBlue,
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
            );
          },
        ),
      ),
    );
  }
}
