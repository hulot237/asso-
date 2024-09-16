import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/business_logic/tontine_perso_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/data/transaction_model.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/presentation/screen/code_secu_compte.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/Theming/color.dart';
import 'package:faroty_association_1/network/token_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class TontinePersoRepository {
  final Dio _dio = Dio()
    ..interceptors.addAll([
      TokenInterceptor(),
    ]);

  Future<Response> getTontinePerso() async {
    return await _dio
        .get('https://api.groups.faroty.com/api/v1/ass_user/get-one');
  }

  Future<List<TransactionModel>> getTransationTontinePerso(
      String accountRef) async {
    final response = await _dio.get(
      'https://api.groups.faroty.com/api/v1/ass_user/savings/$accountRef/get-saving-transactions',
    );
    var data = response.data['data']['payments'];

    // Assuming response.data contains the entire JSON response
    return data
        .map<TransactionModel>((json) => TransactionModel.fromJson(json))
        .toList();
  }

  //  final response = await dio.get('https://api.groups.faroty.com/api/v1/ass_user/savings/68391A/get-saving-transactions');

  Future<void> tontinePersoCreate({
    required String firstName,
    required String lastName,
    required String phone,
    required String identificationType,
    required String pinCode,
    required XFile? selfiePhoto,
    required XFile? idRectoPhoto,
    required XFile? idVersoPhoto,
    required BuildContext context,
  }) async {
    try {
      // Convert XFile to File
      File selfieFile = File(selfiePhoto!.path);
      File idRectoFile = File(idRectoPhoto!.path);
      File idVersoFile = File(idVersoPhoto!.path);

      // Convert images to base64
      String selfieBase64 = base64Encode(await selfieFile.readAsBytes());
      String idRectoBase64 = base64Encode(await idRectoFile.readAsBytes());
      String idVersoBase64 = base64Encode(await idVersoFile.readAsBytes());

      final Map<String, dynamic> payload = {
        'full_name': "$firstName $lastName",
        'phone': phone,
        'pin_code': pinCode,
        'identification_type': identificationType,
        'selfie_photo': selfieBase64,
        'id_recto_photo': idRectoBase64,
        'id_verso_photo': idVersoBase64,
      };

      final response = await _dio.post(
        '${Variables.LienAIP}/api/v1/create_asso_user',
        data: jsonEncode(payload),
        options: Options(
          contentType: 'application/json; charset=UTF-8',
        ),
      );

      if (response.statusCode == 200) {
        print('User created successfully');
        toastification.show(
          context: context,
          title: Text(
            "Soumission réussite",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.blackBlue,
                fontWeight: FontWeight.bold),
          ),
          autoCloseDuration: Duration(seconds: 3),
          type: ToastificationType.success,
          style: ToastificationStyle.minimal,
        );
        context.read<TontinePersoCubit>().fetchTontinePerso();
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        toastification.show(
          context: context,
          title: Text(
            "une erreur est survenue, veuillez réessayer",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.blackBlue,
                fontWeight: FontWeight.bold),
          ),
          autoCloseDuration: Duration(seconds: 3),
          type: ToastificationType.error,
          style: ToastificationStyle.minimal,
        );
        print('Failed to create user: ${response.statusCode}');
        print('Response body: ${response.data}');
      }
    } catch (e) {
      toastification.show(
        context: context,
        title: Text(
          "une erreur est survenue, veuillez réessayer",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.blackBlue,
              fontWeight: FontWeight.bold),
        ),
        autoCloseDuration: Duration(seconds: 3),
        type: ToastificationType.error,
        style: ToastificationStyle.minimal,
      );
      print('Error: $e');
    }
  }
}
