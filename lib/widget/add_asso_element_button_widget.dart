import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AddAssoElement extends StatelessWidget {
  AddAssoElement({
    super.key,
    required this.text,
    required this.routeElement,
    required this.screenSource,
  });
  String text;
  String routeElement;
  String screenSource;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10.h,
      right: 8.w,
      child: !context.read<AuthCubit>().state.detailUser!["isMember"]
          ? GestureDetector(

              onTap: () async {
                updateTrackingData("${screenSource}","${DateTime.now()}", {});
                await launchUrlString(
                  "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/${routeElement}&app_mode=mobile",
                  mode: LaunchMode.platformDefault,
                );
              },
              child: Container(
                // height: 50,
                decoration: BoxDecoration(
                    color: AppColors.colorButton.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20.r)),
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.w900,
                        fontSize: 12.sp,
                        letterSpacing: 0.2.w,
                      ),
                    ),
                    Container(
                      width: 15.w,
                      height: 15.w,
                      margin: EdgeInsets.only(left: 3.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(360),
                          border: Border.all(width: 0.8.w)),
                      child: SvgPicture.asset(
                        "assets/images/addIcon.svg",
                        fit: BoxFit.scaleDown,
                        color: AppColors.blackBlue,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}
