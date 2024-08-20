import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/presentation/widgets/widgetCompteCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/business_logic/help_center_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/business_logic/help_center_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorieHelpCenterScreen extends StatefulWidget {
  CategorieHelpCenterScreen(
      {super.key, required this.title, required this.content});
  String title;
  String content;

  @override
  _CategorieHelpCenterScreenState createState() =>
      _CategorieHelpCenterScreenState();
}

class _CategorieHelpCenterScreenState extends State<CategorieHelpCenterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          centerTitle: false,
          // toolbarHeight: 130.h,
          title: Text(
            "${widget.title}".tr(),
            // "historiques".tr(),
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.white,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: AppColors.backgroundAppBAr,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackButtonWidget(
              colorIcon: AppColors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20.r),
            padding: EdgeInsets.only(
              top: 20.h,
              bottom: 20.h,
              right: 15.w,
              left: 15.w,
            ),
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.h,
                  ),
                  child: Text(
                    widget.content,
                    style: TextStyle(fontSize: 15.sp,color: AppColors.blackBlue,),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Avez-vous la réponse à votre question ?",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.thumb_up,
                          color: AppColors.blackBlueAccent1,
                          size: 30.sp,
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        Icon(
                          Icons.thumb_down,
                          color: AppColors.blackBlueAccent1,
                          size: 30.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
