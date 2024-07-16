import 'dart:async';
import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
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

class ListMeetingScreen extends StatefulWidget {
  const ListMeetingScreen({super.key});

  @override
  State<ListMeetingScreen> createState() => _ListMeetingScreenState();
}

class _ListMeetingScreenState extends State<ListMeetingScreen> {
  String selectedCategory =
      "Toutes"; // État pour suivre la catégorie sélectionnée
  bool showCategories =
      true; // État pour indiquer si les catégories doivent être affichées
  bool isLoading = false;

  ScrollController _scrollController =
      ScrollController(); // Contrôleur de défilement

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
    super.initState();
    // Ajouter un écouteur pour détecter les événements de défilement

    handleTournoiDefault(AppCubitStorage().state.codeTournoisHist);
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
      appBar: AppBar(
        centerTitle: false,
        // toolbarHeight: 130.h,
        title: Text(
          'Vos rencontres'.tr(),
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
          return currentDetailtournoiCourant!["tournois"]["seance"]!.length > 0
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
                                  buildCategoryButton("En cours"),
                                  buildCategoryButton("Terminé"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            // Votre ListView.builder
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                left: 15.w,
                                right: 15.w,
                                bottom: 20.h,
                              ),
                              controller: _scrollController,
                              itemCount: currentDetailtournoiCourant["tournois"]
                                      ["seance"]
                                  .length,
                              itemBuilder: (context, index) {
                                final itemSeance =
                                    currentDetailtournoiCourant["tournois"]
                                        ["seance"][index];

                                // Filtrer les éléments en fonction de la catégorie sélectionnée
                                if (selectedCategory == "Toutes" ||
                                    (selectedCategory == "En cours" &&
                                        itemSeance["status"] == 1 &&
                                        !isPasseDate(
                                            itemSeance["date_seance"])) ||
                                    (selectedCategory == "Terminé" &&
                                        (itemSeance["status"] == 0 ||
                                            isPasseDate(
                                                itemSeance["date_seance"])))) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: WidgetRencontreCard(
                                      codeTournoi: AppCubitStorage()
                                          .state
                                          .codeTournoisHist!,
                                      screenSource: "transactions.meeting",
                                      typeRencontre:
                                          itemSeance["type_rencontre"],
                                      rapportUrl: itemSeance["rapport"],
                                      maskElt: false,
                                      codeSeance: itemSeance["seance_code"],
                                      photoProfilRecepteur: itemSeance["membre"]
                                                  ["photo_profil"] ==
                                              null
                                          ? ''
                                          : itemSeance["membre"]
                                              ["photo_profil"],
                                      dateRencontre:
                                          AppCubitStorage().state.Language ==
                                                  "fr"
                                              ? formatDateToFrench(
                                                  itemSeance["date_seance"])
                                              : formatDateToEnglish(
                                                  itemSeance["date_seance"]),
                                      descriptionRencontre:
                                          '${formatDateTimeintegral(context.locale.toString() == "en_US" ? "en" : "fr", itemSeance["date_seance"]).toUpperCase()} ${"à".tr()} ${itemSeance["heure_debut"]}',
                                      heureRencontre: itemSeance["heure_debut"],
                                      identifiantRencontre:
                                          itemSeance["matricule"],
                                      lieuRencontre: itemSeance["localisation"],
                                      nomRecepteurRencontre:
                                          itemSeance["membre"]["first_name"] ==
                                                  null
                                              ? ""
                                              : itemSeance["membre"]
                                                  ["first_name"],
                                      isActiveRencontre: itemSeance["status"],
                                      prenomRecepteurRencontre:
                                          itemSeance["membre"]["last_name"] ==
                                                  null
                                              ? ""
                                              : itemSeance["membre"]
                                                  ["last_name"],
                                      dateRencontreAPI:
                                          itemSeance["date_seance"],
                                    ),
                                  );
                                } else {
                                  // Retourner un conteneur vide si l'élément ne correspond pas au filtre
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    AddAssoElement(
                      screenSource: "transactions.btnAddMeeting",
                      text: "Ajouter une rencontre".tr(),
                      routeElement: "seances?query=1",
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
                    if (DetailTournoiState!.isLoadingHist == true &&
                        DetailTournoiState.detailtournoiCourantHist != null)
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
                                Container(
                                  child: Text(
                                    "aucune_rencontre".tr(),
                                    style: TextStyle(
                                      color: AppColors.blackBlueAccent1,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                if (!context
                                    .read<AuthCubit>()
                                    .state
                                    .detailUser!["isMember"])
                                  InkWell(
                                    onTap: () async {
                                      updateTrackingData(
                                          "transactions.btnAddMeeting",
                                          "${DateTime.now()}", {});
                                      launchWeb(
                                        "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/seances?query=1&app_mode=mobile",
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
                                            "Ajouter une rencontre".tr(),
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
                        }),
                  ],
                );
        },
      ),
    );
  }

  // Méthode pour construire un bouton de catégorie
  Widget buildCategoryButton(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
          isLoading = true;
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

  @override
  void dispose() {
    _scrollController
        .dispose(); // Libérer le contrôleur de défilement lorsqu'il n'est plus utilisé
    super.dispose();
  }
}
