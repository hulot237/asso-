import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class CompteRepository {
  final dio = Dio();
// http://192.168.1.110:3333/api/v1/cotisation/1hcul26gv/show

  Future<List<dynamic>> AllCompteAss(codeAssociation) async {
    try {
    print("zzzeeezzzzz $codeAssociation");
      log("response AllCotisationOfAss");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/compte/$codeAssociation',
      );
      print("dataJszzz~~~~~~~~~~zzzzzzzzzzzz      ${response.data["data"]}");

      final List<dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay AllCotisationOfAss rep');
      return dataJson;
    } catch (e) {
      log('erreur AllCotisationOfAss rep');
      print(e);
      return [];
    }
  }
}

// class DeliveryRepository {
//   Future<List<DeliveryModel>?> AllLivraisonOfUserPending() async {
//     try {
//       // Récupérer le token du bloc hydraté
//       final token = AuthCubit().state.token;

//       var headers = {'Authorization': 'Bearer $token'};
//       final response = await http.get(
//         Uri.parse('http://192.168.43.163:3333/livraison/OfUse/allPending/show'),
//         headers: headers,
//       );

//       final List<dynamic> dataJson = json.decode(response.body);
//       print(dataJson);
//       final List<DeliveryModel> data = dataJson
//           .map<DeliveryModel>((json) => DeliveryModel.fromJson(json))
//           .toList();

//       log(data.toString());
//       print("Le token" + token.toString());
//       print("delivery reposit ok");
//       return data;
//     } catch (e) {
//       print('erreur proposition rep');
//       print(e);
//       return null;
//     }
//   }
//   // patch("/prositions/reject/:propositionId/active

//   Future<List<DeliveryModel>?> AllLivraisonOfUserEndend() async {
//     try {
//       // Récupérer le token du bloc hydraté
//       final token = AuthCubit().state.token;
//       // /livraison/OfUse/allEnded/show
//       var headers = {'Authorization': 'Bearer $token'};
//       final response = await http.get(
//         Uri.parse('http://192.168.43.163:3333/livraison/OfUse/allEnded/show'),
//         headers: headers,
//       );

//       final List<dynamic> dataJson = json.decode(response.body);
//       print(dataJson);
//       final List<DeliveryModel> data = dataJson
//           .map<DeliveryModel>((json) => DeliveryModel.fromJson(json))
//           .toList();

//       log(data.toString());
//       print("Le token" + token.toString());
//       print("ended delivery reposit ok");
//       return data;
//     } catch (e) {
//       print('ended erreur proposition rep');
//       print(e);
//       return null;
//     }
//   }

//   // /livraison/note/:livraisonId/active

// }
