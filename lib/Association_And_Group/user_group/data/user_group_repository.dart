import 'dart:convert';
import 'dart:developer';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class UserGroupRepository {
  final dio = Dio();
  Future<List> AllGroupOfUser() async {
    try {
      // Récupérer le token du bloc hydraté
      // final token = AuthCubit().state.token;
      log("response6");

      final response = await dio.post(
        '${Variables.LienAIP}/api/v1/usergroupe/userpages',
        options: Options(
          headers: {
            "password": AppCubitStorage().state.passwordKey,
            "username": AppCubitStorage().state.userNameKey,
          },
        ),
      );

      final List<dynamic> dataJson = response.data["data"]["user_groups"];
      // print("dataJsozzzzzzzzzzzzz      ${response.data["data"]["userGroups"].runtimeType}");
      print("dataJsonsssssssssddddedxex      ${dataJson}");

      final List<dynamic> groups = dataJson;

      log('Okay AllUserGroupOfUser rep');
      return groups;
    } catch (e) {
      log('erreur AllUserGroupOfUser rep');
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> UserGroupDefault(codeAssDefaul) async {
    try {
      log("response10");
      final response = await dio.post(
        '${Variables.LienAIP}/api/v1/usergroupe/default',
        data: {
          "urlcodes": ["$codeAssDefaul"],
        },
        options: Options(
          headers: {
            "password": AppCubitStorage().state.passwordKey,
            "username": AppCubitStorage().state.userNameKey,
          },
        ),
      );

      print(
          "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzeeeeeeeeeeeee ${response}");

      // print("dataJsozzzzzzzzzzzzz      ${response.data["data"]["partner_id"]}");

      final Map<String, dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay UserGroupDefaultUserGroupDefault rep');
      return dataJson;
    } catch (e) {
      log('erreur UserGroupDefaultUserGroupDefault rep');
      print(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> ChangerAss(codeAss) async {
    try {
      log("response11");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/usergroupe/$codeAss/show',
        options: Options(
          headers: {
            "password": AppCubitStorage().state.passwordKey,
            "username": AppCubitStorage().state.userNameKey,
          },
        ),
      );

      print(
          "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzeeeeeeeeeeeee ${response}");
      final Map<String, dynamic> dataJson = response.data["data"];
      log('Okay ChangerAssChangerAssChangerAss rep');
      return dataJson;
    } catch (e) {
      log('erreur ChangerAssChangerAssChangerAss rep');
      print(e);
      return {};
    }
  }

  // patch("/prositions/reject/:propositionId/active

  // Future<List<DeliveryModel>?> AllLivraisonOfUserEndend() async {
  //   try {
  //     // Récupérer le token du bloc hydraté
  //     final token = AuthCubit().state.token;
  //     // /livraison/OfUse/allEnded/show
  //     var headers = {'Authorization': 'Bearer $token'};
  //     final response = await http.get(
  //       Uri.parse('http://192.168.43.163:3333/livraison/OfUse/allEnded/show'),
  //       headers: headers,
  //     );

  //     final List<dynamic> dataJson = json.decode(response.body);
  //     print(dataJson);
  //     final List<DeliveryModel> data = dataJson
  //         .map<DeliveryModel>((json) => DeliveryModel.fromJson(json))
  //         .toList();

  //     log(data.toString());
  //     print("Le token" + token.toString());
  //     print("ended delivery reposit ok");
  //     return data;
  //   } catch (e) {
  //     print('ended erreur proposition rep');
  //     print(e);
  //     return null;
  //   }
  // }

  // /livraison/note/:livraisonId/active
}
