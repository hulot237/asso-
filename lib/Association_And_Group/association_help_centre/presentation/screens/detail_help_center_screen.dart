import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/presentation/widgets/widgetCompteCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/business_logic/help_center_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/business_logic/help_center_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/presentation/screens/categorie_help_center_screen.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/presentation/screens/topic_help_center_screen.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailHelpCenterScreen extends StatefulWidget {
  DetailHelpCenterScreen(
      {super.key, required this.title, required this.categorieId});
  String title;
  int categorieId;

  @override
  _DetailHelpCenterScreenState createState() => _DetailHelpCenterScreenState();
}

class _DetailHelpCenterScreenState extends State<DetailHelpCenterScreen> {
  Future<void> handleDetailHelpCategorie(categorieId) async {
    print("response CategoriesTopicsHelpModel!");
    await context.read<HelpCenterCubit>().DetailHelpCategorie(categorieId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleDetailHelpCategorie(widget.categorieId);
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
        body: BlocBuilder<HelpCenterCubit, HelpCenterState>(
            builder: (helpCenterContext, helpCenterState) {
          if (helpCenterState.isLoading == true &&
              helpCenterState.allCategorieTopicHelp == null)
            return Container(
              child: EasyLoader(
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                iconSize: 50.r,
                iconColor: AppColors.blackBlueAccent1,
                image: AssetImage(
                  "assets/images/AssoplusFinal.png",
                ),
              ),
            );
          final currentCategorieTopicHelp =
              context.read<HelpCenterCubit>().state.allCategorieTopicHelp;
          return Stack(
            children: [
              Container(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 30.h, bottom: 70.h),
                  children: [
                    ...currentCategorieTopicHelp!.topics.map(
                      (topic) => Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.h,
                          left: 15.w,
                          right: 15.w,
                        ),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.r),
                          elevation: 1,
                          shadowColor: Colors.black.withOpacity(1),
                          child: ListTile(
                            tileColor: Colors.transparent,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  topic.title!,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackBlue,
                                  ),
                                  // maxLines: 1,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  topic.content!,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppColors.blackBlueAccent1,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18.sp,
                              color: AppColors.blackBlue,
                            ),
                            onTap: () {
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategorieHelpCenterScreen(
                                    title: topic.title!,
                                    content: topic.content!,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                    ),
                    ...currentCategorieTopicHelp.categories.map(
                      (category) => Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.h,
                          left: 15.w,
                          right: 15.w,
                        ),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.r),
                          elevation: 1,
                          shadowColor: Colors.black.withOpacity(1),
                          child: ListTile(
                            tileColor: Colors.transparent,
                            title: Text(
                              category.name!,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackBlue,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18.sp,
                              color: AppColors.blackBlue,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TopicHelpCenterScreen(
                                    title: category.name!,
                                    categorieId: category.id!,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (helpCenterState.isLoading == true &&
                  helpCenterState.allCategorieTopicHelp != null)
                Container(
                  child: EasyLoader(
                    backgroundColor: Color.fromARGB(0, 255, 255, 255),
                    iconSize: 50.r,
                    iconColor: AppColors.blackBlueAccent1,
                    image: AssetImage(
                      "assets/images/AssoplusFinal.png",
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
