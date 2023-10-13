// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:integration_part_one/authentication/business_logic/auth_cubit.dart';
// import 'package:integration_part_one/delivery/data/delivery_model.dart';

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
