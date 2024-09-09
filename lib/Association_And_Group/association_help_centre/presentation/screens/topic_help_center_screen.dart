import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/presentation/widgets/widgetCompteCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/business_logic/help_center_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/business_logic/help_center_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/presentation/screens/categorie_help_center_screen.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopicHelpCenterScreen extends StatefulWidget {
  TopicHelpCenterScreen(
      {super.key, required this.title, required this.categorieId});
  String title;
  int categorieId;

  @override
  _TopicHelpCenterScreenState createState() => _TopicHelpCenterScreenState();
}

class _TopicHelpCenterScreenState extends State<TopicHelpCenterScreen> {
  Future<void> handleTopicHelpCategorie(categorieId) async {
    print("response CategoriesTopicsHelpModel!");
    await context.read<HelpCenterCubit>().DetailHelpTopic(categorieId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleTopicHelpCategorie(widget.categorieId);
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
              helpCenterState.allTopicsHelp == null)
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
          final currentTopicHelp =
              context.read<HelpCenterCubit>().state.allTopicsHelp;
              print("currentTopicHelp $currentTopicHelp");
          return Stack(
            children: [
              Container(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 30.h, bottom: 70.h),
                  itemCount: currentTopicHelp!.length,
                  itemBuilder: (context, index) {
                    var currentTopicHelpItem = currentTopicHelp[index];
                    return Padding(
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
                                  currentTopicHelpItem.title!,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackBlue,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  currentTopicHelpItem.content!,
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
                                    title: currentTopicHelpItem.title!,
                                    content: currentTopicHelpItem.content!,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      
                      
                      
                      // ExpandableListTile(
                      //   title: currentTopicHelpItem.title!,
                      //   description: currentTopicHelpItem.content!,
                      // ),
                    );
                  },
                ),
              ),
               if (helpCenterState.isLoading == true &&
              helpCenterState.allTopicsHelp != null)
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