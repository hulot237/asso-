import 'dart:convert';
import 'dart:developer';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class DetailTournoiCourantRepository {
  final dio = Dio();
  final codeTournoiDefaul = AppCubitStorage().state.codeTournois;

  Future<Map<String, dynamic>> DetailTournoiCourant() async {
    try {
      log("response1");

      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/tournois/${AppCubitStorage().state.codeTournois}/show',
      );

      final Map<String, dynamic> dataJson = response.data["data"];

      print(
          "dataJsozzzzzzzzzzzzzT      ${response.data["data"]["tournois"]["seance"]}");

      log('Okay DetailTournoiCourant rep');
      return dataJson;
    } catch (e) {
      log('erreur DetailTournoiCourant rep');
      print(e);
      return {};
    }
  }

  Future<List<dynamic>> AllTournoiAss(codeAss) async {
    try {
      log("response1");

      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/tournois/$codeAss',
        // data: {
        //   // "urlcodes": Variables().urlcodes,
        // },
      );

      final List<dynamic> dataJson = response.data["data"];

      print("AllTournoiAsseeeeeeeee      ${response.data["data"]}");

      log('Okay AllTournoiAss rep');
      return dataJson;
    } catch (e) {
      log('erreur AllTournoiAss rep');
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> ChangeTournoi(codeTournoi, codeAss) async {
    try {
      log("response1");

      final response = await dio.patch(
        '${Variables.LienAIP}/api/v1/$codeAss/tournois/$codeTournoi/default',
        // data: {
        //   // "urlcodes": Variables().urlcodes,
        // },
      );

      final Map<String, dynamic> dataJson = response.data["data"];

      print("ChangeTournoiiiiiiiiiiiiiiiiiiiii      ${response.data["data"]}");

      log('Okay ChangeTournoi rep');
      return dataJson;
    } catch (e) {
      log('erreur ChangeTournoi rep');
      print(e);
      return {};
    }
  }

  // Future<Map<String, dynamic>> UserGroupDefault() async {
  //   try {
  //     log("response2");
  //     final response = await dio
  //         .post('${Variables.LienAIP}/api/v1/usergroupe/default', data: {
  //       "urlcodes": Variables().urlcodes,
  //     });
  //     // print("dataJsozzzzzzzzzzzzz      ${response.data["data"]["partner_id"]}");

  //     final Map<String, dynamic> dataJson = response.data["data"];
  //     print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");

  //     // print("dataJson      ${dataJson}");
  //     // print("dataJsonnnnnnnnnnnnnnn      ${dataJson.runtimeType}");

  //     // print("groups      ${UserGroupDefaultData.length}");
  //     log('Okay UserGroupDefault rep');
  //     return dataJson;
  //   } catch (e) {
  //     log('erreur UserGroupDefault rep');
  //     print(e);
  //     return {};
  //   }
  // }

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
