import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/business_logic/membres_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/business_logic/membres_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MembersAssPage extends StatefulWidget {
  const MembersAssPage({super.key});

  @override
  State<MembersAssPage> createState() => _MembersAssPageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.pageBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.backgroundAppBAr,
        middle: Text(
          "Liste des membres".tr(),
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
            size: 20.sp,
          ),
        ),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    appBar: AppBar(
      title: Text(
        "Liste des membres".tr(),
        style: TextStyle(fontSize: 16.sp, color: AppColors.white),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: AppColors.white,
          size: 16.sp,
        ),
      ),
    ),
    body: child,
  );
}

class _MembersAssPageState extends State<MembersAssPage> {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, false, true];

  Future<void> handleShowMembers(codeAssociation) async {
    final detailCotisation =
        await context.read<MembreCubit>().showMembersAss(codeAssociation);

    if (detailCotisation != null) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      context: context,
      child: Material(
        child: Container(
          margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
          child: Column(
            children: [
              BlocBuilder<MembreCubit, MembreState>(
                  builder: (membreContext, membreState) {
                if (membreState.allMembers == null &&
                    membreState.isLoading == true)
                  return Expanded(
                    child: Center(
                      child: EasyLoader(
                        backgroundColor: Color.fromARGB(0, 255, 255, 255),
                        iconSize: 50.r,
                        iconColor: AppColors.blackBlueAccent1,
                        image: AssetImage(
                          "assets/images/AssoplusFinal.png",
                        ),
                      ),
                    ),
                  );
                final currentMembers =
                    membreContext.read<MembreCubit>().state.allMembers;
                return Expanded(
                  child: Stack(
                    children: [
                      ListView.separated(
                        itemCount: currentMembers!.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          final itemMembers = currentMembers[index];
                          return Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 65.w,
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Modal().showFullPicture(
                                              context,
                                              itemMembers!.photo_profil == null
                                                  ? "https://services.faroty.com/images/avatar/avatar.png"
                                                  : "${Variables.LienAIP}${itemMembers!.photo_profil}",
                                              "${itemMembers.first_name} ${itemMembers.last_name == null ? '' : itemMembers.last_name}");
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Container(
                                            width: 50.w,
                                            height: 50.w,
                                            child: Image.network(
                                              itemMembers!.photo_profil == null
                                                  ? "https://services.faroty.com/images/avatar/avatar.png"
                                                  : "${Variables.LienAIP}${itemMembers!.photo_profil}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Container(
                                      //   width: 100.r,
                                      //   height: 100.r,
                                      //   child: Image.network(
                                      //     "${Variables.LienAIP}${itemMembers!.photo_profil == null ? "" : itemMembers!.photo_profil}",
                                      //   ),
                                      //   decoration: BoxDecoration(
                                      //       borderRadius:
                                      //           BorderRadius.circular(360)),
                                      // ),
                                      // CircleAvatar(
                                      //   backgroundImage: NetworkImage(
                                      //     "${Variables.LienAIP}${itemMembers!.photo_profil == null ? "" : itemMembers!.photo_profil}",
                                      //   ),
                                      //   radius: 25,
                                      // ),
                                      if (itemMembers.isSuperAdmin == true)
                                        Positioned(
                                          left: 35.w,
                                          child: Container(
                                            padding: EdgeInsets.all(2.r),
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 239, 239, 239),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              "Admin",
                                              style: TextStyle(
                                                color:
                                                    AppColors.backgroundAppBAr,
                                                fontSize: 8.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${itemMembers.first_name} ${itemMembers.last_name == null ? '' : itemMembers.last_name}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        if (itemMembers.membre_code ==
                                            AppCubitStorage().state.membreCode)
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 0.2.r,
                                                color:
                                                    AppColors.backgroundAppBAr,
                                              ),
                                              color: AppColors.blackBlueAccent2,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.all(2.r),
                                            margin: EdgeInsets.only(left: 2.w),
                                            child: Text(
                                              "(Vous)".tr(),
                                              style: TextStyle(
                                                fontSize: 8.sp,
                                                color: AppColors.blackBlue,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        if (itemMembers.countrycode != 0)
                                          Text(
                                            "+${itemMembers.countrycode} ",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.blackBlue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        Text(
                                          "${formatMontantFrancais(double.parse("${itemMembers.first_phone}"))}",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "${itemMembers.membre_code}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11.sp,
                                          color: AppColors.backgroundAppBAr,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      if (membreState.allMembers != null &&
                          membreState.isLoading == true)
                        Center(
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
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
