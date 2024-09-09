import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/contribution_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/screens/detailContributionPage.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetHistoriqueTontineCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widget_pay_another_person.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/encours_widget.dart';
import 'package:faroty_association_1/widget/nonPaye_widget.dart';
import 'package:faroty_association_1/widget/paye_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class widgetRecentEventTontine extends StatefulWidget {
  widgetRecentEventTontine({
    super.key,
    required this.nomBeneficiaire,
    required this.prenomBeneficiaire,
    required this.dateOpen,
    required this.dateClose,
    required this.montantTontine,
    required this.montantCollecte,
    required this.codeCotisation,
    required this.lienDePaiement,
    required this.nomTontine,
    required this.motif,
    required this.isPayed,
    required this.isPassed,
  });
  String nomBeneficiaire;
  String dateClose;
  String dateOpen;
  String montantCollecte;
  int montantTontine;
  String prenomBeneficiaire;
  String codeCotisation;
  String lienDePaiement;
  String nomTontine;
  String motif;
  int isPayed;
  int isPassed;

  @override
  State<widgetRecentEventTontine> createState() =>
      _widgetRecentEventTontineState();
}

class _widgetRecentEventTontineState extends State<widgetRecentEventTontine>
    with TickerProviderStateMixin {
  Future<void> handleDetailContributionTontine(codeContribution) async {
    final detailCotisation = await context
        .read<DetailContributionCubit>()
        .detailContributionTontineCubit(codeContribution);
  }

  RelativeRect _getRelativeRect(GlobalKey key) {
    return RelativeRect.fromSize(
        _getWidgetGlobalRect(key), const Size(200, 200));
  }

  Rect _getWidgetGlobalRect(GlobalKey key) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    debugPrint('Widget position: ${offset.dx} ${offset.dy}');
    return Rect.fromLTWH(offset.dx / 3.1, offset.dy * 1.05,
        renderBox.size.width, renderBox.size.height);
  }

  @override
  Widget build(BuildContext context) {
    final widgetKey = GlobalKey();
    return BlocBuilder<UserGroupCubit, UserGroupState>(
        builder: (UserGroupcontext, UserGroupstate) {
      if (UserGroupstate.isLoadingChangeAss == true &&
          UserGroupstate.changeAssData == null) return Container();
      return Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          side: BorderSide(
            color: AppColors.white,
            width: 0.5.r,
          ),
        ),
        child: InkWell(
          onTap: () {
            updateTrackingData("home.tontine", "${DateTime.now()}",
                {"type": 'tontine', "tontine_id": "${widget.codeCotisation}"});
            if (checkTransparenceStatus(
                context
                    .read<UserGroupCubit>()
                    .state
                    .changeAssData!
                    .user_group!
                    .configs,
                context.read<AuthCubit>().state.detailUser!["isMember"])) {
              // handleDetailContributionTontine(
              //   widget.codeCotisation,
              // );

              // onTap: () {
              handleDetailContributionTontine(widget.codeCotisation);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailContributionPage(
                      montantCotisations: widget.montantTontine,
                      motifCotisations: widget.motif,
                      dateCotisation: widget.dateClose,
                      heureCotisation: widget.dateClose,
                      soldeCotisation: widget.montantCollecte,
                      isPassed: widget.isPassed,
                      type: "0",
                      lienDePaiement: widget.lienDePaiement,
                      codeCotisation: widget.codeCotisation,
                      isPayed: widget.isPayed,
                      // rapportUrl: widget.x,
                      is_passed: widget.isPassed,
                      is_tontine: 1,
                      source: '',
                      nomBeneficiaire: widget.nomBeneficiaire,
                      rubrique: 'Tontine : ${widget.nomTontine}'),
                ),
              );
              // },
            }
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 10.h,
                  left: 10.w,
                  right: 10.w,
                  bottom: 7.h,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5.w),
                              width: 11.r,
                              height: 11.r,
                              decoration: BoxDecoration(
                                  color: !isPasseDate(widget.dateClose)
                                      ? AppColors.colorButton
                                      : AppColors.red,
                                  borderRadius: BorderRadius.circular(360.r)),
                            ),
                            Text(
                              'TONTINE'.tr(),
                              style: TextStyle(
                                color: AppColors.blackBlue,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Tooltip(
                              message: "Voir la liste des membres".tr(),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8.0),
                                  onTap: () {
                                    handleDetailContributionTontine(
                                        widget.codeCotisation);
                                    Modal().showBottomSheetHistTontine(
                                        context,
                                        widget.codeCotisation,
                                        widget.montantTontine);
                                  },
                                  child: Container(
                                    width: 25.w,
                                    height: 25.w,
                                    // color: AppColors.colorButton,
                                    // margin: EdgeInsets.only(right: 15.w),
                                    // padding: EdgeInsets.only(right: 10.w),
                                    child: SvgPicture.asset(
                                      "assets/images/friendsTalking.svg",
                                      fit: BoxFit.cover,
                                      color: AppColors.blackBlue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (widget.isPassed == 1)
                              Row(
                                children: [
                                  if (widget.isPassed == 1)
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.amberAccent,
                                          borderRadius:
                                              BorderRadius.circular(3.r)),
                                      margin: EdgeInsets.only(
                                          bottom: 5.h, left: 5.w, top: 2.h),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.h, horizontal: 2.w),
                                      child: Text(
                                        "expiré".tr(),
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: AppColors.blackBlue,
                                          fontWeight: FontWeight.w600,
                                          // fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  if (widget.isPassed == 1 &&
                                      widget.isPayed == 0)
                                    NonpayeWidget(),
                                  if (widget.isPassed == 1 &&
                                      widget.isPayed == 1)
                                    PayeWidget(),
                                ],
                              ),
                            if (widget.isPassed == 0 && widget.isPayed == 1)
                              Row(
                                children: [
                                  EncoursWidget(),
                                  PayeWidget(),
                                ],
                              ),

                            //         if (widget.isPassed == 1)
                            // Container(
                            //   decoration: BoxDecoration(
                            //       color: Colors.amberAccent,
                            //       borderRadius: BorderRadius.circular(3.r)),
                            //   margin:
                            //       EdgeInsets.only(bottom: 5.h, left: 5.w, top: 2.h),
                            //   padding: EdgeInsets.symmetric(
                            //       vertical: 1.h, horizontal: 2.w),
                            //   child: Text(
                            //     "expiré".tr(),
                            //     style: TextStyle(
                            //       fontSize: 10.sp,
                            //       color: AppColors.blackBlue,
                            //       fontWeight: FontWeight.w600,
                            //       // fontStyle: FontStyle.italic,
                            //     ),
                            //   ),
                            // ),

                            if (widget.isPassed == 0)
                              Row(
                                children: [
                                  if (widget.isPayed == 1)
                                    InkWell(
                                      onTap: () {
                                        handleDetailContributionTontine(
                                          widget.codeCotisation,
                                        );
                                        Modal()
                                            .showModalPayForAnotherPersonTontine(
                                                context,
                                                widget.codeCotisation,
                                                widget.lienDePaiement,
                                                widget.nomTontine,
                                                widget.montantTontine,
                                                widget.dateClose,
                                                widget.nomBeneficiaire);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        // width: 72.w,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 4.h,
                                        ),
                                        margin: EdgeInsets.only(left: 15.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.colorButton,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                        child: Container(
                                          child: Text(
                                            "Tontiner un ami".tr(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (widget.isPayed == 0)
                                    PopupMenuButton(
                                      elevation: 5,
                                      shadowColor: AppColors.barrierColorModal,
                                      onSelected: (value) async {
                                        if (value == "mySelf") {
                                          print("value");
                                          launchWeb(
                                            "https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode}",
                                          );
                                        } else if (value == "anotherPerson") {
                                          handleDetailContributionTontine(
                                            widget.codeCotisation,
                                          );
                                          Modal()
                                              .showModalPayForAnotherPersonTontine(
                                                  context,
                                                  widget.codeCotisation,
                                                  widget.lienDePaiement,
                                                  widget.nomTontine,
                                                  widget.montantTontine,
                                                  widget.dateClose,
                                                  widget.nomBeneficiaire);
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(left: 5.w),
                                        // width: 72.w,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.colorButton,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                        child: Container(
                                          child: Text(
                                            "Tontiner",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry>[
                                        PopupMenuItem(
                                          value: "mySelf",
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8.0),
                                                child: Container(
                                                  height: 22.h,
                                                  width: 22.w,
                                                  child: SvgPicture.asset(
                                                    "assets/images/person.svg",
                                                    fit: BoxFit.cover,
                                                    color: AppColors
                                                        .blackBlueAccent1,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Payer pour moi'.tr(),
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: AppColors.blackBlue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: "anotherPerson",
                                          // onTap: () {
                                          //   _showSimpleModalDialog(context);
                                          // },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8.0),
                                                child: Container(
                                                  height: 22.h,
                                                  width: 22.w,
                                                  child: SvgPicture.asset(
                                                    "assets/images/friendsTalking.svg",
                                                    fit: BoxFit.cover,
                                                    color: AppColors
                                                        .blackBlueAccent1,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Payer pour quelqu'un".tr(),
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: AppColors.blackBlue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7.h),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.nomTontine}",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackBlue,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "${"Bénéficiaire".tr()} :",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.blackBlueAccent1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                child: Text(
                                  "${widget.nomBeneficiaire}",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackBlue,
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
                                  "montant".tr(),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackBlueAccent1,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${formatMontantFrancais(double.parse("${widget.montantTontine}"))} FCFA",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppColors.blackBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "montant_collecté".tr(),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.blackBlueAccent1,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Container(
                                  child: Text(
                                    "${formatMontantFrancais(
                                      double.parse("${widget.montantCollecte}"),
                                    )} FCFA",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppColors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              Text(
                                "${"Date limite".tr()} : ",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackBlueAccent1,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${formatDateTimeintegral(
                                    context.locale.toString() == "en_US"
                                        ? "en"
                                        : "fr",
                                    widget.dateClose,
                                  )} ${"à".tr()} ${formatHeurUnikLiteral(widget.dateClose)}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackBlueAccent1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 8.h,
                      ),
                      padding: EdgeInsets.only(
                        top: 8.h,
                        bottom: 0.h,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (!context
                              .read<AuthCubit>()
                              .state
                              .detailUser!["isMember"])
                            if (widget.nomBeneficiaire != "")
                              Expanded(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () async {
                                      updateTrackingData(
                                          "home.btnwithdrawnFundsContribution",
                                          "${DateTime.now()}", {});
                                      launchWeb(
                                        "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/tontine-details/${widget.codeCotisation}?query=1&app_mode=mobile",
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 17.h,
                                          child: SvgPicture.asset(
                                            "assets/images/withdrawIcon.svg",
                                            fit: BoxFit.scaleDown,
                                            color: AppColors.blackBlueAccent1,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Text(
                                          "Retrait des fonds".tr(),
                                          style: TextStyle(
                                            color: AppColors.blackBlueAccent1,
                                            fontWeight: FontWeight.bold,
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
                          if (!context
                              .read<AuthCubit>()
                              .state
                              .detailUser!["isMember"])
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    updateTrackingData(
                                        "home.btnAdministerTontine",
                                        "${DateTime.now()}", {});
                                    launchWeb(
                                      "https://auth.faroty.com/hello.html?user_data=${context.read<AuthCubit>().state.dataCookies}&group_current_page=${AppCubitStorage().state.codeAssDefaul}&callback=https://groups.faroty.com/tontine-details/${widget.codeCotisation}&app_mode=mobile",
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        // color: const Color.fromARGB(255, 0, 0, 0),
                                        height: 17.h,
                                        // width: 230,
                                        child: SvgPicture.asset(
                                          "assets/images/folderManageSimpleIcon.svg",
                                          fit: BoxFit.scaleDown,
                                          color: AppColors.blackBlueAccent1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Text(
                                        "Gerer".tr(),
                                        style: TextStyle(
                                          color: AppColors.blackBlueAccent1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          Expanded(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  print("object3");
                                  // updateTrackingData(
                                  //     "${widget.screenSource}.btnShareContribution",
                                  //     "${DateTime.now()}", {});

                                  await handleDetailContributionTontine(
                                    widget.codeCotisation,
                                  );

                                  List currentDetailCotisation = context
                                      .read<DetailContributionCubit>()
                                      .state
                                      .detailContributionTontine!["membres"];
                                  print("rrrtttzzz $currentDetailCotisation");

                                  partagerContributionTontine(
                                    context: context,
                                    nomGroupe:
                                        '${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name!.trimRight()}',
                                    // source:
                                    //     '${widget.source == '' ? '*${(widget.nomBeneficiaire)}*' : "*${(widget.source)}*"}',
                                    nomBeneficiaire:
                                        '${(widget.nomBeneficiaire.trimRight())}',
                                    dateCotisation: '${widget.dateClose}',
                                    montantCotisations:
                                        '${widget.montantTontine}',
                                    lienDePaiement: '${widget.lienDePaiement}',
                                    // type: '${widget.type}',
                                    listeOkayCotisation:
                                        currentDetailCotisation,
                                    nomTontine:
                                        '${widget.nomTontine.trimRight()}',
                                    motif: '${widget.motif.trimRight()}',
                                  );

                                  // Share.share(context
                                  //         .read<AuthCubit>()
                                  //         .state
                                  //         .detailUser!["isMember"]
                                  //     ? "Aide-moi à payer ma tontine *${widget.nomTontine}*.\nMontant: *${formatMontantFrancais(double.parse(widget.montantTontine.toString()))} FCFA* .\nMerci de suivre le lien https://${widget.lienDePaiement}?code=${AppCubitStorage().state.membreCode} pour valider"
                                  //     : "Nouvelle tontine créée dans le groupe *${context.read<UserGroupCubit>().state.changeAssData!.user_group!.name}* concernant  *${(widget.nomBeneficiaire)}* .\nSoyez le premier à contribuer ici : https://${widget.lienDePaiement}");
                                },
                                child: Column(
                                  children: [
                                    BlocBuilder<DetailContributionCubit,
                                            ContributionState>(
                                        builder: (DetailContributionContext,
                                            DetailContributionState) {
                                      return DetailContributionState
                                                  .isLoadingContibutionTontine ==
                                              true
                                          ? Container(
                                              width: 15.r,
                                              height: 15.r,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1.w,
                                                color:
                                                    AppColors.blackBlueAccent1,
                                              ),
                                            )
                                          : Container(
                                              height: 17.h,
                                              child: SvgPicture.asset(
                                                "assets/images/shareSimpleIcon.svg",
                                                fit: BoxFit.scaleDown,
                                                color:
                                                    AppColors.blackBlueAccent1,
                                              ),
                                            );
                                    }),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      "Partager".tr(),
                                      style: TextStyle(
                                        color: AppColors.blackBlueAccent1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
