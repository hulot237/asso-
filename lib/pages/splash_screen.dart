import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/network/localisation_phone/business_logic/localisation_phone_cubit.dart';
import 'package:faroty_association_1/network/session_activity/session_cubit.dart';
import 'package:faroty_association_1/pages/home_centrale_screen.dart';
import 'package:faroty_association_1/pages/pre_login_screen.dart';
import 'package:faroty_association_1/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future clearSessionIdStorage() async {
    if (context.read<SessionCubit>().state.isValidSession == false) {
      await AppCubitStorage().updateXSessionId(null);
    }
  }

  Future<void> handleAllUserGroup() async {
    final AllUserGroup = await context
        .read<UserGroupCubit>()
        .AllUserGroupOfUserCubit(AppCubitStorage().state.tokenUser);

    if (AllUserGroup != null) {
      print("1");
    } else {
      print("AllUserGroup null");
    }
  }

  Future<void> handleTournoiDefault() async {
    final detailTournoiCourant = await context
        .read<DetailTournoiCourantCubit>()
        .detailTournoiCourantCubit(AppCubitStorage().state.codeTournois);

    if (detailTournoiCourant != null) {
      print("handleTournoiDefault");
    } else {
      print("handleTournoiDefault null");
    }
  }

  Future handleRecentEvent(codeMembre) async {
    final allRecentEvent =
        await context.read<RecentEventCubit>().AllRecentEventCubit(codeMembre);

    if (allRecentEvent != null) {
    } else {
      print("handleRecentEventhandleRecentEvent null");
    }
  }

  Future handleChangeAss(codeAss) async {
    final allCotisationAss =
        await context.read<UserGroupCubit>().ChangeAssCubit(codeAss);
  }

  Future<void> handleDetailUser(userCode, codeTournoi) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode, codeTournoi);
  }

  @override
  void initState() {
    // TODO: implement initState
    context.read<LocalisationPhoneCubit>().showLocalisationPhone();
    if (AppCubitStorage().state.codeAssDefaul != null &&
        AppCubitStorage().state.codeTournois != null &&
        AppCubitStorage().state.membreCode != null &&
        AppCubitStorage().state.tokenUser != null) {
      clearSessionIdStorage();
      handleAllUserGroup();

      handleTournoiDefault();
      handleRecentEvent(AppCubitStorage().state.membreCode);
      handleChangeAss(AppCubitStorage().state.codeAssDefaul);
      handleDetailUser(AppCubitStorage().state.membreCode,
          AppCubitStorage().state.codeTournois);
      context.read<AuthCubit>().getUid();
      context.read<PretEpargneCubit>().getEpargne();
      context.read<PretEpargneCubit>().getPret();
      context.read<SessionCubit>().GetSessionCubit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 5),
      () {
        AppCubitStorage().state.tokenUser == null &&
                AppCubitStorage().state.codeAssDefaul == null
            ? Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => PreLoginScreen(),
                ),
                (route) => false,
              )
            : Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => HomeCentraleScreen(),
                ),
                (route) => false,
              );

        // ? context.router.replace(
        //     PreLoginRoute(),
        //   )
        // : context.router.replace(
        //     HomeCentraleRoute(),
        //   );
      },
    );
    return Material(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/images/updateBulle.png",
                width: 250.w,
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: RotatedBox(
                quarterTurns: 2,
                child: Image.asset(
                  "assets/images/updateBulle.png",
                  width: 180.w,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: Container(
                // color: Color.fromARGB(185, 255, 4, 4),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Container(
                      margin: EdgeInsets.only(top: 50.h),
                      // color: Colors.blueAccent,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ImageAnimated()
                          // Center(
                          //   child: Container(
                          //     child: Image.asset(
                          //       "assets/images/AssoplusFinalSquare.png",
                          //       width: 150.w,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Image.asset(
                          "assets/images/FArotyPowered.png",
                          width: 80.w,
                        ),
                      ),
                    ),

                    // VersionWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageAnimated extends StatefulWidget {
  const ImageAnimated({super.key});

  @override
  State<ImageAnimated> createState() => _ImageAnimatedState();
}

class _ImageAnimatedState extends State<ImageAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 1))
        ..repeat(reverse: true);
  late Animation<double> _animation = CurvedAnimation(
      parent: _controller, curve: Curves.fastEaseInToSlowEaseOut);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 1,
        end: 1,
      ).animate(_animation),
      child: FadeTransition(
        opacity: Tween<double>(
          begin: 0.4,
          end: 1,
        ).animate(_animation),
        child: Container(
          child: Image.asset(
            "assets/images/AssoplusFinalSquare.png",
            width: 180.w,
          ),
        ),
      ),
    );
    // ScaleTransition(
    //   scale: Tween<double>(
    //         begin: 0.5,
    //         end: 0.6,
    //       ).animate(_animation),
    //   child: Text("data", style: TextStyle(fontSize: 100),),
    // );
  }
}
