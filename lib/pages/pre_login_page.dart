import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/loginScreen.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/pages/administrationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreLoginPage extends StatefulWidget {
  const PreLoginPage({super.key});

  @override
  State<PreLoginPage> createState() => _PreLoginPageState();
}

class _PreLoginPageState extends State<PreLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 20.w, right: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    child: Image.asset(
                      "assets/images/Groupe_ou_Asso.png",
                      scale: 3,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Text(
                      "Groups\n& associations",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20.sp,
                        color: AppColors.blackBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.h),
              padding: EdgeInsets.all(10.r),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Text(
                    "Votre comptable express \net connecté".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15.sp,
                      color: AppColors.blackBlue,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 12.h,
                            top: 15.h,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 8.sp,
                                color: AppColors.blackBlue,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Simple et efficace".tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.blackBlue,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 8.sp,
                                color: AppColors.blackBlue,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Globale (cotisations, prêts et épagnes, \ntontines, bilans, ...)".tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.blackBlue,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 12.h,
                            // top: 15,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 8.sp,
                                color: AppColors.blackBlue,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Rapide et sécurisé".tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.blackBlue,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdministrationPage(
                          lienDePaiement: '',
                          
                        )),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      // decoration: BoxDecoration(
                      //   color: AppColors.white,
                      //   borderRadius: BorderRadius.circular(20.r),
                      // ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "CRÉER UN GROUPE/UNE ASSOCIATION".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 17.sp,
                            color: AppColors.backgroundAppBAr),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              // color: AppColors.blackBlueAccent1,
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.r),
                          child: Text(
                            "Votre groupe a déjà été créé ?".tr(),
                            style: TextStyle(
                                fontSize: 16.sp, color: AppColors.blackBlue),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.greenAssociation,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          padding: EdgeInsets.all(15.r),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Connectez-vous".tr().toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 17.sp,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      "msg_condition_utilisation".tr(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.blackBlue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
