import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayeWidget extends StatelessWidget {
  const PayeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.colorButton,
                                                borderRadius:
                                                    BorderRadius.circular(3.r)),
                                            margin: EdgeInsets.only(
                                                bottom: 5.h, left: 5.w),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.h, horizontal: 2.w),
                                            child: Text(
                                              "payé".tr(),
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w600,
                                                // fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          );
  }
}