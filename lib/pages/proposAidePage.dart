import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/pages/contact_us_page.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
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
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackButtonWidget(colorIcon: AppColors.white)),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.white,
    appBar: AppBar(
      title: Text(
        "a_propos_et_aide".tr(),
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: BackButtonWidget(colorIcon: AppColors.white)),
    ),
    body: child,
  );
}

class _ProposAidePageState extends State<ProposAidePage> {
  @override
  Widget build(BuildContext context) {
    // Future<void> _launchSocial(webUrl) async {
    //   await launchWeb(
    //     webUrl,
    //     mode: LaunchMode.platformDefault,
    //   );
    // }

    return Material(
      type: MaterialType.transparency,
      child: PageScaffold(
        context: context,
        child: Container(
          // padding: EdgeInsets.only(left: 20.w),
          // width: MediaQuery.of(context).size.width / 1.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.h, color: AppColors.colorButton.withOpacity(.2),),),),
                child: ListTile(
                  splashColor: AppColors.colorButton.withOpacity(.5),
                  onTap: () {
                    updateTrackingData(
                        "aboutHelp.privacyPolicy", "${DateTime.now()}", {});
                    launchWeb("https://faroty.com/privacies");
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
              ),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.h, color: AppColors.colorButton.withOpacity(.2),),),),
                child: ListTile(
                  splashColor: AppColors.colorButton.withOpacity(.5),
                  onTap: () {
                    updateTrackingData(
                        "aboutHelp.conditionOfUse", "${DateTime.now()}", {});
                    launchWeb("https://faroty.com/termes");
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
              ),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.h, color: AppColors.colorButton.withOpacity(.2),),),),
                child: ListTile(
                  splashColor: AppColors.colorButton.withOpacity(.5),
                  onTap: () {
                    updateTrackingData(
                        "aboutHelp.aboutApp", "${DateTime.now()}", {});
                    launchWeb("https://faroty.com/Businesspage");
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
              ),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.h, color: AppColors.colorButton.withOpacity(.2),),),),
                child: ListTile(
                  splashColor: AppColors.colorButton.withOpacity(.5),
                  onTap: () {
                    updateTrackingData(
                        "aboutHelp.helpCenter", "${DateTime.now()}", {});
                    launchWeb("https://faroty.com/helpdesk");
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
              ),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.h, color: AppColors.colorButton.withOpacity(.2),),),),
                child: ListTile(
                  splashColor: AppColors.colorButton.withOpacity(.5),
                  onTap: () {
                    updateTrackingData(
                        "aboutHelp.contactUs", "${DateTime.now()}", {});
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
