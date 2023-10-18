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
