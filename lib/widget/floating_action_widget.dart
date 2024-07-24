import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popover/popover.dart';

class FloatingAction extends StatelessWidget {
  const FloatingAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.r,
      height: 50.r,
      child: FloatingActionButton(
        elevation: 2,
        backgroundColor: AppColors.colorButton,
        onPressed: () {
          showPopover(
            context: context,
            bodyBuilder: (context) => Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   width: 200.w,
                  //   color: AppColors.white,
                  //   padding: EdgeInsets.only(
                  //       top: 10.h, bottom: 10.h, left: 10.w, right: 20.w),
                  //   child: Text(
                  //     textAlign: TextAlign.center,
                  //     "Créer une rencontre",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 16.sp,
                  //       color: AppColors.blackBlue,
                  //     ),
                  //   ),
                  // ),
      
                  Material(
                    color: AppColors.white,
                    child: InkWell(
                      onTap: () {
                        launchWeb(
                          "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/seances?query=1&app_mode=mobile",
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 200.w,
                        
                        padding: EdgeInsets.only(
                            top: 10.h, bottom: 10.h, left: 10.w, right: 20.w),
                        child: Text(
                          "Créer une rencontre".tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColors.blackBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: AppColors.white,
                    child: InkWell(
                      onTap: () {
                        launchWeb(
                          "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations?query=1&app_mode=mobile",
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 200.w,
                        padding: EdgeInsets.only(
                            top: 10.h, bottom: 10.h, left: 10.w, right: 20.w),
                        child: Text(
                          "Créer une cotisation".tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColors.blackBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: AppColors.white,
                    child: InkWell(
                      onTap: () {
                        launchWeb(
                          "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/sanctions?query=1&app_mode=mobile",
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 200.w,
                        padding: EdgeInsets.only(
                            top: 10.h, bottom: 10.h, left: 10.w, right: 20.w),
                        child: Text(
                          "Créer une sanction".tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColors.blackBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (checkTransparenceLoans(
                      context
                          .read<UserGroupCubit>()
                          .state
                          .changeAssData!
                          .user_group!
                          .configs,
                      context.read<AuthCubit>().state.detailUser!["isMember"]))
                    Material(
                    color: AppColors.white,
                      child: InkWell(
                        onTap: () {
                          launchWeb(
                            "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/loan?query=1&app_mode=mobile",
                          );
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 200.w,
                          // color: AppColors.white,
                          padding: EdgeInsets.only(
                              top: 10.h, bottom: 10.h, left: 10.w, right: 20.w),
                          child: Text(
                            "Créer un epargne".tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.blackBlue,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            onPop: () => print('Popover was popped!'),
            direction: PopoverDirection.left,
      
            backgroundColor: AppColors.backgroundAppBAr,
            // width: 200,
            barrierColor: AppColors.barrierColorModal,
            height: checkTransparenceLoans(
                    context
                        .read<UserGroupCubit>()
                        .state
                        .changeAssData!
                        .user_group!
                        .configs,
                    context.read<AuthCubit>().state.detailUser!["isMember"])
                ? 150.h
                : 110.h,
            arrowHeight: 10.h,
            arrowWidth: 0.w,
            contentDyOffset: -110.h,
            // contentDxOffset: -100,
          );
        },
        child: Container(
          // color: AppColors.green,
          child: SvgPicture.asset(
            width: 40.r,
            "assets/images/addIcon.svg",
            fit: BoxFit.cover,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
