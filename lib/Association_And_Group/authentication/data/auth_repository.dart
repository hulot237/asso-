import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class AuthRepository {
  final dio = Dio();

  Future<Map<String, dynamic>> UserDetail(userCode) async {
    try {
      print("zzzeeezzzddddddddddddddddddddddddddddddddzz $userCode");
      log("response UserDetail");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/membre/$userCode/show',
      );
      print("dataJszzz=======++++++      ${response.data["data"]}");

      final Map<String, dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay UserDetail rep');
      return dataJson;
    } catch (e) {
      log('erreur UserDetail rep');
      print(e);
      return {};
    }
  }

  Future<bool> LoginRepository(numeroPhone, countrycode) async {
    try {
      print("zzzeeezzzzz $numeroPhone");
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

  Future<Map<String, dynamic>> ConfirmationRepository(codeConfirmation) async {
    try {
      print("zzzeeezzzzz $codeConfirmation");
      log("response ConfirmationRepository");
      final response = await dio.post(
        '${Variables.LienAIP}/confirmation?notification_token=${AppCubitStorage().state.tokenNotification}',
        data: {
          "code": codeConfirmation,
        },
      );
      print("dataJszzz=======++++++      ${response.data}");

      final Map<String, dynamic> dataJson = response.data;
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay ConfirmationRepository rep');
      return dataJson;
    } catch (e) {
      log('erreur ConfirmationRepository rep');
      print(e);
      return {};
    }
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
      print("dataJszzz=======++++++      ${response.data["data"]}");

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

  

// class AuthRepository  {
//   Future<Map<String, dynamic>?> login(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://192.168.43.163:3333/loginDeliverer'),
//         body: {
//           'email': email,
//           'password': password,
//         },
//       );

//       Map data = jsonDecode(response.body);
      
//       print(data['data']);
//       print("login success reposit");
//       return data['data'];
//     } catch (e) {
//       print("login echec reposit");
//       return null;
//     }
//   }

// }
