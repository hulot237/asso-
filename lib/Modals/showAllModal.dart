// import 'dart:html';
import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/screens/detailCotisationPage.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetListTransactionCotisationAllCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/paiement_sanction_widget.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/contribution_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetHistoriqueTontineCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/tournoi_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_webview/administrationPage.dart';
import 'package:faroty_association_1/Association_And_Group/association_webview/administration_webview.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_update_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/home_centrale_screen.dart';
import 'package:faroty_association_1/pages/paiement_screen.dart';
import 'package:faroty_association_1/routes/app_router.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:faroty_association_1/widget/widgetListAssCard.dart';
import 'package:faroty_association_1/widget/widgetListTransactionByEventCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Modal {
  String userDataFromWebView = 'null';

  void showBottomSheetListAss(BuildContext context, List? listAllAss) {
    bool isLoading = false;

    Future handleChangeAss(codeAss) async {
      final ChangeAss =
          await context.read<UserGroupCubit>().ChangeAssCubit(codeAss);

      await AppCubitStorage().updateCodeAssDefaul(codeAss);

      await AppCubitStorage().updatemembreCode(
        context
            .read<UserGroupCubit>()
            .state
            .changeAssData!
            .membre!
            .membre_code!,
        // .ChangeAssData!["membre"]["membre_code"],
      );

      await AppCubitStorage().updateCodeTournoisDefault(context
          .read<UserGroupCubit>()
          .state
          .changeAssData!
          .user_group!
          .tournois![0]
          .tournois_code!);
      await AppCubitStorage().updateCodeTournoisHist(context
          .read<UserGroupCubit>()
          .state
          .changeAssData!
          .user_group!
          .tournois![0]
          .tournois_code!);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => HomeCentraleScreen(),
        ),
        (route) => false,
      );
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 10.h,
                  bottom: 10.h,
                ),
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(7),
                    topLeft: Radius.circular(7),
                  ),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 5.h,
                      width: 55.w,
                      decoration: BoxDecoration(
                          color: AppColors.blackBlue,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Text(
                        "vos_associations".tr(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w900,
                          color: AppColors.blackBlueAccent1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listAllAss!.length,
                        itemBuilder: (context, index) {
                          final currentItemAssociationList = listAllAss[index];

                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });

                              await handleChangeAss(
                                  currentItemAssociationList["urlcode"]!);

                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: Column(
                              children: [
                                widgetListAssCard(
                                  urlcodeAss:
                                      currentItemAssociationList["urlcode"],
                                  nomAssociation:
                                      currentItemAssociationList["name"],
                                  nbreEventPending: 5,
                                  phofilAssociation:
                                      "${Variables.LienAIP}${currentItemAssociationList["profile_photo"] == null ? "" : currentItemAssociationList["profile_photo"]}",
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("objectobjectobjectobjectobject");
                        await launchUrlString(
                          "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://business.faroty.com/groups&app_mode=mobile",
                          mode: LaunchMode.platformDefault,
                        );
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            width: 1.r,
                            color: AppColors.blackBlue,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                right: 20.h,
                              ),
                              child: SvgPicture.asset(
                                "assets/images/addIcon.svg",
                                fit: BoxFit.scaleDown,
                                color: AppColors.blackBlue,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7.h, bottom: 7.h),
                              child: Text(
                                "Ajouter un nouveau groupe".tr(),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blackBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<UserGroupCubit, UserGroupState>(
                  builder: (UserGroupContext, UserGroupState) {
                if (UserGroupState.isLoading == null ||
                    UserGroupState.isLoading == true)
                  return Center(
                    child: EasyLoader(
                      backgroundColor: Color.fromARGB(0, 255, 255, 255),
                      iconSize: 50.r,
                      iconColor: AppColors.blackBlueAccent1,
                      image: AssetImage(
                        "assets/images/AssoplusFinal.png",
                      ),
                    ),
                  );

                return isLoading
                    ? Center(
                        child: EasyLoader(
                          backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          iconSize: 50.r,
                          iconColor: AppColors.blackBlueAccent1,
                          image: AssetImage(
                            "assets/images/AssoplusFinal.png",
                          ),
                        ),
                      )
                    : Container();
              }),
            ],
          );
        });
      },
    );
  }

  void showBottomSheetListTournoi(BuildContext context,
      List<TournoiModel>? currentInfoAssociationCourant, bool isHistorique) {
    // .state.userGroupDefault
    Color? colorSelect(tournois_code) {
      if (tournois_code == AppCubitStorage().state.codeTournois) {
        return AppColors.colorButton;
      } else {
        return Color.fromARGB(23, 20, 45, 99);
      }
      // Aucune correspondance trouvée, retourne null.
      // return null;
    }

    Color? colorSelectInac(tournois_code) {
      if (tournois_code == AppCubitStorage().state.codeTournois) {
        return AppColors.white;
      } else {
        return AppColors.colorButton.withOpacity(0.6);
      }
      // Aucune correspondance trouvée, retourne null.
      // return null;
    }

    Color? colorSelectText(tournois_code) {
      if (tournois_code == AppCubitStorage().state.codeTournois) {
        return AppColors.white;
      } else {
        return Color.fromARGB(139, 20, 45, 99);
      }
      // Aucune correspondance trouvée, retourne null.
      // return null;
    }

    Color? colorSelectTextInac(tournois_code) {
      if (tournois_code == AppCubitStorage().state.codeTournois) {
        return AppColors.blackBlue;
      } else {
        return AppColors.white;
      }
      // Aucune correspondance trouvée, retourne null.
      // return null;
    }

    bool isLoading = false;

    Future handleChangeTournoi(codeTournoi, isHistorique) async {
      final allCotisationAss = await context
          .read<DetailTournoiCourantCubit>()
          .changeTournoiCubit(
              codeTournoi, AppCubitStorage().state.codeAssDefaul);

      await AppCubitStorage().updateCodeTournoisDefault(codeTournoi);
      await AppCubitStorage().updateCodeTournoisHist(codeTournoi);

      if (!isHistorique) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => HomeCentraleScreen(),
          ),
          (route) => false,
        );
      } else {
        // await context.read<UserGroupCubit>().ChangeAssCubit(AppCubitStorage().state.codeAssDefaul);
        await context
            .read<DetailTournoiCourantCubit>()
            .detailTournoiCourantCubit(codeTournoi);
        await context.read<CotisationCubit>().AllCotisationAssTournoiCubit(
            codeTournoi, AppCubitStorage().state.membreCode);
        // await context
        // .read<CotisationCubit>()
        // .AllCotisationAssTournoiCubit(codeTournoi, codeMembre)
        Navigator.pop(context);
      }

      if (allCotisationAss != null) {
      } else {
        print("userGroupDefault null");
      }
    }

    showModalBottomSheet(
      barrierColor: AppColors.barrierColorModal,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 10.h,
                  bottom: 10.h,
                ),
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(7),
                    topLeft: Radius.circular(7),
                  ),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 5.h,
                      width: 55.w,
                      decoration: BoxDecoration(
                          // if (item["tournois_code"] == AppCubitStorage().state.codeTournois)
                          color: AppColors.blackBlue,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Text(
                        "vos_tournois".tr(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w900,
                          color: AppColors.blackBlue,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: currentInfoAssociationCourant!.length,
                        itemBuilder: (context, index) {
                          final currentItemAssociationList =
                              currentInfoAssociationCourant[index];
                          print(
                              "aaaaaaaaaaaaaaaaaaaaaaaa ${currentItemAssociationList.is_default}");

                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await handleChangeTournoi(
                                  currentItemAssociationList.tournois_code,
                                  isHistorique);
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 15.h,
                                bottom: 15.h,
                                left: 15.w,
                              ),
                              decoration: BoxDecoration(
                                color: colorSelect(
                                    currentItemAssociationList.tournois_code),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              margin: EdgeInsets.all(5.r),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${"tournoi".tr()} #${currentItemAssociationList.matricule}',
                                    style: TextStyle(
                                        color: colorSelectText(
                                          currentItemAssociationList
                                              .tournois_code,
                                        ),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14.sp),
                                  ),
                                  if (currentItemAssociationList.is_default ==
                                      1)
                                    Container(
                                      padding: EdgeInsets.only(
                                        // top: 15.h,
                                        // bottom: 15.h,
                                        left: 10.w,
                                        right: 10.w,
                                        top: 3.h,
                                        bottom: 3.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorSelectInac(
                                            currentItemAssociationList
                                                .tournois_code),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      margin: EdgeInsets.all(5.r),
                                      child: Text(
                                        "Actif",
                                        style: TextStyle(
                                            color: colorSelectTextInac(
                                              currentItemAssociationList
                                                  .tournois_code,
                                            ),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  if (currentItemAssociationList.is_default ==
                                      0)
                                    Container(
                                      padding: EdgeInsets.only(
                                        // top: 15.h,
                                        // bottom: 15.h,
                                        left: 10.w,
                                        right: 10.w,
                                        top: 3.h,
                                        bottom: 3.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorSelectInac(
                                            currentItemAssociationList
                                                .tournois_code),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      margin: EdgeInsets.all(5.r),
                                      child: Text(
                                        "Inactif",
                                        style: TextStyle(
                                          color: colorSelectTextInac(
                                            currentItemAssociationList
                                                .tournois_code,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              BlocBuilder<DetailTournoiCourantCubit, DetailTournoiCourantState>(
                  builder:
                      (DetailTournoiCouranContext, DetailTournoiCouranState) {
                if (DetailTournoiCouranState.isLoading == null ||
                    DetailTournoiCouranState.isLoading == true)
                  return Center(
                    child: EasyLoader(
                      backgroundColor: Color.fromARGB(0, 255, 255, 255),
                      iconSize: 50.r,
                      iconColor: AppColors.blackBlueAccent1,
                      image: AssetImage(
                        "assets/images/AssoplusFinal.png",
                      ),
                    ),
                  );

                return isLoading
                    ? Center(
                        child: EasyLoader(
                          backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          iconSize: 50.r,
                          iconColor: AppColors.blackBlueAccent1,
                          image: AssetImage(
                            "assets/images/AssoplusFinal.png",
                          ),
                        ),
                      )
                    : Container();
              }),
            ],
          );
        });
      },
    );
  }

  void showBottomSheetHistTontine(BuildContext context, codeContribution,
      {var codeTontine}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (context) {
        return Container(
          // height: 500,
          padding: EdgeInsets.only(top: 10.h),
          margin: EdgeInsets.only(left: 5.w, right: 5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(7),
              topLeft: Radius.circular(7),
            ),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: TontineHistoriqueWidget(
            codeContribution: codeContribution,
            codeTontine: codeTontine,
          ),
        );
      },
    );
  }

  void showBottomSheetHistCotisation(
    BuildContext context,
    codeCotisation,
    lienDePaiement,
    dateCotisation,
    heureCotisation,
    montantCotisations,
    motifCotisations,
    soldeCotisation,
    type,
    is_passed,
    rapportUrl,
    isPayed,
    source,
    nomBeneficiaire,
    rubrique,
    is_tontine,
  ) {
    Future<void> handleDetailCotisation(codeCotisation) async {
      final detailCotisation = await context
          .read<CotisationDetailCubit>()
          .detailCotisationCubit(codeCotisation);
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (context) {
        return Container(
          // height: 500,
          padding: EdgeInsets.only(top: 10.h),
          margin: EdgeInsets.only(left: 5.w, right: 5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(7),
              topLeft: Radius.circular(7),
            ),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: CotisationHistoriqueWidget(
            rapportUrl: rapportUrl,
            codeCotisation: codeCotisation,
            lienDePaiement: lienDePaiement,
            dateCotisation: dateCotisation,
            heureCotisation: heureCotisation,
            montantCotisations: montantCotisations,
            motifCotisations: motifCotisations,
            soldeCotisation: soldeCotisation,
            type: type,
            is_passed: is_passed,
            isPayed: isPayed,
            is_tontine: is_tontine,
            source: source,
            nomBeneficiaire: nomBeneficiaire,
            rubrique: rubrique,
          ),
        );
      },
    );
  }

  void showModalTransactionByEvent(context, versement, montantAPayer,
      {resteAPayer, dejaPayer}) {
    showDialog<String>(
      context: context,
      barrierColor: AppColors.barrierColorModal,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10.r),
        contentPadding: EdgeInsets.only(top: 0),
        content: Container(
          margin: EdgeInsets.only(
            bottom: 10.h,
          ),
          // padding: EdgeInsets.only(left: 20, right: 20),
          height: 450.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 15.h),
                    child: Text(
                      "liste_de_vos_transactions".tr(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.blackBlue,
                      ),
                    ),
                    padding: EdgeInsets.only(top: 15.h),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.r),
                    margin: EdgeInsets.only(
                      top: 15.h,
                      bottom: 10.h,
                      left: 2.w,
                      right: 2.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        width: 0.5.r,
                        color: AppColors.blackBlue,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "a_payer".tr(),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.blackBlue,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${formatMontantFrancais(double.parse(montantAPayer))} FCFA",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                "déjà_payé".tr(),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                dejaPayer == null
                                    ? "${formatMontantFrancais(double.parse(versement.length > 0 ? versement[0]["balance_after"] : "0"))} FCFA"
                                    : "${formatMontantFrancais(double.parse(dejaPayer))} FCFA",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                "reste".tr(),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.red,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                resteAPayer == null
                                    ? "${formatMontantFrancais(double.parse(versement.length > 0 ? versement[0]["balance_remaining"] : "0"))} FCFA"
                                    : "${formatMontantFrancais(double.parse(resteAPayer))} FCFA",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              versement.length > 0
                  ? Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Color.fromARGB(120, 226, 226, 226),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 7.h,
                            right: 7.w,
                            left: 7.w,
                            bottom: 7.h,
                          ),
                          color: AppColors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      versement[0]["transanctions"] != null
                                          ? versement[0]["transanctions"].length
                                          : versement.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final detailVersement =
                                        versement[0]["transanctions"] != null
                                            ? versement[0]["transanctions"]
                                                [index]
                                            : versement[index];

                                    print(detailVersement);
                                    return Container(
                                      child: widgetListTransactionByEventCard(
                                        date: formatDateLiteral(
                                          detailVersement["created_at"],
                                        ),
                                        montant: detailVersement["amount"],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(top: 200.h),
                      alignment: Alignment.topCenter,
                      child: Text(
                        "aucune_transaction".tr(),
                        style: TextStyle(
                          color: Color.fromRGBO(20, 45, 99, 0.26),
                          fontWeight: FontWeight.w100,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void showModalTransactionEpargne(
    BuildContext context,
  ) {
    Future<void> handleDetailCotisation(codeCotisation) async {
      final detailCotisation = await context
          .read<CotisationDetailCubit>()
          .detailCotisationCubit(codeCotisation);
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (context) {
        return Container(
          // height: 500,
          padding: EdgeInsets.only(top: 10.h),
          margin: EdgeInsets.only(left: 5.w, right: 5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(7),
              topLeft: Radius.circular(7),
            ),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            children: [
              Container(
                height: 5.h,
                width: 55.w,
                decoration: BoxDecoration(
                    color: AppColors.blackBlue,
                    borderRadius: BorderRadius.circular(50)),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    child: Text(
                      "vos transaction sur l'épargne".tr(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.blackBlueAccent1,
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<PretEpargneCubit, PretEpargneState>(
                builder: (PretEpargnecontext, PretEpargnestate) {
                  if (PretEpargnestate.isLoadingDetailEpargne == true &&
                      PretEpargnestate.detailEpargne == null)
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

                  final currentDetailCotisation =
                      PretEpargnecontext.read<PretEpargneCubit>()
                          .state
                          .detailEpargne;

                  print("objectobjectobjectobject ${currentDetailCotisation}");

                  return currentDetailCotisation!.length > 0
                      ? Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(120, 226, 226, 226),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 7.h,
                                    right: 5.w,
                                    left: 5.w,
                                    bottom: 7.h,
                                  ),
                                  color: AppColors.white,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount:
                                              currentDetailCotisation.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final detailVersement =
                                                currentDetailCotisation[index];
                                            return Container(
                                                child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                  .width,
                                              margin: EdgeInsets.only(top: 5.h),
                                              child: Container(
                                                padding: EdgeInsets.all(10.r),
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      width: 0.5.r,
                                                      color: Color.fromARGB(
                                                          62, 20, 45, 99),
                                                    ),
                                                  ),
                                                ),
                                                // margin: EdgeInsets.only(top: 5, left: 7, right: 7),
                                                // padding: EdgeInsets.all(15),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 5.h),
                                                          child: Text(
                                                            "${formatMontantFrancais(double.parse(detailVersement["amount"]))} FCFA",
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: detailVersement[
                                                                          "payment_type"] ==
                                                                      "0"
                                                                  ? AppColors
                                                                      .green
                                                                  : AppColors
                                                                      .red,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          child: Icon(
                                                            detailVersement[
                                                                        "payment_type"] ==
                                                                    "0"
                                                                ? Icons
                                                                    .call_received
                                                                : Icons
                                                                    .north_east,
                                                            size: 18.sp,
                                                            color: AppColors
                                                                .blackBlue,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            formatDateLiteral(
                                                                detailVersement[
                                                                    "created_at"]),
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .blackBlue,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )

                                                // child: widgetListTransactionByEventCard(
                                                //   date: formatDateLiteral(
                                                //       detailVersement["created_at"]),
                                                //   montant: detailVersement["amount"],
                                                // ),
                                                );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (PretEpargnestate.isLoadingDetailEpargne ==
                                      true &&
                                  PretEpargnestate.detailEpargne != null)
                                Center(
                                  child: EasyLoader(
                                    backgroundColor:
                                        Color.fromARGB(0, 255, 255, 255),
                                    iconSize: 50.r,
                                    iconColor: AppColors.blackBlueAccent1,
                                    image: AssetImage(
                                      "assets/images/AssoplusFinal.png",
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(top: 200.h),
                          alignment: Alignment.topCenter,
                          child: Text(
                            "aucune_transaction".tr(),
                            style: TextStyle(
                              color: Color.fromRGBO(20, 45, 99, 0.26),
                              fontWeight: FontWeight.w100,
                              fontSize: 20.sp,
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showModalTransactionPret(
    BuildContext context,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (context) {
        return Container(
          // height: 500,
          padding: EdgeInsets.only(top: 10.h),
          margin: EdgeInsets.only(left: 5.w, right: 5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(7),
              topLeft: Radius.circular(7),
            ),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            children: [
              Container(
                height: 5.h,
                width: 55.w,
                decoration: BoxDecoration(
                    color: AppColors.blackBlue,
                    borderRadius: BorderRadius.circular(50)),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    child: Text(
                      "vos transaction sur le pret".tr(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.blackBlueAccent1,
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<PretEpargneCubit, PretEpargneState>(
                builder: (PretEpargnecontext, PretEpargnestate) {
                  if (PretEpargnestate.isLoadingDetailPret == true &&
                      PretEpargnestate.detailPret == null)
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

                  final currentDetailPret =
                      PretEpargnecontext.read<PretEpargneCubit>()
                          .state
                          .detailPret;

                  print("objectobjectobjectobject ${currentDetailPret}");

                  return currentDetailPret!.length > 0
                      ? Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(120, 226, 226, 226),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 7.h,
                                    right: 5.w,
                                    left: 5.w,
                                    bottom: 7.h,
                                  ),
                                  color: AppColors.white,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: currentDetailPret.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final detailVersement =
                                                currentDetailPret[index];
                                            return Container(
                                                child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                  .width,
                                              margin: EdgeInsets.only(top: 5.h),
                                              child: Container(
                                                padding: EdgeInsets.all(10.r),
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      width: 0.5.r,
                                                      color: Color.fromARGB(
                                                          62, 20, 45, 99),
                                                    ),
                                                  ),
                                                ),
                                                // margin: EdgeInsets.only(top: 5, left: 7, right: 7),
                                                // padding: EdgeInsets.all(15),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 5.h),
                                                          child: Text(
                                                            "${formatMontantFrancais(double.parse(detailVersement["amount"]))} FCFA",
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: detailVersement[
                                                                          "payment_type"] ==
                                                                      "0"
                                                                  ? AppColors
                                                                      .green
                                                                  : AppColors
                                                                      .red,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          child: Icon(
                                                            detailVersement[
                                                                        "payment_type"] ==
                                                                    "0"
                                                                ? Icons
                                                                    .north_east
                                                                : Icons
                                                                    .call_received,
                                                            size: 18.sp,
                                                            color: AppColors
                                                                .blackBlue,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            formatDateLiteral(
                                                                detailVersement[
                                                                    "created_at"]),
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .blackBlue,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )

                                                // child: widgetListTransactionByEventCard(
                                                //   date: formatDateLiteral(
                                                //       detailVersement["created_at"]),
                                                //   montant: detailVersement["amount"],
                                                // ),
                                                );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (PretEpargnestate.isLoadingDetailPret ==
                                      true &&
                                  PretEpargnestate.detailPret != null)
                                Center(
                                  child: EasyLoader(
                                    backgroundColor:
                                        Color.fromARGB(0, 255, 255, 255),
                                    iconSize: 50.r,
                                    iconColor: AppColors.blackBlueAccent1,
                                    image: AssetImage(
                                      "assets/images/AssoplusFinal.png",
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(top: 200.h),
                          alignment: Alignment.topCenter,
                          child: Text(
                            "aucune_transaction".tr(),
                            style: TextStyle(
                              color: Color.fromRGBO(20, 45, 99, 0.26),
                              fontWeight: FontWeight.w100,
                              fontSize: 20.sp,
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showModalAllTransactionCotisation(context) {
    showDialog<String>(
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10.r),
        contentPadding: EdgeInsets.only(top: 0),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15.h),
              child: Text(
                'les_transactions_sur_la_cotisation'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.blackBlue,
                ),
              ),
              padding: EdgeInsets.only(top: 15.h),
            ),
          ],
        ),
        content: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(120, 226, 226, 226),
          // padding: EdgeInsets.only(top: 10),
          // margin: EdgeInsets.only(bottom: 1, left: 1, right: 1),
          child: Container(
            padding: EdgeInsets.only(top: 7.h),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: widgetListTransactionCotisationAllCard(),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              'fermer'.tr(),
              style: TextStyle(
                color: AppColors.blackBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showModalPersonSanctionner(context, var listSanction) {
    showDialog<String>(
      context: context,
      barrierColor: AppColors.barrierColorModal,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10.r),
        contentPadding: EdgeInsets.only(top: 0),
        content: Container(
          height: 450,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          // height: 450,
          // width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.only(top: 10),
          // color: Color.fromARGB(120, 226, 226, 226),
          padding: EdgeInsets.only(top: 5.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                alignment: Alignment.center,
                child: Text(
                  'les_personnes_sanctionnées'.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.blackBlue,
                  ),
                ),
              ),
              Expanded(
                child: listSanction.length > 0
                    ? ListView.builder(
                        itemCount: listSanction.length,
                        itemBuilder: (context, index) {
                          final itemLListSanction = listSanction[index];

                          return Container(
                            margin: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: WidgetPersonSanctionner(
                              motif: itemLListSanction["motif"],
                              nom: itemLListSanction["membre"]["first_name"] ==
                                      null
                                  ? ""
                                  : itemLListSanction["membre"]["first_name"],
                              outilSanction: itemLListSanction["amount"]
                                          .toString() ==
                                      "null"
                                  ? itemLListSanction["libelle"]
                                  : "${formatMontantFrancais(double.parse(itemLListSanction["amount"].toString()))} FCFA",
                              photoProfil: itemLListSanction["membre"]
                                          ["photo_profil"] ==
                                      null
                                  ? ""
                                  : itemLListSanction["membre"]["photo_profil"],
                              prenom: itemLListSanction["membre"]
                                          ["last_name"] ==
                                      null
                                  ? ""
                                  : itemLListSanction["membre"]["last_name"],
                            ),
                          );
                        },
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 200.h),
                        alignment: Alignment.topCenter,
                        child: Text(
                          "aucune_sanction".tr(),
                          style: TextStyle(
                            color: Color.fromRGBO(20, 45, 99, 0.26),
                            fontWeight: FontWeight.w100,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showModalPersonPresent(
    context,
    tabController,
    var listAbs,
    var listPrsent,
  ) {
    showDialog<String>(
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10.r),
        contentPadding: EdgeInsets.only(top: 0),
        content: Container(
          height: 550.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                alignment: Alignment.center,
                child: Text(
                  'liste_de_presence'.tr(),
                  style: TextStyle(
                    color: AppColors.blackBlue,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    // color: AppColors.blackBlueAccent2,
                    padding: EdgeInsets.all(5.r),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          itemCount: listPrsent.length,
                          itemBuilder: (context, index) {
                            final currentListPrsent = listPrsent[index];
                            return Container(
                              // padding: EdgeInsets.all(5.r),
                              child: widgetListPresenceCard(
                                imageProfil:
                                    currentListPrsent["photo_profil"] == null
                                        ? ""
                                        : currentListPrsent['photo_profil'],
                                nom: currentListPrsent['first_name'] == null
                                    ? ""
                                    : currentListPrsent['first_name'],
                                prenom: currentListPrsent['last_name'] == null
                                    ? ""
                                    : currentListPrsent['last_name'],
                                presence: '1',
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          itemCount: listAbs.length,
                          itemBuilder: (context, index) {
                            final currentListAbs = listAbs[index];

                            return Container(
                              // padding: EdgeInsets.all(5.r),
                              child: widgetListPresenceCard(
                                imageProfil:
                                    currentListAbs["photo_profil"] == null
                                        ? ""
                                        : currentListAbs['photo_profil'],
                                nom: currentListAbs['first_name'] == null
                                    ? " "
                                    : currentListAbs['first_name'],
                                prenom: currentListAbs['last_name'] == null
                                    ? " "
                                    : currentListAbs['last_name'],
                                presence: '0',
                              ),
                            );
                          },
                        ),

                        //  Text("2"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheetEditProfilPhoto(BuildContext context, key, _pickImage) {
    TextEditingController infoUserController = TextEditingController();
    Future<void> handleDetailUser(userCode, codeTournoi) async {
      final allCotisationAss = await context
          .read<AuthCubit>()
          .detailAuthCubit(userCode, codeTournoi);
    }

    Future<void> handleUpdateInfoUser(
        key, value, partner_urlcode, membre_code) async {
      final allCotisationAss = await context
          .read<AuthUpdateCubit>()
          .UpdateInfoUserCubit(key, value, partner_urlcode, membre_code);

      if (allCotisationAss != null) {
      } else {
        print("userGroupDefault null");
      }
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // isScrollControlled: true,
      barrierColor: AppColors.barrierColorModal,
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 5.h,
                    width: 55.w,
                    margin: EdgeInsets.only(bottom: 10.h),
                    decoration: BoxDecoration(
                      color: AppColors.blackBlue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pickImage;
                    },
                    child: Container(
                      height: 50.h,
                      margin: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                        bottom: 10.h,
                      ),
                      padding: EdgeInsets.only(left: 25.w),
                      // height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Color.fromARGB(15, 20, 45, 99),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            color: AppColors.blackBlue,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20.w),
                            child: Text(
                              "Camera",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: AppColors.blackBlue,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    margin: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                    ),
                    padding: EdgeInsets.only(left: 25.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color.fromARGB(15, 20, 45, 99),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          color: AppColors.blackBlue,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.w),
                          child: Text(
                            "Galerie",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: AppColors.blackBlue,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showBottomSheetEditProfil(BuildContext context, hintText, key) {
    TextEditingController infoUserController =
        TextEditingController(text: "${hintText}");

    Future<void> handleDetailUser(userCode, codeTournoi) async {
      final allCotisationAss = await context
          .read<AuthCubit>()
          .detailAuthCubit(userCode, codeTournoi);
    }

    Future<void> handleUpdateInfoUser(
        key, value, partner_urlcode, membre_code) async {
      final allCotisationAss = await context
          .read<AuthUpdateCubit>()
          .UpdateInfoUserCubit(key, value, partner_urlcode, membre_code);

      if (allCotisationAss != null) {
      } else {
        print("userGroupDefault null");
      }
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.barrierColorModal,
      // isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: AppColors.white,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 5.h,
                    width: 55.w,
                    decoration: BoxDecoration(
                        color: AppColors.blackBlue,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    child: Text(
                      "entrer_la_nouvelle_valeur".tr(),
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackBlueAccent1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                    ),
                    padding: EdgeInsets.only(left: 15.w),
                    // height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color.fromARGB(15, 20, 45, 99),
                    ),
                    child: TextField(
                      controller: infoUserController,
                      autofocus: true,
                      style: TextStyle(fontSize: 15.sp),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await handleUpdateInfoUser(
                          key,
                          infoUserController.text,
                          AppCubitStorage().state.codeAssDefaul,
                          AppCubitStorage().state.membreCode);
                      await handleDetailUser(AppCubitStorage().state.membreCode,
                          AppCubitStorage().state.codeTournois);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      margin: EdgeInsets.only(
                        top: 10.h,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.colorButton,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        "confirmer".tr(),
                        style:
                            TextStyle(color: AppColors.white, fontSize: 12.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showModalActionPayement(
      BuildContext context,
      msg,
      lienDePaiement,
      raisonComplete,
      motif,
      paiementProcheMsg,
      msgAppBarPaiementPage,
      elementUrl) {
    showDialog<String>(
      context: context,
      barrierColor: AppColors.barrierColorModal,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.only(top: 0),
        content: Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          height: !context.read<AuthCubit>().state.detailUser!["isMember"]
              ? 185.h
              : 150.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  "$raisonComplete",
                  // 'effectuer_le_paiement'.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.blackBlue,
                  ),
                ),
                // padding: EdgeInsets.only(top: 15.h),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(
                    context,
                  );
                  await launchUrlString(
                    "https://${lienDePaiement}?code=${AppCubitStorage().state.membreCode}",
                    mode: LaunchMode.platformDefault,
                  );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => PaiementPage(
                  //       lienDePaiement: lienDePaiement,
                  //       msgAppBarPaiementPage: msgAppBarPaiementPage,
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(7.r),
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 11.h),
                  decoration: BoxDecoration(
                    color: AppColors.colorButton,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    // "payer_vous_même".tr(),
                    "$motif",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                  Share.share("${msg}");
                },
                child: Container(
                  alignment: Alignment.center,

                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(7.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColors.colorButton,
                      )),
                  // height: 20,
                  child: Text(
                    '$paiementProcheMsg',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorButton,
                    ),
                  ),
                ),
              ),
              if (!context.read<AuthCubit>().state.detailUser!["isMember"])
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(
                      context,
                    );
                    await launchUrlString(
                      "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=${elementUrl}&app_mode=mobile",
                      mode: LaunchMode.platformDefault,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 11.h),
                    padding: EdgeInsets.all(7.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.colorButton,
                        )),
                    // height: 20,
                    child: Text(
                      'Payer à partir du tableau de bord'.tr(),

                      // "partager_le_lien_de_paiement".tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorButton,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void showFullPicture(context, photo, textAppbar) {
    showGeneralDialog(
      context: context,
      barrierDismissible:
          false, // should dialog be dismissed when tapped outside
      // barrierLabel: "Modal", // label for barrier
      transitionDuration: Duration(
        milliseconds: 400,
      ), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return Material(
          color: Colors.transparent,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.blackBlue,
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColors.white,
                    size: 16.sp,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                textAppbar,
                style: TextStyle(
                  color: AppColors.white,
                  // fontFamily: 'Overpass',
                  fontSize: 16.sp,
                ),
              ),
              elevation: 0.0,
            ),
            backgroundColor: AppColors.blackBlue,
            body: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Image.network(
                  "$photo",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showModalPaySanction(context, nom, resteAPayer, codeSanction, codeMembre,
      typeSaction, objectSanction, codeTournoi) {
    showDialog(
        context: context,
        barrierColor: AppColors.barrierColorModal,
        builder: (BuildContext context) {
          Future<void> handleDetailCotisation(codeSanction) async {
            // final detailTournoiCourant = await context
            //     .read<DetailTournoiCourantCubit>()
            //     .detailTournoiCourantCubit();
            final detailCotisation = await context
                .read<CotisationDetailCubit>()
                .detailCotisationCubit(codeSanction);
          }

          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r)),
            child: Container(
              constraints:
                  BoxConstraints(maxHeight: typeSaction == "1" ? 250.h : 200.h),
              child: PaiementSanctionWidget(
                codeTournoi: codeTournoi,
                nom: nom,
                codeSanction: codeSanction,
                codeMembre: codeMembre,
                resteAPayer: resteAPayer,
                typeSanction: typeSaction,
                objectSanction: objectSanction,
              ),
            ),
          );
        });
  }

  void showShareLinkPage(context, nomGroupe) {
    showGeneralDialog(
      context: context,

      barrierDismissible:
          false, // should dialog be dismissed when tapped outside
      // barrierLabel: "Modal", // label for barrier

      transitionDuration: Duration(
        milliseconds: 400,
      ), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return Material(
          color: Colors.transparent,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white,
              // centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(context);
                },
                child: BackButtonWidget(
                  colorIcon: AppColors.blackBlue,
                ),
              ),
              title: Text(
                "Lien d'invitation".tr(),
                style: TextStyle(
                  color: AppColors.blackBlue,
                  // fontFamily: 'Overpass',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0.5,
            ),
            backgroundColor: AppColors.white,
            body: Column(
              children: [
                InkWell(
                  onTap: () {
                    updateTrackingData(
                        "inviteLink.copyLink", "${DateTime.now()}", {});
                    Clipboard.setData(ClipboardData(
                            text:
                                "${Variables.LienInvit}/subscribe?urlcode=${AppCubitStorage().state.codeAssDefaul}"))
                        .then(
                      (value) {
                        return toastification.show(
                          context: context,
                          title: Text(
                            "Copié".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          autoCloseDuration: Duration(seconds: 2),
                          type: ToastificationType.success,
                          style: ToastificationStyle.minimal,
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 50.h,
                      bottom: 50.h,
                      left: 20.w,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 55.w,
                          height: 55.w,
                          decoration: BoxDecoration(
                            color: AppColors.colorButton,
                            borderRadius: BorderRadius.circular(360),
                          ),
                          child: SvgPicture.asset(
                            "assets/images/linkIcon.svg",
                            fit: BoxFit.scaleDown,
                            color: AppColors.white,
                          ),
                          margin: EdgeInsets.fromLTRB(0, 0, 15.w, 0),
                          // child: Image.network(
                          //   "$photo",
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        Expanded(
                          child: Container(
                            // width: MediaQuery.of(context).size.width / 1.5,
                            // color: AppColors.blackBlueAccent1,
                            child: Text(
                              "${Variables.LienInvit}/subscribe?urlcode=${AppCubitStorage().state.codeAssDefaul}",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.blackBlue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    updateTrackingData(
                        "inviteLink.copyLink", "${DateTime.now()}", {});
                    Clipboard.setData(ClipboardData(
                            text:
                                "${Variables.LienInvit}/subscribe?urlcode=${AppCubitStorage().state.codeAssDefaul}"))
                        .then(
                      (value) {
                        return toastification.show(
                          context: context,
                          title: Text(
                            "Copié".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          autoCloseDuration: Duration(seconds: 2),
                          type: ToastificationType.success,
                          style: ToastificationStyle.minimal,
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 20.h),
                    child: Row(
                      children: [
                        Container(
                          width: 25.w,
                          height: 25.w,
                          child: SvgPicture.asset(
                            "assets/images/copyIcon.svg",
                            fit: BoxFit.cover,
                            color: AppColors.blackBlueAccent1,
                          ),
                          margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                        ),
                        Text(
                          "Copier le lien".tr(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.blackBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    updateTrackingData(
                        "inviteLink.shareLink", "${DateTime.now()}", {});
                    Share.share(
                        "${"Je vous invite à rejoindre *${nomGroupe}* dans l'application ASSO+ pour nos cotisations et tontines.".tr()}\n${Variables.LienInvit}/subscribe?urlcode=${AppCubitStorage().state.codeAssDefaul}");
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 20.h),
                    child: Row(
                      children: [
                        Container(
                          width: 25.w,
                          height: 25.w,
                          child: SvgPicture.asset(
                            "assets/images/shareSimpleIcon.svg",
                            fit: BoxFit.cover,
                            color: AppColors.blackBlueAccent1,
                          ),
                          margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                        ),
                        Text(
                          "Partager le lien".tr(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.blackBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    updateTrackingData(
                        "inviteLink.qrCode", "${DateTime.now()}", {});
                    _showQrCode(context);
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20.w, 20.h, 15.w, 20.h),
                    child: Row(
                      children: [
                        Container(
                          width: 30.w,
                          height: 30.w,
                          child: SvgPicture.asset(
                            "assets/images/qrCodeIcon.svg",
                            fit: BoxFit.cover,
                            color: AppColors.blackBlueAccent1,
                          ),
                          margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                        ),
                        Text(
                          "QR code",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.blackBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CotisationHistoriqueWidget extends StatefulWidget {
  CotisationHistoriqueWidget({
    super.key,
    required this.rapportUrl,
    required this.codeCotisation,
    required this.lienDePaiement,
    required this.dateCotisation,
    required this.heureCotisation,
    required this.montantCotisations,
    required this.motifCotisations,
    required this.soldeCotisation,
    required this.type,
    required this.is_passed,
    required this.isPayed,
    required this.is_tontine,
    required this.source,
    required this.nomBeneficiaire,
    required this.rubrique,
  });
  var rapportUrl;
  var codeCotisation;
  var lienDePaiement;
  var dateCotisation;
  var heureCotisation;
  var montantCotisations;
  var motifCotisations;
  var soldeCotisation;
  var type;
  var is_passed;
  var isPayed;
  var is_tontine;
  var source;
  var nomBeneficiaire;
  var rubrique;

  @override
  State<CotisationHistoriqueWidget> createState() =>
      _CotisationHistoriqueWidgetState();
}

class _CotisationHistoriqueWidgetState
    extends State<CotisationHistoriqueWidget> {
  Future<void> handleDetailCotisation(codeSanction) async {
    // final detailTournoiCourant = await context
    //     .read<DetailTournoiCourantCubit>()
    //     .detailTournoiCourantCubit();
    final detailCotisation = await context
        .read<CotisationDetailCubit>()
        .detailCotisationCubit(codeSanction);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 5.h,
          width: 55.w,
          decoration: BoxDecoration(
              color: AppColors.blackBlue,
              borderRadius: BorderRadius.circular(50)),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
              child: Text(
                "Historique de la cotisation".tr(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  color: AppColors.blackBlueAccent1,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              color: AppColors.blackBlueAccent2,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          "Contributions ",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.blackBlue,
                          ),
                        ),
                      ),
                      BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
                        builder:
                            (detailCotisationContext, detailCotisationState) {
                          if (detailCotisationState.detailCotisation == null ||
                              detailCotisationState.isLoading == true)
                            return Container(
                              width: 10.w,
                              height: 10.w,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.green,
                                  strokeWidth: 0.3,
                                ),
                              ),
                            );

                          final okayTontine = detailCotisationContext
                              .read<CotisationDetailCubit>()
                              .state
                              .detailCotisation!["membres"]
                              .where((personne) => personne["is_payed"] == 1)
                              .length;
                          ;
                          final nonTontine = detailCotisationContext
                              .read<CotisationDetailCubit>()
                              .state
                              .detailCotisation!["membres"]
                              .where((personne) => personne["is_payed"] == 0)
                              .length;

                          return Container(
                            child: Text(
                              "(${okayTontine}/${nonTontine + okayTontine})",
                              style: TextStyle(
                                  fontSize: 10.sp, color: AppColors.blackBlue),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
                      builder:
                          (detailCotisationContext, detailCotisationState) {
                    if (detailCotisationState.detailCotisation == null ||
                        detailCotisationState.isLoading == true)
                      return Container(
                        padding: EdgeInsets.all(10.r),
                        width: 10.w,
                        height: 10.w,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.green,
                            strokeWidth: 0.3,
                          ),
                        ),
                      );
                    return GestureDetector(
                        onTap: () {
                          handleDetailCotisation(widget.codeCotisation);

                          Navigator.pop(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailCotisationPage(
                                rapportUrl: widget.rapportUrl,
                                codeCotisation: widget.codeCotisation,
                                lienDePaiement: widget.lienDePaiement,
                                dateCotisation: widget.dateCotisation,
                                heureCotisation: widget.heureCotisation,
                                montantCotisations: widget.montantCotisations,
                                motifCotisations: widget.motifCotisations,
                                soldeCotisation: widget.soldeCotisation,
                                type: widget.type,
                                isPassed: widget.is_passed,
                                isPayed: widget.isPayed,
                                is_passed: widget.is_passed,
                                is_tontine: widget.is_tontine,
                                source: widget.source,
                                nomBeneficiaire: widget.nomBeneficiaire,
                                rubrique: widget.rubrique,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.r),
                          child: Icon(
                            Icons.info_outline,
                            color: AppColors.blackBlue,
                            size: 18.sp,
                          ),
                        ));
                  }),
                ],
              ),
            ),
          ],
        ),
        BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
          builder: (CotisationDetailcontext, CotisationDetailstate) {
            if (CotisationDetailstate.isLoading == null ||
                CotisationDetailstate.isLoading == true ||
                CotisationDetailstate.detailCotisation == null)
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
              if (
                CotisationDetailstate.isLoading == true &&
                CotisationDetailstate.detailCotisation != null)
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

            final currentDetailCotisation =
                CotisationDetailcontext.read<CotisationDetailCubit>()
                    .state
                    .detailCotisation;

            List listeOkayCotisation = currentDetailCotisation!["membres"];

            List<Widget> listWidgetOkayCotis =
                listeOkayCotisation.map((monObjet) {
              return Card(
                margin: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  top: 5.h,
                  bottom: 5.h,
                ),
                child: widgetHistoriqueTontineCard(
                  date: formatDateLiteral(monObjet["updated_at"]),
                  imageProfil: monObjet["membre"]["photo_profil"] == null
                      ? ""
                      : monObjet["membre"]["photo_profil"],
                  is_versement_finished: monObjet["is_payed"],
                  montantVersee: monObjet["balance"],
                  nom: monObjet["membre"]["first_name"] == null
                      ? ""
                      : monObjet["membre"]["first_name"],
                  prenom: monObjet["membre"]["last_name"] == null
                      ? ""
                      : monObjet["membre"]["last_name"],
                  amount_remaining: monObjet["amount_remaining"],
                  memberCode: monObjet["membre"]["membre_code"],
                  codeContribution: widget.codeCotisation,
                  codeUserContribution: "",
                ),
              );
            }).toList();

            final listeFinale = [
              ...listWidgetOkayCotis,
              // Container(
              //   color: AppColors.blackBlue,
              //   height: 50,
              //   width: 20,
              //   margin: EdgeInsets.only(
              //       // bottom: Platform.isIOS ? 70.h : 10.h,
              //       ),
              // )
            ];

            return Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: listeFinale,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class TontineHistoriqueWidget extends StatefulWidget {
  TontineHistoriqueWidget({
    required this.codeContribution,
    super.key,
    this.codeTontine,
  });
  String codeContribution;
  String? codeTontine;

  @override
  State<TontineHistoriqueWidget> createState() =>
      _TontineHistoriqueWidgetState();
}

class _TontineHistoriqueWidgetState extends State<TontineHistoriqueWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 5.h,
          width: 55.w,
          decoration: BoxDecoration(
              color: AppColors.blackBlue,
              borderRadius: BorderRadius.circular(50)),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
              child: Text(
                "Historique de la tontine",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  color: AppColors.blackBlueAccent1,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              color: AppColors.blackBlueAccent2,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text(
                      "Contributions ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.blackBlue,
                      ),
                    ),
                  ),
                  BlocBuilder<DetailContributionCubit, ContributionState>(
                    builder:
                        (DetailContributionContext, DetailContributionState) {
                      if (DetailContributionState.isLoadingContibutionTontine ==
                              null ||
                          DetailContributionState.isLoadingContibutionTontine ==
                              true)
                        return Container(
                          width: 10.w,
                          height: 10.w,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.green,
                              strokeWidth: 0.3,
                            ),
                          ),
                        );

                      final okayTontine = DetailContributionContext.read<
                              DetailContributionCubit>()
                          .state
                          .detailContributionTontine!["membres"]
                          .where((personne) => personne["is_payed"] == 1)
                          .length;
                      final nonTontine = DetailContributionContext.read<
                              DetailContributionCubit>()
                          .state
                          .detailContributionTontine!["membres"]
                          .where((personne) => personne["is_payed"] == 0)
                          .length;

                      print(
                          "objectobjectobjectobjectobjectobject ${nonTontine}");
                      return Container(
                        child: Text(
                          "(${okayTontine}/${nonTontine + okayTontine})",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.blackBlue,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
        BlocBuilder<DetailContributionCubit, ContributionState>(
            builder: (DetailContributionContext, DetailContributionState) {
          if (DetailContributionState.isLoadingContibutionTontine == null ||
              DetailContributionState.isLoadingContibutionTontine == true)
            return Expanded(
              child: Center(
                child: Container(
                  child: EasyLoader(
                    backgroundColor: Color.fromARGB(0, 255, 255, 255),
                    iconSize: 50.r,
                    iconColor: AppColors.blackBlueAccent1,
                    image: AssetImage(
                      "assets/images/AssoplusFinal.png",
                    ),
                  ),
                ),
              ),
            );

          final okayTontine =
              DetailContributionContext.read<DetailContributionCubit>()
                  .state
                  .detailContributionTontine!["membres"];
          print("${okayTontine}");

          List listeOkayTontine = okayTontine;

          List<Widget> listWidgetOkayTontine = listeOkayTontine.map((monObjet) {
            return Card(
              margin: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
                top: 5.h,
                bottom: 5.h,
              ),
              child: widgetHistoriqueTontineCard(
                date: formatDateLiteral(monObjet["updated_at"]),
                imageProfil: monObjet["membre"]["photo_profil"] == null
                    ? ""
                    : monObjet["membre"]["photo_profil"],
                is_versement_finished: monObjet["is_payed"],
                montantVersee: monObjet["balance"],
                nom: monObjet["membre"]["first_name"] == null
                    ? ""
                    : monObjet["membre"]["first_name"],
                prenom: monObjet["membre"]["last_name"] == null
                    ? ""
                    : monObjet["membre"]["last_name"],
                amount_remaining: monObjet["amount_remaining"],
                memberCode: monObjet["membre"]["membre_code"],
                codeContribution: widget.codeContribution,
                codeUserContribution: monObjet["code"],
                codeTontine: widget.codeTontine,
              ),
            );
          }).toList();

          final listeFinale = [
            ...listWidgetOkayTontine,
            Container(
              margin: EdgeInsets.only(
                bottom: 10.h,
              ),
            )
          ];

          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: listeFinale,
              ),
            ),
          );
        })
      ],
    );
  }
}

_showQrCode(context) {
  showDialog(
      context: context,
      barrierColor: AppColors.barrierColorModal,
      builder: (BuildContext context) {
        final DetailAss = context.read<UserGroupCubit>().state.changeAssData;
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(20.0),
          // ),
          child: Container(
            height: 400.h,
            color: Colors.transparent,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Container(
                      height: 350.h,
                      // color: Color.fromARGB(167, 164, 14, 14),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 50.h, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 2.h),
                                    child: Text(
                                      "${DetailAss!.user_group!.name}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          color: AppColors.blackBlue,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20.h),
                                    child: Text(
                                      "Groupe ASSO+",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: AppColors.blackBlueAccent1,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                // padding: EdgeInsets.all(15.w),
                                decoration: BoxDecoration(
                                  color: AppColors.blackBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                height: 200.w,
                                width: 200.w,
                                child: QrImageView(
                                  data:
                                      "${Variables.LienInvit}/subscribe?urlcode=${AppCubitStorage().state.codeAssDefaul}",
                                  padding: EdgeInsets.all(15.h),
                                  embeddedImage: AssetImage(
                                    "assets/images/AssoLogoForQR.png",
                                  ),
                                  eyeStyle: const QrEyeStyle(
                                    eyeShape: QrEyeShape.square,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  dataModuleStyle: const QrDataModuleStyle(
                                    dataModuleShape: QrDataModuleShape.square,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  embeddedImageStyle: QrEmbeddedImageStyle(
                                    // color: Color(0xFFe7eaef),
                                    size: Size.square(50.r),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "Scanner pour integrer le groupe".tr(),
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackBlue),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.w,
                      padding: EdgeInsets.all(5.r),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(360.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: Container(
                          color: AppColors.blackBlue.withOpacity(0.1),
                          width: 50.w,
                          height: 50.w,
                          child: Image.network(
                            "${DetailAss!.user_group!.profile_photo} " == null
                                ? "https://services.faroty.com/images/avatar/avatar.png"
                                : "${Variables.LienAIP}${DetailAss!.user_group!.profile_photo}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Container(
                      //   color: AppColors.white,
                      //   child: Image.network(
                      //     "${Variables.LienAIP}${DetailAss!.user_group!.profile_photo}",
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

class widgetListPresenceCard extends StatelessWidget {
  widgetListPresenceCard({
    required this.nom,
    required this.prenom,
    required this.presence,
    required this.imageProfil,
    super.key,
  });
  String nom;

  String prenom;

  String presence;

  String imageProfil;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5.w,
            color: Color.fromARGB(34, 20, 45, 99),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Modal().showFullPicture(
                  context,
                  imageProfil == null
                      ? "https://services.faroty.com/images/avatar/avatar.png"
                      : "${Variables.LienAIP}${imageProfil}",
                  "${nom} ${prenom}");
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 25.w,
                height: 25.w,
                child: Image.network(
                  "${Variables.LienAIP}${imageProfil}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.w),
              child: Container(
                child: Text(
                  "${nom} ${prenom}",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackBlue,
                  ),
                ),
              ),
            ),
          ),
          presence == "0"
              ? Container(
                  padding: EdgeInsets.all(3.r),
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 14,
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(3.r),
                  child: Icon(
                    Icons.check,
                    color: AppColors.green,
                    size: 14,
                  ),
                ),
        ],
      ),
    );
  }
}

class WidgetPersonSanctionner extends StatelessWidget {
  WidgetPersonSanctionner({
    required this.photoProfil,
    required this.nom,
    required this.prenom,
    required this.outilSanction,
    required this.motif,
    super.key,
  });
  String photoProfil;
  String nom;
  String prenom;
  String outilSanction;
  String motif;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.all(5.r),
      child: Container(
        padding: EdgeInsets.only(
          top: 2.h,
          bottom: 5.h,
          left: 5.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.5.r,
              color: Color.fromARGB(88, 20, 45, 99),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 40.w,
                height: 40.w,
                child: Image.network(
                  '${Variables.LienAIP}${photoProfil}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                // color: Colors.blueGrey,
                // alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "${nom} ${prenom}",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackBlue,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3.h),
                      child: Text(
                        "${motif}",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackBlueAccent1,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3.h),
                      child: Row(
                        children: [
                          Text(
                            "${outilSanction}",
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(113, 244, 67, 54),
                            ),
                          ),
                        ],
                      ),
                    ),
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
