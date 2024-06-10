import 'dart:convert';

import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AddAssoWidget extends StatefulWidget {
  AddAssoWidget({
    super.key,
    required this.screenSource,
  });
    String screenSource; 

  @override
  State<AddAssoWidget> createState() => _AddAssoWidgetState();
}

class _AddAssoWidgetState extends State<AddAssoWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        updateTrackingData("${widget.screenSource}", "${DateTime.now()}", {});
        // print("${dataForCookies}");
        print("objectobjectobjectobjectobject${context.read<AuthCubit>().state.dataCookies}");
         launchWeb(
          "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://business.faroty.com/groups&app_mode=mobile",
        );
      },
      child: Container(
        padding: EdgeInsets.all(1.r),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.r,
            color: AppColors.blackBlue,
          ),
          color: AppColors.blackBlueAccent2,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: SvgPicture.asset(
          "assets/images/addIcon.svg",
          fit: BoxFit.scaleDown,
          color: AppColors.white,
        ),
      ),
    );
  }
}