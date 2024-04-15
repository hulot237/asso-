import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/pages/contact_us_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProposAidePage extends StatefulWidget {
  const ProposAidePage({super.key});

  @override
  State<ProposAidePage> createState() => _ProposAidePageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "a_propos_et_aide".tr(),
          style: TextStyle(fontSize: 16.sp, color: AppColors.white),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
            size: 20.sp,
          ),
        ),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.white,
    appBar: AppBar(
      title: Text(
        "a_propos_et_aide".tr(),
        style: TextStyle(fontSize: 16.sp, color: AppColors.white),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: AppColors.white,
          size: 16.sp,
        ),
      ),
    ),
    body: child,
  );
}

class _ProposAidePageState extends State<ProposAidePage> {
  @override
  Widget build(BuildContext context) {
    Future<void> _launchSocial(webUrl) async {
      await launchUrlString(
        webUrl,
        mode: LaunchMode.platformDefault,
      );
    }

    return Material(
      type: MaterialType.transparency,
      child: PageScaffold(
        context: context,
        child: Container(
          margin: EdgeInsets.only(left: 20.w),
          width: MediaQuery.of(context).size.width / 1.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {
                  _launchSocial("https://faroty.com/privacies");
                },
                title: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12.sp,
                        color: AppColors.blackBlue,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.r),
                      child: Text(
                        "Politique de confidentialité".tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.blackBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  _launchSocial("https://faroty.com/termes");
                },
                title: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12.sp,
                        color: AppColors.blackBlue,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.r),
                      child: Text(
                        "Condition d'utilisation".tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.blackBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  _launchSocial("https://faroty.com/Businesspage");
                },
                title: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12.sp,
                        color: AppColors.blackBlue,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.r),
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: Text(
                        "a_propos_de_l'application".tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.blackBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  _launchSocial("https://faroty.com/helpdesk");
                },
                title: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12.sp,
                        color: AppColors.blackBlue,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.r),
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: Text(
                        "centre_d'aide".tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.blackBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactUsPage(),
                    ),
                  );
                },
                title: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12.sp,
                        color: AppColors.blackBlue,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.r),
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: Text(
                        "nous_contacter".tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.blackBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
