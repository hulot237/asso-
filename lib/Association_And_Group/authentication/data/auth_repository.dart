import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/auth_model.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class AuthRepository {
  final dio = Dio();

  Future<Map<String, dynamic>> UserDetail(userCode) async {
    try {
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/membre/$userCode/show',
      );
      final Map<String, dynamic> dataJson = response.data["data"];
      
      return dataJson;
    } catch (e) {
      log('erreur UserDetail rep');
      print(e);
      return {};
    }
  }

  Future<bool> LoginRepository(numeroPhone, countrycode) async {
    try {
      log("response LoginRepository");
      final response = await dio.post('${Variables.LienAIP}/login', data: {
        "phone": numeroPhone,
        "countrycode": countrycode,
      });

      final bool dataJson = response.data["error"];
      log('Okay LoginRepository rep');
      return dataJson;
    } catch (e) {
      log('erreur LoginRepository rep');
      print(e);
      return true;
    }
  }

  Future<AuthModel> ConfirmationRepository(codeConfirmation) async {
    final response = await dio.post(
        '${Variables.LienAIP}/confirmation?notification_token=${AppCubitStorage().state.tokenNotification}',
        data: {
          "code": codeConfirmation,
        },
      );

      var data = response.data;
    
      return AuthModel.fromJson(data['data']);
  }

  Future<Map<String, dynamic>> UpdateInfoUserRepository(
      key, value, partner_urlcode, membre_code) async {
    try {
      final response =
          await dio.put('${Variables.LienAIP}/api/v1/membre/update', data: {
        "key": key,
        "value": value,
        "photo_profil": value,
        "partner_urlcode": partner_urlcode,
        "membre_code": membre_code,
      });
      final Map<String, dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay UpdateInfoUser rep');
      return dataJson;
    } catch (e) {
      log('erreur UpdateInfoUser rep');
      print(e);
      return {};
    }
  }
}

  

