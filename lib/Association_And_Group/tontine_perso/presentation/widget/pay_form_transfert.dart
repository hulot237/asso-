import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/association_recent_event/business_logic/recent_event_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/business_logic/tontine_perso_cubit.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/network/token_interceptor.dart';
import 'package:faroty_association_1/widget/widget_check_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class PayFormTransfert extends StatefulWidget {
  final String typeId;
  final String publicRef;
  final String sourceCode;
  final String membreCode;

  PayFormTransfert({
    required this.typeId,
    required this.publicRef,
    required this.sourceCode,
    required this.membreCode,
  });

  @override
  _PayFormTransfertState createState() => _PayFormTransfertState();
}

class _PayFormTransfertState extends State<PayFormTransfert> {
  final TextEditingController _amountController = TextEditingController();

  final dio = Dio()
    ..interceptors.addAll([
      TokenInterceptor(),
    ]);

  bool isLoading = false;

  Future<void> _makePostRequest(
    BuildContext context, {
    required String typeId,
    required int amount,
    required String sourceCode,
    required String publicRef,
    required String pinCode,
    required String membreCode,
    required String urlCode,
  }) async {
    final String url = '${Variables.LienAIP}/api/v1/payrequest-local';

    final Map<String, dynamic> data = {
      "type_id": typeId,
      "amount": amount,
      "source_code": sourceCode,
      "public_ref": publicRef,
      "pin_code": pinCode,
      "membre_code": membreCode,
      "urlcode": urlCode,
    };

    // Convertir le Map en JSON
    final jsonString = jsonEncode(data);

    // Utiliser log pour imprimer la chaîne JSON
    log(jsonString);
    log(url);

    try {
      final response = await dio.post(url, data: data);

      if (response.statusCode == 200) {
        // Requête réussie
        await context
            .read<RecentEventCubit>()
            .AllRecentEventCubit(AppCubitStorage().state.membreCode);
        await toastification.show(
          context: context,
          title: Text(
            "Paiement réussi".tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.blackBlue,
                fontWeight: FontWeight.bold),
          ),
          autoCloseDuration: Duration(seconds: 5),
          type: ToastificationType.success,
          style: ToastificationStyle.minimal,
        );
      } else {
        await toastification.show(
          context: context,
          title: Text(
            "Une erreur s'est produite. Veuillez réessayer.".tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.blackBlue,
                fontWeight: FontWeight.bold),
          ),
          autoCloseDuration: Duration(seconds: 5),
          type: ToastificationType.error,
          style: ToastificationStyle.minimal,
        );
      }
    } catch (e) {
      print(e);
      await toastification.show(
        context: context,
        title: Text(
          "Une erreur s'est produite. Veuillez réessayer.".tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.blackBlue,
              fontWeight: FontWeight.bold),
        ),
        autoCloseDuration: Duration(seconds: 5),
        type: ToastificationType.error,
        style: ToastificationStyle.minimal,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Payer un evenement',
        style: TextStyle(
          color: AppColors.blackBlue,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Text(
          //     "Numéro de téléphone",
          //     style: TextStyle(
          //       color: AppColors.blackBlue,
          //       fontSize: 12.sp,
          //     ),
          //   ),
          // ),
          // SizedBox(height: 5.h),
          // SizedBox(
          //   height: 40.h,
          //   child: TextField(
          //     enabled: false,
          //     keyboardType: TextInputType.number,
          //     style: TextStyle(
          //       color: AppColors.blackBlue,
          //       fontSize: 14.sp,
          //       letterSpacing: 2.w,
          //       fontWeight: FontWeight.bold,
          //     ),
          //     cursorColor: AppColors.blackBlue,
          //     decoration: InputDecoration(
          //       filled: true,
          //       fillColor: AppColors.white,
          //       contentPadding: EdgeInsets.only(left: 15.w),
          //       hintText: widget.numero,
          //       hintStyle: TextStyle(
          //           letterSpacing: 2.w,
          //           fontSize: 14.sp,
          //           fontWeight: FontWeight.bold,
          //           color: AppColors.blackBlue),
          //       labelStyle: TextStyle(
          //         color: AppColors.blackBlueAccent1,
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderSide: BorderSide(
          //           color: AppColors.colorButton,
          //           width: 1.w,
          //         ),
          //         borderRadius: BorderRadius.circular(7.r),
          //       ),
          //       disabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(
          //           color: AppColors.blackBlueAccent1,
          //           width: 1.w,
          //         ),
          //         borderRadius: BorderRadius.circular(7.r),
          //       ),
          //     ),
          //     autofocus: true,
          //   ),
          // ),

          // SizedBox(height: 20.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Montant",
              style: TextStyle(
                color: AppColors.blackBlue,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            height: 40.h,
            child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: AppColors.blackBlue,
                fontSize: 14.sp,
                letterSpacing: 2.w,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: AppColors.blackBlue,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.only(left: 15.w),
                suffix: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    'FCFA',
                    style: TextStyle(
                      color: AppColors.blackBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                hintText: "Entrez le montant",
                hintStyle: TextStyle(
                    letterSpacing: 2.w,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackBlue.withOpacity(.3)),
                labelStyle: TextStyle(
                  color: AppColors.blackBlueAccent1,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.colorButton,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.blackBlueAccent1,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(7.r),
                ),
              ),
              autofocus: true,
            ),
          ),
          SizedBox(
            height: 30.h,
            width: MediaQuery.of(context).size.width,
          ),
          isLoading
              ? CircularProgressIndicator(
                  color: AppColors.blackBlue,
                  strokeWidth: 1.5.w,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 5.h,
                          bottom: 5.h,
                          left: 20.w,
                          right: 20.w,
                        ),
                        margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: AppColors.colorButton,
                          ),
                        ),
                        child: Text(
                          "Annuler",
                          style: TextStyle(
                            color: AppColors.colorButton,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final result = await showCodeDialog(context);
                        if (result['isValid']) {
                          setState(() {
                            isLoading = true;
                          });
                          await _makePostRequest(
                            context,
                            typeId: widget.typeId,
                            amount: int.tryParse(_amountController.text)!,
                            sourceCode: widget.sourceCode,
                            publicRef: widget.publicRef,
                            pinCode: result['code'],
                            membreCode: widget.membreCode,
                            urlCode: AppCubitStorage().state.codeAssDefaul!,
                          );
                          context.read<TontinePersoCubit>().fetchTontinePerso();
                          // await context
                          //     .read<RecentEventCubit>()
                          //     .AllRecentEventCubit(
                          //         AppCubitStorage().state.membreCode);
                          setState(() {
                            isLoading = false;
                          });
                        }
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.of(context).pop();
                        // _showConfirmationPopup(
                        //     context,
                        //     amount,
                        //     widget.numero,
                        //     widget.publicRef,
                        //     widget.accountRef); // Show confirmation popup
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 5.h,
                          bottom: 5.h,
                          left: 20.w,
                          right: 20.w,
                        ),
                        margin: EdgeInsets.only(left: 10.w, bottom: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.colorButton,
                        ),
                        child: Text(
                          "Continuer",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  // void _showConfirmationPopup(BuildContext context, String amount,
  //     String numero, String publicRef, String accountRef) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return ConfirmationPopup(
  //         numero: numero,
  //         amount: amount,
  //         publicRef: publicRef,
  //         accountRef: accountRef,
  //       );
  //     },
  //   );
  // }
}
