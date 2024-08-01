import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotistion.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanction.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetDetailRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetDetailTontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/pages/checkInternetConnectionPage.dart';
import 'package:faroty_association_1/pages/rapport_view_screen.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:faroty_association_1/widget/button_rapport_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class detailRencontrePage extends StatefulWidget {
  detailRencontrePage({
    super.key,
    required this.nomRecepteurRencontre,
    required this.identifiantRencontre,
    required this.isActiveRencontre,
    required this.descriptionRencontre,
    required this.lieuRencontre,
    required this.dateRencontre,
    required this.heureRencontre,
    required this.prenomRecepteurRencontre,
    required this.photoProfilRecepteur,
    required this.codeSeance,
    required this.dateRencontreAPI,
    required this.rapportUrl,
    required this.codeTournoi,
  });

  String nomRecepteurRencontre;
  String identifiantRencontre;
  int isActiveRencontre;
  String descriptionRencontre;
  String lieuRencontre;
  String dateRencontre;
  String heureRencontre;
  String prenomRecepteurRencontre;
  String photoProfilRecepteur;
  String codeSeance;
  String dateRencontreAPI;
  String? rapportUrl;
  String codeTournoi;
  @override
  State<detailRencontrePage> createState() => _detailRencontrePageState();
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
          "detail_de_la_rencontre".tr(),
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
        "detail_de_la_rencontre".tr(),
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

