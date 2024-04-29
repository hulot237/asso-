import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/screens/homeScreen.dart';
import 'package:faroty_association_1/screens/settingsScreen.dart';
import 'package:faroty_association_1/screens/HistoriqueScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Widget PageScaffold({
//   required BuildContext context,
//   required List<Widget> child,
//   required List<BottomNavigationBarItem> itemListAndroid,
//   required List<BottomNavigationBarItem> itemListIos,
//   required Widget childBottomNavBar,
//   required int indexPage,
// }) {
//   Future<void> handleAllUserGroup() async {
//     final AllUserGroup = await context
//         .read<UserGroupCubit>()
//         .AllUserGroupOfUserCubit(AppCubitStorage().state.tokenUser);
//   }

//   Future<void> handleTournoiDefault() async {
//     final detailTournoiCourant = await context
//         .read<DetailTournoiCourantCubit>()
//         .detailTournoiCourantCubit(AppCubitStorage().state.codeTournois);
//   }

//   Future handleRecentEvent(codeMembre) async {
//     final allRecentEvent =
//         await context.read<RecentEventCubit>().AllRecentEventCubit(codeMembre);
//   }

//   Future handleChangeAss(codeAss) async {
//     final allCotisationAss =
//         await context.read<UserGroupCubit>().ChangeAssCubit(codeAss);
//   }

//   Future<void> handleDetailUser(userCode, codeTournoi) async {
//     final allCotisationAss =
//         await context.read<AuthCubit>().detailAuthCubit(userCode, codeTournoi);
//   }

//   Future<void> handleAllCotisationAssTournoi(codeTournoi, codeMembre) async {
//     final allCotisationAss = await context
//         .read<CotisationCubit>()
//         .AllCotisationAssTournoiCubit(codeTournoi, codeMembre);
//   }

//   Future<void> handleAllCompteAss(codeAssociation) async {
//     final allCotisationAss =
//         await context.read<CompteCubit>().AllCompteAssCubit(codeAssociation);
//   }

//   Future countNotifications() async {
//     final countNotificationsVar =
//         await context.read<NotificationCubit>().countNotification();
//   }

//   if (Platform.isIOS) {
//     return CupertinoTabScaffold(
//       backgroundColor: AppColors.pageBackground,
//       tabBar: CupertinoTabBar(
//         iconSize: 25.sp,
//         activeColor: AppColors.colorButton,
//         inactiveColor: AppColors.blackBlueAccent1,
//         height: 60.h,
//         items: itemListIos,
//         onTap: (index) {
//           if (index == 0) {
//             handleAllUserGroup();
//             handleTournoiDefault();
//             handleRecentEvent(AppCubitStorage().state.membreCode);
//             handleChangeAss(AppCubitStorage().state.codeAssDefaul);
//             handleDetailUser(AppCubitStorage().state.membreCode,
//                 AppCubitStorage().state.codeTournois);
//           }

//           if (index == 1) {
//             handleTournoiDefault();
//             handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournois,
//                 AppCubitStorage().state.membreCode);
//             handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
//           }

//           if (index == 2) {
//             countNotifications();
//           }
//           // setState(
//           //   () {
//           //     widget.pageIndex = index;
//           //   },
//           // );
//         },
//       ),
//       tabBuilder: (BuildContext context, int index) {
//         return CupertinoTabView(
//           builder: (BuildContext context) {
//             return child[index];
//           },
//         );
//       },
//     );
//   }

//   return Scaffold(
//     backgroundColor: AppColors.pageBackground,
//     // bottomNavigationBar:
//     body: child[indexPage],
//   );
// }

