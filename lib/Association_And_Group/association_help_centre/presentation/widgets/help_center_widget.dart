import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetCompteCard extends StatefulWidget {
  const WidgetCompteCard({
    super.key,
    required this.montantFaroty,
    required this.montantCaisse,
    required this.nomCompte,
    required this.numeroCompte,
    required this.icon,
    required this.couleur,
  });

  final String montantFaroty;
  final String montantCaisse;
  final String nomCompte;
  final String numeroCompte;
  final String icon;
  final String couleur;

  @override
  State<WidgetCompteCard> createState() => _WidgetCompteCardState();
}

class _WidgetCompteCardState extends State<WidgetCompteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.15,
      padding: EdgeInsets.all(5.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.all(5.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30.r,
                      width: 30.r,
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(int.parse(
                                '${widget.couleur}'.replaceAll('#', '0xff'))),
                            width: 1.w),
                        borderRadius: BorderRadius.circular(360),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: SvgPicture.asset(
                          height: 10.h,
                          "assets/images/${widget.icon}.svg",
                          fit: BoxFit.cover,
                          color: AppColors.blackBlue,
                        ),
                      ),
                    ),
                    if (!context
                        .read<AuthCubit>()
                        .state
                        .detailUser!["isMember"])
                      Material(
                        color: AppColors.blackBlueAccent2,
                        borderRadius: BorderRadius.circular(7.r),
                        child: InkWell(
                          onTap: () {
                            launchWeb(
                              "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/detail-compte/${widget.numeroCompte}&app_mode=mobile",
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 5.w),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    'Consulter'.tr(),
                                    // "historiques".tr(),
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: AppColors.blackBlue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_outward_rounded,
                                    size: 12.sp,
                                    color: AppColors.blackBlue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  widget.nomCompte.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    color: AppColors.blackBlue,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Faroty",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color.fromARGB(255, 131, 16, 131),
                      ),
                    ),
                    Text(
                      "${formatMontantFrancais(double.parse(widget.montantFaroty))} FCFA",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 131, 16, 131),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Caisse",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.blackBlue,
                      ),
                    ),
                    Text(
                      "${formatMontantFrancais(double.parse(widget.montantCaisse))} FCFA",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
