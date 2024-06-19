// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/home_centrale_screen.dart';
import 'package:faroty_association_1/routes/app_router.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
// import 'package:integration_part_two/authentication/business_logic/auth_cubit.dart';
// import 'package:integration_part_two/pages/homeCoursier.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telephony/telephony.dart';

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

class _VerificationPageState extends State<VerificationPage> {
  int _secondsLeft = 60;
  Timer? _timer;
  final telephony = Telephony.instance;
  // late TextEditingController _pinController;
  final _pinController = TextEditingController();

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
    // initPlatformState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Future<void> initPlatformState() async {
  //   final bool? result = await telephony.requestPhoneAndSmsPermissions;

  //   if (result != null && result) {
  //     telephony.listenIncomingSms(
  //       onNewMessage: _onMessage,
  //       listenInBackground: false,
  //     );
  //   }

  //   if (!mounted) return;
  // }

  // Future<void> _onMessage(SmsMessage message) async {
  //   print("hhhhhhhhhhh ${message.toString()}");
  //   if (message.address != "ASSO+") {
  //     // setState(() {
  //     //   codeController.text = message.body!;
  //     // });
  //     return;
  //   } else {
  //     String? otp;
  //     setState(() {
  //       List<String> words = message.body!.split(' ');
  //       for (int i = words.length - 1; i >= 0; i--) {
  //         String word = words[i];
  //         if (word.length >= 5 &&
  //             RegExp(r'^[0-9]+$').hasMatch(
  //               word.substring(0, 5),
  //             )) {
  //           otp = word.substring(0, 5);
  //           break;
  //         }
  //       }
  //       print("$otp");
  //       _pinController.text = otp!;
  //     });
  //   }
  // }

  Future handleLogin() async {
    final numeroPhone = widget.numeroPhone;
    final countryCode = widget.countryCode;

    final allCotisationAss = await context
        .read<AuthCubit>()
        .loginFirstCubit(numeroPhone, countryCode);

  }

  // TextEditingController countrycode = TextEditingController();

  final codeController = TextEditingController();

  bool isLoading = false;

