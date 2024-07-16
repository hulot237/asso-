import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/screens/detailTontinePage.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetTontineHistoriqueCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTontineScreen extends StatefulWidget {
  const ListTontineScreen({super.key});

  @override
  State<ListTontineScreen> createState() => _ListTontineScreenState();
}

class _ListTontineScreenState extends State<ListTontineScreen> {
  Future<void> handleDetailTontine(codeTournoi, codeTontine) async {
    final detailTontine = await context
        .read<TontineCubit>()
        .detailTontineCubit(codeTournoi, codeTontine);
  }

  Future<void> handleTournoiDefault(codeTournoi) async {
    final detailTournoiCourant = await context
        .read<DetailTournoiCourantCubit>()
        .detailTournoiCourantCubitHist(codeTournoi);

    if (detailTournoiCourant != null) {
      print(
          "objectdddddddddddddddddddddddddddddddddd  ${detailTournoiCourant}");
    } else {
      print("userGroupDefault null");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleTournoiDefault(AppCubitStorage().state.codeTournoisHist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        centerTitle: false,
        // toolbarHeight: 130.h,
        title: Text(
          'Vos tontines'.tr(),
          // "historiques".tr(),
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.white,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: AppColors.backgroundAppBAr,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: BackButtonWidget(
            colorIcon: AppColors.white,
          ),
        ),
      ),
      body: BlocBuilder<DetailTournoiCourantCubit, DetailTournoiCourantState>(
          builder: (DetailTournoiContext, DetailTournoiState) {
        if (DetailTournoiState.isLoadingHist == true &&
            DetailTournoiState.detailtournoiCourantHist == null)
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
        final currentDetailtournoiCourant =
            DetailTournoiContext.read<DetailTournoiCourantCubit>()
                .state
                .detailtournoiCourantHist;

        List<dynamic> listeTontines = currentDetailtournoiCourant!["tontines"];

        List<dynamic> tontinesMembreConnect = [];

        for (var tontine in listeTontines) {
          for (var item in tontine["membres"]) {
            if (item["membre"]["membre_code"] ==
                AppCubitStorage().state.membreCode) {
              tontinesMembreConnect.add(tontine);
              break;
            }
          }
        }

        List<dynamic> listFinal =
            context.read<AuthCubit>().state.detailUser!["isMember"]
                ? tontinesMembreConnect
                : listeTontines;

        return listFinal.length > 0
            ? Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      // bottom: Platform.isIOS ? 70.h : 10.h,
                      top: 20.h,
                      left: 5.w,
                      right: 5.w,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: tontinesMembreConnect.length,
                      itemBuilder: (context, index) {
                        print(tontinesMembreConnect);
                        final itemTontine = tontinesMembreConnect[index];
                        return GestureDetector(
                          onTap: () {
                            updateTrackingData("transactions.tontine",
                                "${DateTime.now()}", {});
                            handleDetailTontine(
                                AppCubitStorage().state.codeTournoisHist,
                                itemTontine["tontine_code"]);

                            print("${itemTontine["tontine_code"]}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailTontinePage(
                                  codeTontine: itemTontine["tontine_code"],
                                  isActive: itemTontine["is_active"],
                                  dateCreaTontine: itemTontine["created_at"],
                                  nomTontine: "${itemTontine["libele"]}",
                                  montantTontine: "${itemTontine["amount"]}",
                                  positionBeneficiaire:
                                      "${itemTontine["membres"].where((objet) => objet["is_passed"] == 1).length}",
                                  nbrMembreTontine:
                                      "${itemTontine["membres"].length}",
                                  listMembre: itemTontine["membres"],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 7.w, right: 7.w, top: 3.h, bottom: 7.h),
                            child: widgetTontineHistoriqueCard(
                              listMembre: itemTontine["membres"],
                              isActive: itemTontine["is_active"],
                              dateCreaTontine: itemTontine["created_at"],
                              nomTontine: "${itemTontine["libele"]}",
                              montantTontine: "${itemTontine["amount"]}",
                              positionBeneficiaire: "${itemTontine["membres"].where((objet) => objet["is_passed"] == 1).length}",
                              nbrMembreTontine:
                                  "${itemTontine["membres"].length}",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (DetailTournoiState.isLoadingHist == true ||
                      DetailTournoiState.detailtournoiCourantHist == null)
                    EasyLoader(
                      backgroundColor: Color.fromARGB(0, 255, 255, 255),
                      iconSize: 50.r,
                      iconColor: AppColors.blackBlueAccent1,
                      image: AssetImage(
                        "assets/images/AssoplusFinal.png",
                      ),
                    )
                ],
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(top: 200.h),
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Aucune tontine",
                        style: TextStyle(
                          color: AppColors.blackBlueAccent1,
                          fontWeight: FontWeight.w100,
                          fontSize: 20.sp,
                        ),
                      ),
                    );
                  },
                ),
              );
      }),
    );
  }
}
