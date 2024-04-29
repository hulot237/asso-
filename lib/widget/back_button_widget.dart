import 'dart:io';

import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackButtonWidget extends StatelessWidget {
  var colorIcon;

  BackButtonWidget({
    super.key,
    required this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 30.h,
      color: Colors.transparent,
      child: Center(
        child: Container(
          // color: AppColors.bleuLight,
          width: 20.w,
          height: 20.h,
          // transformAlignment: Alignment.centerLeft,
          child: SvgPicture.asset(
            Platform.isAndroid
                ? "assets/images/leftArrowAndroid.svg"
                : "assets/images/leftArrowIos.svg",
            //           height: 5, width: 5,
            fit: BoxFit.scaleDown,
            color: colorIcon,
          ),
        ),
      ),
    );
  }
}
