import 'dart:async';
import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/business_logic/sanction_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/business_logic/sanction_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanction.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/add_asso_element_button_widget.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListSanctionScreen extends StatefulWidget {
  const ListSanctionScreen({super.key});

  @override
  State<ListSanctionScreen> createState() => _ListSanctionScreenState();
}

class _ListSanctionScreenState extends State<ListSanctionScreen> {
  String selectedCategory = "Toutes";
  bool showCategories = true;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  Future<void> handleAllSanction() async {
    final allCotisationAss = await context
        .read<SanctionCubit>()
        .getAllSanctions(AppCubitStorage().state.codeTournoisHist);
  }

  Future<void> handleDetailUser(userCode, codeTournoi) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode, codeTournoi);
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().state.detailUser!["isMember"]
        ? handleAllSanction()
        : handleDetailUser(AppCubitStorage().state.membreCode,
            AppCubitStorage().state.codeTournois);
    // Ajouter un écouteur pour détecter les événements de défilement
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // L'utilisateur fait défiler vers le bas, cacher les catégories
        if (showCategories) {
          setState(() {
            showCategories = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // L'utilisateur fait défiler vers le haut, afficher les catégories
        if (!showCategories) {
          setState(() {
            showCategories = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        centerTitle: false,
        // toolbarHeight: 130.h,
        title: Text(
          'Vos sanctions'.tr(),
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
      body:
          BlocBuilder<AuthCubit, AuthState>(builder: (AuthContext, AuthState) {
        // final currentDetailUser = context.read<AuthCubit>().state.detailUser;
        if (AuthState.isLoading == true && AuthState.detailUser == null)
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
        return BlocBuilder<SanctionCubit, SanctionState>(
          builder: (SanctionContext, SanctionState) {
            if (SanctionState.isLoading == true &&
                SanctionState.sanctions == null)
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
            final currentDetailUser =
                context.read<AuthCubit>().state.detailUser!["isMember"]
                    ? context.read<AuthCubit>().state.detailUser!["sanctions"]
                    : context.read<SanctionCubit>().state.sanctions!;
            return currentDetailUser.length > 0
                ? Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10.w),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: showCategories
                                  ? 40.h
                                  : 0, // Hauteur des boutons de catégorie
                              child: SingleChildScrollView(
                                child: Row(
                                  children: [
                                    buildCategoryButton("Toutes"),
                                    buildCategoryButton("Payé"),
                                    buildCategoryButton("Non payé"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // margin: EdgeInsets.only(
                              //   bottom: Platform.isIOS ? 70.h : 10.h,
                              // ),
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                padding: EdgeInsets.only(
                                  top: 5.h,
                                  bottom: 30.h,
                                  left: 15.w,
                                  right: 15.w,
                                ),
                                controller: _scrollController,
                                itemCount: currentDetailUser.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final currentSaction =
                                      currentDetailUser[index];
                                  if (selectedCategory == "Toutes" ||
                                      (selectedCategory == "Payé" &&
                                          currentSaction["is_sanction_payed"] !=
                                              0) ||
                                      (selectedCategory == "Non payé" &&
                                          currentSaction["is_sanction_payed"] ==
                                              0)) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          // left: 7.w,
                                          // right: 7.w,
                                          top: 3.h,
                                          bottom: 10.h),
                                      child: !context
                                              .read<AuthCubit>()
                                              .state
                                              .detailUser!["isMember"]
                                          ? WidgetSanction(
                                              codeTournoi: AppCubitStorage()
                                                  .state
                                                  .codeTournoisHist!,
                                              sanction_code: currentSaction[
                                                  "sanction_code"],
                                              membreCode:
                                                  "${currentSaction["membre"]["membre_code"]}",
                                              nomProprietaire:
                                                  "${currentSaction["membre"]["first_name"]} ${currentSaction["membre"]["last_name"] ?? ""}",
                                              isAdmin: true,
                                              screenSource:
                                                  "transactions.sanction",
                                              objetSanction: currentSaction[
                                                          "libelle"] ==
                                                      null
                                                  ? " "
                                                  : currentSaction["libelle"],
                                              heureSanction: AppCubitStorage()
                                                          .state
                                                          .Language ==
                                                      "fr"
                                                  ? formatTimeToFrench(
                                                      currentSaction[
                                                          "start_date"])
                                                  : formatTimeToEnglish(
                                                      currentSaction[
                                                          "start_date"]),
                                              dateSanction:
                                                  currentSaction["start_date"],
                                              motifSanction:
                                                  currentSaction["motif"],
                                              montantSanction:
                                                  currentSaction["amount"]
                                                      .toString(),
                                              montantPayeeSanction:
                                                  currentSaction[
                                                      "sanction_balance"],
                                              lienPaiement: currentSaction[
                                                          "sanction_pay_link"] ==
                                                      null
                                                  ? " "
                                                  : currentSaction[
                                                      "sanction_pay_link"],
                                              versement:
                                                  currentSaction["versement"],
                                              isSanctionPayed: currentSaction[
                                                  "is_sanction_payed"],
                                              typeSaction:
                                                  currentSaction["type"],
                                              resteAPayer: currentSaction[
                                                  "amount_remaining"],
                                              dejaPayer: currentSaction[
                                                  "sanction_balance"],
                                            )
                                          : WidgetSanction(
                                              codeTournoi: AppCubitStorage()
                                                  .state
                                                  .codeTournoisHist!,
                                              sanction_code: currentSaction[
                                                  "sanction_code"],
                                              membreCode: "",
                                              nomProprietaire: "",
                                              isAdmin: false,
                                              screenSource:
                                                  "transactions.sanction",
                                              objetSanction: currentSaction[
                                                          "libelle"] ==
                                                      null
                                                  ? " "
                                                  : currentSaction["libelle"],
                                              heureSanction: AppCubitStorage()
                                                          .state
                                                          .Language ==
                                                      "fr"
                                                  ? formatTimeToFrench(
                                                      currentSaction[
                                                          "start_date"])
                                                  : formatTimeToEnglish(
                                                      currentSaction[
                                                          "start_date"]),
                                              dateSanction:
                                                  currentSaction["start_date"],
                                              motifSanction:
                                                  currentSaction["motif"],
                                              montantSanction:
                                                  currentSaction["amount"]
                                                      .toString(),
                                              montantPayeeSanction:
                                                  currentSaction[
                                                      "sanction_balance"],
                                              lienPaiement: currentSaction[
                                                          "sanction_pay_link"] ==
                                                      null
                                                  ? " "
                                                  : currentSaction[
                                                      "sanction_pay_link"],
                                              versement:
                                                  currentSaction["payments"],
                                              isSanctionPayed: currentSaction[
                                                  "is_sanction_payed"],
                                              typeSaction:
                                                  currentSaction["type"],
                                              resteAPayer: currentSaction[
                                                  "amount_remaining"],
                                              dejaPayer: currentSaction[
                                                  "sanction_balance"],
                                            ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      AddAssoElement(
                        screenSource: "transactions.btnAddSanction",
                        text: "Ajouter une sanction".tr(),
                        routeElement: "sanctions?query=1",
                      ),
                      if (isLoading)
                        Positioned(
                          top: MediaQuery.of(context).size.height / 15,
                          left: MediaQuery.of(context).size.width / 2,
                          child: Container(
                            width: 20.r,
                            height: 20.r,
                            child: CircularProgressIndicator(
                              color: AppColors.blackBlue,
                            ),
                          ),
                        ),
                      if (SanctionState.isLoading == true &&
                          SanctionState.sanctions != null)
                        EasyLoader(
                          backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          iconSize: 50.r,
                          iconColor: AppColors.blackBlueAccent1,
                          image: AssetImage(
                            "assets/images/AssoplusFinal.png",
                          ),
                        ),
                      if (AuthState.isLoading == true &&
                          AuthState.detailUser != null)
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
                : Stack(
                  children: [
                    ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                       return Container(
                        height:  MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "aucune_sanction".tr(),
                                style: TextStyle(
                                    color: AppColors.blackBlueAccent1,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 20.sp),
                              ),
                              if (!context
                                  .read<AuthCubit>()
                                  .state
                                  .detailUser!["isMember"])
                                InkWell(
                                  onTap: () async {
                                    updateTrackingData(
                                        "transactions.btnAddSanction",
                                        "${DateTime.now()}", {});
                                    launchWeb(
                                      "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/sanctions?query=1&app_mode=mobile",
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.pageBackground,
                                      border: Border.all(
                                        width: 2.w,
                                        color:
                                            AppColors.blackBlue.withOpacity(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        20.r,
                                      ),
                                    ),
                                    // alignment: Alignment
                                    //     .bottomLeft,
                                    margin: EdgeInsets.only(
                                      top: 8.w,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 7.h,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Ajouter une sanction".tr(),
                                          style: TextStyle(
                                            color: AppColors.blackBlue
                                                .withOpacity(1),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18.sp,
                                            letterSpacing: 0.2.w,
                                          ),
                                        ),
                                        Container(
                                          width: 25.w,
                                          height: 25.w,
                                          margin: EdgeInsets.only(left: 3.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(360),
                                            border: Border.all(
                                              width: 2.w,
                                              color: AppColors.blackBlue
                                                  .withOpacity(1),
                                            ),
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/images/addIcon.svg",
                                            fit: BoxFit.scaleDown,
                                            color: AppColors.blackBlue
                                                .withOpacity(1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
          },
        );
      }),
    );
  }

  // Méthode pour construire un bouton de catégorie
  Widget buildCategoryButton(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLoading = true;
          selectedCategory = category;
        });
        Timer(Duration(seconds: 1), () {
          setState(() {
            isLoading = false;
          });
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        margin: EdgeInsets.only(
          top: 10.h,
          bottom: 0,
          left: 5.w,
        ),
        decoration: BoxDecoration(
          color: category == selectedCategory
              ? AppColors.colorButton.withOpacity(0.1)
              : AppColors.blackBlue
                  .withOpacity(0.1), // Couleur du bouton actif/inactif
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: category == selectedCategory
                ? AppColors.backgroundAppBAr
                : AppColors.blackBlue,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