Widget PageScaffold({
  required BuildContext context,
  required List<Widget> child,
  // required List<BottomNavigationBarItem> itemListAndroid,
  required List<BottomNavigationBarItem> itemListIos,
  required dynamic childBottomNavBar,
  required int indexPage,
}) {
  if (Platform.isIOS) {
    return CupertinoTabScaffold(
      backgroundColor: AppColors.pageBackground,
      tabBar: childBottomNavBar,
      tabBuilder: (BuildContext context, int index) {
        // return CupertinoTabView(
        //   builder: (BuildContext context) {
        return child[index];
        // },
        // );
      },
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    bottomNavigationBar: childBottomNavBar,
    body: child[indexPage],
  );
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  final screens = [
    HomeScreen(),
    HistoriqueScreen(),
    SettingScreen(),
  ];

  // final itemListAndroid = [
  //   BottomNavigationBarItem(
  //     icon: Container(
  //       child: SvgPicture.asset(
  //         _pageIndex == 0
  //             ? "assets/images/homeSelectIcon.svg"
  //             : "assets/images/homeUnselectIcon.svg",
  //         fit: BoxFit.scaleDown,
  //         color: _pageIndex == 0 ? AppColors.colorButton : AppColors.blackBlue,
  //       ),
  //     ),
  //     label: 'Accueil'.tr(),
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.article_rounded),
  //     label: 'Historiques'.tr(),
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.person_2_rounded),
  //     label: 'Profil'.tr(),
  //   ),
  // ];

  final itemListIos = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_rounded,
      ),
      label: 'Accueil'.tr(),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.article_rounded),
      label: 'Historiques'.tr(),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_2_rounded),
      label: 'Profil'.tr(),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> handleAllUserGroup() async {
      final AllUserGroup = await context
          .read<UserGroupCubit>()
          .AllUserGroupOfUserCubit(AppCubitStorage().state.tokenUser);
    }

    Future<void> handleTournoiDefault() async {
      final detailTournoiCourant = await context
          .read<DetailTournoiCourantCubit>()
          .detailTournoiCourantCubit(AppCubitStorage().state.codeTournois);
    }

    Future handleRecentEvent(codeMembre) async {
      final allRecentEvent = await context
          .read<RecentEventCubit>()
          .AllRecentEventCubit(codeMembre);
    }

    Future handleChangeAss(codeAss) async {
      final allCotisationAss =
          await context.read<UserGroupCubit>().ChangeAssCubit(codeAss);
    }

    Future<void> handleDetailUser(userCode, codeTournoi) async {
      final allCotisationAss = await context
          .read<AuthCubit>()
          .detailAuthCubit(userCode, codeTournoi);
    }

    Future<void> handleAllCotisationAssTournoi(codeTournoi, codeMembre) async {
      final allCotisationAss = await context
          .read<CotisationCubit>()
          .AllCotisationAssTournoiCubit(codeTournoi, codeMembre);
    }

    Future<void> handleAllCompteAss(codeAssociation) async {
      final allCotisationAss =
          await context.read<CompteCubit>().AllCompteAssCubit(codeAssociation);
    }

    Future countNotifications() async {
      final countNotificationsVar =
          await context.read<NotificationCubit>().countNotification();
    }

    return PageScaffold(
      context: context,
      indexPage: _pageIndex,
      child: screens,
      itemListIos: itemListIos,
      // itemListAndroid: itemListAndroid,
      childBottomNavBar: Platform.isAndroid
          ? Material(
              type: MaterialType.transparency,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
                child: BottomNavigationBar(
                  backgroundColor: AppColors.white,
                  // type: BottomNavigationBarType.shifting,
                  selectedIconTheme: IconThemeData(size: 25.sp),
                  unselectedIconTheme: IconThemeData(size: 25.sp),
                  selectedFontSize: 14.sp,
                  unselectedFontSize: 14.sp,
                  unselectedItemColor: AppColors.blackBlue,
                  selectedItemColor: Color.fromARGB(255, 96, 134, 8),
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  items: [
                    BottomNavigationBarItem(
                      icon: Container(
                        margin: EdgeInsets.all( 2.h),
                        width: 60.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: AppColors.colorButton
                                .withOpacity(_pageIndex == 0 ? 0.1 : 0),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: SvgPicture.asset(
                          _pageIndex == 0
                              ? "assets/images/homeSelectIcon.svg"
                              : "assets/images/homeUnselectIcon.svg",
                          fit: BoxFit.scaleDown,
                          color: _pageIndex == 0
                              ? AppColors.colorButton
                              : AppColors.blackBlue,
                        ),
                      ),
                      label: 'Accueil'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        margin: EdgeInsets.all(2.h),
                        width: 60.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: AppColors.colorButton.withOpacity(
                            _pageIndex == 1 ? 0.1 : 0,
                          ),
                          borderRadius: BorderRadius.circular(
                            15.r,
                          ),
                        ),
                        child: SvgPicture.asset(
                          _pageIndex == 1
                              ? "assets/images/listSelectIcon.svg"
                              : "assets/images/listUnselectIcon.svg",
                          fit: BoxFit.scaleDown,
                          color: _pageIndex == 1
                              ? AppColors.colorButton
                              : AppColors.blackBlue,
                        ),
                      ),
                      label: 'Historiques'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                       margin: EdgeInsets.all(2.h),
                        width: 60.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: AppColors.colorButton
                                .withOpacity(_pageIndex == 2 ? 0.1 : 0),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: SvgPicture.asset(
                          _pageIndex == 2
                              ? "assets/images/personSelectIcon.svg"
                              : "assets/images/personUnselectIcon.svg",
                          fit: BoxFit.scaleDown,
                          color: _pageIndex == 2
                              ? AppColors.colorButton
                              : AppColors.blackBlue,
                        ),
                      ),
                      label: 'Profil'.tr(),
                    ),
                  ],
                  currentIndex: _pageIndex,
                  onTap: (index) {
                    setState(
                      () {
                        _pageIndex = index;
                      },
                    );
                  },
                ),
              ),
            )
          : CupertinoTabBar(
              iconSize: 25.sp,
              activeColor: AppColors.colorButton,
              inactiveColor: AppColors.blackBlueAccent1,
              height: 60.h,
              items: itemListIos,
              onTap: (index) {
                setState(() {
                  _pageIndex = index;
                });
                print("object");
                if (_pageIndex == 0) {
                  handleAllUserGroup();
                  handleTournoiDefault();
                  handleRecentEvent(AppCubitStorage().state.membreCode);
                  handleChangeAss(AppCubitStorage().state.codeAssDefaul);
                  handleDetailUser(AppCubitStorage().state.membreCode,
                      AppCubitStorage().state.codeTournois);
                  context.read<AuthCubit>().getUid();
                  context.read<PretEpargneCubit>().getEpargne();
                  context.read<PretEpargneCubit>().getPret();
                }

                if (_pageIndex == 1) {
                  handleTournoiDefault();
                  handleAllCotisationAssTournoi(
                      AppCubitStorage().state.codeTournois,
                      AppCubitStorage().state.membreCode);
                  handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
                }

                if (_pageIndex == 2) {
                  countNotifications();
                }
              },
            ),
    );
  }
}
