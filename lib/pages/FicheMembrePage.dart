import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Modals/showAllModal.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

Widget PageScaffold({
  required BuildContext context,
  required Widget child,
}) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.pageBackground,
      child: child,
    );
  }

  return Scaffold(
    backgroundColor: AppColors.pageBackground,
    body: child,
  );
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final currentDetailUser = context.read<AuthCubit>().state.detailUser;

    return PageScaffold(
      context: context,
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 25.h,
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                color: AppColors.blackBlue,
              ),
              height: 190.h,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 30.h, left: 20.w),
                          child: Icon(
                            Platform.isAndroid
                                ? Icons.arrow_back
                                : Icons.arrow_back_ios,
                            color: AppColors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 40.w),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15.h, bottom: 3.h),
                                padding: EdgeInsets.all(2.r),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    width: 70.r,
                                    height: 70.r,
                                    child: Image.network(
                                      "${Variables.LienAIP}${currentDetailUser!["photo_profil"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 5.w,
                                        right: 5.w,
                                        top: 5.h,
                                      ),
                                      child: Text(
                                        "${currentDetailUser["first_name"] == null ? "" : currentDetailUser["first_name"]} ${currentDetailUser["last_name"] == null ? "" : currentDetailUser["last_name"]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Type".tr(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteAccent1,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "${currentDetailUser["type"] == "2" ? "Fondateur" : currentDetailUser["type"] == "3" ? "Membre" : "Super Admin"}",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.green,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "matricule".tr(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteAccent1,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "${currentDetailUser["matricule"]}",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.green,
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            String msg =
                                "Aide-moi à payer mon inscription.\nMontant: ${formatMontantFrancais(double.parse((int.parse(currentDetailUser["entry_amount"]) - int.parse(currentDetailUser["inscription_balance"])).toString()))} FCFA.\nMerci de suivre le lien https://${currentDetailUser["inscription_pay_link"]} pour valider";
                            if (currentDetailUser["is_inscription_payed"] != 1)
                              Modal().showModalActionPayement(
                                context,
                                msg,
                                currentDetailUser["inscription_pay_link"],
                              );
                          },
                          child: Column(
                            children: [
                              Text(
                                "Fonds de caisse".tr(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.whiteAccent1,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              currentDetailUser["is_inscription_payed"] == 1
                                  ? Text(
                                      "payé".tr(),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.green,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        String msg =
                                            "Aide-moi à payer mon inscription.\nMontant: ${formatMontantFrancais(double.parse((int.parse(currentDetailUser["entry_amount"]) - int.parse(currentDetailUser["inscription_balance"])).toString()))} FCFA.\nMerci de suivre le lien ${currentDetailUser["inscription_pay_link"]} pour valider";
                                        Modal().showModalActionPayement(
                                          context,
                                          msg,
                                          currentDetailUser[
                                              "inscription_pay_link"],
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "non_payé".tr(),
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.red,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 2.w),
                                            child: Icon(
                                              Icons.open_in_new,
                                              color: AppColors.red,
                                              size: 10.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (currentDetailUser["situation_membre"] != null)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15.h, bottom: 5.h),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "Votre situation".tr(),
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blackBlueAccent1),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(7.r),
                              decoration: BoxDecoration(
                                color: AppColors.blackBlueAccent2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 5.h, bottom: 5.h),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${"TOTAL A PAYER".tr()} :  ${formatMontantFrancais(currentDetailUser["situation_membre"]["sum_remain"].toDouble())} FCFA",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.blackBlue,
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.1,
                                          padding: EdgeInsets.all(7.r),
                                          margin: EdgeInsets.only(
                                            left: 5.w,
                                            right: 5.w,
                                            top: 5.h,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 5.h),
                                                padding: EdgeInsets.only(
                                                    bottom: 2.h),
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      width: 0.3.r,
                                                      color:
                                                          AppColors.blackBlue,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      ("Fonds de caisse".tr())
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .blackBlueAccent1,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "a_payer"
                                                            .tr()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formatMontantFrancais(double.parse(currentDetailUser["situation_membre"]["cash_fund"]["total"]))}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "payé"
                                                            .tr()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formatMontantFrancais(double.parse(currentDetailUser["situation_membre"]["cash_fund"]["verse"]))}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color:
                                                              AppColors.green,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "reste"
                                                            .tr()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formatMontantFrancais(currentDetailUser["situation_membre"]["cash_fund"]["remain"].toDouble())}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.1,
                                          padding: EdgeInsets.all(7.r),
                                          margin: EdgeInsets.only(
                                            left: 5.w,
                                            right: 5.w,
                                            top: 5.h,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 5.h),
                                                padding: EdgeInsets.only(
                                                    bottom: 2.h),
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      width: 0.3.r,
                                                      color:
                                                          AppColors.blackBlue,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "TONTINES",
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .blackBlueAccent1,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    Text(
                                                      " (${currentDetailUser["situation_membre"]["tontine"]["nbre"]})",
                                                      style: TextStyle(
                                                        fontSize: 9.sp,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: AppColors
                                                            .blackBlueAccent1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "a_payer"
                                                            .tr()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formatMontantFrancais(currentDetailUser["situation_membre"]["tontine"]["total"].toDouble())}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "payé"
                                                            .tr()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formatMontantFrancais(currentDetailUser["situation_membre"]["tontine"]["verse"].toDouble())}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color:
                                                              AppColors.green,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "reste"
                                                            .tr()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formatMontantFrancais(currentDetailUser["situation_membre"]["tontine"]["remain"].toDouble())}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.1,
                                          padding: EdgeInsets.all(7.r),
                                          margin: EdgeInsets.only(
                                            left: 5.w,
                                            right: 5.w,
                                            top: 5.h,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 5.h,
                                                  ),
                                                  padding: EdgeInsets.only(
                                                    bottom: 2.h,
                                                  ),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 0.3.r,
                                                        color:
                                                            AppColors.blackBlue,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '${"cotisation".tr().toUpperCase()}S',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .blackBlueAccent1,
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                      Text(
                                                        " (${currentDetailUser["situation_membre"]["cotisation"]["nbre"]})",
                                                        style: TextStyle(
                                                          fontSize: 9.sp,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: AppColors
                                                              .blackBlueAccent1,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "a_payer"
                                                            .tr()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formatMontantFrancais(currentDetailUser["situation_membre"]["cotisation"]["total"].toDouble())}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "payé"
                                                            .tr()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formatMontantFrancais(currentDetailUser["situation_membre"]["cotisation"]["verse"].toDouble())}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color:
                                                              AppColors.green,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "reste"
                                                            .tr()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formatMontantFrancais(currentDetailUser["situation_membre"]["cotisation"]["remain"].toDouble())}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.1,
                                          padding: EdgeInsets.all(7.r),
                                          margin: EdgeInsets.only(
                                            left: 5.w,
                                            right: 5.w,
                                            top: 5.h,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 5.h,
                                                ),
                                                padding: EdgeInsets.only(
                                                  bottom: 2.h,
                                                ),
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      width: 0.3.r,
                                                      color:
                                                          AppColors.blackBlue,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "SANCTIONS",
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .blackBlueAccent1,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    Text(
                                                      " (${currentDetailUser["situation_membre"]["sanction"]["nbre"]})",
                                                      style: TextStyle(
                                                        fontSize: 9.sp,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: AppColors
                                                            .blackBlueAccent1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "a_payer"
                                                            .tr()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formatMontantFrancais(currentDetailUser["situation_membre"]["sanction"]["total"].toDouble())}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "payé"
                                                            .tr()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formatMontantFrancais(currentDetailUser["situation_membre"]["sanction"]["verse"].toDouble())}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color:
                                                              AppColors.green,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "reste"
                                                            .tr()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formatMontantFrancais(currentDetailUser["situation_membre"]["sanction"]["remain"].toDouble())}",
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .blackBlue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    /**/

                    Container(
                      width: MediaQuery.of(context).size.width,
                      // alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15.h, bottom: 5.h),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "informations_personnelles".tr(),
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackBlueAccent1),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(7.r),
                            decoration: BoxDecoration(
                              color: AppColors.blackBlueAccent2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 7.w, bottom: 20.h),
                                                  child: Icon(
                                                    Icons
                                                        .phone_android_outlined,
                                                    size: 18.sp,
                                                    color: Color.fromARGB(
                                                        255, 20, 45, 99),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "téléphone".tr(),
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              139, 20, 45, 99),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "${currentDetailUser["first_phone"]}",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      if (currentDetailUser["email"] != null)
                                        Container(
                                          // margin: EdgeInsets.only(bottom: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      right: 7.w,
                                                      bottom: 20.h,
                                                    ),
                                                    child: Icon(
                                                      Icons.email_outlined,
                                                      size: 18.sp,
                                                      color: Color.fromARGB(
                                                        255,
                                                        20,
                                                        45,
                                                        99,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "Email",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      139,
                                                                      20,
                                                                      45,
                                                                      99),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.6,
                                                        child: Text(
                                                          currentDetailUser[
                                                              "email"],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                      if (currentDetailUser["date_adhesion"] !=
                                          null)
                                        Container(
                                          // margin: EdgeInsets.only(bottom: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      right: 7.w,
                                                      bottom: 20.h,
                                                    ),
                                                    child: Icon(
                                                      Icons.calendar_month,
                                                      size: 18.sp,
                                                      color: Color.fromARGB(
                                                        255,
                                                        20,
                                                        45,
                                                        99,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "date_adhesion".tr(),
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      139,
                                                                      20,
                                                                      45,
                                                                      99),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          '${formatDateLiteral(currentDetailUser["date_adhesion"])}',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      20,
                                                                      45,
                                                                      99),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      // Container(
                                      //   // margin: EdgeInsets.only(bottom: 5),
                                      //   child: Column(
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.start,
                                      //     children: [
                                      //       Row(
                                      //         children: [
                                      //           Container(
                                      //             margin: EdgeInsets.only(
                                      //               right: 7,
                                      //               bottom: 20,
                                      //             ),
                                      //             child: Icon(
                                      //               Icons.cake_outlined,
                                      //               color: Color.fromARGB(
                                      //                   255, 20, 45, 99),
                                      //             ),
                                      //           ),
                                      //           Column(
                                      //             crossAxisAlignment:
                                      //                 CrossAxisAlignment.start,
                                      //             children: [
                                      //               Container(
                                      //                 child: Text(
                                      //                   "Date de naissance",
                                      //                   style: TextStyle(
                                      //                     color: Color.fromARGB(
                                      //                         139, 20, 45, 99),
                                      //                     fontWeight: FontWeight.w800,
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               Container(
                                      //                 child: Text(
                                      //                   "21/02/2003",
                                      //                   style: TextStyle(
                                      //                     color: Color.fromARGB(
                                      //                         255, 20, 45, 99),
                                      //                     fontWeight: FontWeight.w500,
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (currentDetailUser["country"] !=
                                              null &&
                                          currentDetailUser["country"] !=
                                              "undefined" &&
                                          int.tryParse(currentDetailUser[
                                                  "country"]) ==
                                              null)
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 7.w,
                                                        bottom: 20.h),
                                                    child: Icon(
                                                      Icons.flag_outlined,
                                                      size: 18.sp,
                                                      color: Color.fromARGB(
                                                          255, 20, 45, 99),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "Pays".tr(),
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    139,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "${currentDetailUser["country"]}",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      20,
                                                                      45,
                                                                      99),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (currentDetailUser["city"] != null &&
                                          currentDetailUser["city"] !=
                                              "undefined")
                                        Container(
                                          // margin: EdgeInsets.only(bottom: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      right: 7.w,
                                                      bottom: 20.h,
                                                    ),
                                                    child: Icon(
                                                      Icons.home_work_outlined,
                                                      size: 18.sp,
                                                      color: Color.fromARGB(
                                                        255,
                                                        20,
                                                        45,
                                                        99,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "Ville".tr(),
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      139,
                                                                      20,
                                                                      45,
                                                                      99),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.6,
                                                        child: Text(
                                                          currentDetailUser[
                                                              "city"],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (currentDetailUser["marital_status"] !=
                                          null)
                                        Container(
                                          // margin: EdgeInsets.only(bottom: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      right: 7.w,
                                                      bottom: 20.h,
                                                    ),
                                                    child: Icon(
                                                      Icons.diversity_1,
                                                      size: 18.sp,
                                                      color: Color.fromARGB(
                                                        255,
                                                        20,
                                                        45,
                                                        99,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "Situation matrimoniale"
                                                              .tr(),
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      139,
                                                                      20,
                                                                      45,
                                                                      99),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          '${currentDetailUser["marital_status"] == "0" ? "Célibataire".tr() : currentDetailUser["marital_status"] == "1" ? "Marié".tr() : currentDetailUser["marital_status"] == "2" ? "Divorcé".tr() : currentDetailUser["marital_status"] == "3" ? "Veuf".tr() : ""}',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      20,
                                                                      45,
                                                                      99),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15.h, bottom: 5.h),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "vos_bénéficiaires".tr(),
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackBlueAccent1),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(7.r),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(19, 20, 45, 99),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: currentDetailUser["beneficiary"].length > 0
                                ? ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount:
                                        currentDetailUser["beneficiary"].length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final itemCurrentDetailUser =
                                          currentDetailUser["beneficiary"]
                                              [index];
                                      if (currentDetailUser["beneficiary"]
                                              .length !=
                                          0) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                width: 0.5,
                                                color: Color.fromARGB(
                                                    76, 20, 45, 99),
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 2.h, top: 3.h),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            right: 7.w,
                                                            bottom: 20.h,
                                                          ),
                                                          child: Icon(
                                                            Icons.person,
                                                            size: 18.sp,
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              20,
                                                              45,
                                                              99,
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                "nom_complete"
                                                                    .tr(),
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            139,
                                                                            20,
                                                                            45,
                                                                            99),
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                "${itemCurrentDetailUser["first_name"] == null ? "" : itemCurrentDetailUser["first_name"]} ${itemCurrentDetailUser["last_name"] == null ? "" : itemCurrentDetailUser["last_name"]}",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            20,
                                                                            45,
                                                                            99),
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            right: 7.w,
                                                            bottom: 20.h,
                                                          ),
                                                          child: Icon(
                                                            Icons
                                                                .phone_android_outlined,
                                                            size: 18.sp,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    45,
                                                                    99),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                "téléphone"
                                                                    .tr(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                    139,
                                                                    20,
                                                                    45,
                                                                    99,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize:
                                                                      12.sp,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                "${itemCurrentDetailUser["first_phone"]}",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            20,
                                                                            45,
                                                                            99),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        12.sp),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  )
                                : Text(
                                    "Vous n'avez pas de bénéficiaire".tr(),
                                    style: TextStyle(
                                      color: Color.fromARGB(112, 20, 45, 99),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      // alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15.h, bottom: 5.h),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "vos_transactions".tr(),
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackBlueAccent1),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(7.r),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(19, 20, 45, 99),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: currentDetailUser["payments"].length > 0
                                ? ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount:
                                        currentDetailUser["payments"].length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final itemCurrentDetailUser =
                                          currentDetailUser["payments"][index];
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 0.5.r,
                                              color: Color.fromARGB(
                                                  76, 20, 45, 99),
                                            ),
                                          ),
                                        ),
                                        margin: EdgeInsets.only(
                                          bottom: 10.h,
                                          // left: 5,
                                          // right: 5,
                                          // top: 5,
                                        ),
                                        padding: EdgeInsets.only(
                                          bottom: 5.h,
                                          // left: 5,
                                          // right: 5,
                                          // top: 5,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // margin: EdgeInsets.only(
                                                  //     top: 5, bottom: 5),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Container(
                                                      //   color: AppColors.blackBlueAccent1,
                                                      //   child: Text(
                                                      //     "Motif : ",
                                                      //     style: TextStyle(
                                                      //       fontSize: 12,
                                                      //       color:
                                                      //           Color.fromARGB(
                                                      //               255,
                                                      //               20,
                                                      //               45,
                                                      //               99),
                                                      //       fontWeight:
                                                      //           FontWeight.w300,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width /
                                                                1.5,
                                                        child: Html(
                                                          data:
                                                              "<p style='color:#142D63 ; font-size: 12px; padding: 0 0 0 0; margin: 0 0 0 0'> <Span style='color:#142D63 ; font-size: 12px; padding: 0 0 0 0; margin: 0 0 0 0'></Span>${itemCurrentDetailUser["description"]}</p>",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  // color: AppColors.bleuLight,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width /
                                                          1.16,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              "${"montant".tr()} : ",
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        20,
                                                                        45,
                                                                        99),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              "${"${formatMontantFrancais(double.parse(itemCurrentDetailUser["amount"]))} FCFA"}",
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        20,
                                                                        45,
                                                                        99),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          formatDateLiteral(
                                                              itemCurrentDetailUser[
                                                                  "created_at"]),
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    20,
                                                                    45,
                                                                    99),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(3.r),
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      28, 228, 0, 0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360)),
                                              child: Icon(
                                                Icons.close_fullscreen,
                                                size: 12.sp,
                                                color: Colors.red,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    })
                                : Text(
                                    "Vous n'avez éffectuer aucune transaction"
                                        .tr(),
                                    style: TextStyle(
                                      color: Color.fromARGB(112, 20, 45, 99),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   // alignment: Alignment.centerLeft,
                    //   margin: EdgeInsets.only(left: 10, right: 10),
                    //   child: Column(
                    //     children: [
                    //       Container(
                    //         margin: EdgeInsets.only(top: 20, bottom: 5),
                    //         width: MediaQuery.of(context).size.width,
                    //         child: Text(
                    //           "Informations supplementaires",
                    //           style: TextStyle(
                    //             fontSize: 15,
                    //             fontWeight: FontWeight.w500,
                    //             color: AppColors.blackBlueAccent1
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         width: MediaQuery.of(context).size.width,
                    //         padding: EdgeInsets.all(10),
                    //         decoration: BoxDecoration(
                    //             color: Color.fromARGB(19, 20, 45, 99),
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               margin: EdgeInsets.only(bottom: 5),
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Row(
                    //                     children: [
                    //                       Container(
                    //                         margin: EdgeInsets.only(
                    //                           right: 7,
                    //                           bottom: 20,
                    //                         ),
                    //                         child: Icon(
                    //                           Icons.email_outlined,
                    //                           color: Color.fromARGB(
                    //                             255,
                    //                             20,
                    //                             45,
                    //                             99,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: [
                    //                           Container(
                    //                             child: Text(
                    //                               "Email",
                    //                               style: TextStyle(
                    //                                   color: Color.fromARGB(
                    //                                       139, 20, 45, 99),
                    //                                   fontWeight:
                    //                                       FontWeight.w800),
                    //                             ),
                    //                           ),
                    //                           Container(
                    //                             child: Text(
                    //                               "kengnedjoussehulot@gmail.com",
                    //                               style: TextStyle(
                    //                                   color: Color.fromARGB(
                    //                                       255, 20, 45, 99),
                    //                                   fontWeight:
                    //                                       FontWeight.w500),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             Container(
                    //               margin: EdgeInsets.only(bottom: 5),
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Row(
                    //                     children: [
                    //                       Container(
                    //                         margin: EdgeInsets.only(
                    //                             right: 7, bottom: 20),
                    //                         child: Icon(
                    //                           Icons.phone_android_outlined,
                    //                           color: Color.fromARGB(
                    //                               255, 20, 45, 99),
                    //                         ),
                    //                       ),
                    //                       Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: [
                    //                           Container(
                    //                             child: Text(
                    //                               "Téléphone",
                    //                               style: TextStyle(
                    //                                   color: Color.fromARGB(
                    //                                       139, 20, 45, 99),
                    //                                   fontWeight:
                    //                                       FontWeight.w800),
                    //                             ),
                    //                           ),
                    //                           Container(
                    //                             child: Text(
                    //                               "680474835",
                    //                               style: TextStyle(
                    //                                   color: Color.fromARGB(
                    //                                       255, 20, 45, 99),
                    //                                   fontWeight:
                    //                                       FontWeight.w500),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             Container(
                    //               // margin: EdgeInsets.only(bottom: 5),
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Row(
                    //                     children: [
                    //                       Container(
                    //                         margin: EdgeInsets.only(
                    //                             right: 7, bottom: 20),
                    //                         child: Icon(
                    //                           Icons.email_outlined,
                    //                           color: Color.fromARGB(
                    //                               255, 20, 45, 99),
                    //                         ),
                    //                       ),
                    //                       Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: [
                    //                           Container(
                    //                             child: Text(
                    //                               "Date de naissance",
                    //                               style: TextStyle(
                    //                                   color: Color.fromARGB(
                    //                                       139, 20, 45, 99),
                    //                                   fontWeight:
                    //                                       FontWeight.w800),
                    //                             ),
                    //                           ),
                    //                           Container(
                    //                             child: Text(
                    //                               "21/02/",
                    //                               style: TextStyle(
                    //                                   color: Color.fromARGB(
                    //                                       255, 20, 45, 99),
                    //                                   fontWeight:
                    //                                       FontWeight.w500),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
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
