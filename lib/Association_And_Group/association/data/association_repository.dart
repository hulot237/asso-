import 'dart:convert';
import 'dart:developer';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';
import 'package:http/http.dart' as http;

class AssociationRepository {
  Future<List<UserGroupModel>?> AllAssociationOfUser() async {
    try {
      // Récupérer le token du bloc hydraté
      // final token = AuthCubit().state.token;

      // var headers = {'Authorization': 'Bearer $token'};
      final response = await http.post(
          Uri.parse('http://192.168.1.110:53847/api/v1/usergroupe/userpages'),
          // headers: headers,
          body: 
            [
              "131970",
              "646119",
              "272969",
              "645631",
              "988385",
              "475624",
              "691246",
              "756044",
              "745795",
              "236503",
              "765783",
              "750756",
              "444040",
              "639939",
              "704753",
              "152086"
            ]
          );

      final List<dynamic> dataJson = json.decode(response.body);
      print(dataJson);
      final List<UserGroupModel> data = dataJson
          .map<UserGroupModel>((json) => UserGroupModel.fromJson(json))
          .toList();

      log(data.toString());
      // print("Le token" + token.toString());
      print("AllAssociationOfUser reposit ok");
      return data;
    } catch (e) {
      print('erreur AllAssociationOfUserTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT rep');
      print(e);
      return null;
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
