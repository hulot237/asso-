import 'dart:io';

import 'package:easy_loader/easy_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/presentation/widgets/widgetCompteCard.dart';
import 'package:faroty_association_1/Modals/fonction.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListCompteScreen extends StatefulWidget {
  const ListCompteScreen({Key? key}) : super(key: key);

  @override
  _ListCompteScreenState createState() => _ListCompteScreenState();
}

class _ListCompteScreenState extends State<ListCompteScreen> {
    Future<void> handleAllCompteAss(codeAssociation) async {
    final allCotisationAss =
        await context.read<CompteCubit>().AllCompteAssCubit(codeAssociation);

    if (allCotisationAss != null) {
    } else {
      print("userGroupDefault null");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleAllCompteAss(AppCubitStorage().state.codeAssDefaul);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        centerTitle: false,
        // toolbarHeight: 130.h,
        title: Text(
          'Les comptes'.tr(),
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
      body: BlocBuilder<CompteCubit, CompteState>(
          builder: (CompteContext, compteState) {
        if (compteState.isLoading == true && compteState.allCompteAss == null)
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
        final currentCompteAss = context.read<CompteCubit>().state.allCompteAss;

        // List<String> listeDeCouleurs = [
        //   "#F44336", // Rouge
        //   "#F44336", // Rouge
        //   "#2196F3", // Bleu
        //   "#96BF35", // Vert
        //   "#795548", // Jaune
        //   "#9C27B0", // Violet
        // ];       
        List<String> listeDeCouleurs = [
          "tontineTransIcon", // Rouge
          "meetingTransIcon", // Rouge
          "savingTransIcon", // Jaune
          "contributionTransIcon1", // Bleu
          "compteTransIcon", // Violet
          "sanctionTransIcon", // Vert
        ];
        int i = 0;

        List<Widget> listWidgetCompte = currentCompteAss!.map((item) {
          i++;
          return GestureDetector(
            onTap: () async {
              updateTrackingData(
                  "transactions.account", "${DateTime.now()}", {});
              context.read<CompteCubit>().getTransactionCompte(item.public_ref);

              showModalBottomTransactionCompte(context);
            },
            child: WidgetCompteCard(
              montantCompte:
                  "${int.parse(item.balance!) + int.parse(item.faroti_balance!)}",
              nomCompte: item.name!,
              numeroCompte: item.public_ref!,
              couleur: listeDeCouleurs[i],
            ),
          );
        }).toList();

// Ajouter un conteneur vide à la liste
        listWidgetCompte.add(
          GestureDetector(
            onTap: () {}, // Aucun gestionnaire d'événements défini
            child: Container(
              width: MediaQuery.of(context).size.width / 2.15,
              padding: EdgeInsets.all(5.r),
              margin: EdgeInsets.only(top: 10.h, ),
            ),
          ),
        );

        // Ajouter un nouveau WidgetCompteCard à la liste
// listWidgetCompte.add(
//   GestureDetector()
// );

        // width: MediaQuery.of(context).size.width,

        //   child: Wrap(
        //     alignment: WrapAlignment.center,
        //           width: MediaQuery.of(context).size.width / 2.15,
        //           margin: EdgeInsets.only(top: 10.h, right: 5.w, left: 5.w),

        return Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: listWidgetCompte,
                ),
              ),
            ),
            if (compteState.isLoading == true && compteState.allCompteAss !=null)
              EasyLoader(
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                iconSize: 50.r,
                iconColor: AppColors.blackBlueAccent1,
                image: AssetImage(
                  "assets/images/AssoplusFinal.png",
                ),
              )
          ],
        );
      }),
    );
  }
}

Future<dynamic> showModalBottomTransactionCompte(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.barrierColorModal,
    context: context,
    builder: (context) {
      return Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 5.h),
              height: 5.h,
              width: 55.w,
              decoration: BoxDecoration(
                color: AppColors.blackBlue,
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
            BlocBuilder<CompteCubit, CompteState>(
                builder: (CompteContext, compteState) {
              final currentTransactionCompte =
                  context.read<CompteCubit>().state.transactionCompte;
              if (compteState.isLoadingTransaction &&
                  compteState.transactionCompte == null)
                return Expanded(
                  child: EasyLoader(
                    backgroundColor: Color.fromARGB(0, 255, 255, 255),
                    iconSize: 50.r,
                    iconColor: AppColors.blackBlueAccent1,
                    image: AssetImage(
                      "assets/images/AssoplusFinal.png",
                    ),
                  ),
                );
              return Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      itemCount: currentTransactionCompte!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final itemTransaction = currentTransactionCompte[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.blackBlueAccent2,
                          ),
                          padding: EdgeInsets.all(10.r),
                          margin: EdgeInsets.all(7.r),
                          child: Column(
                            children: [
                              // Container(
                              // margin: EdgeInsets.only(bottom: 5),
                              // child:

                              Html(
                                data:
                                    "<p style='color:#142D63 ; font-size:${14.sp}px'>${itemTransaction["description"]}</p>",
                              ),

                              Container(
                                margin: EdgeInsets.only(bottom: 5.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${formatMontantFrancais(double.parse(itemTransaction["amount"]))} FCFA",
                                      style: TextStyle(
                                        color: itemTransaction["type"] == "0"
                                            ? AppColors.green
                                            : AppColors.red,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    itemTransaction["type"] == "0"
                                        ? Icon(
                                            Icons.arrow_downward_sharp,
                                            size: 14.sp,
                                            color:
                                                itemTransaction["type"] == "0"
                                                    ? AppColors.green
                                                    : AppColors.red,
                                          )
                                        : Icon(
                                            Icons.arrow_upward_sharp,
                                            color:
                                                itemTransaction["type"] == "0"
                                                    ? AppColors.green
                                                    : AppColors.red,
                                            size: 14.sp,
                                          ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Via ",
                                          style: TextStyle(
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        Text(
                                          itemTransaction["mode"] == "0"
                                              ? "Admin"
                                              : "Lien de paiement".tr(),
                                          style: TextStyle(
                                            color: AppColors.blackBlue,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      formatDateLiteral(
                                          itemTransaction["created_at"]),
                                      style: TextStyle(
                                        color: AppColors.blackBlue,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Solde après".tr(),
                                        style: TextStyle(
                                          color: AppColors.blackBlueAccent1,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Text(
                                        "${formatMontantFrancais(double.parse(itemTransaction["balance_after"]))} FCFA",
                                        style: TextStyle(
                                          color: AppColors.blackBlue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    if (compteState.isLoadingTransaction &&
                        compteState.transactionCompte != null)
                      EasyLoader(
                        backgroundColor: Color.fromARGB(0, 255, 255, 255),
                        iconSize: 50.r,
                        iconColor: AppColors.blackBlueAccent1,
                        image: AssetImage(
                          "assets/images/AssoplusFinal.png",
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
      );
    },
  );
}
