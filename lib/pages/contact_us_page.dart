import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
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
          "Contactez nous".tr(),
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
        "Contactez nous".tr(),
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
          child: BackButtonWidget(
            colorIcon: AppColors.white,
          )),
    ),
    body: child,
  );
}

class _ContactUsPageState extends State<ContactUsPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("RETOUR");
    }
  }

  @override
  Widget build(BuildContext context) {
    Uri gmailUrl = Uri.parse('mailto:support@faroty.com');
    Future<void> _launch(Uri url) async {
      await canLaunchUrl(url)
          ? await launchUrl(url)
          : print('could_not_launch_this_app'.tr());
    }

    Future<void> dialNumber(
        {required String phoneNumber, required BuildContext context}) async {
      final url = "tel:$phoneNumber";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print("Unable to call $phoneNumber");
      }

      return;
    }

    // Future<void> _launchSocial(webUrl) async {
    //    launchWeb(
    //     webUrl,
    //     mode: LaunchMode.platformDefault,
    //   );
    // }

    return Material(
      type: MaterialType.transparency,
      child: PageScaffold(
        context: context,
        child: Container(
          margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 30.h),
          // width: MediaQuery.of(context).size.width / 1.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Si vous avez des questions, contactez-nous. Nous nous ferons un plaisir de vous aider !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.blackBlue,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  // left: 20.w,
                  // right: 20.w,
                  top: 30.h,
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          width: 2.w,
                          color: AppColors.greenAssociation.withOpacity(0.15),
                        ),
                      ),
                      child: InkWell(
                        splashColor: AppColors.colorButton.withOpacity(.5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 30.w,
                              height: 65.h,
                            ),
                            Icon(
                              Icons.phone_android_rounded,
                              size: 35.sp,
                              color: AppColors.greenAssociation,
                            ),
                            SizedBox(
                              width: 30.w,
                              height: 65.h,
                            ),
                            Text(
                              '+237 679 910 021',
                              style: TextStyle(
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          updateTrackingData(
                              "contactUs.call", "${DateTime.now()}", {});
                          // _launch(gmailUrl);
                          dialNumber(
                              phoneNumber: "+237 679 910 021",
                              context: context);
                          // _launchInstagram();
                          // launchUrl(
                          //   Uri.parse('https://www.instagram.com/forwheel_app/'),
                          //   mode: LaunchMode.externalApplication,
                          // );
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          width: 2.w,
                          color: AppColors.greenAssociation.withOpacity(0.15),
                        ),
                      ),
                      child: InkWell(
                        splashColor: AppColors.colorButton.withOpacity(.5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 30.w,
                              height: 65.h,
                            ),
                            Icon(
                              Icons.mail_outline_rounded,
                              size: 35.sp,
                              color: AppColors.greenAssociation,
                            ),
                            SizedBox(
                              width: 30.w,
                              height: 65.h,
                            ),
                            Text(
                              'support@faroty.com',
                              style: TextStyle(
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          updateTrackingData(
                              "contactUs.email", "${DateTime.now()}", {});
                          _launch(gmailUrl);
                          // _launchInstagram();
                          // launchUrl(
                          //   Uri.parse('https://www.instagram.com/forwheel_app/'),
                          //   mode: LaunchMode.externalApplication,
                          // );
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 30.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          width: 2.w,
                          color: AppColors.greenAssociation.withOpacity(0.15),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                            decoration: BoxDecoration(
                              // color: AppColors.bleuLight,
                              border: Border(
                                bottom: BorderSide(
                                  width: 2.w,
                                  color: AppColors.greenAssociation
                                      .withOpacity(0.15),
                                ),
                              ),
                            ),
                            child: Text(
                              "Social Media",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.greenAssociation,
                              ),
                            ),
                          ),

                          // SizedBox(height: 20,),

                          InkWell(
                            splashColor: AppColors.colorButton.withOpacity(.5),
                            onTap: () {
                              updateTrackingData("contactUs.linkedin",
                                  "${DateTime.now()}", {});
                              launchWeb(
                                "https://www.linkedin.com/company/faroty/",
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 40.w, right: 40.w),
                              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                              decoration: BoxDecoration(
                                // color: AppColors.bleuLight,
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2.w,
                                    color: AppColors.greenAssociation
                                        .withOpacity(0.15),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 35.h,
                                    height: 35.h,
                                    child: Image.asset(
                                      "assets/images/logo_linkedin.png",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  Text(
                                    "farotyme",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blackBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            splashColor: AppColors.colorButton.withOpacity(.5),
                            onTap: () {
                              updateTrackingData(
                                  "contactUs.x", "${DateTime.now()}", {});
                              launchWeb(
                                "https://x.com/farotyMe/",
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 40.w, right: 40.w),
                              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                // color: AppColors.bleuLight,
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2.w,
                                    color: AppColors.greenAssociation
                                        .withOpacity(0.15),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 35.h,
                                    height: 35.h,
                                    child: Image.asset(
                                      "assets/images/logo_x.png",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  Text(
                                    "farotyme",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blackBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            splashColor: AppColors.colorButton.withOpacity(.5),
                            onTap: () {
                              updateTrackingData("contactUs.instagram",
                                  "${DateTime.now()}", {});
                              launchWeb(
                                "https://www.instagram.com/farotyme/",
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 40.w, right: 40.w),
                              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                // color: AppColors.bleuLight,
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2.w,
                                    color: AppColors.greenAssociation
                                        .withOpacity(0.15),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 35.h,
                                    height: 35.h,
                                    child: Image.asset(
                                      "assets/images/logo_instagram.png",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  Text(
                                    "Faroty",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blackBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            splashColor: AppColors.colorButton.withOpacity(.5),
                            onTap: () {
                              updateTrackingData("contactUs.facebook",
                                  "${DateTime.now()}", {});
                              launchWeb(
                                "https://www.facebook.com/farotyMe/",
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 40.w, right: 40.w),
                              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  // color: AppColors.bleuLight,
                                  // border: Border(
                                  //   bottom: BorderSide(
                                  //     width: 2.w,
                                  //     color: AppColors.greenAssociation
                                  //         .withOpacity(0.15),
                                  //   ),
                                  // ),
                                  ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 35.h,
                                    height: 35.h,
                                    child: Image.asset(
                                      "assets/images/logo_facebook.png",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  Text(
                                    "Faroty",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blackBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
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
