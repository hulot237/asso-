import 'dart:io';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotistion.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotistionDetailPage.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetDetailCotisationCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetHistoriqueCotisation.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widget_collecte_detail_externe.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/screens/detailRencontrePage.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/checkInternetConnectionPage.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:faroty_association_1/widget/button_rapport_widget.dart';
import 'package:faroty_association_1/widget/widgetListTransactionByEventCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailCollectePage extends StatefulWidget {
  var is_tontine;

  var source;

  var nomBeneficiaire;

  var rubrique;

  DetailCollectePage({
    super.key,
    required this.montantCotisations,
    required this.motifCotisations,
    required this.dateCotisation,
    required this.heureCotisation,
    required this.soldeCotisation,
    required this.isPassed,
    required this.type,
    required this.lienDePaiement,
    required this.codeCotisation,
    required this.isPayed,
    required this.rapportUrl,
    required this.is_passed,
    required this.is_tontine,
    required this.source,
    required this.nomBeneficiaire,
    required this.rubrique,
    required this.description,
    required this.photoCol,
  });
  int montantCotisations;
  String motifCotisations;
  String dateCotisation;
  String heureCotisation;
  String soldeCotisation;
  String type;
  String lienDePaiement;
  int isPassed;
  String codeCotisation;
  int isPayed;
  String? rapportUrl;
  var is_passed;
  String description;
  String photoCol;

  @override
  State<DetailCollectePage> createState() => _DetailCollectePageState();
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
          "détail de la collecte".tr(),
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.white,
              fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
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
        "détail de la collecte".tr(),
        style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.bold),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: InkWell(
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

class _DetailCollectePageState extends State<DetailCollectePage>
    with TickerProviderStateMixin {
  int _pageIndex = 0;
  var Tab = [true, false, false, true, false, true];

  Future<void> handleParticipantCollecte(codeCollecte) async {
    await context
        .read<CotisationDetailCubit>()
        .getParticipantCollecte(codeCollecte);
  }

  Future refresh() async {
    handleParticipantCollecte(widget.codeCotisation);
  }

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);

    return PageScaffold(
      context: context,
      child: Material(
        type: MaterialType.transparency,
        child: BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
            builder: (CotiDetailcontext, CotiDetailstate) {
          // if (CotiDetailstate.errorLoadDetailCotis == true)
          //   return checkInternetConnectionPage(
          //     functionToCall: () =>
          //         handleDetailCotisation(widget.codeCotisation),
          //   );
          return Container(
            margin: EdgeInsets.only(top: 0, left: 10.w, right: 10.w),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: WidgetCollecteDetailExterne(
                    screenSource: "meeting",
                    isPayed: widget.isPayed,
                    montantCotisations: widget.montantCotisations,
                    motifCotisations: widget.motifCotisations,
                    dateCotisation: widget.dateCotisation,
                    heureCotisation: widget.heureCotisation,
                    soldeCotisation: widget.soldeCotisation,
                    codeCotisation: widget.codeCotisation,
                    type: widget.type,
                    lienDePaiement: widget.lienDePaiement,
                    is_passed: widget.isPassed,
                    is_tontine: widget.is_tontine,
                    rubrique: widget.rubrique,
                    description: widget.description,
                    photoCol: widget.photoCol,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                  child: Text(
                    "historique_des_cotisations".tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackBlue,
                    ),
                  ),
                ),
                BlocBuilder<CotisationDetailCubit, CotisationDetailState>(
                  builder: (CotisationDetailcontext, CotisationDetailstate) {
                    if (CotisationDetailstate.isLoading == true &&
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

                    final currentParticipant =
                        CotisationDetailcontext.read<CotisationDetailCubit>()
                            .state
                            .participants;

                    return Expanded(
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount: currentParticipant!.length,
                            padding: EdgeInsets.only(bottom: 50.h),
                            itemBuilder: (context, index) {
                              final participant = currentParticipant[index];
                              return Container(
                                width: double.infinity,
                                color: AppColors.white,
                                padding: EdgeInsets.only(
                                  top: 5.h,
                                  bottom: 5.h,
                                  left: 10.w,
                                  right: 10.w,
                                ),
                                margin: EdgeInsets.only(
                                  bottom: 10.h,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 5.h),
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.9,
                                          ),
                                          child: Text(
                                            participant.name ?? "Anonyme",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.blackBlue,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Container(
                                          child: Text(
                                            "${formatMontantFrancais(double.parse("${participant.amount}"))} FCFA / ${widget.type == "1" ? "volontaire".tr() : "${formatMontantFrancais(double.parse("${500}"))} FCFA"}",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                          child: Text(
                                            "${formatDateTimeintegral(context.locale.toString() == "en_US" ? "en" : "fr", participant.updatedAt!)} ${"à".tr()} ${formatHeurUnikLiteral(participant.updatedAt!)}",
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.blackBlueAccent1,
                                            ),
                                          ),
                                        ),
                                    
                                  ],
                                ),
                              );
                            },
                          ),
                          if (CotisationDetailstate.isLoading == true &&
                              CotisationDetailstate.detailCotisation != null)
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
                            ),
                        ],
                      ),
                    );
                  
                  
                  
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
