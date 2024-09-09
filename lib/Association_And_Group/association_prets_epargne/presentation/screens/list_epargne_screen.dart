import 'dart:convert';
import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/business_logic/prets_epargne_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/data/prets_epargne_repository.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/add_asso_element_button_widget.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListEpargneScreen extends StatefulWidget {
  const ListEpargneScreen({Key? key}) : super(key: key);

  @override
  _ListEpargneScreenState createState() => _ListEpargneScreenState();
}

class _ListEpargneScreenState extends State<ListEpargneScreen> {
  Future<void> handleAllEpargne(codeTournoisHist) async {
    final allCotisationAss = await context
        .read<PretEpargneCubit>()
        .getAllAssEpargnes(codeTournoisHist);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleAllEpargne(AppCubitStorage().state.codeTournoisHist);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          centerTitle: false,
          // toolbarHeight: 130.h,
          title: Text(
            'Liste des epargnes'.tr(),
            // "historiques".tr(),
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.white,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: AppColors.backgroundAppBAr,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackButtonWidget(
              colorIcon: AppColors.white,
            ),
          ),
      
      
          actions: [
            BlocBuilder<PretEpargneCubit, PretEpargneState>(
          builder: (PretEpargneContext, PretEpargneState) {
              final currentInfoAllTournoiAssCourant =
                  PretEpargneContext.read<UserGroupCubit>()
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
                              if (item.is_active == 0)
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
                      onTap: () async {
                        print(" before ${item.tournois_code}");
                        await AppCubitStorage()
                            .updateCodeTournoisHist(item.tournois_code!);
                        print(
                            " after ${AppCubitStorage().state.codeTournoisHist}");
                      
                        // await handleTournoiDefault(
                        //     AppCubitStorage()
                        //         .state
                        //         .codeTournoisHist);
                        handleAllEpargne(AppCubitStorage().state.codeTournoisHist);
                        // handleAllCotisationAssTournoi(
                        //     AppCubitStorage()
                        //         .state
                        //         .codeTournoisHist,
                        //     AppCubitStorage()
                        //         .state
                        //         .membreCode);
                        // context
                        //     .read<
                        //         SanctionCubit>()
                        //     .getAllSanctions(
                        //         AppCubitStorage()
                        //             .state
                        //             .codeTournoisHist);
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
                                color: item.is_active == 1
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
                                item.is_active == 1
                                    ? 'Actif'.tr()
                                    : "Inactif",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: item.is_active == 1
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
            })
          ],
       
        ),
        body: BlocBuilder<PretEpargneCubit, PretEpargneState>(
          builder: (PretEpargneContext, PretEpargneState) {
            if (PretEpargneState.isLoadingAllAssEpargne == true &&
                PretEpargneState.allAssEpargne == null)
              return Container(
                padding: EdgeInsets.only(top: 15.h),
                child: EasyLoader(
                  backgroundColor: Color.fromARGB(0, 255, 255, 255),
                  iconSize: 50.r,
                  iconColor: AppColors.blackBlueAccent1,
                  image: AssetImage(
                    'assets/images/AssoplusFinal.png',
                  ),
                ),
              );
            final currentAllEpargne = context
                .read<PretEpargneCubit>()
                .state
                .allAssEpargne!["membre_savings"];
            return currentAllEpargne!.length > 0
                ? Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          padding: EdgeInsets.only(
                            top: 20.h,
                            right: 8.w,
                            left: 8.w,
                            bottom: 70.h,
                          ),
                          itemCount: currentAllEpargne.length,
                          itemBuilder: (BuildContext context, int index) {
                            final currentEpargne = currentAllEpargne[index];
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 7.w, right: 7.w, bottom: 10.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.w,
                                    color: currentEpargne["is_active"] == 0
                                        ? AppColors.red
                                        : AppColors.green,
                                  ),
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: AppColors.white,
                                ),
                                padding: EdgeInsets.only(
                                  left: 10.w,
                                  top: 10.h,
                                  bottom: 5.h,
                                  right: 10.w,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 10.r,
                                          height: 10.r,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(360),
                                            color:
                                                currentEpargne["is_active"] == 0
                                                    ? AppColors.red
                                                    : AppColors.green,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          currentEpargne["is_active"] == 1
                                              ? "Actif".tr()
                                              : "Suspendu".tr(),
                                          style: TextStyle(
                                            color:
                                                currentEpargne["is_active"] == 0
                                                    ? AppColors.red
                                                    : AppColors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${currentEpargne["type_interest"] == "1" ? "Fixe mensuel".tr() : "Indexé sur les prêts".tr()}"
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: AppColors.colorButton,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "montant épargné"
                                                  .tr()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: AppColors.blackBlueAccent1,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Text(
                                              "${formatMontantFrancais(double.parse(currentEpargne["amount_saved"].toString()))} FCFA",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors.blackBlue,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "${currentEpargne["membre"]["first_name"]} ${currentEpargne["membre"]["last_name"] ?? ""}",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.blackBlue,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "INTÉRÊT GÉNÉRÉ".tr(),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: AppColors.blackBlueAccent1,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Text(
                                          "${formatMontantFrancais(double.parse(currentEpargne["total_interest"].toString()))} FCFA",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "INTERÊT RECENT".tr(),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: AppColors.blackBlueAccent1,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Text(
                                          "${formatMontantFrancais(double.parse(currentEpargne["interest_added"] ?? "0".toString()))} FCFA",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Créé le, ".tr(),
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.blackBlueAccent1,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Text(
                                          "${formatDateLiteral(currentEpargne["created_at"])}",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.blackBlueAccent1,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 8.h,
                                      ),
                                      padding: EdgeInsets.only(
                                        top: 7.h,
                                        bottom: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            width: .5.r,
                                            color: AppColors.blackBlueAccent2,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (!context
                                              .read<AuthCubit>()
                                              .state
                                              .detailUser!["isMember"])
                                            // if (widget.nomBeneficiaire != "")
                                            Expanded(
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () async {
                                                    showModalPayEpargne(
                                                      context,
                                                      "${currentEpargne["membre"]["first_name"]} ${currentEpargne["membre"]["last_name"] ?? ""}",
                                                      // "resteAPayer",
                                                      "${currentEpargne["saving_code"]}",
                                                      "${currentEpargne["membre"]["membre_code"]}",
                                                      9,
                                                    );
                                                    //   updateTrackingData(
                                                    //       "${widget.screenSource}.btnwithdrawnFundsContribution",
                                                    //       "${DateTime.now()}", {});
                                                    //   await launchWeb(
                                                    //     "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/cotisations-details/${widget.codeCotisation}?query=1&app_mode=mobile",
                                                    //     mode: LaunchMode.platformDefault,
                                                    //   );
                                                    //   print("object1");
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 17.h,
                                                        child: SvgPicture.asset(
                                                          "assets/images/walletPayIcon.svg",
                                                          fit: BoxFit.scaleDown,
                                                          color: AppColors
                                                              .blackBlueAccent1,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      Text(
                                                        "Dépôt".tr(),
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .blackBlueAccent1,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 11.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          // if (!context
                                          //     .read<AuthCubit>()
                                          //     .state
                                          //     .detailUser!["isMember"])
                                          // https://groups.faroty.com/cotisation-details/code
                                          Expanded(
                                            child: buttonSuspend(
                                                currentEpargne: currentEpargne),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      AddAssoElement(
                        screenSource: "transactions.btnAddSanction",
                        text: "Ajouter un épargnant".tr(),
                        routeElement: "loan?query=1",
                      ),
                      if (PretEpargneState.isLoadingAllAssEpargne == true &&
                          PretEpargneState.allAssEpargne != null)
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
                                "aucune_epargnant".tr(),
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
                                        "transactions.btnAddSaving",
                                        "${DateTime.now()}", {});
                                    launchWeb(
                                      "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/loan?query=1&app_mode=mobile",
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.pageBackground,
                                      border: Border.all(
                                        width: 2.w,
                                        color: AppColors.blackBlue.withOpacity(1),
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
                                          "Ajouter un épargnant".tr(),
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
        ),
      ),
    );
  }

  void showModalPayEpargne(context, nom, codeEpargne, codeMembre, typeEpargne) {
    showDialog(
        context: context,
        barrierColor: AppColors.barrierColorModal,
        builder: (BuildContext context) {
          Future<void> handleDetailCotisation(codeSanction) async {
            // final detailTournoiCourant = await context
            //     .read<DetailTournoiCourantCubit>()
            //     .detailTournoiCourantCubit();
            // final detailCotisation = await context
            //     .read<CotisationDetailCubit>()
            //     .detailCotisationCubit(codeSanction);
          }

          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              child: Container(
                height: 250.h,
                child: PayEpargneWidget(
                  nom: nom,
                  codeEpargne: codeEpargne,
                  codeMembre: codeMembre,
                  // resteAPayer: resteAPayer,
                  typeEpargne: typeEpargne,
                  // objectSanction: objectSanction,
                ),
              )

              // Container(
              //   // constraints:
              //       // BoxConstraints(maxHeight: typeSaction == "1" ? 250.h : 200.h),
              //   // child: PaiementSanctionWidget(
              //   //   nom: nom,
              //   //   codeSanction: codeSanction,
              //   //   codeMembre: codeMembre,
              //   //   resteAPayer: resteAPayer,
              //   //   typeSanction: typeSaction,
              //   //   objectSanction: objectSanction,
              //   // ),
              // ),
              );
        });
  }
}

class PayEpargneWidget extends StatefulWidget {
  PayEpargneWidget({
    super.key,
    // required this.infoUserController,
    required this.nom,
    required this.codeEpargne,
    required this.codeMembre,
    required this.typeEpargne,
    // required this.typeSanction,
    // required this.objectSanction,
  });
  var nom;

  var codeEpargne;

  var codeMembre;

  var typeEpargne;

  // var typeSanction;

  // var objectSanction;
  @override
  State<PayEpargneWidget> createState() => _PayEpargneWidgetState();
}

class _PayEpargneWidgetState extends State<PayEpargneWidget> {
  bool load = false;

  late TextEditingController infoUserController;

  @override
  void initState() {
    super.initState();
    infoUserController = TextEditingController(text: "0");
  }

  @override
  Widget build(BuildContext context) {
    String? jsonString = context.read<AuthCubit>().state.dataCookies;

    // Analyse de la réponse JSON
    Map<String, dynamic> data = jsonDecode(jsonString!);

    // Récupération du hash_id
    String hashId = data['user']['hash_id'];
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: 10.h,
          // ),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.blackBlue,
              ),
              text: "Vous confirmez avoir reçu le paiement de ".tr(),
              children: <InlineSpan>[
                TextSpan(
                  text: "${widget.nom} ",
                  // widget.typeSanction == "1"
                  //     ? "${widget.nom} ?"
                  // : "${widget.objectSanction} ",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackBlue),
                ),
                // if (widget.typeSanction == "0")
                TextSpan(
                  text: "pour son épargne ?".tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.blackBlue,
                  ),
                ),
                // if (widget.typeSanction == "0")
                // TextSpan(
                //   // text: widget.nom,
                //   text: "rrrr",
                //   style: TextStyle(
                //       fontSize: 14.sp,
                //       fontWeight: FontWeight.bold,
                //       color: AppColors.blackBlue),
                // )
              ],
            ),
          ),
          // if (widget.typeSanction == "1")
          SizedBox(
            height: 20.h,
          ),
          // if (widget.typeSanction == "1")
          SizedBox(
            height: 60.h,
            child: TextField(
              controller: infoUserController,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: TextStyle(fontSize: 20.sp),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.w,
                      color: AppColors.blackBlue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.w,
                      color: AppColors.blackBlue,
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Material(
                          color: AppColors.colorButton,
                          borderRadius: BorderRadius.circular(10.r),
            child: InkWell(
              onTap: () async {
                setState(() {
                  load = true;
                });
                print(load);
                await CotisationRepository().PayOneCotisation(
                  widget.codeEpargne,
                  infoUserController.text,
                  widget.codeMembre,
                  AppCubitStorage().state.codeAssDefaul,
                  hashId,
                  9,
                );
                context
                    .read<PretEpargneCubit>()
                    .getAllAssEpargnes(AppCubitStorage().state.codeTournoisHist);
                // context.read<RecentEventCubit>().AllRecentEventCubit(AppCubitStorage().state.membreCode);
                setState(() {
                  load = false;
                });
                print(load);
                Navigator.pop(context);
              },
              child: load == true
                  ? CircularProgressIndicator(
                      color: AppColors.colorButton,
                    )
                  : Container(
                      height: 45.h,
                      // decoration: BoxDecoration(
                      //     ),
                      alignment: Alignment.center,
                      child: Text(
                        "Confirmer",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class buttonSuspend extends StatefulWidget {
  buttonSuspend({
    super.key,
    required this.currentEpargne,
  });

  var currentEpargne;

  @override
  State<buttonSuspend> createState() => _buttonSuspendState();
}

class _buttonSuspendState extends State<buttonSuspend> {
  bool suspendLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          setState(() {
            suspendLoaded = true;
          });
      
          if (widget.currentEpargne["is_active"] == 1) {
            await PretEpargneRepository()
                .suspendEpargne(widget.currentEpargne["saving_code"]);
          } else {
            await PretEpargneRepository()
                .activeEpargne(widget.currentEpargne["saving_code"]);
          }
          await context
              .read<PretEpargneCubit>()
              .getAllAssEpargnes(AppCubitStorage().state.codeTournoisHist);
      
          setState(() {
            suspendLoaded = false;
          });
          //   print("object3");
          //   updateTrackingData(
          //       "${widget.screenSource}.btnShareContribution",
          //       "${DateTime.now()}", {});
      
          //   Share.share(context
          //           .read<AuthCubit>()
          //           .state
          //           .detailUser!["isMember"]
          //       ? "Aide-moi à payer ma cotisation *${widget.motifCotisations}*.\nMontant: *${formatMontantFrancais(double.parse(widget.montantCotisations.toString()))} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode} pour valider"
          //       : "Nouvelle cotisation créée dans le groupe *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* concernant ${widget.source == '' ? "*${(widget.nomBeneficiaire)}*" : "*${(widget.source)}*"}.\nSoyez le premier à contribuer ici : https://${widget.lienDePaiement}");
          // },
          // onTap: () async {
          //   updateTrackingData("transactions.btnAddSharesaving", "${DateTime.now()}", {});
          //     Share.share(
          //        "Vous pouvez *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* concernant ${widget.source == '' ? "*${(widget.nomBeneficiaire)}*" : "*${(widget.source)}*"}.\nSoyez le premier à contribuer ici : https://${widget.lienDePaiement}");
          //   await launchWeb(
          //     "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/loan?query=1&app_mode=mobile",
          //     mode: LaunchMode.platformDefault,
          //   );
        },
        child: suspendLoaded
            ? Center(
                child: Container(
                  width: 20.r,
                  height: 20.r,
                  child: CircularProgressIndicator(
                    color: AppColors.green,
                    strokeWidth: 2.w,
                  ),
                ),
              )
            : Column(
                children: [
                  Container(
                    height: 17.h,
                    child: SvgPicture.asset(
                      widget.currentEpargne["is_active"] == 1
                          ? "assets/images/suspendIcon.svg"
                          : "assets/images/activeIcon.svg",
                      fit: BoxFit.scaleDown,
                      color: widget.currentEpargne["is_active"] == 1
                          ? AppColors.red
                          : AppColors.green,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    widget.currentEpargne["is_active"] == 1
                        ? "Suspendre".tr()
                        : "Activer".tr(),
                    style: TextStyle(
                      color: widget.currentEpargne["is_active"] == 1
                          ? AppColors.red
                          : AppColors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
