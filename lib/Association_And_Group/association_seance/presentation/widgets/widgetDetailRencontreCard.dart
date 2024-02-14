import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class widgetDetailRencontreCard extends StatefulWidget {
  widgetDetailRencontreCard({
    super.key,
    required this.nomRecepteurRencontre,
    required this.prenomRecepteurRencontre,
    required this.identifiantRencontre,
    required this.isActiveRencontre,
    required this.descriptionRencontre,
    required this.lieuRencontre,
    required this.dateRencontre,
    required this.heureRencontre,
    required this.nbrPresence,
    required this.codeSeance,
    required this.dateRencontreAPI,
  });

  String nomRecepteurRencontre;
  String prenomRecepteurRencontre;
  String identifiantRencontre;
  int isActiveRencontre;
  String descriptionRencontre;
  String lieuRencontre;
  String dateRencontre;
  String heureRencontre;
  String nbrPresence;
  String codeSeance;
  String dateRencontreAPI;

  @override
  State<widgetDetailRencontreCard> createState() =>
      _widgetDetailRencontreCardState();
}

class _widgetDetailRencontreCardState extends State<widgetDetailRencontreCard>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final TabController _tabController2 = TabController(length: 2, vsync: this);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(69, 0, 0, 0),
              spreadRadius: 0.5.r,
              blurRadius: 2),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(7.r),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.h, bottom: 5.h),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          // margin: EdgeInsets.only(right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "rencontre".tr(),
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        " ${widget.identifiantRencontre}",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (widget.isActiveRencontre == 0 && isPasseDate(widget.dateRencontreAPI))
                        Container(
                          padding: EdgeInsets.all(7.r),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(24, 212, 0, 0),
                              borderRadius: BorderRadius.circular(7),),
                          child: Container(
                            padding: EdgeInsets.all(1.r),
                            child: Text(
                              "Archivé".tr(),
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,),
                            ),
                          ),
                        ),

                      if ( widget.isActiveRencontre == 1 && isPasseDate(widget.dateRencontreAPI))
                        Container(
                          padding: EdgeInsets.all(7.r),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(24, 212, 0, 0),
                              borderRadius: BorderRadius.circular(7)),
                          child: Container(
                            padding: EdgeInsets.all(1.r),
                            child: Text(
                              "terminé".tr(),
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,),
                            ),
                          ),
                        ),

                        if (!isPasseDate(widget.dateRencontreAPI))
                         Container(
                          padding: EdgeInsets.all(7.r),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(43, 0, 212, 7),
                              borderRadius: BorderRadius.circular(7)),
                          child: Container(
                            padding: EdgeInsets.all(1.r),
                            child: Text(
                              "en_cours".tr(),
                              style: TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,),
                            ),
                          ),
                        )
                      
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "recepteur".tr(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(125, 20, 45, 99),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3.h),
                        child: Text(
                          "${widget.nomRecepteurRencontre} ${widget.prenomRecepteurRencontre}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // width: MediaQuery.of(context).size.width / 1.1,
                  margin: EdgeInsets.only(top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "lieu_de_la_réception".tr(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(125, 20, 45, 99),
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 3.h),
                                      child: Text(
                                        widget.lieuRencontre,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5.w),
                                    child: Icon(
                                      Icons.maps_home_work_rounded,
                                      size: 13.sp,
                                      color: AppColors.blackBlue,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                "dateheure".tr(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(125, 20, 45, 99),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3.h,),
                              child: Text(
                                formatDateLiteral(widget.dateRencontreAPI),
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.blackBlue,
                                    fontWeight: FontWeight.w600,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h,),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(14, 20, 45, 99),
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BlocBuilder<SeanceCubit, SeanceState>(
                            builder: (context, state) {
                          if (state.isLoading == null ||
                              state.isLoading == true)
                            return GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                                // alignment: Alignment.center,
                                padding: EdgeInsets.all(10.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 3.h,),
                                      child: Text(
                                        "Sanctions",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w800,
                                          color:
                                              Color.fromARGB(171, 20, 45, 99),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 16.w,
                                      height: 16.w,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.bleuLight,
                                          strokeWidth: 0.1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          final currentDetailSeanceSanction = context.read<SeanceCubit>().state.detailSeance!["sanctions"];
                          return GestureDetector(
                            onTap: () {
                              if (checkTransparenceStatus(context.read<UserGroupCubit>().state.changeAssData!.user_group!.configs, context.read<AuthCubit>().state.detailUser!["isMember"]))
                                Modal().showModalPersonSanctionner(context, currentDetailSeanceSanction);
                            },
                            child: Container(
                              color: Colors.transparent,
                              // alignment: Alignment.center,
                              padding: EdgeInsets.all(10.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 3.h),
                                    child: Text(
                                      "Sanctions",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w800,
                                        color: Color.fromARGB(171, 20, 45, 99),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${currentDetailSeanceSanction.length}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.blackBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (checkTransparenceStatus( context.read<UserGroupCubit>().state.changeAssData!.user_group!.configs,
                                context.read<AuthCubit>().state.detailUser!["isMember"]))
                              Modal().showModalPersonPresent(
                                  context,
                                  _tabController2,
                                  context
                                      .read<SeanceCubit>()
                                      .state
                                      .detailSeance!["abs"],
                                  context
                                      .read<SeanceCubit>()
                                      .state
                                      .detailSeance!["presents"]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  width: 2.r,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.all(10.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 3.h),
                                  child: Text(
                                    "présence".tr(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromARGB(171, 20, 45, 99),
                                    ),
                                  ),
                                  // margin: EdgeInsets.only(right: 5),
                                ),
                                BlocBuilder<SeanceCubit, SeanceState>( builder: (context, state) {
                                  if (state.isLoading == null || state.isLoading == true)
                                    return Container(
                                      width: 16.w,
                                      height: 16.w,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.bleuLight,
                                          strokeWidth: 0.1,
                                        ),
                                      ),
                                    );
                                  String presence = ("${context.read<SeanceCubit>().state.detailSeance!["abs"].length + context.read<SeanceCubit>().state.detailSeance!["presents"].length}");
                                  return Container(
                                    child: Text(
                                      presence,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.blackBlue,
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
