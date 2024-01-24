import 'dart:io';
import 'dart:math';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/presentation/widgets/widgetCotistion.dart';
import 'package:faroty_association_1/Association_And_Group/association_notifications/business_logic/notification_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/presentation/widgets/widgetSanction.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/presentation/widgets/widgetRencontreCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetTontineHistoriqueCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/screens/detailTontinePage.dart';
import 'package:faroty_association_1/pages/homePage.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/presentation/widgets/widgetCompteCard.dart';
import 'package:faroty_association_1/widget/widgetCallFunctionFailled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({super.key});

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreenState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
  required Widget widgetAction,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "historiques".tr(),
          style: TextStyle(fontSize: 16, color: AppColors.white),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
        trailing: widgetAction,
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.white,
    appBar: AppBar(
      title: Text(
        "historiques".tr(),
        style: TextStyle(fontSize: 16, color: AppColors.white),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: AppColors.white),
      ),
      actions: [widgetAction],
    ),
    body: child,
  );
}

class _HistoriqueScreenState extends State<HistoriqueScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _dataLoaded = false;

  Future<void> handleAllCotisationAssTournoi(codeTournoi) async {
    final allCotisationAss = await context
        .read<CotisationCubit>()
        .AllCotisationAssTournoiCubit(codeTournoi);

    if (allCotisationAss != null) {
      print("handleAllCotisationAss");
    } else {
      print("handleAllCotisationAss null");
    }
  }

  Future<void> handleAllCompteAss(codeAssociation) async {
    final allCotisationAss =
        await context.read<CompteCubit>().AllCompteAssCubit(codeAssociation);

    if (allCotisationAss != null) {
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllSeanceAss(codeAssociation) async {
    final allSeanceAss =
        await context.read<SeanceCubit>().AllAssSeanceCubit(codeAssociation);

    if (allSeanceAss != null) {
    } else {
      print("userGroupDefault null");
    }
  }

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

  Future<void> handleDetailTontine(codeTournoi, codeTontine) async {
    final detailTontine = await context
        .read<TontineCubit>()
        .detailTontineCubit(codeTournoi, codeTontine);

    if (detailTontine != null) {
    } else {
      print("userGroupDefault null");
    }
  }

  Future<void> handleAllUserGroup() async {
    final AllUserGroup = await context
        .read<UserGroupCubit>()
        .AllUserGroupOfUserCubit(AppCubitStorage().state.tokenUser);

    if (AllUserGroup != null) {
      print("1");
    } else {
      print("AllUserGroup null");
    }
  }

  Future handleChangeAss(codeAss) async {
    final allCotisationAss =
        await context.read<UserGroupCubit>().ChangeAssCubit(codeAss);
  }

  Future getNotifications() async {
    final getNotificationsVar = await context
        .read<NotificationCubit>()
        .getNotification(AppCubitStorage().state.tokenUser,
            AppCubitStorage().state.codeAssDefaul);

    print("cdddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcrrrr");
  }

  Future<void> handleDetailUser(userCode) async {
    final allCotisationAss =
        await context.read<AuthCubit>().detailAuthCubit(userCode);

    if (allCotisationAss != null) {
      print("handleDetailUser");
    } else {
      print("handleDetailUser null");
    }
  }

  Future refreshRencontre() async {
    handleTournoiDefault(AppCubitStorage().state.codeTournois);
  }

  Future refreshTontine() async {
    handleTournoiDefault(AppCubitStorage().state.codeTournois);
  }

  Future refreshCotisation() async {
    handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournois);
  }

  Future refreshSanction() async {
    handleDetailUser(AppCubitStorage().state.membreCode);
  }

  Future refreshCompte() async {
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    handleTournoiDefault(AppCubitStorage().state.codeTournois);
    // handleAllUserGroup();
    handleAllCotisationAssTournoi(AppCubitStorage().state.codeTournois);
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
    getNotifications();

    // handleAllSeanceAss(AppCubitStorage().state.codeAssDefaul);
    // handleChangeAss(AppCubitStorage().state.codeAssDefaul);

    _tabController = TabController(length: 0, vsync: this);
  }

  // List<Color> listeDeCouleurs = [
  //   Colors.red, // Rouge
  //   Colors.blue, // Bleu
  //   AppColors.green, // Vert
  //   Colors.brown, // Jaune
  //   Colors.purple, // Violet
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (Authcontext, Authstate) {
      if (Authstate.isLoading == true && Authstate.detailUser == null)
        return Container(
          child: EasyLoader(
            backgroundColor: Color.fromARGB(0, 255, 255, 255),
            iconSize: 50,
            iconColor: AppColors.blackBlueAccent1,
            image: AssetImage(
              'assets/images/Groupe_ou_Asso.png',
            ),
          ),
        );
      return BlocBuilder<UserGroupCubit, UserGroupState>(
        builder: (UserGroupContext, UserGroupState) {
          if (UserGroupState.isLoading == true ||
              UserGroupState.changeAssData == null)
            return Container(
              child: EasyLoader(
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                iconSize: 50,
                iconColor: AppColors.blackBlueAccent1,
                image: AssetImage(
                  'assets/images/Groupe_ou_Asso.png',
                ),
              ),
            );

          // if (UserGroupState.isLoading == false &&
          //     UserGroupState.ChangeAssData == {} &&
          //     UserGroupState.userGroup == [])
          //   return Container(
          //     color: AppColors.pageBackground,
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.height,
          //     child: callFunctionFailled(reFunction: () async {
          //       await UserGroupContext.read<UserGroupCubit>()
          //           .AllUserGroupOfUserCubit(
          //         AppCubitStorage().state.tokenUser,
          //       );

          //       await UserGroupContext.read<UserGroupCubit>().ChangeAssCubit(
          //         AppCubitStorage().state.codeAssDefaul,
          //       );
          //     }),
          //   );
          _tabController = TabController(
            length: UserGroupState.changeAssData!.user_group!.is_tontine ==
                        true ||
                    !checkTransparenceStatus(
                      context
                          .read<UserGroupCubit>()
                          .state
                          .changeAssData!
                          .user_group!
                          .configs,
                      context.read<AuthCubit>().state.detailUser!["isMember"],
                    )
                ? 5
                : 4,
            vsync: this,
          );

          return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                ),
                (route) => false,
              );
              return false;
            },
            child: Scaffold(
              backgroundColor: AppColors.pageBackground,
              appBar: AppBar(
                title: Text(
                  "historiques".tr(),
                  style: TextStyle(fontSize: 16, color: AppColors.white),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Modal().showBottomSheetListAss(
                        context,
                        context.read<UserGroupCubit>().state.userGroup,
                      );
                    },
                    child: Container(
                      child: Container(
                        margin: EdgeInsets.all(15),
                        width: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 255, 26, 9),
                          ),
                          borderRadius: BorderRadius.circular(360),
                        ),
                        padding: EdgeInsets.all(1),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360),
                            ),
                            child: Image.network(
                              "${Variables.LienAIP}${context.read<UserGroupCubit>().state.changeAssData!.user_group!.profile_photo == null ? "" : context.read<UserGroupCubit>().state.changeAssData!.user_group!.profile_photo}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                elevation: 0,
                backgroundColor: AppColors.backgroundAppBAr,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Icon(Icons.arrow_back, color: AppColors.white),
                ),
                bottom: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: AppColors.white,
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    padding: EdgeInsets.all(0),
                    unselectedLabelStyle: TextStyle(
                      color: AppColors.whiteAccent1,
                      fontWeight: FontWeight.bold,
                    ),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: AppColors.white,
                        width: 5.0,
                      ),
                      insets: EdgeInsets.symmetric(
                        horizontal: 36.0,
                      ),
                    ),
                    indicatorWeight: 0,
                    tabs: [
                      Tab(
                        text: "rencontres".tr(),
                      ),
                      if (UserGroupState
                              .changeAssData!.user_group!.is_tontine ==
                          true)
                        Tab(
                          text: "Tontines",
                        ),
                      Tab(
                        text: "cotisations".tr(),
                      ),
                      Tab(
                        text: "Sanctions",
                      ),
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
                              .detailUser!["isMember"]))
                        Tab(
                          text: "comptes".tr(),
                        ),
                    ]),
              ),
              body: Container(
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage("assets/images/BG.png"),
                //     fit: BoxFit.cover,
                //     opacity: 0.2
                //   ),
                // ),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 1.5,
                        left: 1.5,
                        right: 1.5,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.only(top: 10, left: 5, bottom: 15),
                            child: Text(
                              "toutes_les_rencontres".tr(),
                              style: TextStyle(
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          BlocBuilder<DetailTournoiCourantCubit,
                              DetailTournoiCourantState>(
                            builder:
                                (DetailTournoiContext, DetailTournoiState) {
                              if (DetailTournoiState.isLoading == true &&
                                  DetailTournoiState.detailtournoiCourant ==
                                      null)
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.bleuLight,
                                    ),
                                  ),
                                );
                              final currentDetailtournoiCourant = context
                                  .read<DetailTournoiCourantCubit>()
                                  .state
                                  .detailtournoiCourant;
                              return currentDetailtournoiCourant!["tournois"]
                                              ["seance"]!
                                          .length >
                                      0
                                  ? Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: RefreshIndicator(
                                              onRefresh: refreshRencontre,
                                              child: ListView.builder(
                                                padding: EdgeInsets.all(0),
                                                shrinkWrap: true,
                                                itemCount:
                                                    currentDetailtournoiCourant[
                                                                "tournois"]
                                                            ["seance"]
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  final itemSeance =
                                                      currentDetailtournoiCourant[
                                                              "tournois"]
                                                          ["seance"][index];

                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        left: 7,
                                                        right: 7,
                                                        top: 3,
                                                        bottom: 7),
                                                    child: WidgetRencontreCard(
                                                      maskElt: false,
                                                      codeSeance: itemSeance[
                                                          "seance_code"],
                                                      photoProfilRecepteur: "",
                                                      dateRencontre: AppCubitStorage()
                                                                  .state
                                                                  .Language ==
                                                              "fr"
                                                          ? formatDateToFrench(
                                                              itemSeance[
                                                                  "date_seance"])
                                                          : formatDateToEnglish(
                                                              itemSeance[
                                                                  "date_seance"]),
                                                      descriptionRencontre:
                                                          '${"La rencontre du".tr()} ${AppCubitStorage().state.Language == "fr" ? formatDateToFrench(itemSeance["date_seance"]) : formatDateToEnglish(itemSeance["date_seance"])} ${"se tiendra à".tr()} ${itemSeance["heure_debut"]}',
                                                      heureRencontre:
                                                          itemSeance[
                                                              "heure_debut"],
                                                      identifiantRencontre:
                                                          itemSeance[
                                                              "matricule"],
                                                      lieuRencontre: itemSeance[
                                                          "localisation"],
                                                      nomRecepteurRencontre:
                                                          itemSeance["membre"][
                                                                      "first_name"] ==
                                                                  null
                                                              ? ""
                                                              : itemSeance[
                                                                      "membre"][
                                                                  "first_name"],
                                                      isActiveRencontre:
                                                          itemSeance["status"],
                                                      prenomRecepteurRencontre:
                                                          itemSeance["membre"][
                                                                      "last_name"] ==
                                                                  null
                                                              ? ""
                                                              : itemSeance[
                                                                      "membre"]
                                                                  ["last_name"],
                                                      dateRencontreAPI:
                                                          itemSeance[
                                                              "date_seance"],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          if (DetailTournoiState.isLoading ==
                                                  true ||
                                              DetailTournoiState
                                                      .detailtournoiCourant ==
                                                  null)
                                            EasyLoader(
                                              backgroundColor: Color.fromARGB(
                                                  0, 255, 255, 255),
                                              iconSize: 50,
                                              iconColor:
                                                  AppColors.blackBlueAccent1,
                                              image: AssetImage(
                                                'assets/images/Groupe_ou_Asso.png',
                                              ),
                                            )
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: RefreshIndicator(
                                        onRefresh: refreshRencontre,
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                padding:
                                                    EdgeInsets.only(top: 200),
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  "aucune_rencontre".tr(),
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          20, 45, 99, 0.26),
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      fontSize: 20),
                                                ),
                                              );
                                            }),
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                    if (UserGroupState.changeAssData!.user_group!.is_tontine ==
                        true)
                      Container(
                        padding: EdgeInsets.only(
                          top: 1.5,
                          left: 1.5,
                          right: 1.5,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding:
                                  EdgeInsets.only(top: 10, left: 5, bottom: 15),
                              child: Text(
                                "Toutes vos tontines",
                                style: TextStyle(
                                    color: AppColors.blackBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 0.2),
                              ),
                            ),
                            BlocBuilder<DetailTournoiCourantCubit,
                                    DetailTournoiCourantState>(
                                builder:
                                    (DetailTournoiContext, DetailTournoiState) {
                              final currentDetailtournoiCourant = context
                                  .read<DetailTournoiCourantCubit>()
                                  .state
                                  .detailtournoiCourant;

                              List<dynamic> listeTontines =
                                  currentDetailtournoiCourant!["tontines"];

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
                              return tontinesMembreConnect.length > 0
                                  ? Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: RefreshIndicator(
                                              onRefresh: refreshTontine,
                                              child: ListView.builder(
                                                padding: EdgeInsets.all(0),
                                                shrinkWrap: true,
                                                itemCount: tontinesMembreConnect
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  print(tontinesMembreConnect);
                                                  final itemTontine =
                                                      tontinesMembreConnect[
                                                          index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      handleDetailTontine(
                                                          AppCubitStorage()
                                                              .state
                                                              .codeTournois,
                                                          itemTontine[
                                                              "tontine_code"]);

                                                      print(
                                                          "${itemTontine["tontine_code"]}");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailTontinePage(
                                                            isActive:
                                                                itemTontine[
                                                                    "is_active"],
                                                            dateCreaTontine:
                                                                itemTontine[
                                                                    "created_at"],
                                                            nomTontine:
                                                                "${itemTontine["libele"]}",
                                                            montantTontine:
                                                                "${itemTontine["amount"]}",
                                                            positionBeneficiaire:
                                                                "${itemTontine["membres"].where((objet) => objet["is_passed"] == 1).length}",
                                                            nbrMembreTontine:
                                                                "${itemTontine["membres"].length}",
                                                            listMembre:
                                                                itemTontine[
                                                                    "membres"],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 7,
                                                          right: 7,
                                                          top: 3,
                                                          bottom: 7),
                                                      child:
                                                          widgetTontineHistoriqueCard(
                                                        isActive: itemTontine[
                                                            "is_active"],
                                                        dateCreaTontine:
                                                            itemTontine[
                                                                "created_at"],
                                                        nomTontine:
                                                            "${itemTontine["libele"]}",
                                                        montantTontine:
                                                            "${itemTontine["amount"]}",
                                                        positionBeneficiaire:
                                                            "0",
                                                        nbrMembreTontine:
                                                            "${itemTontine["membres"].length}",
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          if (DetailTournoiState.isLoading ==
                                                  true ||
                                              DetailTournoiState
                                                      .detailtournoiCourant ==
                                                  null)
                                            EasyLoader(
                                              backgroundColor: Color.fromARGB(
                                                  0, 255, 255, 255),
                                              iconSize: 50,
                                              iconColor:
                                                  AppColors.blackBlueAccent1,
                                              image: AssetImage(
                                                'assets/images/Groupe_ou_Asso.png',
                                              ),
                                            )
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: RefreshIndicator(
                                          onRefresh: refreshTontine,
                                          child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                padding:
                                                    EdgeInsets.only(top: 200),
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  "Aucune tontine",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          20, 45, 99, 0.26),
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      fontSize: 20),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                            }),
                          ],
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 1.5,
                        left: 1.5,
                        right: 1.5,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.only(top: 10, left: 5, bottom: 15),
                            child: Text(
                              "toutes_vos_cotisations".tr(),
                              style: TextStyle(
                                  color: AppColors.blackBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 0.2),
                            ),
                          ),
                          // if (currentAllCotisationAssTournoi != null)
                          BlocBuilder<CotisationCubit, CotisationState>(
                            builder: (CotisationContext, CotisationState) {
                              if (CotisationState.isLoading == true &&
                                  CotisationState.allCotisationAss == null)
                                return Container(
                                  child: EasyLoader(
                                    backgroundColor:
                                        Color.fromARGB(0, 255, 255, 255),
                                    iconSize: 50,
                                    iconColor: AppColors.blackBlueAccent1,
                                    image: AssetImage(
                                      'assets/images/Groupe_ou_Asso.png',
                                    ),
                                  ),
                                );
                              final currentAllCotisationAssTournoi = context
                                  .read<CotisationCubit>()
                                  .state
                                  .allCotisationAss;

                              List<dynamic> objetCotisationUniquement =
                                  currentAllCotisationAssTournoi!
                                      .where(
                                          (objet) => objet["is_tontine"] == 0)
                                      .toList();

                              return objetCotisationUniquement.length > 0
                                  ? Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: RefreshIndicator(
                                              onRefresh: refreshCotisation,
                                              child: ListView.builder(
                                                itemCount:
                                                    objetCotisationUniquement
                                                        .length,
                                                // physics: NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.all(0),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final ItemDetailCotisation =
                                                      objetCotisationUniquement[
                                                          index];
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        left: 7,
                                                        right: 7,
                                                        top: 3,
                                                        bottom: 7),
                                                    child: WidgetCotisation(
                                                      rubrique: ItemDetailCotisation[
                                                                  "ass_rubrique"] ==
                                                              null
                                                          ? ""
                                                          : ItemDetailCotisation[
                                                                  "ass_rubrique"]
                                                              ["name"],
                                                      montantCotisations:
                                                          ItemDetailCotisation[
                                                              "amount"],
                                                      motifCotisations:
                                                          ItemDetailCotisation[
                                                              "name"],
                                                      dateCotisation:
                                                          ItemDetailCotisation[
                                                              "start_date"],
                                                      heureCotisation: AppCubitStorage()
                                                                  .state
                                                                  .Language ==
                                                              "fr"
                                                          ? formatTimeToFrench(
                                                              ItemDetailCotisation[
                                                                  "start_date"])
                                                          : formatTimeToEnglish(
                                                              ItemDetailCotisation[
                                                                  "start_date"]),
                                                      soldeCotisation:
                                                          ItemDetailCotisation[
                                                              "cotisation_balance"],
                                                      codeCotisation:
                                                          ItemDetailCotisation[
                                                              "cotisation_code"],
                                                      type:
                                                          ItemDetailCotisation[
                                                              "type"],
                                                      lienDePaiement: ItemDetailCotisation[
                                                                  "cotisation_pay_link"] ==
                                                              null
                                                          ? "le lien n'a pas été généré"
                                                          : ItemDetailCotisation[
                                                              "cotisation_pay_link"],
                                                      is_passed:
                                                          ItemDetailCotisation[
                                                              "is_passed"],
                                                      is_tontine:
                                                          ItemDetailCotisation[
                                                              "is_tontine"],
                                                      source: ItemDetailCotisation[
                                                                  "seance"] ==
                                                              null
                                                          ? ''
                                                          : '(${'rencontre'.tr()} ${ItemDetailCotisation["seance"]["matricule"]})',
                                                      nomBeneficiaire:
                                                          ItemDetailCotisation[
                                                                      "membre"] ==
                                                                  null
                                                              ? ''
                                                              : '(${ItemDetailCotisation["membre"]["last_name"] == null ? "${ItemDetailCotisation["membre"]["first_name"]}" : "${ItemDetailCotisation["membre"]["first_name"]} ${ItemDetailCotisation["membre"]["last_name"]}"})',
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          if (CotisationState.isLoading ==
                                                  true ||
                                              CotisationState
                                                      .allCotisationAss ==
                                                  null)
                                            EasyLoader(
                                              backgroundColor: Color.fromARGB(
                                                  0, 255, 255, 255),
                                              iconSize: 50,
                                              iconColor:
                                                  AppColors.blackBlueAccent1,
                                              image: AssetImage(
                                                'assets/images/Groupe_ou_Asso.png',
                                              ),
                                            )
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: RefreshIndicator(
                                        onRefresh: refreshCotisation,
                                        child: ListView.builder(
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                padding:
                                                    EdgeInsets.only(top: 200),
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  "aucune_cotisation".tr(),
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          20, 45, 99, 0.26),
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      fontSize: 20),
                                                ),
                                              );
                                            }),
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 1.5, left: 1.5, right: 1.5),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.only(top: 10, left: 5, bottom: 15),
                            child: Text(
                              "toutes_vos_sanctions".tr(),
                              style: TextStyle(
                                  color: AppColors.blackBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 0.2),
                            ),
                          ),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (AuthContext, AuthState) {
                              final currentDetailUser =
                                  context.read<AuthCubit>().state.detailUser;

                              return currentDetailUser!["sanctions"].length > 0
                                  ? Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: RefreshIndicator(
                                              onRefresh: refreshSanction,
                                              child: ListView.builder(
                                                itemCount: currentDetailUser[
                                                        "sanctions"]
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final currentSaction =
                                                      currentDetailUser![
                                                          "sanctions"][index];
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        left: 7,
                                                        right: 7,
                                                        top: 3,
                                                        bottom: 7),
                                                    child: WidgetSanction(
                                                      objetSanction:
                                                          currentSaction[
                                                                      "libelle"] ==
                                                                  null
                                                              ? " "
                                                              : currentSaction[
                                                                  "libelle"],
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
                                                          currentSaction[
                                                              "start_date"],
                                                      motifSanction:
                                                          currentSaction[
                                                              "motif"],
                                                      montantSanction:
                                                          currentSaction[
                                                                  "amount"]
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
                                                      versement: currentSaction[
                                                          "versement"],
                                                      isSanctionPayed:
                                                          currentSaction[
                                                              "is_sanction_payed"],
                                                      typeSaction:
                                                          currentSaction[
                                                              "type"],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          if (AuthState.isLoading == true ||
                                              AuthState.detailUser == null)
                                            EasyLoader(
                                              backgroundColor: Color.fromARGB(
                                                  0, 255, 255, 255),
                                              iconSize: 50,
                                              iconColor:
                                                  AppColors.blackBlueAccent1,
                                              image: AssetImage(
                                                'assets/images/Groupe_ou_Asso.png',
                                              ),
                                            )
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: RefreshIndicator(
                                        onRefresh: refreshSanction,
                                        child: ListView.builder(
                                          itemCount: 1,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              padding:
                                                  EdgeInsets.only(top: 200),
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                "aucune_sanction".tr(),
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        20, 45, 99, 0.26),
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 20),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
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
                            .detailUser!["isMember"]))
                      Container(
                        padding:
                            EdgeInsets.only(top: 1.5, left: 1.5, right: 1.5),
                        width: MediaQuery.of(context).size.width,
                        // decoration:
                        // BoxDecoration(color: Color.fromARGB(255, 240, 35, 35),),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding:
                                  EdgeInsets.only(top: 10, left: 5, bottom: 15),
                              child: Text(
                                "les_comptes_de_l'association".tr(),
                                style: TextStyle(
                                    color: AppColors.blackBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 0.2),
                              ),
                            ),
                            BlocBuilder<CompteCubit, CompteState>(
                                builder: (CompteContext, CompteState) {
                              final currentCompteAss = context
                                  .read<CompteCubit>()
                                  .state
                                  .allCompteAss;

                              List<String> listeDeCouleurs = [
                                "#F44336", // Rouge
                                "#F44336", // Rouge
                                "#2196F3", // Bleu
                                "#96BF35", // Vert
                                "#795548", // Jaune
                                "#9C27B0", // Violet
                              ];
                              int i = 0;

                              List<Widget> listWidgetSanction =
                                  currentCompteAss!.map((item) {
                                i++;
                                return WidgetCompteCard(
                                  montantCompte:
                                      "${int.parse(item.balance!) + int.parse(item.faroti_balance!)}",
                                  nomCompte: item.name!,
                                  numeroCompte: item.public_ref!,
                                  couleur: listeDeCouleurs[i],
                                );
                              }).toList();

                              return Expanded(
                                child: Stack(
                                  children: [
                                    RefreshIndicator(
                                      onRefresh: refreshCompte,
                                      child: SingleChildScrollView(
                                        child: Container(
                                          child: Wrap(
                                            alignment:
                                                WrapAlignment.spaceBetween,
                                            children: listWidgetSanction,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (CompteState.isLoading == true)
                                      EasyLoader(
                                        backgroundColor:
                                            Color.fromARGB(0, 255, 255, 255),
                                        iconSize: 50,
                                        iconColor: AppColors.blackBlueAccent1,
                                        image: AssetImage(
                                          'assets/images/Groupe_ou_Asso.png',
                                        ),
                                      )
                                  ],
                                ),
                              );
                            }),
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
    });
  }
}
