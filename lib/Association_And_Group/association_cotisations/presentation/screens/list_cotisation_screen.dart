

import 'dart:async';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotistion.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widget_collecte_externe.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
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

class ListCotisationScreen extends StatefulWidget {
  @override
  State<ListCotisationScreen> createState() => _ListCotisationScreenState();
}

class _ListCotisationScreenState extends State<ListCotisationScreen>
    with SingleTickerProviderStateMixin {
  String selectedCotisationType = "cotisation interne".tr();
  String selectedCategory = "Toutes".tr();
  bool showCategories = true;
  bool isLoading = false;
  TabController? _tabController;
  String _currentTab = 'Internes';
  ScrollController _scrollController = ScrollController();

  Future<void> handleAllCotisationAssTournoi(codeTournoi, codeMembre) async {
    final allCotisationAss = await context
        .read<CotisationCubit>()
        .AllCotisationAssTournoiCubit(codeTournoi, codeMembre);
  }

  Future<void> handleGetCollectes() async {
    final allCotisationAss = await context
        .read<CotisationCubit>()
        .getCollectes(AppCubitStorage().state.codeTournoisHist);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging ||
          _tabController!.index != _tabController!.previousIndex) {
        int newIndex = _tabController!.index;
        String tabName = newIndex == 0 ? 'Internes' : 'Externes';
        setState(() {
          _currentTab = tabName;
          selectedCategory = "Toutes".tr();
          print("_currentTab $_currentTab");
        });
      }
    });
    handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournoisHist,
        AppCubitStorage().state.membreCode);
    handleGetCollectes();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (showCategories) {
          setState(() {
            showCategories = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!showCategories) {
          setState(() {
            showCategories = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          title: Text(
            'Vos cotisations'.tr(),
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.white,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.backgroundAppBAr,
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            labelColor: AppColors.white,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
            padding: EdgeInsets.all(0),
            unselectedLabelStyle: TextStyle(
              color: AppColors.whiteAccent1,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: AppColors.white,
                width: 2.h,
              ),
            ),
            tabs: [
              Tab(text: "Membres uniquement".tr()),
              Tab(text: "Membres & autres".tr()),
            ],
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackButtonWidget(
              colorIcon: AppColors.white,
            ),
          ),
          actions: [
            BlocBuilder<CotisationCubit, CotisationState>(
                builder: (CotisationContext, CotisationState) {
              return BlocBuilder<DetailTournoiCourantCubit,
                      DetailTournoiCourantState>(
                  builder: (DetailTournoiContext, DetailTournoiState) {
                final currentInfoAllTournoiAssCourant =
                    DetailTournoiContext.read<UserGroupCubit>()
                        .state
                        .changeAssData;
                return PopupMenuButton(
                  padding: EdgeInsets.all(0),
                  position: PopupMenuPosition.under,
                  child: Row(
                    children: [
                      for (var item in currentInfoAllTournoiAssCourant!
                          .user_group!.tournois!)
                        if (item.tournois_code ==
                            AppCubitStorage().state.codeTournoisHist)
                          Center(
                            child: Row(
                              children: [
                                Text(
                                  '${"tournoi".tr()} #${item.matricule}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                if (item.is_default == 0)
                                  Icon(
                                    Icons.dangerous,
                                    size: 12.sp,
                                    color: AppColors.white,
                                  ),
                              ],
                            ),
                          ),
                      Icon(
                        Icons.arrow_right_rounded,
                        size: 15.sp,
                      )
                    ],
                  ),
                  itemBuilder: (BuildContext context) => [
                    for (var item in currentInfoAllTournoiAssCourant!
                        .user_group!.tournois!)
                      PopupMenuItem(
                        padding: EdgeInsets.all(0),
                        value: "tournoi",
                        onTap: () async {
                          print(" before ${item.tournois_code}");
                          await AppCubitStorage()
                              .updateCodeTournoisHist(item.tournois_code!);
                          print(
                              " after ${AppCubitStorage().state.codeTournoisHist}");

                          handleAllCotisationAssTournoi(
                            AppCubitStorage().state.codeTournoisHist,
                            AppCubitStorage().state.membreCode,
                          );
                        },
                        child: Container(
                          color: item.tournois_code! ==
                                  AppCubitStorage().state.codeTournoisHist
                              ? AppColors.blackBlue.withOpacity(.05)
                              : null,
                          padding: EdgeInsets.only(
                            top: 15.h,
                            bottom: 15.h,
                            left: 10.w,
                            right: 10.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    Text(
                                      '${"tournoi".tr()} #${item.matricule}'
                                          .tr(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.blackBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 70.w,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: item.is_default == 1
                                      ? AppColors.backgroundAppBAr
                                          .withOpacity(.1)
                                      : AppColors.red.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                padding: EdgeInsets.only(
                                  left: 10.w,
                                  right: 10.w,
                                  top: 3.h,
                                  bottom: 3.h,
                                ),
                                child: Text(
                                  item.is_default == 1
                                      ? 'Actif'.tr()
                                      : "Inactif",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: item.is_default == 1
                                        ? AppColors.backgroundAppBAr
                                        : AppColors.red,
                                    // fontWeight:
                                    //     FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              });
            })
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            BlocBuilder<CotisationCubit, CotisationState>(
              builder: (CotisationContext, CotisationState) {
                      // selectedCategory = 'Toutes'.tr();
                if (CotisationState.isLoadingCotis == true &&
                    CotisationState.allCotisationAss == null)
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
                  
                final currentAllCotisationAssTournoi = CotisationContext.read<CotisationCubit>().state.allCotisationAss;

                List<dynamic> objetCotisationUniquement = currentAllCotisationAssTournoi!.where((objet) => objet["is_tontine"] == 0).toList();
                
                // selectedCategory = 'Toutes'.tr();

                return objetCotisationUniquement.length > 0
                      ? Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 10.h,
                                  ),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    height: showCategories ? 30.h : 0,
                                    child: SingleChildScrollView(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          buildCategoryButton("Toutes".tr()),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          buildCategoryButton("non_payé".tr()),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          buildCategoryButton("en_cours".tr()),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          buildCategoryButton("expiré".tr()),
                                          SizedBox(
                                            width: 15.w,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      itemCount:
                                          objetCotisationUniquement.length,
                                      controller: _scrollController,
                                      padding: EdgeInsets.only(
                                        left: 5.w,
                                        right: 5.w,
                                        bottom: 70.h,
                                        top: 5.h,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final ItemDetailCotisation =
                                            objetCotisationUniquement[index];
                                        if (selectedCategory == "Toutes".tr() ||
                                            (selectedCategory ==
                                                    "non_payé".tr() &&
                                                ItemDetailCotisation[
                                                        "is_payed"] ==
                                                    0) ||
                                            (selectedCategory ==
                                                    "en_cours".tr() &&
                                                ItemDetailCotisation[
                                                        "is_passed"] ==
                                                    0) ||
                                            (selectedCategory ==
                                                    "expiré".tr() &&
                                                ItemDetailCotisation[
                                                        "is_passed"] ==
                                                    1)) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 7.w,
                                                right: 7.w,
                                                top: 5.h,
                                                bottom: 9.h),
                                            child: WidgetCotisation(
                                              rapportUrl: ItemDetailCotisation[
                                                  "rapport"],
                                              screenSource: "transactions",
                                              isPayed: ItemDetailCotisation[
                                                  "is_payed"],
                                              rubrique: ItemDetailCotisation[
                                                          "ass_rubrique"] ==
                                                      null
                                                  ? ""
                                                  : ItemDetailCotisation[
                                                      "ass_rubrique"]["name"],
                                              montantCotisations:
                                                  ItemDetailCotisation[
                                                      "amount"],
                                              motifCotisations:
                                                  ItemDetailCotisation["name"],
                                              dateCotisation:
                                                  ItemDetailCotisation[
                                                      "end_date"],
                                              heureCotisation: AppCubitStorage()
                                                          .state
                                                          .Language ==
                                                      "fr"
                                                  ? formatTimeToFrench(
                                                      ItemDetailCotisation[
                                                          "end_date"])
                                                  : formatTimeToEnglish(
                                                      ItemDetailCotisation[
                                                          "end_date"]),
                                              soldeCotisation:
                                                  ItemDetailCotisation[
                                                      "total_cotise"],
                                              codeCotisation:
                                                  ItemDetailCotisation[
                                                      "cotisation_code"],
                                              type:
                                                  ItemDetailCotisation["type"],
                                              lienDePaiement: ItemDetailCotisation[
                                                          "cotisation_pay_link"] ==
                                                      null
                                                  ? "le lien n'a pas été généré"
                                                  : ItemDetailCotisation[
                                                      "cotisation_pay_link"],
                                              is_passed: ItemDetailCotisation[
                                                  "is_passed"],
                                              is_tontine: ItemDetailCotisation[
                                                  "is_tontine"],
                                              source: ItemDetailCotisation[
                                                          "seance"] ==
                                                      null
                                                  ? ''
                                                  : '${'rencontre'.tr()} ${ItemDetailCotisation["seance"]["matricule"]} ${"du".tr()} ${formatDateTimeintegral(context.locale.toString() == "en_US" ? "en" : "fr", ItemDetailCotisation["seance"]["date_seance"])}',
                                              nomBeneficiaire: ItemDetailCotisation[
                                                          "membre"] ==
                                                      null
                                                  ? ''
                                                  : '${ItemDetailCotisation["membre"]["last_name"] == null ? "${ItemDetailCotisation["membre"]["first_name"]}" : "${ItemDetailCotisation["membre"]["first_name"]} ${ItemDetailCotisation["membre"]["last_name"]}"}',
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
                              screenSource: "transactions.btnAddContribution",
                              text: "Ajouter une cotisation".tr(),
                              routeElement: "cotisations?query=1",
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
                            if (CotisationState.isLoadingCotis == true &&
                                CotisationState.allCotisationAss != null)
                              EasyLoader(
                                backgroundColor:
                                    Color.fromARGB(0, 255, 255, 255),
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
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "aucune_cotisation".tr(),
                                        style: TextStyle(
                                          color: AppColors.blackBlueAccent1,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      if (!context
                                          .read<AuthCubit>()
                                          .state
                                          .detailUser!["isMember"])
                                        InkWell(
                                          onTap: () async {
                                            updateTrackingData(
                                                "transactions.btnAddContribution",
                                                "${DateTime.now()}", {});
                                            launchWeb(
                                              "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations?query=1&app_mode=mobile",
                                            );
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2.w,
                                                color: AppColors.blackBlue
                                                    .withOpacity(1),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20.r,
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 7.h,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Ajouter une cotisation".tr(),
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
                                                  margin: EdgeInsets.only(
                                                      left: 3.w),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            360),
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
            ),
            BlocBuilder<CotisationCubit, CotisationState>(
              builder: (CotisationContext, CotisationState) {
                if (CotisationState.isLoadingCollect == true &&
                    CotisationState.collectes == null)
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
                  // selectedCategory = 'en_cours'.tr();
                final currentCollectes = context
                    .read<CotisationCubit>()
                    .state
                    .collectes!
                    .collections;
                return currentCollectes!.length > 0
                      ? Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 10.h,
                                  ),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    height: showCategories ? 30.h : 0,
                                    child: SingleChildScrollView(
                                      // scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          buildCategoryButton("Toutes".tr()),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          buildCategoryButton("en_cours".tr()),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          buildCategoryButton("expiré".tr()),
                                          SizedBox(
                                            width: 15.w,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      itemCount: currentCollectes.length,
                                      controller: _scrollController,
                                      padding: EdgeInsets.only(
                                        left: 5.w,
                                        right: 5.w,
                                        bottom: 70.h,
                                        top: 5.h,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final itemCollecte =
                                            currentCollectes[index];
                                        if (selectedCategory == "Toutes".tr() ||(selectedCategory ==
                                                    "en_cours".tr() &&
                                                itemCollecte.isPassed == 0) ||
                                            (selectedCategory ==
                                                    "expiré".tr() &&
                                                itemCollecte.isPassed == 1)) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 7.w,
                                                right: 7.w,
                                                top: 5.h,
                                                bottom: 9.h),
                                            child: WidgetCollecteExterne(
                                              photoCol: itemCollecte.colImage!,
                                              screenSource: "transactions",
                                              isPayed: 1,
                                              rubrique: itemCollecte
                                                  .assRubrique!.name!,
                                              montantCotisations: int.parse(
                                                  itemCollecte.amount!),
                                              motifCotisations:
                                                  itemCollecte.motif!,
                                              dateCotisation:
                                                  itemCollecte.endDate!,
                                              heureCotisation: AppCubitStorage()
                                                          .state
                                                          .Language ==
                                                      "fr"
                                                  ? formatTimeToFrench(
                                                      itemCollecte.endDate!)
                                                  : formatTimeToEnglish(
                                                      itemCollecte.endDate!),
                                              soldeCotisation:
                                                  itemCollecte.collectBalance!,
                                              codeCotisation:
                                                  itemCollecte.code!,
                                              type: itemCollecte.type!,
                                              lienDePaiement:
                                                  itemCollecte.collectPayLink!,
                                              is_passed: itemCollecte.isPassed!,
                                              is_tontine: 0,
                                              description:
                                                  itemCollecte.description!,
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
                              screenSource: "transactions.btnAddContribution",
                              text: "Ajouter une collecte".tr(),
                              routeElement: "collecte-externe?query=1",
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
                            if (CotisationState.isLoadingCollect == true &&
                                CotisationState.allCotisationAss != null)
                              EasyLoader(
                                backgroundColor:
                                    Color.fromARGB(0, 255, 255, 255),
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
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "aucune_collecte".tr(),
                                        style: TextStyle(
                                          color: AppColors.blackBlueAccent1,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      if (!context
                                          .read<AuthCubit>()
                                          .state
                                          .detailUser!["isMember"])
                                        InkWell(
                                          onTap: () async {
                                            updateTrackingData(
                                                "transactions.btnAddCollecte",
                                                "${DateTime.now()}", {});
                                            launchWeb(
                                              "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/collecte-externe?query=1&app_mode=mobile",
                                            );
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2.w,
                                                color: AppColors.blackBlue
                                                    .withOpacity(1),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20.r,
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 7.h,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Ajouter une collecte".tr(),
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
                                                  margin: EdgeInsets.only(
                                                      left: 3.w),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            360),
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
            )
          ],
        ),
      ),
    );
  }

  Widget buildCategoryButton(String category) {
    return InkWell(
      onTap: () {
        print(category);
        setState(() {
          selectedCategory = category;
          isLoading = true;
          print("Selected Category1: $selectedCategory");
        });
        print("Selected Category: $selectedCategory");
        Timer(Duration(seconds: 1), () {
          setState(() {
            isLoading = false;
          });
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: category == selectedCategory
              ? AppColors.colorButton.withOpacity(0.1)
              : AppColors.blackBlue.withOpacity(0.1),
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




  Widget buildCotisationType(String cotisationType) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedCotisationType = cotisationType;
          isLoading = true;
        });
        if (cotisationType == "cotisation interne".tr()) {
          setState(() {
            selectedCategory = "Toutes".tr();
          });
          await handleAllCotisationAssTournoi(
            AppCubitStorage().state.codeTournoisHist,
            AppCubitStorage().state.membreCode,
          );
        } else {
          setState(() {
            selectedCategory = "en_cours".tr();
          });
          handleGetCollectes();
        }
        setState(() {
          isLoading = false;
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
          color: cotisationType == selectedCotisationType
              ? AppColors.colorButton.withOpacity(0.1)
              : AppColors.blackBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          cotisationType,
          style: TextStyle(
            color: cotisationType == selectedCotisationType
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