class _detailRencontrePageState extends State<detailRencontrePage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  // with WidgetsBindingObserver
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<SeanceCubit>().detailSeanceCubit(widget.codeSeance);
      print("RETOUR");
    }
  }

  int _pageIndex = 0;
  var Tab = [true, false, false, true, "end", "end"];

  Future<void> handleDefaultSeance(codeSeance) async {
    final detailSeance =
        await context.read<SeanceCubit>().detailSeanceCubit(codeSeance);
  }

  Future<void> handleDetailContributionTontine(codeContribution) async {
    final detailCotisation = await context
        .read<DetailContributionCubit>()
        .detailContributionTontineCubit(codeContribution);
  }

  Future refresh() async {
    handleDefaultSeance(widget.codeSeance);
  }

  @override
  Widget build(BuildContext context) {
    final currentAssCourant =
        context.read<UserGroupCubit>().state.changeAssData;
    final TabController _tabController = TabController(
        length: currentAssCourant!.user_group!.is_tontine == true ? 3 : 2,
        vsync: this);
    return Material(
      type: MaterialType.transparency,
      child: PageScaffold(
        context: context,
        child: BlocBuilder<SeanceCubit, SeanceState>(
            builder: (detSeancecontext, detSeancestate) {
          if (detSeancestate.errorLoadDetailSeance == true)
            return checkInternetConnectionPage(
              functionToCall: () => handleDefaultSeance(widget.codeSeance),
            );
          return Container(
            margin: EdgeInsets.only(top: 0, left: 5.w, right: 5.w),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: widgetDetailRencontreCard(
                    codeSeance: widget.codeSeance,
                    nbrPresence: ("000"),
                    dateRencontre: widget.dateRencontre,
                    descriptionRencontre: widget.descriptionRencontre,
                    heureRencontre: widget.heureRencontre,
                    identifiantRencontre: widget.identifiantRencontre,
                    isActiveRencontre: widget.isActiveRencontre,
                    lieuRencontre: widget.lieuRencontre,
                    nomRecepteurRencontre: widget.nomRecepteurRencontre,
                    prenomRecepteurRencontre: widget.prenomRecepteurRencontre,
                    dateRencontreAPI: widget.dateRencontreAPI,
                    rapportUrl: widget.rapportUrl,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  color: Color.fromARGB(120, 226, 226, 226),
                  alignment: Alignment.center,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: AppColors.blackBlue,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                    ),
                    padding: EdgeInsets.all(0),
                    unselectedLabelStyle: TextStyle(
                      color: AppColors.blackBlueAccent1,
                      fontWeight: FontWeight.bold,
                    ),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: AppColors.blackBlue,
                        width: 5.0.r,
                      ),
                      insets: EdgeInsets.symmetric(
                        horizontal: 36.0.w,
                      ),
                    ),
                    tabs: [
                      if (currentAssCourant.user_group!.is_tontine == true)
                        Container(
                          margin: EdgeInsets.only(bottom: 5.h),
                          child: Text("Tontines"),
                        ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5.h),
                        child: Text("cotisations".tr()),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5.h),
                        child: Text("Sanctions"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<SeanceCubit, SeanceState>(
                      builder: (detailSeancecontext, detailSeancestate) {
                    if (detailSeancestate.detailSeance == null &&
                        detailSeancestate.isLoading == true)
                      return Center(
                        child: EasyLoader(
                          backgroundColor: Color.fromARGB(173, 255, 255, 255),
                          iconSize: 50.r,
                          iconColor: AppColors.blackBlueAccent1,
                          image: AssetImage(
                            "assets/images/AssoplusFinal.png",
                          ),
                        ),
                      );
                    final currentDetailSeance =
                        context.read<SeanceCubit>().state.detailSeance!;

                    List<dynamic> objetCotisationUniquement =
                        currentDetailSeance!["cotisation"]
                            .where((objet) => objet["is_tontine"] == 0)
                            .toList();

                    List<dynamic> allSanctionUserConnect;

                    // List<dynamic> allSanctionUserConnect =
                    //     currentDetailSeance["sanctions"]
                    //         .where((sanctions) =>
                    //             sanctions["membre"]["membre_code"] ==
                    //             AppCubitStorage().state.membreCode)
                    //         .toList();
                    if (context
                        .read<AuthCubit>()
                        .state
                        .detailUser!["isMember"]) {
                      allSanctionUserConnect = currentDetailSeance["sanctions"]
                          .where((sanctions) =>
                              sanctions["membre"]["membre_code"] ==
                              AppCubitStorage().state.membreCode)
                          .toList();
                    } else {
                      allSanctionUserConnect = currentDetailSeance["sanctions"]
                          // .where((sanctions) =>
                          //     sanctions["membre"]["membre_code"] ==
                          //     AppCubitStorage().state.membreCode)
                          .toList();
                    }

                    // context
                    //                 .read<AuthCubit>()
                    //                 .state
                    //                 .detailUser!["isMember"]

                    return TabBarView(
                      controller: _tabController,
                      children: [
                        if (currentAssCourant.user_group!.is_tontine == true)
                          currentDetailSeance["contributions"].length > 0
                              ? RefreshIndicator(
                                  onRefresh: refresh,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          bottom: 10.h,
                                        ),
                                        child: ListView.builder(
                                          itemCount: currentDetailSeance[
                                                  "contributions"]
                                              .length,
                                          padding: EdgeInsets.all(0),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final ItemDetailCotisation =
                                                currentDetailSeance[
                                                    "contributions"][index];
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
                                                            .detailUser![
                                                        "isMember"])) {
                                                  handleDetailContributionTontine(
                                                    ItemDetailCotisation[
                                                        "code"],
                                                  );

                                                  Modal()
                                                      .showBottomSheetHistTontine(
                                                          context,
                                                          ItemDetailCotisation[
                                                              "code"],  ItemDetailCotisation[
                                                          "amount"]);
                                                }
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  left: 7.w,
                                                  right: 7.w,
                                                  top: 3.h,
                                                  bottom: 7.h,
                                                ),
                                                child: widgetDetailTontine(
                                                  isPayed: ItemDetailCotisation[
                                                      "is_payed"],
                                                      isPassed: ItemDetailCotisation[
                                                      "is_passed"],
                                                  nomBeneficiaire:
                                                      ItemDetailCotisation[
                                                                      "membre"][
                                                                  "first_name"] ==
                                                              null
                                                          ? ""
                                                          : ItemDetailCotisation[
                                                                  "membre"]
                                                              ["first_name"],
                                                  prenomBeneficiaire:
                                                      ItemDetailCotisation[
                                                                      "membre"][
                                                                  "last_name"] ==
                                                              null
                                                          ? ""
                                                          : ItemDetailCotisation[
                                                                  "membre"]
                                                              ["last_name"],
                                                  dateOpen: AppCubitStorage()
                                                              .state
                                                              .Language ==
                                                          "fr"
                                                      ? formatDateToFrench(
                                                          ItemDetailCotisation[
                                                              "start_date"])
                                                      : formatDateToEnglish(
                                                          ItemDetailCotisation[
                                                              "start_date"]),
                                                  dateClose:
                                                      ItemDetailCotisation[
                                                          "end_date"],
                                                  // ItemDetailCotisation["end_date"],
                                                  montantTontine:
                                                      ItemDetailCotisation[
                                                          "amount"],
                                                  montantCollecte:
                                                      ItemDetailCotisation[
                                                          "total_cotise"],
                                                  codeCotisation:
                                                      ItemDetailCotisation[
                                                          "code"],
                                                  lienDePaiement:
                                                      ItemDetailCotisation[
                                                          "tontine_pay_link"],
                                                  nomTontine:
                                                      ItemDetailCotisation[
                                                          "matricule"],
                                                          motif: ItemDetailCotisation["motif"],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      if (detailSeancestate.detailSeance !=
                                              null &&
                                          detailSeancestate.isLoading == true)
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
                                  ),
                                )
                              : RefreshIndicator(
                                  onRefresh: refresh,
                                  child: ListView.builder(
                                    itemCount: 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6),
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "Aucune Tontine".tr(),
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  20, 45, 99, 0.26),
                                              fontWeight: FontWeight.w100,
                                              fontSize: 20.sp),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        objetCotisationUniquement.length > 0
                            ? RefreshIndicator(
                                onRefresh: refresh,
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        bottom: 10.h,
                                      ),
                                      child: ListView.builder(
                                        itemCount:
                                            objetCotisationUniquement.length,
                                        padding: EdgeInsets.all(0),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final ItemDetailCotisation =
                                              objetCotisationUniquement[index];
                                          return Container(
                                            margin: EdgeInsets.only(
                                              left: 7.w,
                                              right: 7.w,
                                              top: 3.h,
                                              bottom: 7.h,
                                            ),
                                            child: WidgetCotisation(
                                              rapportUrl: ItemDetailCotisation[
                                                  "rapport"],
                                              screenSource: "meeting",
                                              isPayed: ItemDetailCotisation[
                                                  "is_payed"],
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
                                                  : '${'rencontre'.tr()} ${ItemDetailCotisation["seance"]["matricule"]} ${"du".tr()} ${formatDateTimeintegral(context.locale.toString() == "en_US" ? "en" : "fr",ItemDetailCotisation["seance"]["date_seance"] )  }',
                                              nomBeneficiaire: ItemDetailCotisation[
                                                          "membre"] ==
                                                      null
                                                  ? ''
                                                  : ItemDetailCotisation[
                                                                  "membre"]
                                                              ["last_name"] ==
                                                          null
                                                      ? "${ItemDetailCotisation["membre"]["first_name"]}"
                                                      : "${ItemDetailCotisation["membre"]["first_name"]} ${ItemDetailCotisation["membre"]["last_name"]}",
                                              rubrique: ItemDetailCotisation[
                                                          "ass_rubrique"] ==
                                                      null
                                                  ? ""
                                                  : ItemDetailCotisation[
                                                      "ass_rubrique"]["name"],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    if (detailSeancestate.detailSeance !=
                                            null &&
                                        detailSeancestate.isLoading == true)
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
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: refresh,
                                child: ListView.builder(
                                    itemCount: 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6),
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "aucune_cotisation".tr(),
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                20, 45, 99, 0.26),
                                            fontWeight: FontWeight.w100,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                        allSanctionUserConnect.length > 0
                            ? Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      bottom: 10.h,
                                    ),
                                    child: ListView.builder(
                                      itemCount: allSanctionUserConnect.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final currentSaction =
                                            allSanctionUserConnect[index];
                                        print(context
                                            .read<AuthCubit>()
                                            .state
                                            .detailUser!["isMember"]);
                                        return Container(
                                          margin: EdgeInsets.only(
                                            left: 7.w,
                                            right: 7.w,
                                            top: 3.h,
                                            bottom: 7.h,
                                          ),
                                          child: WidgetSanction(
                                            codeTournoi: widget.codeTournoi,
                                            sanction_code:
                                                currentSaction["sanction_code"],
                                            membreCode: "",
                                            isAdmin: !context
                                                .read<AuthCubit>()
                                                .state
                                                .detailUser!["isMember"],
                                            nomProprietaire:
                                                "${currentSaction["membre"]["first_name"]} ${currentSaction["membre"]["last_name"] ?? ""}",
                                            screenSource: "meeting.sanction",
                                            objetSanction:
                                                currentSaction["libelle"] ==
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
                                            typeSaction: currentSaction["type"],
                                            resteAPayer: currentSaction[
                                                "amount_remaining"],
                                            dejaPayer: currentSaction[
                                                "sanction_balance"],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  if (detailSeancestate.detailSeance != null &&
                                      detailSeancestate.isLoading == true)
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
                            : RefreshIndicator(
                                onRefresh: refresh,
                                child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6),
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        "aucune_sanction".tr(),
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                20, 45, 99, 0.26),
                                            fontWeight: FontWeight.w100,
                                            fontSize: 20.sp),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
