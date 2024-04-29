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

class PreLoginPage extends StatefulWidget {
  const PreLoginPage({super.key});

  @override
  State<PreLoginPage> createState() => _PreLoginPageState();
}

class _PreLoginPageState extends State<PreLoginPage> {

  @override
  void initState() {
    // TODO: implement initState
    PushNotifications.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 20.w, right: 20.w),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200.w,
                      child: Image.asset(
                        "assets/images/AssoplusFinal.png",
                        scale: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.h),
                      padding: EdgeInsets.only(left:10.w, top: 20.h),
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
                          Container(
                            child: Padding(
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
                                    width: MediaQuery.of(context).size.width,
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
                                              "Interactive et globale".tr(),
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: AppColors.blackBlue,
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
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdministrationPageWebview(
                                          forAdmin: false,
                                          urlPage: 'https://business.faroty.com/groups',
                                          // urlPage: 'https://business.rush.faroty.com/',
                                          forFirstPage: true,
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
                              // margin: EdgeInsets.only( bottom: 10.h),
                              padding: EdgeInsets.all(15.r),
                              child: Text(
                                "CRÉER UN GROUPE/UNE ASSOCIATION".tr(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16.sp,
                                  color: AppColors.backgroundAppBAr,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(
                            "Code notification: ${AppCubitStorage().state.tokenNotification}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20.r),
                                  child: Text(
                                    "Votre groupe a déjà été créé ?".tr(),
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.blackBlue),
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
                        ],
                      ),
                    ),
                  ],
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
                        child: Image.asset("assets/images/FAroty_gris.png"),
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
    );
  }
}
