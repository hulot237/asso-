import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/push_notification.dart';
import 'package:faroty_association_1/Association_And_Group/association_webview/administration_webview.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/presentation/screens/loginScreen.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/Association_And_Group/association_webview/administrationPage.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//@RoutePage()
class PreLoginScreen extends StatefulWidget {
  const PreLoginScreen({super.key});

  @override
  State<PreLoginScreen> createState() => _PreLoginScreenState();
}

class _PreLoginScreenState extends State<PreLoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    PushNotifications.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.pageBackground,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: Image.asset(
                opacity: AlwaysStoppedAnimation(.6),
                "assets/images/bgDechire.png",
                // width: 180.w,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                // top: MediaQuery.of(context).padding.top,
                left: 20.w,
                right: 20.w,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170.w,
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: AppColors.colorButton.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Image.asset(
                            "assets/images/AssoplusFinalSquare.png",
                            scale: 1,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 50.h),
                              padding: EdgeInsets.only(left: 10.w, top: 20.h),
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Le partenaire financier \nde votre association"
                                        .tr(),
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
                                            bottom: 20.h,
                                            top: 20.h,
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
                                          margin: EdgeInsets.only(bottom: 20.h),
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
                                              Container(
                                                // color:AppColors.backgroundAppBAr ,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.3,
                                                  child: Text(
                                                    "Interactive et globale"
                                                        .tr(),
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color:
                                                          AppColors.blackBlue,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            bottom: 20.h,
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
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 10.w, bottom: 15.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            print(
                                                "Code notification: ${AppCubitStorage().state.tokenNotification}");

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColors.greenAssociation,
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            padding: EdgeInsets.all(11.r),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(
                                              "Rejoignez votre groupe"
                                                  .tr()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18.sp,
                                                color: Colors.black,
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(bottom: 50.h, right: 20.w, left: 20.w),
                    padding: EdgeInsets.all(11.r),
                    decoration: BoxDecoration(
                      // color: AppColors.greenAssociation,
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.white,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdministrationPageWebview(
                              forAdmin: false,
                              urlPage: 'https://business.faroty.com/groups',
                              // urlPage: 'https://business.rush.faroty.com/',
                              forFirstPage: true,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // width: 50,
                              // height: 50,
                              // color: AppColors.red,
                              child: Icon(
                                Icons.add,
                                color: AppColors.backgroundAppBAr,
                              ),
                            ),
                            SizedBox(width: 12,),
                            Text(
                              "Créer un groupe ASSO+".tr().toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16.sp,
                                color: AppColors.backgroundAppBAr,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                  SizedBox(
                    height: 10.h,
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
                              child:
                                  Image.asset("assets/images/FAroty_gris.png"),
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
            ),
          ],
        ),
      ),
    );
  }
}