  Future<void> handleConfirmation() async {
    context.read<AuthCubit>().confirmationCubit(_pinController.text);
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 55.w,
      height: 60.w,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: AppColors.blackBlue,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: AppColors.colorButton.withOpacity(.2),
        borderRadius: BorderRadius.circular(
          20.r,
        ),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
    );
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
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) async {
                if (state.successLoading) {
                  setState(() {
                    isLoading = true; // Démarre l'indicateur de chargement
                  });
                  // print(
                  //     "objectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobject ${loginInfo!.username!}");
                  var loginInfo = context.read<AuthCubit>().state.loginInfo;

                  await AppCubitStorage().updateCodeAssDefaul(
                      loginInfo!.userGroup!.first.urlcode!);
                  await AppCubitStorage().updateTokenUser(loginInfo.token!);
                  await AppCubitStorage()
                      .updatemembreCode(loginInfo.user!.membre_code!);
                  await AppCubitStorage().updateCodeTournoisDefault(
                      loginInfo.tournoi!.tournois_code!);
                      await AppCubitStorage().updateCodeTournoisHist(loginInfo.tournoi!.tournois_code!);
                  await AppCubitStorage()
                      .updateuserNameKey(loginInfo.username!);
                  await AppCubitStorage()
                      .updatepasswordKey(loginInfo.password!);
                  await context
                      .read<UserGroupCubit>()
                      .AllUserGroupOfUserCubit(loginInfo.token);
                  Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => HomeCentraleScreen(),
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
                  padding:
                      EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          // width: 40.w,
                          // transformAlignment: Alignment.centerLeft,
                          child: BackButtonWidget(
                            colorIcon: AppColors.blackBlue,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 50.h,
                                ),
                                Container(
                                  width: 130.w,
                                  child: Image.asset(
                                    "assets/images/AssoplusFinal.png",
                                    scale: 1,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "vérification".tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 27.sp,
                                    color: AppColors.blackBlue,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 90.h),
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
                                // Container(
                                //   child: Container(
                                //     height: 55.h,
                                //     // decoration: BoxDecoration(
                                //     //   border: Border.all(
                                //     //     width: 1.r,
                                //     //     color: AppColors.blackBlue,
                                //     //   ),
                                //     //   borderRadius: BorderRadius.circular(
                                //     //     10.r,
                                //     //   ),
                                //     // ),
                                //     child: TextField(
                                //       autofocus: true,
                                //       textAlign: TextAlign.center,
                                //       controller: codeController,
                                //       keyboardType: TextInputType.number,
                                //       cursorColor: AppColors.blackBlue,
                                //       style: TextStyle(
                                //         color: AppColors.blackBlue,
                                //         fontSize: 18.sp,
                                //         letterSpacing: 3.w,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //       decoration: InputDecoration(
                                //         focusedBorder: OutlineInputBorder(
                                //           borderSide: BorderSide(
                                //             color: AppColors.colorButton,
                                //             width: 2.w,
                                //           ),
                                //           borderRadius:
                                //               BorderRadius.circular(7.r),
                                //         ),
                                //         border: OutlineInputBorder(
                                //           borderSide: BorderSide(
                                //             color: AppColors.blackBlue,
                                //             width: 2.w,
                                //           ),
                                //           borderRadius:
                                //               BorderRadius.circular(7.r),
                                //         ),
                                //         hintText: "code_à_5_chiffres".tr(),
                                //         hintStyle: TextStyle(
                                //           color: AppColors.blackBlueAccent1,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                Pinput(
                                  length: 5,
                                  autofocus: true,
                                  scrollPadding: const EdgeInsets.all(20),
                                  controller: _pinController,
                                  defaultPinTheme: defaultPinTheme,
                                  focusedPinTheme: defaultPinTheme.copyWith(
                                    decoration: defaultPinTheme.decoration!
                                        .copyWith(
                                            border: Border.all(
                                              color: AppColors.colorButton,
                                              width: 2.w,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                  ),
                                  onCompleted: (pin) async {
                                    await handleConfirmation();
                                  },
                                ),

                                SizedBox(height: 25.h),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50.h,
                                  child: BlocBuilder<AuthCubit, AuthState>(
                                    builder: (Authcontext, Authstate) {
                                      if (Authstate.isLoading == null ||
                                          Authstate.isLoading == true ||
                                          Authstate.isLoadingDetailUser ==
                                              true ||
                                          Authstate.isLoading == null)
                                        return Container(
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.green,
                                            ),
                                          ),
                                        );

                                      return isLoading
                                          ? Center(
                                              child: CircularProgressIndicator(
                                               color: AppColors.green,
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
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    resetTimer();
                                    handleLogin();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 15.h,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${"vous_n'avez_pas_reçu_le_code?".tr()} ",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: _secondsLeft == 0
                                                ? AppColors.blackBlue
                                                : AppColors.blackBlueAccent2,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        _secondsLeft == 0
                                            ? Row(
                                                children: [
                                                  Text(
                                                    "${"renvoyer".tr()} ",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: AppColors
                                                          .greenAssociation,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Icon(
                                                    Icons.double_arrow_outlined,
                                                    size: 8.sp,
                                                    color: AppColors
                                                        .greenAssociation,
                                                  )
                                                ],
                                              )
                                            : GestureDetector(
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
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: AppColors
                                                            .blackBlueAccent2,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .double_arrow_outlined,
                                                      size: 8.sp,
                                                      color: AppColors
                                                          .blackBlueAccent2,
                                                    )
                                                  ],
                                                ),
                                              )

                                        // Text(
                                        //     "00: $_secondsLeft",
                                        //     style: TextStyle(
                                        //       fontSize: 12.sp,
                                        //       fontWeight: FontWeight.w400,
                                        //       color: AppColors.blackBlue,
                                        //     ),
                                        //     textAlign: TextAlign.center,
                                        //   ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                                  child: Image.asset(
                                      "assets/images/FAroty_gris.png"),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
