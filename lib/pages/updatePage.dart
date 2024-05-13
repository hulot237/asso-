import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              margin: EdgeInsets.only(left: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 200.h,
                        ),
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
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          "Mettre à jour votre application à la dernière version".tr(),
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w900,
                              color: AppColors.blackBlue),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: 30.w,
                        ),
                        child: Text(
                          "${"Une toute nouvelle version de l'application Asso+ est disponible sur".tr()} ${Platform.isIOS ? 'App Store' : 'Play Store'}. ${"Veuillez mettre à jour votre application afin d'utiliser toutes nos nouvelles fonctionnalités.".tr()}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.backgroundAppBAr,
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      await launchUrlString(
                        Platform.isIOS
                            ? "https://apps.apple.com/cm/app/asso/id6483809142?l=en-GB"
                            : "https://play.google.com/store/apps/details?id=com.faroty.groups&pcampaignid=web_share",
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.colorButton,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50.h,
                      child: Center(
                        child: Text(
                          "Mettre à jour".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
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
    );
  }
}


// Update your application to the latest version
// A brand new version of the Food Fuels app is available in the App Store. Please update your app to use all of our amazing features.