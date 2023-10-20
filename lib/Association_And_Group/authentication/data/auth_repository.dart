import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class AuthRepository {
  final dio = Dio();

  Future<Map<String, dynamic>> UserDetail(userCode) async {
    try {
      print("zzzeeezzzzz $userCode");
      log("response DetailCotisation");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/membre/$userCode/show',
      );
      print("dataJszzz=======++++++      ${response.data["data"]}");

      final Map<String, dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay DetailCotisation rep');
      return dataJson;
    } catch (e) {
      log('erreur DetailCotisation rep');
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> LoginRepository(numeroPhone) async {
    try {
      print("zzzeeezzzzz $numeroPhone");
      log("response DetailCotisation");
      final response = await dio
          .post('${Variables.LienAIP}/login', data: {
        "phone": numeroPhone,
      });
      print("dataJszzz=======++++++      ${response.data["data"]}");

      final Map<String, dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay DetailCotisation rep');
      return dataJson;
    } catch (e) {
      log('erreur DetailCotisation rep');
      print(e);
      return {};
    }
  }


    Future<Map<String, dynamic>> UpdateInfoUserRepository(key, value, partner_urlcode, membre_code) async {
    try {
      print("zzzeeezzzzz $key");
      print("zzzeeezzzzz $value");
      print("zzzeeezzzzz $partner_urlcode");
      print("zzzeeezzzzz $membre_code");


      log("response DetailCotisation");
      final response = await dio
          .put('${Variables.LienAIP}/api/v1/membre/update', data: {
        "key": key,
        "value": value,
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
