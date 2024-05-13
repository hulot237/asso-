import 'package:auto_route/auto_route.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/home_centrale_screen.dart';
import 'package:faroty_association_1/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class checkInternetConnectionPage extends StatefulWidget {
  checkInternetConnectionPage({
    super.key,
    required Function() this.functionToCall,
    bool? this.backToHome,
  });
  Function() functionToCall;
  bool? backToHome;

  @override
  State<checkInternetConnectionPage> createState() =>
      _checkInternetConnectionPageState();
}

class _checkInternetConnectionPageState
    extends State<checkInternetConnectionPage> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    Future<void> handleTournoiDefault(codeTournoi) async {
      final detailTournoiCourant = await context
          .read<DetailTournoiCourantCubit>()
          .detailTournoiCourantCubit(codeTournoi);

      if (detailTournoiCourant != null) {
        print(
            "objectdddddddddddddddddddddddddddddddddd  ${detailTournoiCourant}");
      } else {
        print("userGroupDefault null");
      }
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Opacity(
              opacity: 0.16,
              child: Image.asset(
                "assets/images/no_Connection.png",
                width: 250.r,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
            child: Text(
              "Une erreur s'est produite lors du chargement de vos données. Veuillez vérifier votre connexion avant de réessayer.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColors.blackBlueAccent1,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  print("${AppCubitStorage().state.tokenUser}");
                  print("${AppCubitStorage().state.codeTournois}");
                  print("${AppCubitStorage().state.codeAssDefaul}");
                  handleTournoiDefault(AppCubitStorage().state.codeTournois);
                  // context
                  //                             .read<DetailTournoiCourantCubit>()
                  //                             .state
                  //                             .detailtournoiCourant;

                  if (widget.backToHome!)
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomeCentraleScreen(),
                      ),
                      (route) => false,
                    );
                  setState(() {
                    isLoading = true;
                  });
                  await widget.functionToCall();
                  setState(() {
                    isLoading = false;
                  });
                },
                child: Container(
                  // width: MediaQuery.of(context).size.width / 1.3,
                  height: 50.h,
                  margin: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                    top: 5.h,
                    // bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.greenAssociation,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: isLoading == true
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Réessayer",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: AppColors.white,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 7.w),
                              child: Icon(
                                Icons.refresh,
                                size: 17.sp,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
