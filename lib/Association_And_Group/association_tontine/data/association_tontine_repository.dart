import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class TontineRepository {
  final dio = Dio();

  Future<List<dynamic>> DetailTontine(codeTournoi, codeTontine) async {
    try {
      print("zzzeeezzzzz $codeTournoi");
      log("response DetailTontineDetailTontine");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/tournois/$codeTournoi/tontine/$codeTontine/all',
      );
      print(
          "DetailTontineDetailTontine      ${response.data["data"]}");

      final List<dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay DetailTontineDetailTontine rep');
      return dataJson;
    } catch (e) {
      log('erreur DetailTontineDetailTontine rep');
      print(e);
      return [];
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
