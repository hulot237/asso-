import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/presentation/widgets/widgetCompteCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/business_logic/help_center_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/business_logic/help_center_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/presentation/screens/detail_help_center_screen.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  Future<void> handleAllHelpCategori() async {
    print("response CategoriesHelpModel!");
    await context.read<HelpCenterCubit>().AllHelpCategorie();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleAllHelpCategori();
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
            "Centre d'aide".tr(),
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
              helpCenterState.allCategorieHelp == null)
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
          final currentHelpCategorie =
              context.read<HelpCenterCubit>().state.allCategorieHelp;
          return Container(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                  child: SizedBox(
                    child: TextField(
                      enabled: false, // Désactiver le TextField
                      decoration: InputDecoration(
                        hintText: "Rechercher un sujet dans l'aide",
                        hintStyle: TextStyle(
                          color: AppColors.blackBlueAccent1,
                          fontSize: 16.sp,
                        ),
                        fillColor: AppColors.white,
                        filled: true,
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15.r,
                          ),
                          borderSide: BorderSide(
                            color: AppColors.blackBlueAccent1,
                            width: 2.0,
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Icon(
                            Icons.search,
                            color: AppColors.blackBlueAccent1,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: currentHelpCategorie!.length,
                        itemBuilder: (context, index) {
                          var currentHelpCategori = currentHelpCategorie[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: 10.h,
                              left: 15.w,
                              right: 15.w,
                            ),
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              elevation: 2,
                              shadowColor: AppColors.blackBlueAccent1,
                              child: ListTile(
                                tileColor: Colors.transparent,
                                title: Text(
                                  currentHelpCategori.name!,
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
                                      builder: (context) =>
                                          DetailHelpCenterScreen(
                                        title: currentHelpCategori.name!,
                                        categorieId: currentHelpCategori.id!,
                                      ),
                                    ),
                                  );
                                },
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
          );
        }),
      ),
    );
  }
}
