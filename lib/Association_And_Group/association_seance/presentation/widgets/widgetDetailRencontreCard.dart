import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/button_rapport_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class widgetDetailRencontreCard extends StatefulWidget {
  var rapportUrl;

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
    required this.rapportUrl,
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
  bool load = false;
  @override
  Widget build(BuildContext context) {
    final TabController _tabController2 = TabController(length: 2, vsync: this);

    return Stack(
      children: [
        Container(
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
                          if (widget.isActiveRencontre == 0 &&
                              isPasseDate(widget.dateRencontreAPI))
                            Container(
                              padding: EdgeInsets.all(7.r),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(24, 212, 0, 0),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(1.r),
                                child: Text(
                                  "Archivé".tr(),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                          if (widget.isActiveRencontre == 1 &&
                              isPasseDate(widget.dateRencontreAPI))
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
                                    fontSize: 10.sp,
                                  ),
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
                                    fontSize: 10.sp,
                                  ),
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
                                  margin: EdgeInsets.only(
                                    top: 3.h,
                                  ),
                                  child: Text(
                                    formatDateLiteral(widget.dateRencontreAPI),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.blackBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blackBlue.withOpacity(0.06),
                        borderRadius: BorderRadius.all(
                          Radius.circular(7.w),
                        ),
                      ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            bottom: 3.h,
                                          ),
                                          child: Text(
                                            "Sanctions",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w800,
                                              color: Color.fromARGB(
                                                  171, 20, 45, 99),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 16.w,
                                          height: 16.w,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.green,
                                              strokeWidth: 0.1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              final currentDetailSeanceSanction = context
                                  .read<SeanceCubit>()
                                  .state
                                  .detailSeance!["sanctions"];
                              return GestureDetector(
                                onTap: () {
                                  if (checkTransparenceStatus(
                                      context
                                          .read<UserGroupCubit>()
                                          .state
                                          .changeAssData!
                                          .user_group!
                                          .configs,
                                      context
                                          .read<AuthCubit>()
                                          .state
                                          .detailUser!["isMember"]))
                                    Modal().showModalPersonSanctionner(
                                        context, currentDetailSeanceSanction);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        width: 2.5.r,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    color: Colors.transparent,
                                  ),
                                  // alignment: Alignment.center,
                                  padding: EdgeInsets.all(10.r),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 3.h),
                                        child: Text(
                                          "Sanctions",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.blackBlueAccent1,
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
                                if (checkTransparenceStatus(
                                    context
                                        .read<UserGroupCubit>()
                                        .state
                                        .changeAssData!
                                        .user_group!
                                        .configs,
                                    context
                                        .read<AuthCubit>()
                                        .state
                                        .detailUser!["isMember"]))
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
                                      width: 2.5.r,
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
                                          color: AppColors.blackBlueAccent1,
                                        ),
                                      ),
                                      // margin: EdgeInsets.only(right: 5),
                                    ),
                                    BlocBuilder<SeanceCubit, SeanceState>(
                                        builder: (context, state) {
                                      if (state.isLoading == null ||
                                          state.isLoading == true)
                                        return Container(
                                          width: 16.w,
                                          height: 16.w,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.green,
                                              strokeWidth: 0.1,
                                            ),
                                          ),
                                        );
                                      String presence =
                                          ("${context.read<SeanceCubit>().state.detailSeance!["abs"].length + context.read<SeanceCubit>().state.detailSeance!["presents"].length}");
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
                    // if (!context.read<AuthCubit>().state.detailUser!["isMember"])
                    BlocBuilder<SeanceCubit, SeanceState>(
                        builder: (context, state) {
                      if (state.isLoading == null || state.isLoading == true)
                        return Container();
                      String currentDetailSeanceRapport = context
                              .read<SeanceCubit>()
                              .state
                              .detailSeance!["rapport"] ??
                          "";
                      print("rrtt ${currentDetailSeanceRapport}");

                      if (currentDetailSeanceRapport == "") {
                        return Container();
                      } else {
                        return InkWell(
                          onTap: () async {
                             launchWeb(
                              "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/details-seances/${widget.codeSeance}&app_mode=mobile",
                            );
                          },
                          child: currentDetailSeanceRapport != ""
                              ? ButtonRapport(
                                  nomElement:
                                      "${"rencontre".tr()} ${widget.identifiantRencontre}",
                                  rapportUrl: "$currentDetailSeanceRapport",
                                )
                              : Container(),
                        );
                      }
                    }),
                    Container(
                      margin: EdgeInsets.only(
                        top: 8.h,
                      ),
                      padding: EdgeInsets.only(
                        top: 8.h,
                        bottom: 0.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: .5.r,
                            color: AppColors.blackBlueAccent2,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (!context
                              .read<AuthCubit>()
                              .state
                              .detailUser!["isMember"])
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  // updateTrackingData("home.btnAdminister",
                                  //     "${DateTime.now()}", {});
                                   launchWeb(
                                    "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/details-seances/${widget.codeSeance}&app_mode=mobile",
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      // color: const Color.fromARGB(255, 0, 0, 0),
                                      height: 17.h,
                                      // width: 230,
                                      child: SvgPicture.asset(
                                        "assets/images/folderManageSimpleIcon.svg",
                                        fit: BoxFit.scaleDown,
                                        color: AppColors.blackBlueAccent1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      "Gerer".tr(),
                                      style: TextStyle(
                                        color: AppColors.blackBlueAccent1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (!context
                              .read<AuthCubit>()
                              .state
                              .detailUser!["isMember"])
                            if (widget.isActiveRencontre == 1 &&
                                isPasseDate(widget.dateRencontreAPI))
                              // if (widget.nomBeneficiaire != "")
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    _showSimpleModalDialog(
                                        context,
                                        widget.identifiantRencontre,
                                        widget.codeSeance);
                                    // updateTrackingData(
                                    //       "home.btnwithdrawnFundsContribution",
                                    //       "${DateTime.now()}", {});
                                    // SeanceRepository().CloseSeance(widget.codeSeance);
                                    //   await launchWeb(
                                    //     "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations-details/${widget.codeCotisation}?query=1&app_mode=mobile",
                                    //     mode: LaunchMode.platformDefault,
                                    //   );
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 17.h,
                                        child: SvgPicture.asset(
                                          "assets/images/closeSeanceIcon.svg",
                                          fit: BoxFit.scaleDown,
                                          color: AppColors.blackBlueAccent1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Text(
                                        "Cloturer".tr(),
                                        // textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.blackBlueAccent1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          Expanded(
                            child: InkWell(
                              splashColor: AppColors.blackBlue,
                              onTap: () {
                                // print("object3");
                                Share.share(
                                    "Nouvelle séance créée dans le groupe ${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name} dont le récepteur est *${widget.nomRecepteurRencontre}* au lieu-dit *${widget.lieuRencontre}* le *${formatDateLiteral(widget.dateRencontreAPI)}*.");
                                //  Voir les détails de la séance : xxx");
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 17.h,
                                    child: SvgPicture.asset(
                                      "assets/images/shareSimpleIcon.svg",
                                      fit: BoxFit.scaleDown,
                                      color: AppColors.blackBlueAccent1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    "Partager".tr(),
                                    style: TextStyle(
                                      color: AppColors.blackBlueAccent1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (!context
                              .read<AuthCubit>()
                              .state
                              .detailUser!["isMember"])
                            // if (widget.nomBeneficiaire != "")
                            // Expanded(
                            //   child: InkWell(
                            //     onTap: () async {
                            //       // updateTrackingData(
                            //       //       "home.btnwithdrawnFundsContribution",
                            //       //       "${DateTime.now()}", {});
                            //       //   await launchWeb(
                            //       //     "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations-details/${widget.codeCotisation}?query=1&app_mode=mobile",
                            //       //     mode: LaunchMode.platformDefault,
                            //       //   );
                            //     },
                            //     child: Column(
                            //       // mainAxisAlignment: MainAxisAlignment.center,
                            //       // crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Container(
                            //           // color: AppColors.blackBlue,
                            //           height: 17.h,
                            //           child: SvgPicture.asset(
                            //             "assets/images/threePointIcon.svg",
                            //             fit: BoxFit.scaleDown,
                            //             color: AppColors.blackBlueAccent1,
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           height: 3.h,
                            //         ),
                            //         Text(
                            //           "Plus".tr(),
                            //           textAlign: TextAlign.center,
                            //           style: TextStyle(
                            //             color: AppColors.blackBlueAccent1,
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 11.sp,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: PopupMenuButton(
                                elevation: 5,
                                shadowColor: AppColors.barrierColorModal,
                                // clipBehavior: Clip.antiAlias,
                                // surfaceTintColor: AppColors.colorButton,
                                child: Column(
                                  children: [
                                    Container(
                                      // color: AppColors.blackBlue,
                                      height: 17.h,
                                      child: SvgPicture.asset(
                                        "assets/images/threePointIcon.svg",
                                        fit: BoxFit.scaleDown,
                                        color: AppColors.blackBlueAccent1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      "Plus".tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.blackBlueAccent1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                onSelected: (value) async {
                                  if (value == "cotisation") {
                                    print(value);
                                     launchWeb(
                                      "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/details-seances/${widget.codeSeance}?query=1&app_mode=mobile",
                                    );
                                  } else if (value == "sanction") {
                                     launchWeb(
                                      "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/details-seances/${widget.codeSeance}?query=2&app_mode=mobile",
                                    );
                                  } else if (value == "tontine") {
                                     launchWeb(
                                      "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/details-seances/${widget.codeSeance}?query=4&app_mode=mobile",
                                    );
                                  } else if (value == "rappot") {
                                     launchWeb(
                                      "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/details-seances/${widget.codeSeance}?query=3&app_mode=mobile",
                                    );
                                  } else if (value == "pdf") {
                                    setState(() {
                                      load = true;
                                    });
                                    await SeanceRepository()
                                        .genereRapport(widget.codeSeance);
                                    await Future.delayed(Duration(seconds: 10));

                                    await context
                                        .read<SeanceCubit>()
                                        .detailSeanceCubit(widget.codeSeance);
                                    print("${widget.codeSeance}");
                                    context
                                        .read<DetailTournoiCourantCubit>()
                                        .detailTournoiCourantCubit(
                                          AppCubitStorage().state.codeTournois,
                                        );
                                    // // context.read<RecentEventCubit>().AllRecentEventCubit(AppCubitStorage().state.membreCode);
                                    setState(() {
                                      load = false;
                                    });
                                    // Navigator.pop(context);
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry>[
                                  PopupMenuItem(
                                    value: "cotisation",
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            height: 22.h,
                                            child: SvgPicture.asset(
                                              "assets/images/addCotisation.svg",
                                              fit: BoxFit.scaleDown,
                                              color: AppColors.blackBlueAccent1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Créer une cotisation',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: "sanction",
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            height: 22.h,
                                            child: SvgPicture.asset(
                                              "assets/images/addSanction.svg",
                                              fit: BoxFit.scaleDown,
                                              color: AppColors.blackBlueAccent1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Créer une sanction',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: "tontine",
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            height: 22.h,
                                            child: SvgPicture.asset(
                                              "assets/images/paramTontine.svg",
                                              fit: BoxFit.scaleDown,
                                              color: AppColors.blackBlueAccent1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Paramétrer la tontine',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: "rappot",
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            height: 22.h,
                                            child: SvgPicture.asset(
                                              "assets/images/saisirRapport.svg",
                                              fit: BoxFit.scaleDown,
                                              color: AppColors.blackBlueAccent1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Saisir le rapport',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: "pdf",
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            height: 22.h,
                                            child: SvgPicture.asset(
                                              "assets/images/downPdf.svg",
                                              fit: BoxFit.scaleDown,
                                              color: AppColors.blackBlueAccent1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Générer le rapport PDF',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        
                        
                        
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (load)
          Positioned.fill(
            child: Container(
              color: Color.fromARGB(0, 20, 45, 99),
              child: Center(
                child: SizedBox(
                  height: 20.r,
                  width: 20.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.r,
                    color: AppColors.green,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  _showSimpleModalDialog(context, code, codeRencontre) {
    showDialog(
      context: context,
      barrierColor: AppColors.barrierColorModal,
      builder: (BuildContext context) {
        return Center(
          child: ConfirmWidget(
            code: code,
            codeRencontre: codeRencontre,
          ),
        );
      },
    );
  }
}

class ConfirmWidget extends StatefulWidget {
  var code;

  var codeRencontre;

  ConfirmWidget({
    super.key,
    required this.code,
    required this.codeRencontre,
  });

  @override
  State<ConfirmWidget> createState() => _ConfirmWidgetState();
}

class _ConfirmWidgetState extends State<ConfirmWidget> {
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      height: 130.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20.r,
        ),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text.rich(
            TextSpan(
              text: 'Confirmer la cloturer de la ',
              style: TextStyle(fontSize: 16.sp, color: AppColors.blackBlue),
              children: <InlineSpan>[
                TextSpan(
                  text: "rencontre".tr(),
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackBlue),
                ),
                TextSpan(
                  text: ' ${widget.code} ?',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackBlue),
                ),
              ],
            ),
          ),
          // SizedBox(height: 10.h,),
          GestureDetector(
            onTap: () async {
              setState(() {
                load = true;
              });
              print(load);
              await SeanceRepository().CloseSeance(widget.codeRencontre);

              context
                  .read<SeanceCubit>()
                  .detailSeanceCubit(widget.codeRencontre);
              context
                  .read<DetailTournoiCourantCubit>()
                  .detailTournoiCourantCubit(
                      AppCubitStorage().state.codeTournois);
              // context.read<RecentEventCubit>().AllRecentEventCubit(AppCubitStorage().state.membreCode);
              setState(() {
                load = false;
              });
              Navigator.pop(context);
            },
            child: load == true
                ? CircularProgressIndicator(
                    color: AppColors.green,
                  )
                : Container(
                    padding: EdgeInsets.only(
                        top: 10.h, right: 30.w, left: 30.w, bottom: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.colorButton,
                    ),
                    child: Text(
                      "confirmer".tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
