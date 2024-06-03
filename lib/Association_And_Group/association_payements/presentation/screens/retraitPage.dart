import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/business_logic/association_payements_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_state.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RetraitPage extends StatefulWidget {
  const RetraitPage({super.key});

  @override
  State<RetraitPage> createState() => _RetraitPageState();
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
          "active_de_retrait".tr(),
          style: TextStyle(fontSize: 16.sp, color : AppColors.white),
        ),
        backgroundColor: AppColors.backgroundAppBAr,
      ),
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    appBar: AppBar(
      title: Text(
        "active_de_retrait".tr(),
        style: TextStyle(fontSize: 16.sp, color : AppColors.white),
      ),
      backgroundColor: AppColors.backgroundAppBAr,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: AppColors.white, size: 16.sp,),
      ),
    ),
    
    body: child,
  );
}

class _RetraitPageState extends State<RetraitPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> handleDetailUser(userCode, codeTournoi) async {
      final allCotisationAss =
          await context.read<AuthCubit>().detailAuthCubit(userCode, codeTournoi);

    }

    Future<void> handleApproveWithdraw(withdrawId, codeMembre) async {
      final ApproveWithdraw = await context
          .read<PayementCubit>()
          .approvePayementCubit(withdrawId, codeMembre);

      if (ApproveWithdraw != null) {
        handleDetailUser(AppCubitStorage().state.membreCode, AppCubitStorage().state.codeTournois);
        print("handleDetailUser");
      } else {
        print("handleDetailUser null");
      }
    }

    return PageScaffold(
        context: context,
        child: Container(
          margin: EdgeInsets.only(top: 10.h),
          child: BlocBuilder<AuthCubit, AuthState>(
              builder: (authContext, authState) {
            if (authState.isLoading == null || authState.isLoading == true)
              return Container(
                color: AppColors.white,
                child: Center(
                  child: CircularProgressIndicator(
                   color: AppColors.green,
                  ),
                ),
              );
            final currentDetailUser =
                context.read<AuthCubit>().state.detailUser;
            return ListView.builder(
                itemCount: currentDetailUser!["checked_withdrawals"].length,
                itemBuilder: (BuildContext context, int index) {
                  final itemWithdrawals = currentDetailUser!["checked_withdrawals"][index];
                  int isApprouveValeur = 0;

                  for (var objet in itemWithdrawals["withdrawals_approvers"]) {
                    if (objet["ass_membre_id"] == currentDetailUser['id']) {
                      isApprouveValeur = objet["is_approved"];
                      break;
                    }
                  }

                  return GestureDetector(
                    onTap: () {
                      handleApproveWithdraw(itemWithdrawals["id"],
                          AppCubitStorage().state.membreCode);
                    },
                    child: widgetRetraitCard(
                      date: itemWithdrawals["created_at"],
                      nomCompte: itemWithdrawals["compte"]["name"],
                      nomInitiateur:
                          "${itemWithdrawals["membre"]["first_name"] == null ? "" : itemWithdrawals["membre"]["first_name"]} ${itemWithdrawals["membre"]["last_name"] == null ? "" : itemWithdrawals["membre"]["last_name"]}",
                      statut: itemWithdrawals["status"],
                      montant: itemWithdrawals["amount"],
                      nbrMembre:
                          itemWithdrawals["withdrawals_approvers"].length,
                      nbrApprouvee: itemWithdrawals["withdrawals_approvers"]
                          .where((objet) => objet["is_approved"] == 1)
                          .length,
                      isApprovedForThisUser: isApprouveValeur,
                      idRetrait: itemWithdrawals["id"],
                    ),
                  );
                });
          }),
        ));
  }
}

class widgetRetraitCard extends StatelessWidget {
  widgetRetraitCard(
      {super.key,
      required this.date,
      required this.nomCompte,
      required this.nomInitiateur,
      required this.statut,
      required this.montant,
      required this.nbrMembre,
      required this.nbrApprouvee,
      required this.isApprovedForThisUser,
      required this.idRetrait});
  String nomCompte;

  String nomInitiateur;

  String statut;
  String date;
  String montant;
  int nbrMembre;
  int nbrApprouvee;
  int isApprovedForThisUser;
  int idRetrait;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white,
      ),
      margin: EdgeInsets.only(bottom: 10.h, left: 5.w, right: 5.w,),
      padding: EdgeInsets.symmetric(vertical:15.h, horizontal: 15.w),
      // height: 20,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    child: Text(
                      "Date : ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${AppCubitStorage().state.Language == "fr" ? formatDateToFrench(date) : formatDateToEnglish(date)}",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              statut == "0"
                  ? Container(
                      child: Text(
                        "En attente (${nbrApprouvee}/${nbrMembre})",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  : Container(
                      child: Text(
                        "Approuvé (${nbrApprouvee}/${nbrMembre})",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.green,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
            ],
          ),
          Container(
            // color: Color.fromARGB(6, 0, 0, 0),
            margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Compte",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.blackBlue,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width / 1.3,
                      child: Text(
                        "${nomCompte}",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.blackBlue,
                          fontWeight: FontWeight.w700,
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
                        "Montant",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.blackBlue,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width / 1.3,
                      child: Text(
                        "${formatMontantFrancais(double.parse(montant))} FCFA",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.blackBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Initié par:",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${nomInitiateur}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.blackBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              isApprovedForThisUser == 0
                  ? Container(
                      padding:
                          EdgeInsets.only(left: 8.w, right: 8.w, top: 5.h, bottom: 5.h),
                      decoration: BoxDecoration(
                        color: AppColors.colorButton,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        child: Text(
                          "Approuver",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      child: Text(
                        "Approuvé",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.green,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
