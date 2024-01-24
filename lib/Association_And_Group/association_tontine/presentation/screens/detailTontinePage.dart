import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/detail_contribution_tontine.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetDetailHistoriqueTontineCard.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/presentation/widgets/widgetDetailTontineCard.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailTontinePage extends StatefulWidget {
  DetailTontinePage({
    super.key,
    required this.dateCreaTontine,
    required this.nomTontine,
    required this.montantTontine,
    required this.positionBeneficiaire,
    required this.nbrMembreTontine,
    required this.listMembre,
    required this.isActive,
  });
  String dateCreaTontine;
  String nomTontine;
  String montantTontine;
  String positionBeneficiaire;
  String nbrMembreTontine;
  List listMembre;
  int isActive;
  @override
  State<DetailTontinePage> createState() => _DetailTontinePageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.pageBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Detail de la tontine",
          style: TextStyle(fontSize: 16, color: AppColors.white),
        ),
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    appBar: AppBar(
      title: Text(
        "Detail de la tontine",
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
    ),
    body: child,
  );
}

class _DetailTontinePageState extends State<DetailTontinePage>
    with TickerProviderStateMixin {
  Future<void> handleDetailContributionTontine(codeContribution) async {
    final detailCotisation = await context
        .read<DetailContributionCubit>()
        .detailContributionTontineCubit(codeContribution);

    if (detailCotisation != null) {
      print("objaaaaaaaaaaaaaaaaaa  ${detailCotisation}");
      print(
          "aaaaaaaaaaaaaaaaaaaaaqqqqq  ${context.read<CotisationDetailCubit>().state.detailCotisation}");
    } else {
      print("userGroupDefault null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      context: context,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, top: 10),
              child: WidgetDetailTontineCard(
                dateCreaTontine: widget.dateCreaTontine,
                nomTontine: widget.nomTontine,
                montantTontine: widget.montantTontine,
                positionBeneficiaire: widget.positionBeneficiaire,
                nbrMembreTontine: widget.nbrMembreTontine,
                isActive: widget.isActive,
              ),
            ),
            Container(
              // color: Colors.blueGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 7, left: 5, right: 5),
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "ordre_de_passage".tr(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackBlue,
                      ),
                    ),
                  ),
                  Container(
                    color: AppColors.white,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        color: AppColors.white,
                        padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var itemListMembre in widget.listMembre)
                              Container(
                                // color: AppColors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 3),
                                      width: 70,
                                      child: Text(
                                        "${itemListMembre["membre"]["first_name"] == null ? "" : itemListMembre["membre"]["first_name"]} ${itemListMembre["membre"]["last_name"] == null ? "" : itemListMembre["membre"]["last_name"]}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.blackBlue,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(360),
                                              color:
                                                  itemListMembre["is_passed"] ==
                                                          0
                                                      ? Color.fromRGBO(
                                                          20, 45, 99, 0.24)
                                                      : Color.fromRGBO(
                                                          15, 190, 24, 0.658),
                                            ),
                                            width: 15,
                                            height: 15,
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: itemListMembre[
                                                            "is_passed"] ==
                                                        0
                                                    ? Text(
                                                        "${itemListMembre["position"]}",
                                                        style: TextStyle(
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color.fromRGBO(
                                                              20, 45, 99, 1),
                                                        ),
                                                      )
                                                    : Icon(
                                                        Icons.check,
                                                        size: 10,
                                                        color: AppColors.white,
                                                      )),
                                          ),
                                          Container(
                                            color:
                                                itemListMembre["is_passed"] == 0
                                                    ? Color.fromRGBO(
                                                        20, 45, 99, 0.24)
                                                    : Color.fromRGBO(
                                                        15, 190, 24, 0.658),
                                            width: 80,
                                            height: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                print(context.read<TontineCubit>().state.detailTontine);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 5),
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Historique de la tontine",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackBlue,
                  ),
                ),
              ),
            ),
            BlocBuilder<TontineCubit, TontineState>(
                builder: (tontineContext, tontineState) {
              if (tontineState.isLoading == null ||
                  tontineState.isLoading == true ||
                  tontineState.detailTontine == null)
                return Expanded(
                          child: Center(
                            child: EasyLoader(
                              backgroundColor: Color.fromARGB(0, 255, 255, 255),
                              iconSize: 50,
                              iconColor: AppColors.blackBlueAccent1,
                              image: AssetImage(
                                'assets/images/Groupe_ou_Asso.png',
                              ),
                            ),
                          ),
                        );
              final currentDetailTontineCard =
                  tontineContext.read<TontineCubit>().state.detailTontine;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 0, left: 5, right: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 1,
                    color: Color.fromARGB(85, 9, 185, 255),
                  )),
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: currentDetailTontineCard!.length,
                    itemBuilder: (context, index) {
                      final itemTontine = currentDetailTontineCard[index];

                      return GestureDetector(
                        // onTap: (){
                        //   print(itemTontine["code"],);
                        // },

                        onTap: () {
                          if (checkTransparenceStatus(
                              context
                                  .read<UserGroupCubit>()
                                  .state
                                  .ChangeAssData!["user_group"]["configs"],
                              context
                                  .read<AuthCubit>()
                                  .state
                                  .detailUser!["isMember"])) {
                            handleDetailContributionTontine(
                              itemTontine["code"],
                            );

                            Modal().showBottomSheetHistTontine(
                              tontineContext,
                            );
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.all(5),
                            child: widgetDetailHistoriqueTontineCard(
                              nomTontine: widget.nomTontine,
                              lienDePaiement: itemTontine['tontine_pay_link'],
                              dateClose: itemTontine['end_date'],
                              dateOpen: itemTontine['start_date'],
                              montantCollecte: itemTontine['tontine_balance'],
                              montantTontine: itemTontine['amount'],
                              nomBeneficiaire: itemTontine["membre"]
                                  ["first_name"],
                              prenomBeneficiaire:
                                  itemTontine["membre"]["last_name"] == null
                                      ? ""
                                      : itemTontine["membre"]["last_name"],
                              codeCotisation: itemTontine["code"],
                            )),
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
