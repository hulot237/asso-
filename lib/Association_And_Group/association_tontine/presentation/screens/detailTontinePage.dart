import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetDetailHistoriqueTontineCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetDetailTontineCard.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/checkInternetConnectionPage.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailTontinePage extends StatefulWidget {
  DetailTontinePage({
    super.key,
    required this.dateCreaTontine,
    required this.nomTontine,
    required this.montantTontine,
    required this.positionBeneficiaire,
    required this.nbrMembreTontine,
    required this.listMembre,
    required this.isActive,
    required this.codeTontine,
  });
  String dateCreaTontine;
  String nomTontine;
  String montantTontine;
  String positionBeneficiaire;
  String nbrMembreTontine;
  List listMembre;
  int isActive;
  String codeTontine;
  @override
  State<DetailTontinePage> createState() => _DetailTontinePageState();
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
          "Detail de la tontine".tr(),
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: BackButtonWidget(
            colorIcon: AppColors.white,
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
        "Detail de la tontine".tr(),
        style: TextStyle(fontSize: 16.sp, color: AppColors.white,fontWeight: FontWeight.bold,),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: BackButtonWidget(
          colorIcon: AppColors.white,
        ),
      ),
    ),
    body: child,
  );
}

class _DetailTontinePageState extends State<DetailTontinePage>
    with TickerProviderStateMixin {
  Future<void> handleDetailContributionTontine(codeContribution) async {
    final detailCotisation = await context
        .read<DetailContributionCubit>()
        .detailContributionTontineCubit(codeContribution);
  }

  Future<void> handleDetailTontine(codeTournoi, codeTontine) async {
    final detailTontine = await context
        .read<TontineCubit>()
        .detailTontineCubit(codeTournoi, codeTontine);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      context: context,
      child: Material(
        type: MaterialType.transparency,
        child: BlocBuilder<TontineCubit, TontineState>(
            builder: (detTontineContext, detTontineState) {
          if (detTontineState.errorLoadDetailTontine == true)
            return checkInternetConnectionPage(
              functionToCall: () => handleDetailTontine(
                AppCubitStorage().state.codeTournois,
                widget.codeTontine,
              ),
            );
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h),
                child: WidgetDetailTontineCard(
                  dateCreaTontine: widget.dateCreaTontine,
                  nomTontine: widget.nomTontine,
                  montantTontine: widget.montantTontine,
                  positionBeneficiaire: widget.positionBeneficiaire,
                  nbrMembreTontine: widget.nbrMembreTontine,
                  isActive: widget.isActive,
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          EdgeInsets.only(bottom: 7.h, left: 5.w, right: 5.w),
                      padding: EdgeInsets.only(top: 20.h),
                      child: Text(
                        "ordre_de_passage".tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackBlue,
                        ),
                      ),
                    ),
                    Container(
                      // color: Color.fromARGB(255, 174, 12, 12),
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          color: AppColors.white,
                          padding: EdgeInsets.only(
                              top: 10.h, left: 10.w, bottom: 10.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var itemListMembre in widget.listMembre)
                                Container(
                                  // color: AppColors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 3.h),
                                        width: 95.w,
                                        child: Text(
                                          "${itemListMembre["membre"]["first_name"] == null ? "" : itemListMembre["membre"]["first_name"]} ${itemListMembre["membre"]["last_name"] == null ? "" : itemListMembre["membre"]["last_name"]}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.blackBlue,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(360),
                                                color: itemListMembre[
                                                            "is_passed"] ==
                                                        0
                                                    ? Color.fromRGBO(
                                                        20, 45, 99, 0.24)
                                                    : Color.fromRGBO(
                                                        15, 190, 24, 0.658),
                                              ),
                                              width: 15.w,
                                              height: 15.w,
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: itemListMembre[
                                                              "is_passed"] ==
                                                          0
                                                      ? Text(
                                                          "${itemListMembre["position"]}",
                                                          style: TextStyle(
                                                            fontSize: 9.sp,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color:
                                                                Color.fromRGBO(
                                                                    20,
                                                                    45,
                                                                    99,
                                                                    1),
                                                          ),
                                                        )
                                                      : Icon(
                                                          Icons.check,
                                                          size: 12.sp,
                                                          color:
                                                              AppColors.white,
                                                        )),
                                            ),
                                            Container(
                                              color:
                                                  itemListMembre["is_passed"] ==
                                                          0
                                                      ? Color.fromRGBO(
                                                          20, 45, 99, 0.24)
                                                      : Color.fromRGBO(
                                                          15, 190, 24, 0.658),
                                              width: 100.w,
                                              height: 2.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                      top: 0, left: 5.w, right: 5.w, bottom: 5.h),
                  padding: EdgeInsets.only(top: 15.h),
                  child: Text(
                    "Historique de la tontine".tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackBlue,
                    ),
                  ),
                ),
              ),
              BlocBuilder<TontineCubit, TontineState>(
                  builder: (tontineContext, tontineState) {
                if (tontineState.isLoading == true &&
                    tontineState.detailTontine == null)
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
                final currentDetailTontineCard =
                    tontineContext.read<TontineCubit>().state.detailTontine;
                return Expanded(
                  child: Stack(
                    children: [
                      Container(
                        // padding: EdgeInsets.only(
                        //   bottom: 70.h,
                        // ),
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: currentDetailTontineCard!.length,
                          itemBuilder: (context, index) {
                            final itemTontine = currentDetailTontineCard[index];

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
                                        .detailUser!["isMember"])) {
                                  handleDetailContributionTontine(
                                    itemTontine["code"],
                                  );

                                  Modal().showBottomSheetHistTontine(
                                    tontineContext,
                                    itemTontine["code"],
                                   codeTontine:  widget.codeTontine
                                  );
                                  // widget.codeTontine;
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.all(10.r),
                                child: widgetDetailHistoriqueTontineCard(
                                  isPayed: itemTontine['is_payed'],
                                  nomTontine: widget.nomTontine,
                                  lienDePaiement:
                                      itemTontine['tontine_pay_link'],
                                  dateClose: itemTontine['end_date'],
                                  dateOpen: itemTontine['start_date'],
                                  montantCollecte:
                                      itemTontine['total_cotise'],
                                  montantTontine: itemTontine['amount'],
                                  nomBeneficiaire: itemTontine["membre"]
                                      ["first_name"],
                                  prenomBeneficiaire:
                                      itemTontine["membre"]["last_name"] == null
                                          ? ""
                                          : itemTontine["membre"]["last_name"],
                                  codeCotisation: itemTontine["code"],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (tontineState.isLoading == true &&
                          tontineState.detailTontine != null)
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
              }),
            ],
          );
        }),
      ),
    );
  }
}
