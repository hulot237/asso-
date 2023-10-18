import 'dart:convert';
import 'dart:developer';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class UserGroupRepository {
  final dio = Dio();
  Future<List<UserGroupModel>> AllGroupOfUser() async {
    try {
      // Récupérer le token du bloc hydraté
      // final token = AuthCubit().state.token;
      log("response1");

      final response = await dio
          .post('${Variables.LienAIP}/api/v1/usergroupe/userpages', data: {
        "urlcodes": Variables().urlcodes,
      });

      final List<dynamic> dataJson = response.data["data"]["userGroups"];
      // print("dataJsozzzzzzzzzzzzz      ${response.data["data"]["userGroups"].runtimeType}");
      print("dataJsonsssssssssddddedxex      ${dataJson}");

      final List<UserGroupModel> groups = dataJson
          .map<UserGroupModel>(
            (json) => UserGroupModel.fromJson(json),
          )
          .toList();

      log('Okay AllUserGroupOfUser rep');
      return groups;
    } catch (e) {
      log('erreur AllUserGroupOfUser rep');
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> UserGroupDefault() async {
    try {
      log("response2");
      final response = await dio
          .post('${Variables.LienAIP}/api/v1/usergroupe/default', data: {
        "urlcodes": Variables().urlcodes,
      });
      // print("dataJsozzzzzzzzzzzzz      ${response.data["data"]["partner_id"]}");

      final Map<String, dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay UserGroupDefault rep');
      return dataJson;
    } catch (e) {
      log('erreur UserGroupDefault rep');
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
